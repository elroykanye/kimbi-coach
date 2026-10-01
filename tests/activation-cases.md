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
