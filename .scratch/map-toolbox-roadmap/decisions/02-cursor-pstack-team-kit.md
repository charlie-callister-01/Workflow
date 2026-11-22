# Cursor's pstack and cursor-team-kit

Type: research
Status: resolved
Blocked by: none

## Question

What do Cursor's `pstack` (https://github.com/cursor/plugins/tree/main/pstack) and `cursor-team-kit` (same repo; source of the toolbox's thermo-nuclear-code-quality-review) offer, how are Cursor plugins packaged compared with Claude Code skills/plugins, and what is worth taking?

## Answer

- **cursor-team-kit** (MIT, (c) Cursor): 18 small, stack-neutral skills (CI loop/fix, PR shipping and review canvas, `verify-this`, `deslop`, smoke tests, weekly/what-did-i-get-done reports, `workflow-from-chats`, thermo-nuclear review), a background `ci-watcher` agent and two `.mdc` rules. Easy to cherry-pick.
- **pstack** (MIT, (c) Lauren Tan): one person's heavy agent style. `/poteto-mode` routes to 22 playbooks and an index of 24 one-rule principle skills; extras include `reflect`/`correct` (turn corrections into skill edits or lints), `blast-radius`, `interrogate`, `how`/`why`, multi-model arena/swarm. Depends on team kit (`/deslop`).
- **Packaging**: Cursor plugin = `.cursor-plugin/plugin.json` + `skills/`, `agents/`, `rules/*.mdc`, `mcp.json`; skills are Agent Skills standard SKILL.md. Cursor also loads `.claude/skills/` and reads `AGENTS.md`, so our installed skills already work in Cursor; tool names, subagent fields, model slugs and rules do not port. pstack ships to Claude Code via a generated tree plus a one-page name-mapping adapter.
- **Take**: `deslop`, `verify-this`, CI-watch pattern for the github platform; try `reflect`/`correct`/`workflow-from-chats` as a learning loop and a short principles index. **Skip**: poteto-mode wholesale, multi-model and Cursor-only features.

Full note: [notes/research/2026-11-22 Cursor pstack and team kit.md](../../../notes/research/2026-11-22%20Cursor%20pstack%20and%20team%20kit.md)
