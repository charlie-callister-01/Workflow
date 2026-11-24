# Release tracks: production, beta and promotion

Type: grilling
Status: open
Blocked by: none

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
