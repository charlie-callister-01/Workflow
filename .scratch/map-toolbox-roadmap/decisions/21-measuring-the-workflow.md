# Measuring the workflow

Type: grilling
Status: open
Blocked by: 20

## Question

Which few markers does the toolbox track, collected automatically only (no self-rating), to answer "is this beta better than production": e.g. session-start context weight, tokens per change flow, subagent tokens, plan usage, time from spec to merge? Where are they recorded, and how do they feed the success checks in `notes/trials.md` (17)?

## From 35 (2026-11-24)

All sessions now start in home, so Claude Code's transcripts for every project land under home's folder; markers must be split per project from the session itself (e.g. the project chosen at start, 36). The transcript source is Claude-only; note what other agents would lose.
