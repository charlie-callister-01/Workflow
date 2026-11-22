# Interpretable Context Methodology (ICM)

Type: research
Status: resolved
Blocked by: none

## Question

What is Jake Van Clief's Interpretable Context Methodology (https://github.com/RinDig/Interpretable-Context-Methodology), what problem does it solve, how does it compare with this toolbox's docs/agents + CLAUDE.md approach, and what is worth taking?

## Answer

ICM ("folder structure as agent architecture", MIT, arXiv:2603.16021; formerly Model Workspace Protocol) replaces multi-agent frameworks with a folder: numbered stage folders, each with a `CONTEXT.md` contract (Inputs with section scope / Process / Outputs, plus Checkpoints and Audit for creative stages), `references/` for stable rules and `output/` as the hand-off to the next stage. One agent reads down five layers (`CLAUDE.md` -> workspace `CONTEXT.md` -> stage `CONTEXT.md` -> references -> working artifacts) and stops when it has enough.
It solves sequential, human-reviewed, repeatable workflows (content, reports, course decks), not software development or branching/concurrent systems.
Philosophy matches this toolbox (plain markdown, canonical sources, small entry file, selective loading); the difference is that ICM keeps process in per-workspace folders while the toolbox keeps it in reusable skills, which suits dev work better.
Mostly agent-agnostic: only `CLAUDE.md` auto-load and bundled `SKILL.md` folders are Claude Code specific.
Worth taking: a "What to load / Do NOT load" table in `templates/CLAUDE.md`; a leftover-placeholder scan at the end of `/setup-workflow` and `/refit-workflow`; Audit tables (check + pass condition) in artifact-writing skills; one-way references, the canonical-source grep test and "docs over outputs" as conventions; line caps for `docs/agents/*.md`. Not taking: numbered stage folders as the dev process, bundling skills per repo.

Research note: [notes/research/2026-11-22 Interpretable Context Methodology.md](../../../notes/research/2026-11-22%20Interpretable%20Context%20Methodology.md)
