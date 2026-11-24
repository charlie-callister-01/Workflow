# Architecture deepening: toolbox scripts and files

Status: needs-triage

## Why

An architecture review on 2026-11-24 found the same rules written in several places across the toolbox. The skill lists sit in two install scripts. `code_pattern` has two regexes that disagree. What a preset means is decided in five places. Limits are restated in setup, refit and the template. Fixed rules are written as prose that no test checks. Decision 0009 (home repo, no skill copies in projects, agent-agnostic) makes some of this urgent. Each ticket below deepens one module, so its rule lives in one place.

## Tickets

1. `issues/01-skill-copy-by-tier.md`: one script copies skills by `tier`, into one folder per agent.
2. `issues/02-platform-owns-code-pattern.md`: the platform module owns the merge rules and `code_pattern`.
3. `issues/03-profiles-as-data.md`: presets (soon repo profiles) become data that the script reads.
4. `issues/04-template-slots.md`: the `AGENTS.md` template holds slots, and the profile fills them.
5. `issues/05-fixed-rules-in-script.md`: setup and refit's fixed rules move into the script.

Suggested order: 02 (a live bug), then 01. Tickets 03, 04 and 05 wait on roadmap tickets 07 and 23.

## Not doing

- Plugins, or Claude-only install paths as the only target (0009).
- Redesigning the change flows or the repo profile here: those are roadmap tickets.
