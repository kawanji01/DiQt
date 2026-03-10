---
name: review-fix-pass
description: Review the current uncommitted diff against the latest review report, apply only high-confidence fixes, and return a structured result for iterative loops.
---

# Review Fix Pass

Use this skill when the user wants to repeat "review uncommitted changes -> fix -> review again" until findings are exhausted.

## Workflow

1. Read the latest review report from the prompt before doing anything else.
2. Inspect the current working tree with `git status --short`, `git diff --stat`, `git diff --cached`, and `git diff`.
3. If multi-agent is enabled and helpful, ask `explorer` to map the affected code paths and `reviewer` to challenge or prioritize the reported findings before you edit.
4. Fix only findings you can resolve with high confidence from the current diff and repository context.
5. Keep unrelated user changes intact. Never revert or overwrite edits that are not required for the reviewed issue.
6. Run only the validation explicitly requested in the prompt. Do not guess broad commands if the prompt says not to.
7. The final response must match the requested JSON schema exactly.

## Behavior Rules

- Prioritize correctness, security, regressions, and missing tests.
- Avoid style-only edits.
- Make the smallest defensible change.
- If the review report is already satisfied by the current diff, return `clean` without churn.
- If a finding needs product judgment, wide refactoring, or external clarification, keep it in `findings_remaining` and use `blocked` when the pass cannot proceed safely.
