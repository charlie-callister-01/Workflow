# Ideas

Backlog of things to try. Move to `CHANGELOG.md` (and `decisions/` if needed) once adopted; strike through if dropped, with why.

- [ ] **Risk levels**: develop the draft tables in `platforms/*.md` into real rules (by change type and risk: how much review, explainer, wait, approvals).
- [ ] **Azure team mode**: script the Boards mirror; link PRs to work items; required reviewers by path or risk.
- [ ] **GitHub personal mode**: a `New-GhPr` wrapper like `New-AzurePr.ps1`; auto-merge docs-only PRs after CI.
- [ ] **Team preset**: fill in `presets/team.md` when a second person joins a project.
- [ ] **Install script**: `Install-Workflow.ps1 -Project <path> -Preset full -Platform azure` that copies skills and templates and fills settings.
- [ ] **Package as a plugin**: so skills update in one place instead of being copied.
- [ ] **Learning skill**: opt-in teaching mode (explain the change at a chosen depth).
- [ ] **Weekly roll-up** for `day-log` (`Logs/YYYY-Wnn.md`).
- [ ] **Measure it**: tokens per session, PRs per week, time from spec to merge, to compare presets.
- [ ] **Compare with other workflows**: findings go in `research/`.
