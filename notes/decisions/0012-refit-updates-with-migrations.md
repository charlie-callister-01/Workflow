# Refit updates projects, with migration files

Status: **accepted** (2026-11-24), roadmap decision ticket 23 (Updating the workflow in an older project). Not built yet.

Bringing a primed project up to date is a path of `/refit-workflow`, not a new skill: refit picks **merge** (a repo with its own workflow), **update** (a seeded or v1 project) or **re-seed** (profile changed) from what it finds. An update three-way merges each template (base = the template at the project's seed version), so project edits are kept and conflicts become questions, then moves the seed version forward. What a diff can't express (moving, renaming or deleting a project file, retiring a setting) goes into a toolbox **migration** file, `migrations/NNNN-<slug>.md`, with steps, a check and a rollback, shipped in the same PR as the change and run once, oldest first, one commit each.

Over: (a) a separate `/update-workflow` skill, smaller and more mechanical, but a third entry point next to refit's re-seed (0010) and `-Track` (0011), with two skills to keep in step; (b) overwriting templates from the toolbox, simple but loses each project's edits; (c) describing moves only in `CHANGELOG.md` prose, which leaves every update to re-derive the steps and has no rollback.

Trade-off: refit grows a fork and its description must name all three jobs; every file-moving toolbox change costs a migration file; three-way merges need the toolbox's git history at the seed version, which home's clone has.

Reverse it if: the update path is used often and the merge path almost never, so a small `/update-workflow` would be clearer; or migrations pile up faster than projects take them, so a periodic re-seed beats replaying them.
