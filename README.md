# Kimbi Coach

**Learn it. Defend it. Master it.**

Kimbi Coach is a constructive, persistent accounting study coach for ChatGPT and Codex. It teaches from the learner's current level, asks for an attempt before revealing answers, checks the accounting independently, challenges weak reasoning, records useful study artifacts, and retests fragile knowledge.

It contains fourteen skills: context-aware proactive help, file intake, a broad coaching entry point, onboarding, accounting tutoring, progressive hints, verified practice, adaptive quizzes, adversarial mock examinations, exam-answer verification, assignment review, source-grounded research, study planning, and accounting career planning.

## Proactive by default

Kimbi Coach is designed to reduce the amount of prompting the learner must do. When she sends a bare link, screenshot, score, calculation, single topic, “done,” short fragment, unexplained output, or other study-related item with little context, it should:

1. inspect the visible context;
2. explain what it appears to mean without pretending uncertain inferences are facts;
3. perform one immediately useful, low-risk step;
4. recommend the next action;
5. ask at most one targeted question with concrete choices.

It does not perform external writes, submissions, messages, or other consequential actions without the authority those actions normally require.

## Upload-and-go behavior

Kimbi Coach treats a file attachment as an implicit request for help—even when the learner writes nothing. It should immediately:

1. inspect and classify the file;
2. summarize what matters;
3. extract deadlines, requirements, risks, or ambiguities;
4. recommend the most useful next action;
5. ask one specific follow-up with relevant options.

It must not respond only with “What do you want me to do?” If a file cannot be read, it explains the exact limitation and gives a recovery step.

Skill activation is metadata-driven. This release explicitly targets attachment-only turns, but a skills-only plugin cannot provide a guaranteed file-open event on every ChatGPT surface. A future MCP file-viewer extension is the route to a hard file-event integration.

## Easiest Windows installation — no `codex` command required

For a learner using the ChatGPT desktop app on Windows:

1. Download the latest ZIP from [GitHub Releases](https://github.com/elroykanye/kimbi-coach/releases/latest).
2. Right-click the ZIP, select **Extract All**, and open the extracted `kimbi-coach` folder.
3. Double-click **`INSTALL-KIMBI-COACH-WINDOWS.cmd`**.
4. Fully close and reopen the ChatGPT desktop app.
5. Open **Codex** or **Work**, then **Plugins**. Choose the **Personal** source, open **Kimbi Coach**, and select **Install plugin**.
6. Start a new chat and send: `Set up Kimbi Coach.`

The installer needs no administrator account, Node.js, Python, Git, or Codex CLI. It installs files only for the current Windows user. Windows may show a security warning because the downloaded script is not code-signed; its source is included in this repository for review.

If she uses only `chatgpt.com` or the mobile app, this GitHub build cannot be installed there directly. Account-wide installation on supported ChatGPT and Codex surfaces requires approval and publication in OpenAI's universal Plugins Directory.

### Already installed an earlier version?

The installed plugin is cached, so updating the GitHub repository alone is not enough. Windows users can download the latest ZIP and run `INSTALL-KIMBI-COACH-WINDOWS.cmd` again. Developers with Codex CLI can run:

```bash
codex plugin marketplace upgrade kimbi-coach
codex plugin add kimbi-coach@kimbi-coach
```

Then restart the client and test in a completely new chat. The attachment-only fix is included in v0.3.0 and later.

## Automatic daily updates

Local Codex and ChatGPT desktop installations include a bundled `SessionStart` hook. After the learner reviews and trusts it once, the hook:

- checks for a Kimbi Coach release at most once every 24 hours;
- refreshes and reinstalls the latest Kimbi Coach package;
- stores only update timestamps and compact command results in the plugin's writable data directory;
- retries a failed check after six hours without blocking study features.

An update found at session start applies to a **new chat** and may require restarting the client. The hook does not run on ChatGPT web or mobile because web installation does not deploy local scripts. Those surfaces receive updates through the Plugins Directory after a new package version is reviewed and published.

On Windows, the updater uses built-in PowerShell and does not require the `codex` command or Python. On other local systems it uses Codex CLI. Bundled hooks are intentionally not trusted automatically by Codex. During setup, review and trust `hooks/hooks.json` and the platform updater script if automatic local updates are desired. If hooks are unavailable but scheduled automations are supported, Kimbi Coach offers to configure a daily update check after receiving permission.

## Give this link to ChatGPT or Codex

Share this repository:

**https://github.com/elroykanye/kimbi-coach**

In ChatGPT desktop or Codex with access to the local computer, send this prompt:

> Install Kimbi Coach from https://github.com/elroykanye/kimbi-coach as a user-level plugin, not only for the current project. Verify the installation, start its onboarding workflow, and help me choose a safe backed-up study workspace. Do not request or store passwords, recovery codes, API keys, or student identification numbers.

If that environment cannot install GitHub marketplace plugins, it should explain the limitation rather than pretending the installation succeeded. Use the manual steps below.

## Command-line installation (optional)

### 1. Add the marketplace and plugin

Developers who already have Codex CLI may run these commands on each computer:

```bash
codex plugin marketplace add https://github.com/elroykanye/kimbi-coach.git
codex plugin add kimbi-coach@kimbi-coach
```

This is a user-level local installation. It is not limited to one source-code project. Use the full HTTPS URL shown above: GitHub shorthand may be interpreted as SSH and fail with `Permission denied (publickey)` on a machine without a GitHub SSH key. If PowerShell says `codex` is not recognized, use the Windows ZIP installer above instead.

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

## Study plans, guides, and online research

Kimbi Coach can turn a syllabus, exam date, topic list, notes, or weak-area evidence into:

- dated study plans with recovery rules;
- concise topic guides and prerequisite maps;
- formula, authority, and misconception checklists;
- retrieval practice and retest schedules;
- a small, level-appropriate resource stack;
- current online research using authoritative and first-party sources.

It should explain why each recommended resource was selected, distinguish free from paid material, and never pretend to have reviewed a page that it did not open.

## Accounting career coaching

Kimbi Coach can compare accounting career paths, research current qualifications and opportunities, identify skill gaps, suggest portfolio projects, prepare internship or job-search strategies, and build semester or 90-day career plans. Time-sensitive claims—especially Philippine licensure requirements, deadlines, job openings, and salary evidence—must be checked against current authoritative or first-party sources.

## Exam-answer trust gate

Before Kimbi Coach calls an exam answer correct, verified, reliable, or trustworthy, it must:

1. identify the source of material facts and rules;
2. separate question facts, course sources, external authority, calculations, and assumptions;
3. recompute or re-reason the answer independently;
4. try to falsify it through an adversarial review;
5. disclose limitations and label it `Verified`, `Reasoned but not externally verified`, or `Uncertain`.

Current tax, law, regulation, and accounting-standard claims cannot receive the `Verified` label until jurisdiction, effective period, and appropriate authority have been checked. Potential live or restricted assessments receive concept-level or analogous help until permitted-assistance rules are clear.

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

Download the latest tested archive from [GitHub Releases](https://github.com/elroykanye/kimbi-coach/releases/latest). The ZIP contains a single top-level `kimbi-coach` plugin directory, including the Windows installer.

## Repository layout

- [`plugins/kimbi-coach`](plugins/kimbi-coach) — portable plugin package
- [Plugin installation details](plugins/kimbi-coach/INSTALL.md)
- [Plugin capabilities](plugins/kimbi-coach/README.md)
- [Marketplace manifest](.agents/plugins/marketplace.json)
- [`hooks/check_updates.py`](plugins/kimbi-coach/hooks/check_updates.py) — rate-limited local updater

Kimbi Coach is currently skills-only. It has no remote server, credentials, or independent student-data store. Cloud files are handled only through apps or folders the learner connects and authorizes.
