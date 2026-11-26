# Route work with a flow table and skill descriptions, not a router skill

Status: **accepted** (2026-11-26), roadmap decision ticket 34 (Flow table). Not built yet.

There is no router skill. `AGENTS.md` (layer 0) carries only the six-line flow and size table and a pointer; `docs/agents/change-flows.md` holds one short section per flow with Stage | Skill | Tier | Who starts | Load (pointers only), read just for the chosen flow; agents route to skills by their descriptions. Models are named by tier (`frontier`, `standard`, `light`), mapped to real models in home's per-agent setup and applied to subagents and the session's start. A signal table picks the planning method, with a prompt override. Projects change a cell only through Checks lines (`<stage>.skill[.flow]`, `<stage>.tier[.flow]`); the agent states `flow · stage · skill` as each stage starts, and the PR lists the flow and changed cells.

Over: (a) Osmani's `using-agent-skills` router skill, which he himself leaves unwired on Claude Code and Codex because native description routing and a second router conflict; (b) a SessionStart hook injecting the table, which is Claude-only and loads it every session; (c) naming models per stage, which does not carry between vendors (18); (d) per-project override of who starts a skill, impossible with home's single skill copy.

Trade-off: description routing depends on how well each skill's description is written, and tiers are only advice for the main session's later stages; a project changes routing through Checks lines rather than by editing its own table.

Reverse it if: the agent's first proposed flow or skill is corrected often in stage 1, or the table grows past about 60 lines.
