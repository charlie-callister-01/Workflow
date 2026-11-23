# Multi-agent projects

Type: grilling
Status: open
Blocked by: 01, 02, 35

## Question

When a project uses one or several agents (Claude Code, Cursor, Codex, Copilot), how do the toolbox's skills, instruction files (CLAUDE.md / AGENTS.md / rules) and install scripts work? How far does the toolbox go: open formats only, or install support per agent? And the **agent refit**: how an existing Claude-only project is moved to work with other agents or several at once (choosing the agents at setup or refit). A new skill (`/refit-agents`) or a mode of `/refit-workflow`?

## Settled so far

- 2026-11-22: the instruction file is `AGENTS.md`, with `CLAUDE.md` as the single line `@AGENTS.md` (decision 0006, on trial in `notes/trials.md` with Antigravity CLI). Still open: skills for other agents (Antigravity loads `.agents/skills/`), per-agent adapters, and `/refit-agents` vs a refit mode. The trial's verdict section feeds this ticket.
