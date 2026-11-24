# Model selection

Type: grilling
Status: resolved
Notes: merged into 34 (flow table) in the map refit (2026-11-24); its points now live there.
Blocked by: 18, 13, 06

## Question

Which model runs which step of each change flow (planning: grilling, specs, wayfinder; implementing; reviewing) and, above all, which model each **subagent** uses (research, exploration, review, implement-spec workers), since subagents are how the owner manages context? How is it set per project and per skill (settings, skill frontmatter), and when may a plan from a frontier model be implemented by a lighter or another vendor's model?

## From 35 (2026-11-24)

Per-project settings now mostly live in home, since sessions start there; keep per-skill choices agent-neutral where possible (`model:` frontmatter doesn't carry between vendors, 18).

## From 06 (2026-11-24)

No plugin for Matt's skills: home copies them, so skills are called by bare name in every agent. Per-skill `model:` is Claude-only frontmatter, allowed as an optional extra; a neutral fallback is a plain sentence in the skill or a per-agent setting in home.
