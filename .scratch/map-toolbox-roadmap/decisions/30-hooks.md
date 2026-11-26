# Hooks: the toolbox's enforcement layer

Type: grilling
Status: resolved
Blocked by: 36, 07

## Question

Which rules move from prose into Claude Code hooks, and how do hooks reach a project? Candidates: a PreToolUse guard on commits and pushes to `main` (plus GitHub branch protection as the real guard), blocking edits to `.claude/skills/` in this repo, blocking stray `.md` writes outside an allow-list, plus (decided elsewhere) session hooks in 15 and a test-running Stop hook in 31. Decide: which hooks, PowerShell 5.1 or Git Bash, shipped in `templates/`, globally, or as an optional kit, and trialled on the beta track (17). Session hooks moved to 15 and the test-running Stop hook to 31 (2026-11-23); this ticket keeps the guard hooks and how all hooks ship.

Related: 15 (after implementation, with 24 merged in), 25, 29; research in `notes/research/2026-11-23 Loops, sandboxes and session hooks.md`.

## From 05 (2026-11-23)

Candidate: a hook that warns on edits outside the plan's Scope block (`Touch` / `Never`). Possibly: automating the `notes/upstream.md` sync.

## From 35 (2026-11-24)

Sessions start in the home repo, and a project's hooks don't run there (only when the session starts in, or `/cd`s into, the project). Decide whether must-hold hooks live in each project, in home (working for every project), or both. Prefer checks every agent obeys (git hooks, CI) over Claude-only ones.

## From 35, review (2026-11-24)

Reframed: the title says "Claude Code hooks", but the owner wants the workflow agent-agnostic. Rank enforcement as git hooks and CI or branch protection first (every agent and teammate obeys them), agent hooks second (per agent, home or project). Shared repos get only neutral checks.

## From 36 (2026-11-24)

Home is the default starting place and projects still work on their own (36). Decide when a session must start inside the project so its agent hooks run, or whether git hooks and CI make that unnecessary.

## From 06 (2026-11-24)

Per-agent settings, permissions included, live in home (06); a project gets agent-specific config only for a shared repo's team need.

## From 07 (2026-11-24)

No hook or skill may read the profile to change behaviour: behaviour lives in concrete, editable lines. If stakes should turn on a hook (e.g. guard hooks for `production`), setup seeds the hook config as ordinary files, which the project then owns.

## Answer

Resolved 2026-11-24 (grilling, three rounds). No decision record: the hard-to-reverse part (agent-agnostic enforcement) is decision 0009.

1. **Layers, in order:** platform rules and CI (GitHub branch protection or rulesets, Azure branch policies) first; **git hooks** in the project second; **agent hooks** (Claude `PreToolUse`, `SessionStart`, ...) third, as optional extras. A rule moves from prose into a check only when a recorded failure shows it's needed (25, 26), never because a hook could enforce it.
2. **Guard against committing to `main`:** `pre-commit` and `pre-push` git hooks refuse `main` / `master` and name the fix ("create a branch: `feature/<name>`"), backed by branch protection where the platform allows it. This repo's `main` has none today (checked 2026-11-24): turning it on is a roadmap item. No agent hook does this job.
3. **Dropped candidates:** blocking edits to `.claude/skills/` (no repo carries skill copies after 35 and 06; the toolbox's own copies go in the v2 migration, 23); the `.md` allow-list (no recorded failure; returns as a `pre-commit` check only through 09's ratchet); the Scope-block warning from 05 (`/ship`'s three-question check covers it; 32 may make it a CI diff check); automating the `notes/upstream.md` sync (stays 05's monthly step, at most a script that prints the upstream diff since the pinned commit).
4. **Where a session starts doesn't matter for enforcement:** must-hold rules are git hooks, which fire for every agent, person and starting folder, so a session never has to start inside the project for its rules to hold.
5. **Hooks in the project harness:** git hooks are seeded by stakes (point 6). Agent hooks get into a project only when the owner adds them or a shared repo's team needs them (06 point 5); either way the project owns and edits them, and refit keeps its edits (23).
6. **Shipping git hooks:** `templates/.githooks/` holds them as small POSIX `sh` scripts (git runs them with its own `sh` on every OS, so a teammate's Mac works too; the logic stays in `sh`). Seeded for stakes `everyday` and `production`, none for `spike` (37). `/setup-workflow` and `/refit-workflow` run `git config core.hooksPath .githooks`; that setting doesn't travel with a clone, so `/start-session`'s facts check spots it missing and offers to set it.
7. **Trial:** a template trial (17), `beta/templates/.githooks/`, on this toolbox plus one personal project with `-Track beta`. Rollback: unset `core.hooksPath` and delete `.githooks/`. Review after 1 week.
8. **Script first, agent for judgement:** a step that does the same thing every run is a **skill script** the skill calls once, not a string of agent tool calls; the skill keeps only proposing, summarising and asking. Skill scripts live in the skill's folder (`skills/<skill>/scripts/`, part of the Agent Skills format), so home's copy script brings them and no project carries them; the skill body names the plain commands as a fallback. Principle goes in `DEVELOPING.md`. Which steps become scripts (session facts for `/start-session`, the LOG line for `/end-session`, switching to `main`, pulling and deleting merged branches after merge) is 15's for `/ship` and after merge, and 39's for `/start-session` and `/end-session` (map refit), with the saving measured by 20's markers. For a one-off, the owner can type `! git switch main; git pull`, which costs no model reasoning.
9. **Agent hooks only start scripts:** none are built now. Later, an agent hook (e.g. a `SessionStart` in home running the same session-facts script as `/start-session`) only starts an existing script and holds no logic of its own. **Portable agent hooks** (one script, plus a per-agent trigger file home's copy script writes for each agent that has hooks) arrive only through 09's ratchet, after a recorded failure (map refit, 2026-11-24).
10. **Skipping hooks (`--no-verify`):** no new rule. Agents are already told not to; the hook's refusal message gives the proper route; branch protection catches the rest.
11. **Languages:** POSIX `sh` for git hooks; PowerShell 5.1 for home's agent hooks and the toolbox's other scripts.

Glossary: Git hook, Agent hook, Skill script.

## From 41 (2026-11-26)

`/idea` is the first **portable agent hook**: a thin per-agent trigger that starts the `idea` script, justified by saving usage and context rather than by a recorded failure (an exception to this ticket's rule, made by the owner). Home's `pre-commit` hook allows a direct commit to `main` for `inbox/` only.

## From 42 (2026-11-26)

Two more checks, built in home's stage E: the toolbox clone's pre-push hook greps the outgoing diff against home's private deny-list (`../home/private-terms.txt`, a no-op when absent), and a secret scanner (e.g. gitleaks) runs in the toolbox's CI.
