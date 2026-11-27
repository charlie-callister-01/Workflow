# Release tracks: production, beta and promotion

Type: grilling
Status: resolved
Blocked by: 36

## Question

How do the agreed release tracks work in practice? Settled already (grill, 2026-11-22; principles in `DEVELOPING.md`, "Pace and release tracks"):

- **Production** = `skills/`, `templates/` etc. on `main`, tagged per release. **Beta** = a `beta/` overlay folder mirroring the repo with full changed copies (`beta/skills/ship/SKILL.md`). Changes on trial are listed in `notes/trials.md` with a success check, trial project, notes and verdict.
- Switching a project to beta replaces only the files the beta changes; project data is untouched; `workflow_track: beta` sits beside `workflow_version`. Going back restores the production copies. A beta change that creates or moves project files needs a written rollback line in `trials.md`, or it can't go on trial mid-project.
- Skill descriptions start `[wf]`; the install stamps `[wf vX.Y]` or `[wf vX.Y beta]`.

Success checks use the markers decided in 21 (Measuring the workflow). Left to decide: the `Install-Workflow.ps1` / `/setup-workflow` / `/refit-workflow` changes (`-Track beta` overlay, stamping the label, recording `workflow_track`, rollback); how promotion and drop run (move the copy over, archive, tag, `trials.md` verdict); how a beta copy is kept in step when production changes during a trial; the `/end-session` reminders (this repo: trials without notes; a beta project: "anything to note?" written into `trials.md`); version numbering between tags.

## From 35 (2026-11-24)

No plugin: skills reach the owner through a copy script in the home repo, and projects carry no toolbox skills. The beta track then mostly means "home's copy script takes `beta/` over production"; templates still reach projects as copies.

## From 35, review (2026-11-24)

Problem this creates: if home copies skills once for every project, a beta skill can no longer be trialled in **one** project while others stay on production; the beta track becomes per machine, not per project. Options: home switches tracks as a whole; beta skills copied side by side under another name; or a per-project track that home's script reads when the session picks a project (36). `workflow_track` and the `[wf vX.Y]` stamp then apply to home's copies; projects record only their template version.

## From 36 (2026-11-24)

Home's copy script takes skills from `origin/main` by default; trying a toolbox branch means naming it to the script, which switches every project until reset (36). Decide whether the beta track is that switch, or per session project.

## From 06 (2026-11-24)

Home's copy script fills `.agents/skills` (real copy) and a `.claude/skills` junction, and copies Matt's skills from a pinned clone. A beta overlay has to work through that same script.

## Answer

Resolved 2026-11-24 (grilling, four rounds). Decision 0011.

1. **Skill trials run side by side.** `beta/skills/<skill>/` holds a full copy. Home's copy script always installs every beta skill next to production as `<skill>-beta` (`name: <skill>-beta`), description stamped `[wf <version> beta]`; no switch, nothing to restore. A beta skill is used only when typed by its beta name, which is what makes it observable. When promoted or dropped, the next script run removes the installed copy: the script keeps a manifest of what it installed and deletes only manifest entries whose source is gone, and never deletes when run against a named branch (36), so a branch missing a skill can't wipe it.
2. **Skills that call skills:** a beta copy names its beta partners explicitly (`run ship-beta`); the trial row lists every skill in the set, and a skill only ever called by others is trialled through a beta copy of its caller. The copy script warns when a beta skill names a production skill that also has a beta copy.
3. **Global skills** (`setup-workflow`, `refit-workflow`) trial the same way: `Install-GlobalSkills.ps1` installs `<skill>-beta` beside them and gets the same manifest cleanup, so a promoted or dropped global beta copy is removed on its next run.
4. **Template trials run per project.** `/setup-workflow` and `/refit-workflow` take `-Track beta`: they lay `beta/templates/` over that project's files and record `workflow_track: beta` as a concrete setting in `workflow-settings.md` (outside `## Seeded from`, which only setup and refit read, 07; `/end-session` reads it for point 9), and note the version under `## Seeded from`. A beta file that creates or moves project files is refused unless its trial row has a rollback line. `-Track production` restores production and runs the rollback. `workflow_track` exists only in projects and only means "its templates are on beta"; skills have no track.
5. **`beta/` stays on `main`**, full copies beside production so the change is a plain diff and trials don't tangle. Naming a branch to home's copy script (36) is for quick tries of unmerged work, never a trial.
6. **Versions:** `git describe` output (`v1.0-12-gabc1234`) in stamps and `## Seeded from`, with ` beta` appended on beta. Tags only for deliberate releases (e.g. `v2.0` at the end of a roadmap phase), never per promotion.
7. **Keep:** one PR that replaces each production file with its beta copy (file by file; a plain `git mv` of a folder onto an existing folder nests it), verdict **keep** with the date, a `CHANGELOG.md` line, an ADR if it was a real trade-off. **Drop:** one PR that moves the beta copy to `notes/archive/<date> <change>/`, verdict **drop** with why. **Tune:** edit the beta copy, dated line in Notes. On keep or drop of a template trial, every project in "Used in" goes back with refit `-Track production` (after keep, that is the promoted text; after drop, the rollback runs). (`trials.md` currently says `archive/` and, with `DEVELOPING.md`, still says to tag a release per promotion: both fixed to this answer when built.)
8. **Keeping a beta copy in step:** rule, a change to a file on trial goes into both copies in the same PR; check, each beta copy records the production commit it was based on (in its trial row), and the copy script, refit and `/start-session` (toolbox as session project) warn when the production file has changed since that commit, and show the diff to carry over; carrying it over moves the base commit. Comparing commit dates alone would miss a fix once the beta copy is edited again.
9. **Trial notes live in the project:** when a beta skill or template was used, `/end-session` asks and ends the project's `docs/LOG.md` line with `trial:<slug> <note>` (slug from the trial row). No cross-repo write per session.
10. **Trials board** columns: Change | Success check | Kind (`skill, side by side` / `template, per project`) | Skills or files in the set | Used in (from LOG tags) | Started | Review by (default 1 week after Started) | Rollback | Notes | Verdict. With the toolbox as session project, `/start-session` flags trials past Review by and proposes the verdict sweep: home gathers the `trial:` lines from each project's LOG (36, point 5).
11. **Success checks** stay free text until 21 settles the markers.

Glossary: Track (now templates only), Trial (skill trial vs template trial).

## Revised by 09 (2026-11-27)

Point 10's trials board and point 11's free-text success check are replaced, and the unit of trial changes: a trial is **one module switched on in one project** (09 point 1); `<skill>-beta` copies and the template beta track are how a module's change is carried. Each trial gets `notes/trials/<slug>.md` with a pass condition written before it starts (markers with baseline and target, drop if, review by; usage always measured), and `notes/trials.md` becomes an index (09 points 2 to 4). Decision 0019 revises 0011.
