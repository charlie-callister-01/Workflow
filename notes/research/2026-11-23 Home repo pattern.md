# Home repo pattern

## Question

What is the "home repo pattern" (one repo that holds an owner's agent setup and feeds other projects), how does it handle distribution and updates into projects, and how does it compare with this toolbox's copy-and-refit model? Feeds decision ticket 23 (updating primed projects) and the map's Distribution fog (copies vs a plugin).

## Sources

- AI Hero, "The Home Repo Pattern": https://www.aihero.dev/the-home-repo-pattern (no author byline; page last updated 2026-11-12). Its outbound links are glossary entries only (skill, AGENTS.md, progressive disclosure, software factory, sandbox), so there were no further primary sources to follow.
- This repo: `SETUP.md`, `notes/ideas.md`, `.scratch/map-toolbox-roadmap/decisions/23-update-workflow.md`.

## What I learned

**The pattern.** A Home Repo is "one repository that holds your skills, your AGENTS.md and your shared docs". You start the agent **in the Home Repo**, not inside a single project ("In the Home Repo, not inside a single repo"). Its AGENTS.md has an "Other Repos" section of plain pointers (path, clone URL if missing, a hint such as "Read its AGENTS.md before changing it"), so the agent opens or clones the other repos and works across them. Each repo is cloned once; features get worktrees inside that clone.

**What moves and what stays.**
- Moves to the Home Repo: skills used across repos, steering files, shared docs (coding standards first, then a glossary and system-wide decisions), and later any tooling or CLI.
- Stays in each repo: its own AGENTS.md, build and test commands, repo-specific docs, code, history, remote and issue tracker.

**Setup** is a copyable prompt: inventory every repo and every skill or agent file; sort each into shared, duplicate (keep the newest), repo-specific or installed; show a plan table and stay read-only until approved; then create the Home Repo, copy the shared items in, and remove the moved copies from each child repo on a new local branch. Pushing is left to the owner.

**Distribution and updates.** There is barely any, by design. Shared skills are not copied into projects at all: they live in one place and are used from there, so an update is just a commit to the Home Repo. Child repos lose their copies. The article does not say how a session started *inside* a child repo gets the shared skills; the pattern assumes you don't start there.

**Alternatives it names.**
- `~/.claude/skills` (user folder): "the stopgap"; a Home Repo is versioned and can be shared with a team.
- Git submodules: fine at 5-10 repos, but "plain pointers do the same job without submodules".
- Monorepo: better when you can have one; the Home Repo is the substitute when you can't (mixed public and private repos, a team that won't adopt one).
- Scale: pointer lists strain past about 20 repos (use progressive disclosure, one file per business area); "at thousands of repos ... a skills marketplace makes more sense".

## Compared with this toolbox

| | Home repo | This toolbox |
|---|---|---|
| Where skills live | Once, in the Home Repo | `skills/` here, **copied** into each project's `.claude/skills/` (core), plus `/setup-workflow` and `/refit-workflow` in `~/.claude/skills/` |
| Where the agent starts | The Home Repo, pointing at projects | Inside each project |
| Per-project rules | The project's own AGENTS.md | The project's AGENTS.md, filled in from `templates/` |
| Updates | Commit to the Home Repo; nothing to propagate | Copies drift from `workflow_version`; needs refit, a `-Force` re-sync, or a plugin |
| Works for a session opened in the project | Not addressed | Yes: everything the project needs is in it |
| Works for a team / other agents on the project | Only if they use the Home Repo too | Yes: the project is self-contained |

The two answer different questions. The home repo pattern is about **one owner working across several repos from one place**; the toolbox is about **making each project carry its own workflow** so it works when opened on its own, by anyone. The Workflow repo is already half a home repo (one versioned place for skills, notes and decisions), but it feeds projects by copying, not by pointing.

## What the toolbox might change

- **Keep copies for templates and settings.** AGENTS.md, presets and settings are per-project by nature; the article agrees these stay in each repo. An update path (ticket 23) is still needed for them.
- **Stop copying skills where possible.** The article's main lesson: shared skills should live in one place. For this toolbox that place is either `~/.claude/skills` via `Install-GlobalSkills.ps1` (the article's "stopgap") or a plugin (its answer at scale, and the "Package as a plugin" idea). Either removes skill drift and most of what an update has to do. Weigh against: a project opened on another machine or by another person then needs the global install or plugin too.
- **Ticket 23:** if skills go global or plugin, `/update-workflow` shrinks to templates, settings and file moves; worth settling copies vs plugin first.
- **Borrow the inventory step.** The setup prompt's buckets (shared / duplicate-keep-newest / repo-specific / installed) and "read-only until the plan table is approved" fit `/refit-workflow`'s analysis step well.
- **Optional: pointers in the Workflow repo.** An "Other Repos" section in this repo's AGENTS.md would let one session here look at primed projects (e.g. to check their `workflow_version` before an update). Small, cheap, and separate from distribution. Add to `../ideas.md` if wanted.
