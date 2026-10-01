# Kimbi Coach

**Learn it. Defend it. Master it.**

Kimbi Coach is a skills-only plugin for ChatGPT and Codex. It is a supportive but persistent accounting study partner: it proactively inspects uploads, configures a safe study home, teaches, asks for an attempt, challenges the reasoning, checks the accounting, and retests weak areas.

## Included skills

- `proactive-study-copilot` — infer a useful next step from context-poor study inputs
- `intake-study-file` — immediate, useful analysis of attachments with or without a message
- `study-with-kimbi-coach` — broad entry point for accounting-course requests
- `setup-kimbi-coach` — first-run preferences and backed-up workspace selection
- `learn-accounting-topic` — diagnostic, first-principles tutoring
- `solve-with-hints` — progressive hints without premature answer disclosure
- `accounting-practice-lab` — original accounting exercises with independent checks
- `quiz-and-retest` — adaptive quizzes and targeted retesting
- `adversarial-examiner` — strict written or oral examination practice
- `verify-exam-answer` — source, recompute, challenge, and confidence-label exam answers
- `review-my-work` — correctness, rubric, writing, and integrity review
- `research-with-sources` — evidence-led research and citation checking
- `build-study-plan` — realistic planning based on deadlines and weak topics
- `plan-accounting-career` — current career pathways, skills, resources, and action plans

## Good first prompts

- “Here is my syllabus. Diagnose my weak areas and build a plan.”
- “Teach me adjusting entries, but make me attempt each step.”
- “Create a bank-reconciliation problem and grade my working.”
- “Give me a strict oral exam based only on these notes.”
- “Review this assignment against the rubric. Do not rewrite it for me.”

## Privacy

Kimbi Coach has no server and no account connection of its own. It writes study artifacts only through a workspace or connected app the learner selects and authorizes. Avoid including student numbers, passwords, private school records, or confidential client data in prompts, profile files, or source files.

## Updates

Supported local clients can run the bundled, rate-limited SessionStart updater after the learner reviews and trusts its hook. It checks no more than daily and loads installed changes in a new chat. Web and mobile clients rely on published Plugins Directory releases.

## Development

Validate the plugin from the repository root:

```bash
python3 /path/to/plugin-creator/scripts/validate_plugin.py plugins/kimbi-coach
```

See [INSTALL.md](INSTALL.md) for installation and packaging.
