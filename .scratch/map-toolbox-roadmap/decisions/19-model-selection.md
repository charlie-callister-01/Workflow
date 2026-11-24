# Model selection

Type: grilling
Status: open
Blocked by: 18, 13, 06

## Question

Which model runs which step of each change flow (planning: grilling, specs, wayfinder; implementing; reviewing) and, above all, which model each **subagent** uses (research, exploration, review, implement-spec workers), since subagents are how the owner manages context? How is it set per project and per skill (settings, skill frontmatter), and when may a plan from a frontier model be implemented by a lighter or another vendor's model?

## From 35 (2026-11-24)

Per-project settings now mostly live in home, since sessions start there; keep per-skill choices agent-neutral where possible (`model:` frontmatter doesn't carry between vendors, 18).
