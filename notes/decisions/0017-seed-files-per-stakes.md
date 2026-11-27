# Seed projects from one small file per stakes value, not presets

Status: **accepted** (2026-11-27), roadmap decision ticket 37 (Seed files). Not built yet.

`presets/` is replaced by `seeds/`: one file per stakes value (`spike.md`, `everyday.md`, `production.md`), each holding the literal `## Checks` block setup pastes into the project and a short list of the other files it seeds (`.githooks/` for `everyday` and `production`). Audience stays the shared-only block in `templates/AGENTS.md`; platform stays `platforms/*.md`. There is no team seed. `seeds/README.md` is the module's guide and documents every Checks setting, including the off-by-default ones. Setup asks one questionnaire with defaults (audience, stakes, platform, agents, deploys, lint rules as errors per stack) and ends with a leftover-placeholder scan. v1 projects are asked the same questions at refit, with defaults from their old preset, and `presets/` is deleted by migration (d). Code checks per stack are offered, never seeded; the rest arrives through 09's ratchet.

Over: (a) one `seeds/checks.md` table from which setup works out the lines, which needs an agent to read it and gives refit no per-file merge base; (b) keeping seed files under `templates/`, which mixes profile-chosen starters with files every project gets; (c) a team seed for shared, `production`, `azure` repos, which would carry process a team has not asked for (required reviewers are a platform branch policy instead); (d) mapping old presets to stakes automatically, which would guess, since a preset never recorded stakes.

Trade-off: none of the primary sources (Pocock, Osmani, pstack / fstack, ICM) seeds by stakes or audience, so this is the toolbox's own design; three thin files carry little, and most of a project's rules must still come from its own failures.

Reverse it if: during the beta trial (a new project, and this repo's refit off `lite`) seeded Checks lines are edited back often, or the three files stay near-identical and could be one.
