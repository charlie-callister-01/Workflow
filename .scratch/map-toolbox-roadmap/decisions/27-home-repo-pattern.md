# AI Hero: the home repo pattern

Type: research
Status: resolved
Blocked by: none

## Question

What is the home repo pattern (one repo that holds an owner's agent setup and feeds other projects), how does it handle distribution and updates into projects, and how does it compare with this toolbox's copy-and-refit model (feeds 23 and the Distribution fog)?

Source: https://www.aihero.dev/the-home-repo-pattern

## Answer

- **What it is:** one home repo holds the owner's skills, AGENTS.md and shared docs (coding standards, then a glossary and system-wide decisions). The agent starts *in the home repo*, and its AGENTS.md has an "Other Repos" list of plain pointers (path, clone URL, "read its AGENTS.md first"). Each project keeps its own AGENTS.md, build and test commands, and project docs.
- **Distribution and updates:** almost none. Shared skills move out of projects (copies deleted), so an update is a commit to the home repo. The article doesn't say how a session started inside a project gets the shared skills.
- **Alternatives named:** `~/.claude/skills` is "the stopgap"; submodules are fine for 5-10 repos but pointers do the same; a monorepo is better where possible; pointer lists strain past ~20 repos; a skills marketplace at thousands.
- **Compared with the toolbox:** different goals. Home repo = one owner working across repos from one place. Toolbox = each project self-contained (works opened alone, by anyone), at the cost of copies drifting from `workflow_version`.
- **For the toolbox:** keep shared skills in one place (global install or plugin) to remove drift and most of an update; every machine or person then needs that install. Templates and settings stay per-project copies, so `/update-workflow` is mainly templates, settings and file moves (23). Borrow its setup inventory for `/refit-workflow` (shared / duplicate / repo-specific / installed, read-only until a plan table is approved). Optional idea: an "Other Repos" section in this repo's AGENTS.md.

Note: [notes/research/2026-11-23 Home repo pattern.md](../../../notes/research/2026-11-23%20Home%20repo%20pattern.md)
