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

## From 41 (2026-11-26)

`/start-session` shows idea counts from the `idea` script (`Ideas: <project> N · toolbox N · knowledge N`) and offers the idea batch at 5 or more. Decide here whether an end-of-day step (e.g. `/day-log` or `/end-session`) also runs the batch.

## From 15 (2026-11-26)

One branch per session (15 point 1): the LOG line goes on the session branch, settling the usual case of "where the LOG line goes". `/start-session` runs the `sync-main` script when the current branch's PR has merged. The periodic branch sweep leaves `/end-session` for `sync-main --sweep`.

## From 34 (2026-11-26)

`/start-session` reads layer 0 only for routing (13's six-line flow and size table in `AGENTS.md`), never `change-flows.md`. If 09 wants owner corrections of the first proposed flow counted, the LOG line may carry a marker; its format is this ticket's.

## From 37 (2026-11-27)

`presets/team.md` is retired; its idea of STATUS per person (or replaced by the board) for shared repos comes here, alongside the session-specific STATUS lines idea in the Inbox.

## From the inbox (2026-11-27)

- **Mid-session save**, one idea merged from three Inbox items (update-docs skill, one-step LOG line, "safe to clear"): refresh the state or LOG line (append today's, or amend it if one exists), commit or list uncommitted work, write down open questions, then say plainly that it is safe to clear. No branch sweep or reminders; the LOG line rides on the session branch (15). Decide whether it is its own skill or script, or a light mode of `/end-session`.
- **Session-specific state**: each session or worktree keeps its own lines (branch, what it is on, next step), possibly one small file per session keyed by branch (the pattern of 41's one inbox file per machine), so parallel sessions read the right context and never edit the same lines. Joins 37's STATUS per person for shared repos. Ties to 36 (worktrees).
- **Tracking running sessions** (which repo, branch or worktree, what each is on, idle or finished) feeds the status page; the launcher itself is in `## For home`.
