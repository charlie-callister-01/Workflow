# Move setup and refit's fixed rules into the install script

Status: needs-triage
Notes: Waits on roadmap tickets 07 and 23, because decision 0009 changes what setup and refit do.

## What

The rule for which instruction file to keep (four branches for which of `CLAUDE.md` and `AGENTS.md` exists) is written in three places: `skills/setup-workflow` steps 5 and 7, `tools/Install-Workflow.ps1:48-55`, and `skills/refit-workflow:19,31`. Move the fixed rules (the manifest, which instruction file to keep, which settings lines to delete) into the script, where a dry-run test can check them. The skills keep only the questions and the judgement calls.

## Done when

- [ ] The instruction-file rules live only in the script.
- [ ] The smoke test checks the manifest and the settings lines, not just the copy.
- [ ] CHANGELOG line.

## Comments
