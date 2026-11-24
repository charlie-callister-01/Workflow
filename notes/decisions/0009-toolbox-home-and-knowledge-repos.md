# The toolbox, a home repo and a knowledge repo

Status: **accepted** (2026-11-24), roadmap decision ticket 35 (Home repo or toolbox). Not built yet.

The toolbox stays a separate, public-safe repo of skills, templates and the notes that evolve them. Development sessions start in a separate private home repo (pointers to sibling repos, coding and agent practices, private scripts), following AI Hero's home repo pattern (https://www.aihero.dev/the-home-repo-pattern). A private knowledge repo replaces the Obsidian vault. Home copies toolbox skills into its own skill folders per agent, so no project carries toolbox skill copies; personal projects rely on home for general rules, while public, shared and work repos stand alone with neutral process files (AGENTS.md, CI checks) and none of the owner's skills. Everything is agent-agnostic: plain instructions and scripts, no plugin, and Claude-only settings only as an optional extra.

Over: (a) toolbox only, copying skills into every project, which drifts and puts general rules in every repo; (b) this repo as the home repo, which buries a versioned toolbox among private scripts and stops it being shareable; (c) shipping the toolbox as a plugin, which teammates must install, other agents can't use, and is harder to develop than a plain repo.

Trade-off: work depends on the home repo being next to each project; a project's own hooks don't run in a session started in home; shared repos lose the owner's skills for teammates.

Reverse it if: working from home costs more than it saves (e.g. agents keep missing a project's AGENTS.md), or most projects turn out to be shared rather than personal.
