---
name: setup-kimbi-coach
description: Onboard a learner into Kimbi Coach and configure a safe, backed-up study workspace. Use on first run, when no Kimbi Coach workspace is available in the current context, or when the learner wants to change storage, courses, preferences, or study-coach intensity.
---

# Set up Kimbi Coach

Welcome the learner briefly, explain that Kimbi Coach works best with one persistent study home, and help her select and initialize it. Do not imply that installation alone grants access to cloud storage.

## Choose the study home

Ask the learner to choose one option based on tools actually available in the current environment:

1. **Google Drive folder — recommended for cross-device use.** Use a connected Google Drive app only after the learner selects or creates a folder and authorizes the write. Preserve its existing permissions.
2. **OneDrive-synced local folder.** Use when Codex has filesystem access to a folder already synchronized by OneDrive. Confirm the sync client reports the folder as available and do not assume ChatGPT web can access the local path.
3. **Another backed-up local folder.** Confirm the full path and backup mechanism.
4. **ChatGPT Space or Project.** Use when the learner prefers an online study hub and its files or connected sources are available in the current chat.

If none is available, continue without persistence and explain that progress will remain limited to the current conversation. Never ask for a cloud password, recovery code, API key, or secret.

## Obtain consent and initialize

Before creating folders or files, show the proposed destination and contents and obtain the learner's confirmation. Then create only the minimal structure described in [workspace layout](references/workspace-layout.md), using the tools available in the current environment.

Record preferences in `KIMBI_PROFILE.md`:

- preferred name and pronouns if volunteered;
- school, program, year level, and current subjects;
- reporting frameworks and jurisdictions relevant to the courses;
- deadlines and ordinary study availability;
- coach intensity: gentle, firm, strict examiner, or merciless auditor;
- chosen workspace type and a non-secret locator such as a Drive folder link or local path;
- last setup date.

Do not place passwords, access tokens, student identification numbers, private grades, or confidential client data in the profile. Let the learner omit any optional field.

## Verify

After writing, read back `KIMBI_PROFILE.md` and one created index file to confirm that the destination is writable. If the destination is a synced local folder, ask the learner to verify the sync status rather than claiming backup succeeded. Summarize where future Kimbi Coach files should be stored.

If a profile already exists, read it, confirm it belongs to the learner, preserve unknown fields, and update only what she requests.

## Enable updates

Explain that local Codex installations include a SessionStart hook that checks the `kimbi-coach` marketplace at most once per 24 hours. The learner must review and trust the bundled hook once; do not claim it is active until the host shows it as trusted. A newly installed version becomes available in a new chat and may require restarting the client.

If hooks are unavailable but the environment supports scheduled automations, offer to create a daily Kimbi Coach update check. Obtain confirmation before creating the automation in the learner's account. Web and mobile installations rely on published Plugins Directory updates rather than the local hook.
