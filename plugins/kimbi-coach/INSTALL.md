# Install Kimbi Coach

## Windows learner setup — recommended

The Windows route does not use the `codex` command.

1. Download the latest release ZIP from <https://github.com/elroykanye/kimbi-coach/releases/latest>.
2. Right-click the downloaded ZIP and select **Extract All**. Do not run the installer from inside the compressed ZIP viewer.
3. Open the extracted `kimbi-coach` folder and double-click `INSTALL-KIMBI-COACH-WINDOWS.cmd`.
4. Read the result, then fully close and reopen the ChatGPT desktop app.
5. Open Codex or Work, then open Plugins. Select the **Personal** source, open **Kimbi Coach**, and select **Install plugin**.
6. Start a new chat and say: `Set up Kimbi Coach.`

The installer copies the plugin to `%USERPROFILE%\.codex\plugins\kimbi-coach` and safely adds or replaces its entry in `%USERPROFILE%\.agents\plugins\marketplace.json`. Existing installations and marketplace files receive timestamped backups. It does not need administrator access, Node.js, Python, Git, or Codex CLI.

Windows may warn about a downloaded, unsigned script. The source is included in the package at `scripts/install-windows.ps1` for review. If organizational policy blocks local scripts or local marketplaces, an administrator must allow them or Kimbi Coach must be installed after publication in the universal Plugins Directory.

## Ask an agent to install it

In a ChatGPT desktop or Codex session that can operate the local computer, provide the repository link and say:

> Install Kimbi Coach from https://github.com/elroykanye/kimbi-coach as a user-level plugin. Verify it, start a new chat if required, and run its setup workflow so I can choose a backed-up study workspace.

The agent should report any unsupported surface or missing permission rather than claiming success.

## Install from GitHub with Codex CLI — optional

```bash
codex plugin marketplace add elroykanye/kimbi-coach
codex plugin add kimbi-coach@kimbi-coach
```

Restart the ChatGPT desktop app or Codex client and begin a new chat. This installs Kimbi Coach at the local user level; it is not tied to a particular source-code repository.

If PowerShell reports that `codex` is not recognized as a cmdlet, do not keep retrying the command. Use the Windows learner setup above. Installing Codex CLI separately is not required for Kimbi Coach.

If it was previously installed, refresh it with:

```bash
codex plugin marketplace upgrade kimbi-coach
codex plugin add kimbi-coach@kimbi-coach
```

Restart the client and open a completely new chat after refreshing. Installed marketplace plugins are cached; an existing chat may continue using the earlier skill metadata.

## Automatic updates

Kimbi Coach bundles `hooks/hooks.json`. On Windows it runs a built-in PowerShell updater; on other local systems it runs `hooks/check_updates.py`. It checks GitHub Releases and refreshes Kimbi Coach no more than once every 24 hours. Failed checks retry after six hours.

Codex does not trust plugin-bundled hooks automatically. Review and trust this hook once when the client prompts. If an update is installed, restart or open a new chat before expecting the new skill metadata to apply.

The Windows updater needs neither Codex CLI nor Python. The local updater is not available on ChatGPT web or mobile. Those installations depend on approved Plugins Directory releases. Where scheduled automations are supported, the setup skill can offer a daily update check as a fallback and must obtain approval before creating it.

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

## Install from the ZIP on macOS or Linux

The distributable ZIP contains one top-level `kimbi-coach` directory. Keep it intact. Add the containing marketplace or copy the plugin into an existing personal marketplace, then install it through the local Plugins Directory. The double-click installer is Windows-specific.

## Build a fresh ZIP

From the repository root:

```bash
./plugins/kimbi-coach/scripts/package.sh
```

The archive is written to `dist/kimbi-coach-<version>.zip`.

## Cross-device and web availability

A GitHub marketplace installation affects supported local clients on the computer where it was installed. It does not by itself enable the plugin on ChatGPT web, mobile, or another computer.

For universal directory installation across supported ChatGPT and Codex surfaces, upload the plugin ZIP through the OpenAI plugin submission portal, resolve automated findings, submit it for review, and publish the approved version. Organization and school workspace policies can still restrict availability.
