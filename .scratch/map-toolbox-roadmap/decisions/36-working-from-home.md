# Working from home: session skills across repos

Type: grilling
Status: open
Blocked by: none

## Question

Since 35, every session starts in the home repo and works on a sibling repo by pointer, but the toolbox's session skills assume the session runs *inside* the project: `/start-session` reads `docs/agents/workflow-settings.md` relative to the working folder, `/ship` branches and opens a PR in the current repo, `/end-session` writes that repo's `docs/LOG.md`. How do they work from home?

Points to decide:

1. **Choosing the project:** how a session says which repo it is working on (argument, question at start, a "current project" line in home), and whether a session may touch several repos.
2. **Where each skill acts:** which repo's settings, branch, PR, LOG and STATUS each session skill uses; what home itself records (e.g. a cross-project log).
3. **Moving into the project:** when the session should `/cd` (or start) inside the project instead, e.g. so the project's hooks run (30), and how the agent-agnostic default ("read its `AGENTS.md` first") holds for other agents.
4. **The toolbox as a project:** this repo is also worked on from home, but it is where the skills are developed: how its own changes are tried (home's copy script from the working tree, or `beta/`, 17) without breaking the copies home uses for other projects.

Related: 35, 15 (after implementation), 16 (status page), 17 (beta track), 30 (hooks), 34 (router).
