# One skill-copy script, driven by `tier`

Status: needs-triage
Notes: Blocked by the home repo existing (decision 0009). Can be built and dry-run here first.

## What

Replace the hard-coded skill lists with one script that copies skills by the `tier:` value in each `SKILL.md` (`core`, `global`, `optional`), into one folder per agent (`.claude/skills/`, `.agents/skills/`, ...). The two hard-coded lists are `core = start-session, end-session, ship` in `tools/Install-Workflow.ps1:31` and `'setup-workflow','refit-workflow'` in `tools/Install-GlobalSkills.ps1:13`. The home repo calls this script. `Install-Workflow.ps1` stops copying skills and copies templates only. The toolbox gets found one way only. Today `skills/setup-workflow:9` reads `workflow-repo.txt` and `skills/refit-workflow:9` reads that file or the `workflow_repo` setting.

## Done when

- [ ] No skill name is hard-coded in any script: the tier comes from `SKILL.md`.
- [ ] A `-DryRun` lists, for each agent folder, the skills it would copy.
- [ ] `Install-Workflow.ps1` no longer writes to `.claude/skills/`.
- [ ] Setup and refit find the toolbox the same way.
- [ ] Runs on PowerShell 5.1, and reads and writes UTF-8 explicitly.
- [ ] CHANGELOG line.

## Comments
