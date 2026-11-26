# Session bookends: what start and end read and write

Type: grilling
Style: rounds
Status: open
Blocked by: 15

## Question

What do `/start-session` and `/end-session` read and write, and how does the owner see where things are without asking an agent?

1. **Skill scripts** (30 point 8): which steps become one script each, e.g. a `session-facts` script for `/start-session` (fetch, status, last commits, behind `origin/main`, open PRs, LOG tail, `core.hooksPath` check) and an `/end-session` script that writes the LOG line skeleton and checks for uncommitted work; plain commands as the fallback.
2. **The LOG line after merge** (15 point 2): a new PR, a direct commit to `main` for `docs/LOG.md` only, or the next session's first branch. Blocked by 15 for this.
3. **The lesson question** (05 point 9): `/end-session` asks what a rule, check or hook would have stopped, and sends it as one `/idea` line.
4. **A status page for the owner** (16, merged in; read its notes): a cross-project page in home reading each project's LOG and PRs, versus a human-first STATUS per project; which projects get it.
5. **The toolbox README's "Where I'm up to"** (from 09): whether `/end-session` keeps it current.

**From 40 (2026-11-26), what a session loads at start:** ICM's layers, read top-down, stopping when there is enough. `/start-session` reads layer 0 (`AGENTS.md`) and layer 1 (`workflow-settings.md`, the LOG tail or STATUS, the active map) and stops there: it names the next step without opening layer 3 (`docs/agents/*.md`, `GLOSSARY.md`, decisions) or layer 4 (specs, tickets, code).

Created in the map refit (2026-11-24) from parts of 15, 16 and 09. Related: 24 (merged into 15), 20 (markers for the saving), 36 (session project).
