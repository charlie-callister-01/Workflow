# Hooks: the toolbox's enforcement layer

Type: grilling
Status: open
Blocked by: none

## Question

Which rules move from prose into Claude Code hooks, and how do hooks reach a project? Candidates: a PreToolUse guard on commits and pushes to `main` (plus GitHub branch protection as the real guard), blocking edits to `.claude/skills/` in this repo, blocking stray `.md` writes outside an allow-list, a SessionStart hook that feeds `/start-session` its git and PR facts, a SessionEnd note when `/end-session` was skipped, a Stop hook that runs tests. Decide: which hooks, PowerShell 5.1 or Git Bash, shipped in `templates/`, globally, or as an optional kit, and trialled on the beta track (17). Hooks back the session skills, not replace them (29).

Related: 24 (leaner ship and end-session), 25, 29; research in `notes/research/2026-11-23 Loops, sandboxes and session hooks.md`.
