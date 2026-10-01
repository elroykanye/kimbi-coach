# Install Kimbi Coach

## From GitHub

Add the repository as a marketplace, then install Kimbi Coach:

```bash
codex plugin marketplace add elroykanye/kimbi-coach
codex plugin add kimbi-coach@kimbi-coach
```

Restart the ChatGPT desktop app after installing, then begin a new chat so the skills are loaded cleanly.

## From the ZIP

The distributable ZIP contains one top-level `kimbi-coach` directory. Keep that directory intact when extracting it. Add the containing directory as a local marketplace or copy the plugin into an existing local marketplace before installing it.

## Build a fresh ZIP

From the repository root:

```bash
./plugins/kimbi-coach/scripts/package.sh
```

The archive is written to `dist/kimbi-coach-<version>.zip`.

## Public plugin directory

A public GitHub repository does not automatically create a public ChatGPT plugin listing. Directory publication is a separate process: upload the ZIP through the OpenAI plugin submission portal, complete the automated checks and policy attestations, submit it for review, and publish it after approval.
