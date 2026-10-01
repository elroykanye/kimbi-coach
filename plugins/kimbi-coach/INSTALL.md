# Install Kimbi Coach

## Ask an agent to install it

In a ChatGPT desktop or Codex session that can operate the local computer, provide the repository link and say:

> Install Kimbi Coach from https://github.com/elroykanye/kimbi-coach as a user-level plugin. Verify it, start a new chat if required, and run its setup workflow so I can choose a backed-up study workspace.

The agent should report any unsupported surface or missing permission rather than claiming success.

## Install from GitHub manually

```bash
codex plugin marketplace add elroykanye/kimbi-coach
codex plugin add kimbi-coach@kimbi-coach
```

Restart the ChatGPT desktop app or Codex client and begin a new chat. This installs Kimbi Coach at the local user level; it is not tied to a particular source-code repository.

If it was previously installed, refresh it with:

```bash
codex plugin marketplace upgrade kimbi-coach
codex plugin add kimbi-coach@kimbi-coach
```

Restart the client and open a completely new chat after refreshing. Installed marketplace plugins are cached; an existing chat may continue using the earlier skill metadata.

## Automatic updates

Kimbi Coach bundles `hooks/hooks.json`, which runs `hooks/check_updates.py` at session start. The script refreshes the marketplace and reinstalls Kimbi Coach no more than once every 24 hours. Failed checks retry after six hours.

Codex does not trust plugin-bundled hooks automatically. Review and trust this hook once when the client prompts. If an update is installed, restart or open a new chat before expecting the new skill metadata to apply.

The local updater is not available on ChatGPT web or mobile. Those installations depend on approved Plugins Directory releases. Where scheduled automations are supported, the setup skill can offer a daily update check as a fallback and must obtain approval before creating it.

## First-time setup

The manifest declares `setup-kimbi-coach` as its onboarding skill. It asks the learner to select one of these destinations:

- a connected Google Drive folder;
- a local folder already synchronized by OneDrive;
- a ChatGPT Space or Project;
- another explicitly backed-up local folder.

The skill displays the intended files and asks for confirmation before writing. It then reads created files back to verify access. It never requests credentials or stores secrets.

If onboarding does not launch automatically, ask:

> Use `setup-kimbi-coach` to configure my study workspace.

Google Drive access depends on the connected app and workspace policy. A OneDrive local path works only where that synchronized filesystem is mounted and authorized.

## Install from the ZIP

The distributable ZIP contains one top-level `kimbi-coach` directory. Keep it intact. Add the containing marketplace or copy the plugin into an existing personal marketplace, then install it through the local Plugins Directory.

## Build a fresh ZIP

From the repository root:

```bash
./plugins/kimbi-coach/scripts/package.sh
```

The archive is written to `dist/kimbi-coach-<version>.zip`.

## Cross-device and web availability

A GitHub marketplace installation affects supported local clients on the computer where it was installed. It does not by itself enable the plugin on ChatGPT web, mobile, or another computer.

For universal directory installation across supported ChatGPT and Codex surfaces, upload the plugin ZIP through the OpenAI plugin submission portal, resolve automated findings, submit it for review, and publish the approved version. Organization and school workspace policies can still restrict availability.
