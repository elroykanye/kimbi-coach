# Kimbi Coach

**Learn it. Defend it. Master it.**

Kimbi Coach is a constructive, persistent accounting study coach for ChatGPT and Codex. It teaches from the learner's current level, asks for an attempt before revealing answers, checks the accounting independently, challenges weak reasoning, records useful study artifacts, and retests fragile knowledge.

It contains eleven skills: proactive file intake, a broad automatic coaching entry point, onboarding, accounting tutoring, progressive hints, verified practice, adaptive quizzes, adversarial mock examinations, assignment review, source-grounded research, and realistic study planning.

## Upload-and-go behavior

Kimbi Coach treats a file attachment as an implicit request for help—even when the learner writes nothing. It should immediately:

1. inspect and classify the file;
2. summarize what matters;
3. extract deadlines, requirements, risks, or ambiguities;
4. recommend the most useful next action;
5. ask one specific follow-up with relevant options.

It must not respond only with “What do you want me to do?” If a file cannot be read, it explains the exact limitation and gives a recovery step.

Skill activation is metadata-driven. This release explicitly targets attachment-only turns, but a skills-only plugin cannot provide a guaranteed file-open event on every ChatGPT surface. A future MCP file-viewer extension is the route to a hard file-event integration.

### Already installed an earlier version?

The installed plugin is cached, so updating the GitHub repository alone is not enough. Run:

```bash
codex plugin marketplace upgrade kimbi-coach
codex plugin add kimbi-coach@kimbi-coach
```

Then restart the client and test in a completely new chat. The attachment-only fix is included in v0.3.0 and later.

## Give this link to ChatGPT or Codex

Share this repository:

**https://github.com/elroykanye/kimbi-coach**

In ChatGPT desktop or Codex with access to the local computer, send this prompt:

> Install Kimbi Coach from https://github.com/elroykanye/kimbi-coach as a user-level plugin, not only for the current project. Verify the installation, start its onboarding workflow, and help me choose a safe backed-up study workspace. Do not request or store passwords, recovery codes, API keys, or student identification numbers.

If that environment cannot install GitHub marketplace plugins, it should explain the limitation rather than pretending the installation succeeded. Use the manual steps below.

## Manual installation

### 1. Add the marketplace and plugin

Run these commands on each computer that uses a supported local Codex or ChatGPT desktop client:

```bash
codex plugin marketplace add elroykanye/kimbi-coach
codex plugin add kimbi-coach@kimbi-coach
```

This is a user-level local installation. It is not limited to one source-code project.

### 2. Restart and open a new chat

Restart the ChatGPT desktop app or Codex client. Begin a new chat so the newly installed skills are discovered.

### 3. Run first-time setup

The supported plugin host should offer the `setup-kimbi-coach` onboarding skill. If it does not appear automatically, send:

> Set up Kimbi Coach. Help me choose a persistent study workspace and initialize it only after I approve the location and proposed files.

### 4. Verify

Ask:

> List the Kimbi Coach skills you can use, tell me where my study workspace is, and create one harmless test note there. Read the note back to verify it was saved, then ask before deleting it.

Also test attachment intake by uploading a syllabus or lecture file with no text. A correct first response identifies the document and provides a useful initial analysis before asking a targeted question.

Do not assume cloud backup succeeded merely because a local file was created. Check the Google Drive or OneDrive sync status separately.

## Choosing the study workspace

Kimbi Coach asks before creating anything. Supported choices depend on the apps and filesystem available in the current environment:

1. **Google Drive folder — recommended for cross-device study.** Connect Google Drive in ChatGPT, select a dedicated `Kimbi Coach` folder, and grant only the access needed. The connected app must support writing if Kimbi Coach will create files there.
2. **OneDrive-synced folder.** Select a local folder already synchronized by OneDrive. This works well for local Codex sessions, but a local filesystem path is not automatically available to ChatGPT on the web.
3. **ChatGPT Space or Project.** Use an online study hub and attach or link the source material it should use.
4. **Another backed-up folder.** Provide its full path and confirm how it is backed up.

The onboarding workflow proposes this structure:

```text
Kimbi Coach/
├── KIMBI_PROFILE.md
├── START_HERE.md
├── Courses/
├── Progress/
├── Practice/
├── Research/
├── Submissions/
└── Archive/
```

The profile contains learning preferences and course context—not credentials, student numbers, or confidential client data.

## Availability across her ecosystem

A GitHub marketplace installation is available to supported local clients on the computer where it is installed. It does **not** automatically install the plugin in every ChatGPT web, mobile, or organization workspace.

True account-level discovery across supported ChatGPT and Codex surfaces requires Kimbi Coach to be submitted, approved, and published in OpenAI's universal Plugins Directory. Workspace administrators may also control whether plugins and connected apps are available. Until directory publication is complete, install the GitHub marketplace on each local computer where she needs it.

The skills are designed for automatic selection when a study request matches them, so she should not need to remember skill names after installation. Automatic selection still depends on the host loading and enabling the plugin.

## Update an installation

```bash
codex plugin marketplace upgrade kimbi-coach
codex plugin add kimbi-coach@kimbi-coach
```

Restart the client and use a new chat after updating.

## Download the ZIP

Download the latest tested archive from [GitHub Releases](https://github.com/elroykanye/kimbi-coach/releases/latest). The ZIP contains a single top-level `kimbi-coach` plugin directory.

## Repository layout

- [`plugins/kimbi-coach`](plugins/kimbi-coach) — portable plugin package
- [Plugin installation details](plugins/kimbi-coach/INSTALL.md)
- [Plugin capabilities](plugins/kimbi-coach/README.md)
- [Marketplace manifest](.agents/plugins/marketplace.json)

Kimbi Coach is currently skills-only. It has no remote server, credentials, or independent student-data store. Cloud files are handled only through apps or folders the learner connects and authorizes.
