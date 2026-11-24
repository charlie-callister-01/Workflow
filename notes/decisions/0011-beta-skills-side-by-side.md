# Beta skills install side by side

Status: **accepted** (2026-11-24), roadmap decision ticket 17 (Release tracks). Not built yet.

Since decision 0009 skills live in the home repo, shared by every session, so a skill can't be put on beta for one project. A skill on trial is therefore installed **next to** its production version as `<skill>-beta` (description stamped `[wf <version> beta]`), always, with no switch; it is used only when typed by that name. Beta copies name their beta partners explicitly, and the copy script warns about mismatches. Templates, which are copied into projects, keep a per-project track: `/setup-workflow` and `/refit-workflow` take `-Track beta` and record `workflow_track`.

Over: (a) a per-machine switch in home's copy script laying `beta/skills/` over production, which is simpler and keeps skill-to-skill calls working, but hides which version ran and puts every project on beta at once; (b) a per-project skill track re-copied when a session picks a project, which rewrites home's shared skill folder under parallel sessions.

Trade-off: a beta skill is exercised only when typed, and skills that call each other need beta copies of their callers; the `/` menu carries extra `-beta` entries while trials run.

Reverse it if: trials keep missing real use because the beta name isn't typed, or the paired beta copies get out of step often enough that a machine-wide switch costs less.
