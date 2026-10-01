#!/usr/bin/env python3
"""Refresh Kimbi Coach at most once per 24 hours on local Codex hosts."""

from __future__ import annotations

import json
import os
from pathlib import Path
import subprocess
import sys
import time


CHECK_INTERVAL_SECONDS = 24 * 60 * 60
FAILURE_RETRY_SECONDS = 6 * 60 * 60
COMMAND_TIMEOUT_SECONDS = 90
MARKETPLACE = "kimbi-coach"
PLUGIN = "kimbi-coach@kimbi-coach"


def load_state(path: Path) -> dict[str, object]:
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
        return value if isinstance(value, dict) else {}
    except (FileNotFoundError, json.JSONDecodeError, OSError):
        return {}


def save_state(path: Path, state: dict[str, object]) -> None:
    temporary = path.with_suffix(".tmp")
    temporary.write_text(json.dumps(state, indent=2) + "\n", encoding="utf-8")
    temporary.replace(path)


def run_codex(*arguments: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        ["codex", *arguments],
        capture_output=True,
        check=False,
        text=True,
        timeout=COMMAND_TIMEOUT_SECONDS,
    )


def compact(text: str, limit: int = 1000) -> str:
    return " ".join(text.split())[:limit]


def main() -> int:
    data_value = os.environ.get("PLUGIN_DATA") or os.environ.get("CLAUDE_PLUGIN_DATA")
    if not data_value:
        return 0

    data_dir = Path(data_value)
    data_dir.mkdir(parents=True, exist_ok=True)
    state_path = data_dir / "update-state.json"
    lock_path = data_dir / "update-check.lock"
    state = load_state(state_path)
    now = int(time.time())

    last_attempt = int(state.get("last_attempt", 0) or 0)
    last_success = int(state.get("last_success", 0) or 0)
    wait_seconds = CHECK_INTERVAL_SECONDS if last_success >= last_attempt else FAILURE_RETRY_SECONDS
    if now - last_attempt < wait_seconds:
        return 0

    try:
        descriptor = os.open(lock_path, os.O_CREAT | os.O_EXCL | os.O_WRONLY)
        os.close(descriptor)
    except FileExistsError:
        try:
            if now - int(lock_path.stat().st_mtime) < COMMAND_TIMEOUT_SECONDS * 2:
                return 0
            lock_path.unlink()
            descriptor = os.open(lock_path, os.O_CREAT | os.O_EXCL | os.O_WRONLY)
            os.close(descriptor)
        except (FileNotFoundError, FileExistsError, OSError):
            return 0

    state["last_attempt"] = now
    try:
        marketplace = run_codex("plugin", "marketplace", "upgrade", MARKETPLACE)
        if marketplace.returncode != 0:
            raise RuntimeError(compact(marketplace.stderr or marketplace.stdout))

        install = run_codex("plugin", "add", PLUGIN)
        if install.returncode != 0:
            raise RuntimeError(compact(install.stderr or install.stdout))

        state.update(
            {
                "last_success": now,
                "status": "ok",
                "marketplace_output": compact(marketplace.stdout),
                "install_output": compact(install.stdout),
            }
        )
        save_state(state_path, state)
        return 0
    except (FileNotFoundError, subprocess.TimeoutExpired, RuntimeError, OSError) as error:
        state.update({"status": "failed", "error": compact(str(error))})
        save_state(state_path, state)
        print(
            json.dumps(
                {
                    "continue": True,
                    "systemMessage": (
                        "Kimbi Coach could not complete its daily update check. "
                        "Study features remain available; retry later or run the documented update commands."
                    ),
                }
            )
        )
        return 0
    finally:
        try:
            lock_path.unlink()
        except FileNotFoundError:
            pass


if __name__ == "__main__":
    sys.exit(main())
