# Addy Osmani's agent-skills

Type: research
Status: resolved
Blocked by: none

## Question

What does Addy Osmani's agent-skills collection offer (skills, structure, conventions, cross-agent support), how does it overlap with this toolbox and Matt Pocock's skills, and what is worth taking?

## Answer

- agent-skills (MIT, v0.6.17) is a broad 26-skill lifecycle pack (Define, Plan, Build, Verify, Review, Ship) with 10 phase commands, 5 reviewer personas, 7 shared checklists and a 3-tier eval framework (lint, description-routing check in CI, headless behavioural runs).
- Every skill follows one anatomy: spec-only frontmatter, When to Use / NOT, Process, Common Rationalizations table, Red Flags, Verification checklist.
- Cross-agent: one portable `skills/` core (agentskills.io spec) plus thin per-host adapters (Claude Code, Gemini, Codex, Antigravity, Copilot CLI, OpenCode), docs-only setups for Cursor, Windsurf and Kiro, and `npx skills add` for 70+ agents. The router meta-skill is hook-injected only on hosts without native skill routing.
- Overlap: Pocock owns Define and Build (grilling, to-spec, tdd); agent-skills is strongest at Review and Ship plus production concerns; this toolbox's own value is the outer loop (sessions, presets, platforms, setup), which agent-skills lacks.
- Take: don't install the whole pack (two routers clash). Borrow `constraint-driven-development`, `doubt-driven-development` and the security/a11y/perf skills as optional skills; add Rationalizations, Red Flags and Verification sections to our skills; a Definition of Done for `full`; a light skill lint; and their portable-core-plus-adapters layout for ticket 06.

Research note: [notes/research/2026-11-22 Addy Osmani agent-skills.md](../../../notes/research/2026-11-22%20Addy%20Osmani%20agent-skills.md)
