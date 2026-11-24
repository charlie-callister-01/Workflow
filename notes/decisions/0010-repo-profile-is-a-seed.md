# The repo profile is a seed, not a switch

Status: **accepted** (2026-11-24), roadmap decision ticket 07 (Repo profile). Not built yet.

A project's repo profile (audience `personal | shared`, stakes `spike | everyday | production`, platform, agents) is read only by `/setup-workflow` and `/refit-workflow`, to choose the project's starting files. It is recorded under `## Seeded from` in `docs/agents/workflow-settings.md` with the date and toolbox version. No day-to-day skill or hook reads it: behaviour lives in concrete lines the project owns (settings, and a Checks section in `AGENTS.md` seeded from the stakes), which evolve for the project's own domain. The change flow picks the stages; the Checks lines set how strict they are. Changing the profile later goes through refit, which proposes a line-by-line diff and keeps lines the owner has edited.

Over: (a) a runtime switch that skills read (v1's `preset:` line), which hides behaviour behind one word and fights each repo's own evolution; (b) a depth axis choosing which state files exist, replaced by creating state when a change flow first needs it; (c) a kind axis (`code | notes`), since the work a repo does already decides which flows it uses.

Trade-off: two repos with the same profile drift apart over time, and fixing a seed in the toolbox no longer reaches existing projects on its own; refit has to offer it.

Reverse it if: projects keep drifting in ways that cost more than they gain, or refit's seed diffs turn out too noisy to review.
