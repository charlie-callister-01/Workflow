# Updating the workflow in an older project

Type: grilling
Status: resolved
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

## From 06 (2026-11-24)

Migration grows: remove a bare `@AGENTS.md` `CLAUDE.md` (projects carry `AGENTS.md` only), add the `agents:` line, and switch Claude Code from Matt's plugin to home's pinned copies (bare skill names in toolbox skills).

## From 07 (2026-11-24)

The repo profile is a seed recorded under `## Seeded from` in `workflow-settings.md`, read only by setup and refit. Updating includes the seed: when the owner changes the profile (spike to production, personal to shared), refit proposes a line-by-line diff of the seeded lines (Checks, the shared-only block), keeps lines edited since setup by default, and updates the seed record. v1 projects name a `preset:`; the migration maps it to a seed (`full` to `production` or `everyday`, `lite` to `spike` or `everyday`; ask).

## From 17 (2026-11-24)

Versions are `git describe` output, recorded in installed skill stamps and `## Seeded from`; tags only for deliberate releases. Refit takes `-Track beta | production` for template trials and records `workflow_track`; skills have no track (beta skills install side by side via home's copy script, which also removes skills whose source is gone). Updating must keep a project's beta template files until its trial ends.

## Answer

Resolved 2026-11-24 (grilling, two rounds). Decision 0012.

1. **One skill: `/refit-workflow`.** It picks its path from what it finds: no `## Seeded from` and no `workflow_version` -> **merge** (today's analysis, grill brief, decisions table; for repos with their own workflow); seeded -> **update** (list changes, propose one by one, no grill); profile changed -> **re-seed** (07). Refit already owns re-seeding (07) and `-Track` (17), so a separate `/update-workflow` would make three overlapping entry points across two skills.
2. **Template changes merge three ways:** base = the template at the project's recorded version, theirs = the template now, ours = the project's file. Clean changes are proposed as a diff; lines the project edited since setup are kept by default (07); a real conflict is a question to the owner, never an overwrite. This covers point 4 (project edits).
3. **What is offered:** every change on `origin/main` since the project's version, not tags only (tags are rare, 17). Found mechanically from the diff of `templates/` and `platforms/` between the two versions, with the matching `CHANGELOG.md` lines shown as the why. `beta/templates/` only when `workflow_track: beta`; a project on beta keeps its beta files until its trial ends. No new marker in `CHANGELOG.md`.
4. **Migrations** for what a diff can't express (move, rename or delete a project file, retire a setting): one toolbox file per change, `migrations/NNNN-<slug>.md`, saying what and why, when it applies (from which version, which projects), the steps (`git mv` for renames), a check and a rollback. Refit runs every migration newer than the project's version, oldest first, one commit each, before the template merge. Migrations are toolbox files; nothing lands in projects.
5. **Version bookkeeping:** the version line under `## Seeded from` means "this project's files are in step with the toolbox at X". Refit moves it forward after each update, last; it is the merge base (2) and the start point (3, 4). The profile values change only on a re-seed. v1's `workflow_version` line is retired by a migration.
6. **Across repos:** refit works on one session project. Home's sweep (36) runs a cheap check per repo in `## Other repos` (is its seed version behind `origin/main` for project files?), lists the ones behind, and the owner picks; one branch and PR per repo. Shared repos are not skipped, but only ever get the neutral process files they carry (07's shared-only block), never home-only parts.
7. **Finding out:** `/start-session` adds one line when project files have changed since the seed version ("toolbox: N changes for this project, run `/refit-workflow`"), from `git diff --stat` only. Nothing updates on its own.
8. **The v2 migration** for projects primed before v2 is several small migrations, oldest first, one commit each: (a) drop toolbox skill copies: delete `.claude/skills/<name>` only where the name matches a toolbox skill or its description carries the `[wf` stamp; project-only skills stay; shared repos keep only neutral process files; (b) drop the `CLAUDE.md` shim only if its whole content is `@AGENTS.md`, else it becomes a merge question; (c) add the `agents:` line; (d) map `preset:` to a seed (ask stakes: `full` -> `production` or `everyday`, `lite` -> `spike` or `everyday`; ask audience), write `## Seeded from` with the version, retire `preset:` and `workflow_version`. Switching Claude Code from Matt's plugin to home's copies is done in home. Each has its own check and rollback.
9. **v1 projects take the update path:** `workflow_version` without `## Seeded from` is read as "seeded at `workflow_version`"; refit runs the migrations (8), then the template merge. The merge path stays for repos never primed from the toolbox.
10. **Authoring rule:** any toolbox change that moves, renames or deletes a project file, or retires a setting, ships its migration in the same PR, named in its `CHANGELOG.md` line (rule in `DEVELOPING.md`). A migration on trial lives in `beta/migrations/` and runs only on the beta track; its rollback is the rollback line 17 already requires, so `-Track production` runs it.
11. **Script for the mechanics, skill for the talk:** an agent-neutral PowerShell script lists the changes and pending migrations since the version, does the three-way merges into `.scratch/workflow-update/`, and reports clean merges and conflicts. Refit's update path wraps it: shows the result, asks the conflict and migration questions, commits (one per migration, then one for the template merge), one PR per update, a project LOG line, seed version moved forward last.

Glossary: Update, Migration.

## From the inbox (2026-11-25)

The install scripts still copy skills into a project's `.claude/skills/` and `Install-GlobalSkills.ps1` installs only into `~/.claude/skills`, although 06 and 35 removed both. Rebuilding them agent-neutral (home's copy script filling `.agents/skills`) is a Phase 1 roadmap item, ordered first. Until then refit's step 5 deletes retired skill copies (`.claude/skills/ship`, renamed `open-pr` on 2026-11-25, PR #25); that clean-up moves to home's copy script once it exists.

## From 42 (2026-11-26)

Home's stage B removes toolbox skill copies from personal projects on branches (AI Hero's step 4): a migration file under this ticket's mechanism, run by refit's update path.
