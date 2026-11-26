# Ship and after: from PR to clean branch

Type: grilling
Style: rounds
Status: resolved
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

## Answer

Resolved 2026-11-26 (grilling, `rounds`: two rounds). Built under the owner's staged, modular principle (map Main takeaways): every part below is a module with settings, a trace and an evaluation, and all of it will be tuned per repo over time.

### Picks

| Source | Taken | Dismissed or parked |
|---|---|---|
| Pocock | The `pr` skill writes code PR bodies (summary, evidence, merge danger). | `retro` placement: 09. |
| Osmani | Small, atomic PRs. | An extra pre-launch checklist: covered by 05's three-question check and 31's evidence. |
| pstack / team kit | A CI loop with a finish condition. | The PR-care canvas parked. |
| ICM | The PR body and the LOG line are the stage's reviewable files. | - |
| Built-ins, research | Ship / Show / Ask (Fowler); a `gh api` REST fallback for cloud sessions (29). | Ship (straight to `main`): 30's guard refuses it. `/steward`: an optional Claude-only extra (06, 35). |

Evidence that drove it: this session alone opened four PRs (#31 to #34) plus an end-session PR; on docs-only work most of the shipping cost is ceremony.

### Decisions

1. **One branch per session.** A session's docs and notes (ticket answers, notes, CHANGELOG, the LOG line) go on one branch and one PR. A separate PR only for code (merge commit, not squash), a second repo, or when the owner wants something merged mid-session; the branch then carries on from the updated `main`.
2. **Show and Ask.** Docs-only PRs are Show (opened, merged by the owner without waiting for review); code PRs are Ask. Ship is rejected (30).
3. **Docs-only fast path.** No explainer, a short body (summary and changed files) instead of a full `/pr` run. A cheap consistency pass (light mode of the strict review of written work) once that skill exists (34). Auto-merge after CI is available but off.
4. **When `/open-pr` runs.** Offered when a unit of code work passes verify, and at session end for the session branch. Whether it opens unasked follows 31's `autonomy` (loose opens; normal and ask-first offer in one line). To be tuned over time.
5. **Watching CI.** Where the repo has CI, `/open-pr` ends by watching the checks; on a failure it fixes, pushes and watches again, up to `ship.ci_tries` (3), then stops and reports. Review comments only when the owner asks. Repo-specific and expected to evolve.
6. **After merge.** A `sync-main` skill script: switch to `main`, pull, delete the merged local branch (squash merges detected through the platform), remove its worktree, prune. Run when the owner says "merged", and by `/start-session` when the current branch's PR has merged. The periodic branch sweep (archive tags for unmerged branches) moves from `/end-session` to `sync-main --sweep`.
7. **A second repo.** One PR per repo, each opened by `/open-pr` against that repo's path, linking each other; the session project's LOG line lists both. Leans on home's session-project mechanics (36), where most cross-repo work runs.
8. **Scripts.** `pr-facts` (branch, clean tree, pushed, code or docs-only per `code_pattern`, open PR), `ci-watch` (pass or fail) and `sync-main`. POSIX `sh` plus `ps1` (30, 42). They try `gh pr ...` first and fall back to `gh api` REST where GraphQL is blocked. Writing the body stays with the model.
9. **Settings** (in the Checks section, form from 31): `ship.mode` (show / ask; default show for docs-only, ask for code), `ship.automerge.docs` (off), `ship.ci_watch` (on where CI exists), `ship.ci_tries` (3). None seeded: defaults live in `/open-pr` and its guide, and a project adds a line only to change one. **Observable:** `/open-pr` writes the ship settings in force into the PR's `## Verification` section beside 31's Checks lines.
10. **Cheap on usage and context.** Scripts print summaries, never raw logs: `pr-facts` about 6 lines, `sync-main` one line per action, `ci-watch` `pass`, or the failing checks' names and the last ~30 lines of the failing log. The model fetches more only when a failure needs it. The trial measures tokens per `/open-pr` run and per session with 20's markers.
11. **Staged rollout.** Stage 1: one branch per session plus the docs-only fast path (no new scripts), trialled in this repo. Stage 2: `pr-facts` and `sync-main`. Stage 3: `ci-watch`, on a project with CI. Each stage runs about a week, watched for PRs per session, tokens per ship and anything lost (a branch deleted early, a change left unmerged). Stage 1 passes when docs-only sessions end with one PR (two if a mid-session merge was wanted) and nothing is lost. **Open, from the owner:** whether trials should be per module rather than `<skill>-beta` copies (17's mechanism); noted on 09 and the Roadmap phases fog.
12. **Modules** (each switchable on its own, all staying observable and configurable): session-branch (depends on nothing), docs fast path (`code_pattern`), ci-watch (CI on the platform), sync-main (the platform CLI), cross-repo PRs (home's session project, 36). One guide, **Shipping**, covers all five: what each does, its settings, how to tell it is working, its evaluation.

### Handed on

- **09**: the evaluation of each stage (markers, pass conditions, keep / tune / drop); the owner's question whether trials go per module rather than per `<skill>-beta` copy.
- **10**: where the Shipping guide lives.
- **34**: the consistency pass for docs-only PRs (light mode of the strict written-work review).
- **37**: no ship lines seeded; the guide documents the defaults.
- **39**: the LOG line goes on the session branch (point 1 settles point 2 of the 24 merge-in for the usual case); `/start-session` runs `sync-main` when the current branch's PR has merged; `/end-session` loses the branch sweep.
- **Roadmap items**: the three scripts, the Shipping guide, and the three-stage trial.

Decision 0015.
