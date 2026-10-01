#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
plugin_dir="$(cd -- "${script_dir}/.." && pwd)"
repo_dir="$(cd -- "${plugin_dir}/../.." && pwd)"
version="$(sed -n 's/.*"version": "\([^"]*\)".*/\1/p' "${plugin_dir}/plugin.json" | head -n 1)"
dist_dir="${repo_dir}/dist"
archive="${dist_dir}/kimbi-coach-${version}.zip"

mkdir -p "${dist_dir}"
rm -f "${archive}"
(
  cd "$(dirname -- "${plugin_dir}")"
  zip -qr "${archive}" kimbi-coach \
    -x 'kimbi-coach/.git/*' \
    -x 'kimbi-coach/.DS_Store' \
    -x 'kimbi-coach/**/__pycache__/*'
)
printf '%s\n' "${archive}"
