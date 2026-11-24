# Presets (soon repo profiles) as data the script reads

Status: needs-triage
Notes: Waits on roadmap ticket 07 (repo profile), which replaces presets. Build it as part of the profile.

## What

What a preset means is decided in five places:

- `presets/lite.md:20` (prose)
- `tools/Install-Workflow.ps1:61-67` (`if ($Preset -ne 'lite')`)
- `skills/setup-workflow:22,24`
- `skills/start-session:11` and `skills/end-session:8`, which have lite special cases
- `templates/docs/agents/workflow-settings.md:23`

Each profile should state its file list and its settings lines once, as data. The install script and the skills read that list instead of each working it out again.

## Done when

- [ ] Each profile's file list and settings lines live in one place.
- [ ] No script or skill branches on a profile name.
- [ ] A `-DryRun` prints the manifest for a profile.
- [ ] CHANGELOG line.

## Comments
