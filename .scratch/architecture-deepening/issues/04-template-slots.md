# The `AGENTS.md` template holds slots; the profile fills them

Status: needs-triage
Notes: Waits on roadmap ticket 07 (personal vs shared templates) and works with 03.

## What

Several rules are written out in many places:

- "~120 lines" appears in 5 files.
- "`CLAUDE.md` is the single line `@AGENTS.md` … Decision 0006" is repeated word for word at `skills/setup-workflow:11` and `skills/refit-workflow:11`.
- The `full` pipeline is written twice, at `presets/full.md:19-30` and `templates/AGENTS.md:21-25`.
- "~30 lines" appears in 4 files and "160k" in 3.

The template should hold slots only. The profile owns the pipeline and the limits, and setup and refit's no-bloat check read the same values.

## Done when

- [ ] Each limit and the instruction-file rule are stated once.
- [ ] `templates/AGENTS.md` holds no pipeline text of its own.
- [ ] CHANGELOG line.

## Comments
