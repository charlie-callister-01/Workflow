# Session bookends: what start and end read and write

Type: grilling
Style: rounds
Status: resolved
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

## Answer

Resolved 2026-11-27 (grilling, `rounds`: two rounds). Decision 0018.

### Picks

| Source | Taken | Dismissed or parked |
|---|---|---|
| Pocock | `handoff` points at files by path rather than copying them (the session note does the same); `retro` behind the lesson question; wayfinder's claim before work, so parallel sessions skip each other. | - |
| Osmani | Restartable session boundaries: save five things before clearing (scope and decisions, status and next, files and tree, checks run, open questions); a fresh session re-reads `git status` and never infers approval from an earlier conversation. | - |
| pstack / fstack | `ketchup` as the model for the status page; `reflect`'s approval step for lessons. | fstack's `LEARNED.md` written without asking: rejected, lessons must land as rules or checks, not a second notes file. |
| ICM | Status drawn from files on disk, not a hand-kept document; read down the layers and stop when there is enough. | - |

### Decisions

1. **State model.** Each session branch gets a **session note** holding Osmani's five things, about 15 lines under five headings (Scope and decisions, Status and next, Files and tree, Checks run, Open questions). It stays while the branch's work runs over several sessions; when the work is done `/end-session` folds it into the LOG line and deletes it in the last commit, so `main` collects no notes and git history keeps every version. Facts git or the platform hold are read, never copied in. One note per branch means parallel sessions and teammates (37's STATUS per person) never edit the same lines. HANDOFF retires (40: `/start-session` reads layers 0 and 1 only; 34's load tables say what each stage opens); projects get no shared STATUS. The note's exact location is decided in the **Directory and design** fog (provisionally `.scratch/sessions/<branch>.md`).
2. **`session-facts` script** (POSIX `sh` plus `ps1`, in the skill's `scripts/` folder per 30 point 8), about 10 lines: session project; branch, behind or ahead; newer remote branches; dirty tree; open PRs and whether the current branch's PR merged (then `sync-main`, 15); last LOG line; active map frontier or the session note's next step; idea counts (41); `core.hooksPath` check (30); toolbox changes since the seed version (23). `--end` adds commits since the last LOG line and uncommitted files. Prose stays with the model; plain commands are the fallback. A later SessionStart hook in home only runs this script (30 point 9). The owner asked for low usage overhead: one call, a few hundred tokens, no files opened to infer state; measured in the trial.
3. **`/save-session`**, a small skill: write or refresh the session note, amend today's LOG line, commit and push when allowed or list what is uncommitted and say so, then say plainly "safe to clear". `/end-session` is `/save-session` plus the lesson question, the idea offer and the commit or PR step. Absorbs the Inbox's update-docs, one-step LOG line and "safe to clear" ideas.
4. **Lesson question.** `/end-session` asks "what went wrong that a rule, check or hook would have stopped?"; "nothing" is fine. An answer goes out as one `/idea` line tagged `lesson`; nothing changes without the owner's approval. `retro` on the worst sessions and its cadence stay with 09.
5. **Status page.** A home script the owner runs (`! status`) prints, and writes as a gitignored `STATUS.md` in home, one table: repo | last LOG line (date, gist) | open PRs | next step (session note or LOG `Next:`) | ideas | live sessions (worktrees and branches with an open session note). Home's `/start-session` runs it. Built from files, nothing written twice (36), no agent needed. Projects get no human-first STATUS.
6. **Toolbox README.** `/end-session` no longer keeps "Where I'm up to"; the README points to the map, the CHANGELOG and the status page.
7. **Ideas at the end.** `/end-session` shows idea counts and offers the idea batch at 5 or more (41's threshold); it never runs it on its own.
8. **LOG.** Projects carry `.gitattributes` `docs/LOG.md merge=union`, so local merges and rebases keep both sessions' lines; GitHub's merge button ignores it, so `/open-pr` rebases on `main` first. The line takes an optional `Flow: <flow>` tail, with `(corrected from <flow>)` when the owner changed the agent's first proposed flow (34's marker, for 09). The LOG line rides the session branch (15); if the PR merged before the session ends, it goes in a small docs-only PR.
9. **Missed saves.** No SessionEnd or PreCompact hook. `session-facts` flags a branch with commits after its session note's last update ("the last session may have ended without saving").
10. **v1 projects.** A migration (23's scheme) copies STATUS's "Next action" into a session note on the refit branch, then deletes STATUS and HANDOFF.
11. **Rollout, four modules in three stages.** Stage 1 (this repo, beta track): `session-facts`, the session note, `/save-session`. Stage 2: `/end-session` rework (lesson question, idea offer), HANDOFF and STATUS retired with the migration, the README pointer. Stage 3, with home's build (42): the status page. Passes when `/start-session` uses fewer tokens than today (20's markers), the owner never re-explains where things were after a `/clear`, and no LOG conflict reaches GitHub. Watch: tokens per start and end, re-explanations, missed-save flags.
12. **Map.** New fog patch **Directory and design**, last before Roadmap phases: context layers and every repo's overall layout, decided once the rest is set up; absorbs the directory map item and settles the session note's location.

Glossary: Session note.

### Handed on

- **09**: the `Flow:` marker and corrections in LOG lines; `lesson` ideas and `retro`'s cadence; the trial's token and re-explanation counts.
- **10**: the session note is a new artifact; its location goes to Directory and design.
- **42**: the status script and gitignored `STATUS.md` in home (stage 3).
- **Roadmap items**: `session-facts`, `/save-session`, the `/end-session` rework, the STATUS / HANDOFF migration, the `merge=union` line in templates, the README pointer.
