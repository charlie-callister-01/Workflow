# Ship and after: from PR to clean branch

Type: grilling
Style: rounds
Status: open
Blocked by: 13, 36, 31

## Question

_Narrowed by the map refit (2026-11-24, last section): where they differ, the refit note wins._

What happens after `/ship`: PR review and CI, merge, what `/end-session` updates, what happens to the spec folder and its work tickets (archive, or fold into living docs as OpenSpec does), lessons to the vault (link to 10), branch cleanup, and release or deploy where a project has one? Which parts belong in `/ship`, `/end-session` or a new step?

## Merged in: 24, leaner /ship and /end-session (2026-11-23)

Goal: as few PRs as a session needs and fewer tokens. Points carried over:

1. **One branch per session:** one working branch and PR for a session's notes and docs changes, shipped once; what still splits PRs (code vs docs, merge types). Ship / Show / Ask (research 29) as the model: notes Ship or Show, `skills/`, `tools/`, `templates/` Ask.
2. **Where the LOG line goes** once the session's PR has merged: a new PR, a direct commit to `main` for `docs/LOG.md` only, or the next session's first branch.
3. **Docs-only fast path:** skip parts of `/ship` (the `/pr` run, the full body) or auto-merge after CI ("GitHub personal mode" in `ideas.md`).
4. **Usage:** which steps of `/ship`, `/end-session` and `/start-session` cost the most tokens and can be trimmed (measure with 20's markers).
5. **When `/ship` is offered:** automatically, at session end only, or when asked.
6. **Cloud sessions** block GitHub GraphQL, so `/ship` needs a `gh api` fallback there (research 29).

Related: 30 (hooks back the session skills), 21.

## Moved in from 30: session hooks (2026-11-23)

A SessionStart hook that feeds `/start-session` its git and PR facts (up to 10,000 characters; can't block), and a SessionEnd hook that leaves a note when `/end-session` was skipped (can't talk to the model; 1.5 s budget). Hooks back the session skills, never replace them (research 29). How hooks are shipped and trialled is 30's; 15 decides what these two do.

## From 05 (2026-11-23)

Where `retro` sits after `/ship` (05 adopted it as the ratchet's review step); `/end-session` gains the lesson question. The CI watcher and PR care (team kit, Compound Engineering) are candidates here.

## From 35 (2026-11-24)

Sessions start in home (36 decides how the session skills act there). Lessons go to the knowledge repo, not the vault. The SessionStart and SessionEnd hooks would be home's, not each project's, and are Claude-only: prefer an agent-neutral form where one exists. A home session that touches several repos means one PR per repo, which affects "one branch per session".

## From 36 (2026-11-24)

Each session skill acts on the session project (36). Decide here: removing a worktree at `<project>/.worktrees/<branch>` after its PR merges; how a session that changed a second, named repo ships (one PR per repo, both listed in the session project's LOG line).

## From 30 (2026-11-24)

Script first (30 point 8): a step that does the same thing every run becomes a skill script in the skill's folder, called once, with plain commands as a fallback in the body. Decide here which steps of `/ship` and after merge become scripts (the start and end steps moved to 39 in the map refit). The owner's examples: a `session-facts` script (fetch, status, last commits, behind `origin/main`, open PRs, LOG tail, `core.hooksPath` check) that `/start-session` runs once and only reasons over; an `/end-session` script that writes the LOG line skeleton and checks for uncommitted work; a sync-main script after merge (switch to `main`, pull, delete merged branches, remove the worktree). Measure the saving with 20's markers. The SessionStart and SessionEnd hooks, if ever built, only start these same scripts (30 point 9).

## Map refit (2026-11-24)

Session C, narrowed to the PR lifecycle (read by `/ship` and the platform docs). Keeps: points 1, 3, 5 and 6 of the 24 merge-in; PR review and CI, the CI watcher and PR care (05); PRs for a second, named repo (36); a sync-main skill script after merge (switch to `main`, pull, delete merged branches) and worktree and branch cleanup. Blocked by 31: the evidence `/ship` reads and any docs-only skip are 31's answer.

Moved out:
- Point 2 (where the LOG line goes after merge), the start and end skill scripts and the lesson question: 39, session bookends.
- Point 4 (token trimming): measurement with 20's markers, a roadmap item, not a decision.
- Session hooks: answered by 30 (agent hooks only start existing scripts; none built now).
- What happens to the spec folder and its work tickets: 14.
- Release or deploy: 31.
- Where `retro` sits after `/ship`: 09, which now owns all of `retro`.

## From the inbox (2026-11-25)

The docs-only fast path (point 3): issue #16 asked for "at most a cheap consistency pass" on docs-only changes. A light mode of the planned strict review of written work (see 34's inbox note) is a candidate for that pass.

## From 31 (2026-11-26)

`/open-pr` runs a runnable `Check:` itself and writes a `## Verification` section in the PR body: the evidence (command and output tail, or screenshot path) and the Checks lines in force. It refuses a code-changing PR (per `code_pattern`) without it. Release and deploy are settled in 31 (the `deploy` setting, off unless the project deploys).
