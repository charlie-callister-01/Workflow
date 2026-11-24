# Updating the workflow in an older project

Type: grilling
Status: open
Blocked by: 35, 07

## Question

How does a primed project that took the toolbox some time ago (its `workflow_version`) get brought up to date: a new `/update-workflow` skill, or a mode of `/refit-workflow`? Today refit says it is "also used to update a primed repo" (its step 1 lists toolbox changes since `workflow_version`), but its steps are built for merging two different workflows: a wide analysis, a grill brief, decision groups. Updating is a narrower job: what changed in the toolbox since my version, and which of those changes does this project take?

Points to decide:

1. **One skill or two:** a separate `/update-workflow` (small, frequent, mostly mechanical), or refit with an update path (one entry point, refit spots `workflow_version` and skips the grill)? Weigh: two skills to keep in step versus one skill with a fork.
2. **What counts as an update:** changed skill copies (refresh from the toolbox, the `-Force` re-sync idea in `ideas.md`), changed templates (merge into the project's filled-in copies, never overwrite), new settings lines, files that moved or were renamed (e.g. `CLAUDE.md` -> `AGENTS.md`, the first v2 change).
3. **Which changes to offer:** all of `git log <workflow_version>..HEAD`, or only tagged releases? How `CHANGELOG.md` lines and release tags are written so an update can list them per project (and skip `beta/` unless the project is on the beta track).
4. **Project edits:** a project may have changed its copy of a skill or template. Detect that (diff against the toolbox at `workflow_version`) and ask, rather than overwrite.
5. **Files that move:** an update that creates or moves project files (like the `AGENTS.md` change) needs the same care as a trial: a rename via `git mv`, one commit per change, a rollback line.
6. **Fit with distribution:** if the toolbox later ships as a plugin, skills update themselves and only templates and settings are left. Decide whether this ticket assumes copies, or settles copies vs plugin as well (map fog: "Distribution and updates").

Related: 17 (release tracks and promotion), 09 (evolution loop).

## From 35 (2026-11-24)

Point 6 is settled: copies, no plugin. Skills no longer live in projects (home copies them from the toolbox), so an update to a project is templates, settings and file moves only; updating skills is "pull the toolbox, rerun home's copy script". Shared and work repos carry only process files.

## From 35, review (2026-11-24)

Also: a one-time **migration** for projects primed before 35, which carry `.claude/skills/` copies: remove the copies the owner now gets from home, keep project-only skills, and for shared repos leave only process files. Points 1, 2 and 4 shrink accordingly, since skills no longer live in projects.

## From 36 (2026-11-24)

Updating every repo is a home sweep (36): home as the session project, one branch and PR per repo, one summary at the end. Decide here whether `/update-workflow` (or refit's update path) runs across home's `## Other repos` table, and which repos it skips (kind = shared).
