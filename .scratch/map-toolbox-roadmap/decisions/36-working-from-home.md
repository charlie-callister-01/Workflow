# Working from home: session skills across repos

Type: grilling
Status: resolved
Blocked by: none

## Question

Since 35, every session starts in the home repo and works on a sibling repo by pointer, but the toolbox's session skills assume the session runs *inside* the project: `/start-session` reads `docs/agents/workflow-settings.md` relative to the working folder, `/ship` branches and opens a PR in the current repo, `/end-session` writes that repo's `docs/LOG.md`. How do they work from home?

Points to decide:

1. **Choosing the project:** how a session says which repo it is working on (argument, question at start, a "current project" line in home), and whether a session may touch several repos.
2. **Where each skill acts:** which repo's settings, branch, PR, LOG and STATUS each session skill uses; what home itself records (e.g. a cross-project log).
3. **Moving into the project:** when the session should `/cd` (or start) inside the project instead, e.g. so the project's hooks run (30), and how the agent-agnostic default ("read its `AGENTS.md` first") holds for other agents.
4. **The toolbox as a project:** this repo is also worked on from home, but it is where the skills are developed: how its own changes are tried (home's copy script from the working tree, or `beta/`, 17) without breaking the copies home uses for other projects.

Related: 35, 15 (after implementation), 16 (status page), 17 (beta track), 30 (hooks), 34 (router).

## Answer

Resolved 2026-11-24 (grilling, three rounds), checked against [AI Hero: The Home Repo Pattern](https://www.aihero.dev/the-home-repo-pattern) (research 27). No new decision record: decision 0009 already holds the hard-to-reverse part.

1. **Session project** (glossary): the one repo a session works on, fixed at the start. Every session skill acts on its path and its `docs/agents/workflow-settings.md` (`git -C <path>`, `gh` against its remote), never on whichever folder the agent is in. It may be a project, the toolbox, or home itself. Each skill names the session project in its first line.
2. **Choosing it:** `/start-session <repo>`, or, with no argument, it lists home's repos and asks. Nothing is stored in a file (a "current project" line goes stale and clashes with parallel sessions). The repos list is an `## Other repos` table in home's `AGENTS.md`: name | relative path | clone URL | kind (personal / shared, feeds 07) | one line on what it is. If the path is missing, offer to clone it (as in the article). The toolbox documents this format generically and never names home (35: links go one way).
3. **Fallback when `/start-session` didn't run:** use the session project already named in the conversation; otherwise the current folder, if it holds `docs/agents/workflow-settings.md`; otherwise ask. Never guess between two repos.
4. **The project's rules:** nothing loads a sibling repo's `AGENTS.md` by itself (35 fact check), so `/start-session` reads the session project's `AGENTS.md` and settings explicitly and says so; the project wins over home where they conflict. Skipped when the session started inside the project. Check the session project's git remote, not home's (Pocock's setup fix, 11).
5. **One session project per session.** Another repo is changed only when named (`/ship <repo>`), on its own branch and PR; small notes about other repos go to `/idea`. Home as the session project drives work across repos (e.g. updating every repo): one repo at a time, a branch and PR each, one summary table at the end, PRs approved per repo or as a batch. Home is primed like any project (its own `AGENTS.md`, settings, LOG); the sweep scripts belong to home's harness.
6. **Where each skill acts:** `/start-session` reads the session project's git, PRs and log; `/ship` branches and opens the PR there; `/end-session` writes the LOG line there, naming any other repo's PR in the same line. Home records nothing per session (a cross-project view can be read from each project's LOG; 16), except when home is the session project.
7. **Parallel sessions on one repo:** if the clone is dirty or on another session's branch, `/start-session` offers a git worktree at `<project>/.worktrees/<branch>` (gitignored, plain git so every agent can use it), and the session project's path becomes the worktree. Cleanup after merge is 15's.
8. **Where to start:** home is the default; every project still works opened on its own (other agents, teammates, a session started inside it), since the skills don't depend on the starting folder. When a session must start in the project so its hooks run is 30's.
9. **The toolbox as a session project:** home's copy script copies skills from a fixed ref (`origin/main` by default, via `git show` / `git archive`), never from the toolbox working tree, so half-finished branches don't leak into other projects' sessions. Trying a branch means naming it to the script; that changes the copies for every project until the script runs again without a ref. Per-project beta stays with 17.

Traps checked against the article: project rules not loading (point 4), pointer format and clone-if-missing (2), two sessions in one clone (7, the article's worktree-per-feature), nested repos (ruled out by 35), scale (~20 repos fine, per-area pointer files beyond; not needed yet). The article doesn't cover hooks or permissions (30).
