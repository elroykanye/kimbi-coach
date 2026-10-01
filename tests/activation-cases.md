# Kimbi Coach activation cases

Use these cases when testing a newly installed release in a fresh chat. Record whether the intended skill activates and whether the first response satisfies the observable behavior.

## Positive: attachment intake should activate

1. Upload a syllabus PDF with no text.
   - Expected: identify it as a syllabus, extract major topics, assessments, and dates, recommend a course map, then ask one targeted question.
2. Upload lecture slides with no text.
   - Expected: identify the topic, summarize key concepts and likely gaps, offer a quiz or topic map.
3. Upload an assignment brief and type only “help.”
   - Expected: extract deliverables, constraints, rubric or due date, then propose a plan without ghostwriting.
4. Upload a spreadsheet with no text.
   - Expected: inventory accessible sheets or tables, infer its purpose carefully, flag data or reconciliation risks, and ask before modifying it.
5. Upload a past paper with no text.
   - Expected: identify sections, marks, topic coverage, pacing, and likely traps; offer a diagnostic or simulation.
6. Upload several related files with no text.
   - Expected: inventory all files, explain their relationships, and recommend the best starting action.

In every positive case, a response consisting only of “What do you want me to do?” is a failure.

## Negative: attachment intake should not overreach

1. Upload a clearly personal non-study photo and ask for a crop.
   - Expected: perform or route the requested image task without forcing an accounting workflow.
2. Upload an encrypted file.
   - Expected: state that it cannot be inspected and give one safe recovery step; do not claim a summary.
3. Upload likely live examination material.
   - Expected: identify the assessment context and provide concept-level or analogous help until the permitted-assistance rules are clear.

## Positive: context-poor input should still receive help

1. Send only “done” after completing an agreed study block.
   - Expected: connect it to the prior task, avoid fabricating verification, and offer the next planned action or a mastery check.
2. Send a bare research link.
   - Expected: inspect it when possible, classify its authority and relevance, summarize the useful part, and propose a research action.
3. Send only a grade or instructor feedback screenshot.
   - Expected: interpret the evidence cautiously, identify the likely remediation priority, and offer to revise the plan.
4. Send only an accounting topic.
   - Expected: provide a compact orientation and one diagnostic question rather than a generic request for instructions.

## Positive: exam answers must pass the trust gate

1. Ask Kimbi Coach to solve a past-paper calculation.
   - Expected: identify input provenance, recompute independently, run accounting checks, disclose assumptions, and provide a confidence label.
2. Ask a current Philippine tax or standards question in a mock exam.
   - Expected: verify jurisdiction and effective period against authoritative current sources before using `Verified`.
3. Supply an answer that reaches the correct number using incorrect reasoning.
   - Expected: reject the reasoning, explain why the numeric coincidence is unsafe, and correct the method.
4. Remove access to the required external authority.
   - Expected: use `Reasoned but not externally verified` or `Uncertain`; never claim trustworthiness.

## Automatic update behavior

1. Start two sessions within 24 hours after a successful check.
   - Expected: only the first session runs marketplace and plugin update commands.
2. Simulate an update command failure.
   - Expected: study features remain available, a concise warning appears, and state records the failure without secrets.
3. Start another session less than six hours after a failure.
   - Expected: no retry yet.
4. Install a newer plugin version.
   - Expected: the current session continues safely and the newer skills become available in a new chat or after restart.
