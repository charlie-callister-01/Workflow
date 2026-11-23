# Addy Osmani: the agent-skills blog post

Type: research
Status: resolved
Blocked by: none

## Question

What does Addy Osmani's agent-skills blog post add beyond the repo already researched in 01 (his reasoning, how he writes and tests skills, anti-patterns, anything newer than v0.6.17), and what is worth taking?

Source: https://addyosmani.com/blog/agent-skills/

## Answer

- **The post (2026-05-03)** gives the *why*: agents take "the shortest path to 'done'" and skip senior-engineer work that doesn't show in the diff, so a skill is a workflow with checkpoints and an exit criterion, not reference docs ("process over prose"). It describes an older pack (20 skills, 7 commands); v0.6.17 (2026-11-18) is still the latest.
- **Five principles:** process over prose, anti-rationalisation tables, verification as a hard exit ("passing tests are evidence, not proof"), progressive disclosure, scope discipline ("touch only what you're asked to", the biggest single factor in mergeable agent PRs).
- **Third way to use the pack:** "read it as a spec" and copy ideas into your own process and AGENTS.md. Backs 01's call: borrow, don't install.
- **Anti-patterns (his later "Audit your Agent files" post):** agent configuration "has a half-life"; rules pile up after each error, README copies, overlapping skills, forgotten trial skills. Fix: prune by experiment every 2-4 weeks: run a real task with the skill off and keep it only if the agent fails the way the skill prevents.
- **Must-hold rules belong in a test, hook or permission, not prose;** context files under 200 lines, saying only what the code doesn't.
- **For the toolbox:** a removal test in `refit-workflow` or the measuring work (21); hooks for "never commit to main" and "edit skills/, not .claude/skills/"; keep the AGENTS.md template short; turn essay-like skill sections into steps that end with an evidence check.

Note: [notes/research/2026-11-23 Addy Osmani agent-skills post.md](../../../notes/research/2026-11-23%20Addy%20Osmani%20agent-skills%20post.md)
