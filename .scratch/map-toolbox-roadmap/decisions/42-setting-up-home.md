# Setting up home

Type: grilling
Style: rounds
Status: resolved
Blocked by: 41

## Question

Until now this map left setting up the home and knowledge repos to those repos (35, Out of scope). But this repo is serving as home today, and most of how home works was decided here, so the build plan is made here too. Gather what is already decided into one plan for building **home** and the **knowledge repo**, then hand it to a normal `/to-spec` when it gets built.

Decided inputs to gather (read their answers, don't re-decide them): 35 (three repos, agent-agnostic, no plugin), 36 (session project, `## Other repos` table, sweeps, worktrees, copy script from `origin/main`), 06 (one skill copy in `.agents/skills` plus a `.claude/skills` junction, per-agent setup and permissions in home, Matt's skills from a pinned clone), 22 and 41 (`/idea` routes across project, toolbox and knowledge), 23 (home's sweep shows who is behind), 30 (enforcement never depends on where a session starts), 17 (beta skills side by side).

Decide:

1. **What home holds:** the file list (`AGENTS.md`, `## Other repos`, practices, private scripts, the copy script, the idea inbox), and what stays out.
2. **Build order:** the smallest home that works first, then what is added after; which roadmap items it needs first (the agent-neutral install and copy scripts, Phase 1).
3. **What moves out of this repo:** the toolbox ideas that are really home's (`## For home` in `notes/ideas.md`), the Inbox, the global-skills install, and when this repo stops acting as home (sessions then start in home).
4. **The knowledge repo:** created alongside home with the same steps; the layout inside is 10's answer, pointed at, not decided here; what replaces the Obsidian vault settings (`vault_folder`, `day-log`, `vault-note`).
5. **Private vs public:** what must never land in this public-safe toolbox, and the check that keeps it so.

Starting checklist: `## For home` in `notes/ideas.md`.

Created 2026-11-25 in the inbox triage grilling, at the owner's request: this repo acts as home until 42 is built. Related: 35, 36, 06, 10, 22, 23, 39 (the cross-project status page lives in home), 41.

## From 40 (2026-11-26)

The knowledge repo gets its own starting checklist, `## For knowledge` in `notes/ideas.md` (as `## For home` is home's). Point 4 changes: the learning layout is decided in the knowledge repo itself, using ICM's ideas (layers, injection, reviewable stage outputs), not in 10.

## From 41 (2026-11-26)

Home holds the `idea` script (`sh` + `ps1`, with a `check` mode), the per-agent hook triggers that start it, `inbox/<machine>.md` (one per machine) and the `pre-commit` exception for `inbox/`. On build, move this repo's `notes/ideas.md` Inbox into home's inbox. Knowledge ideas route to the knowledge repo's ideas file.

## Answer

Resolved 2026-11-26 (rounds, two rounds), with a fresh read of [AI Hero: The Home Repo Pattern](https://www.aihero.dev/the-home-repo-pattern) and its setup prompt. No ADR: this gathers decisions already made (0009 holds the hard-to-reverse part); home's layout will evolve in home.

1. **What home holds** (private, sibling of every repo):

   ```text
   repos/home/
     AGENTS.md                         practices pointer; "read the project's AGENTS.md first"; ## Other repos table (36)
     docs/                             shared docs: coding standards first, then system-wide decisions
     docs/agents/workflow-settings.md, docs/LOG.md      primed like any project (36)
     scripts/                          sh + ps1: copy-skills, idea (+ check), sweep, machine-inventory
     inbox/<machine>.md                idea capture (41)
     agents/<agent>/                   permission starters and per-agent settings (06)
     .githooks/                        pre-commit: refuse main except inbox/ (30, 41)
     .agents/skills/ + .claude/skills junction          gitignored, rebuilt by copy-skills (06)
   Not in home: code, knowledge notes, toolbox skill sources, secrets (.env never read),
   Matt's clone (sibling repos/mattpocock-skills, pinned in the toolbox's notes/upstream.md)
   ```

   The `## Other repos` table (name | path | clone URL | kind | what it is) carries the article's pointer facts plus `kind` for 07; one file per area only past ~20 repos.
2. **Build order**, each stage usable on its own:

   | Stage | What | Needs first | Done when |
   |---|---|---|---|
   | A. Minimal home + knowledge | Inventory repos and shared material (AI Hero steps 1-3: path, remote, visibility, last commit; items sorted shared / duplicate / repo-specific / installed; plan approved in rounds). Create private `home` and `knowledge` as siblings, both primed; home gets `## Other repos` and coding standards, knowledge gets `## For knowledge`. Skills still from today's installs | nothing | an agent started in home finds every repo and reads its `AGENTS.md` |
   | B. Skills from home | `copy-skills`, `.agents/skills` + junction, Matt's pinned clone; project skill copies removed on branches (AI Hero step 4, a 23 migration) | roadmap: agent-neutral install and copy scripts | each agent lists every skill once, from home |
   | C. Session project | Session skills act on the session project (36) | roadmap: 36's session-skill changes | switch-over (point 3) |
   | D. Ideas | `idea` script, `inbox/`, the pre-commit exception, hook triggers; this repo's Inbox and checklists move | C | `/idea` from a project session lands in home and is pushed |
   | E. Upkeep | sweep, machine inventory, private-terms pre-push, permission starters, gitleaks in toolbox CI, `day-log` / `vault-note` re-pointed | A | each runs once cleanly |

3. **What moves out of this repo, and when:** the Inbox, `## For home` and `## For knowledge` go to home (toolbox ideas come back through the idea batch); `Install-GlobalSkills.ps1` stays (setup and refit stay global, 35). This repo stops acting as home after **one real session started in home has run `/start-session`, `/open-pr` and `/end-session` on another repo**; then the map's "acts as home" note goes and `AGENTS.md` Start here points to a home repo generically (35: links go one way).
4. **The knowledge repo:** created with home in stage A, same steps; its layout is decided there (40). `vault_folder` becomes `knowledge_repo: ../knowledge`; `day-log` and `vault-note` write into a drop folder the knowledge repo defines (e.g. `inbox/`), which files them its own way. Re-pointing them is roadmap work.
5. **Private vs public:** never in the toolbox: employer, customer or people's names, emails, machine paths, the `## Other repos` contents, inbox contents. Home keeps the deny-list (`private-terms.txt`); the toolbox clone's pre-push hook greps the outgoing diff against `../home/private-terms.txt` when it exists and does nothing otherwise (teammates, CI); a secret scanner (e.g. gitleaks) runs in the toolbox's CI.
6. **How the setup runs:** no `/setup-home` skill (home is built once; a new machine clones it and runs `copy-skills`). Home's build goes through a normal `/to-spec` in home, fed by the context pack below; the toolbox's `SETUP.md` gains a generic "Set up a home repo" section: a setup prompt in our own words based on AI Hero's four steps (inventory repos, inventory shared material, agree the plan in rounds, apply on branches with pushing left to the owner), credited, never naming the owner's repos, and telling the agent to load the context pack. Both are roadmap items.

## Context pack for home's spec and setup prompt

The `/to-spec` in home and the `SETUP.md` prompt load these from the toolbox (read the Answer sections; don't re-decide them):

| Read | For |
|---|---|
| This ticket's Answer | layout, build order, switch-over, knowledge, private vs public |
| 35 and decision 0009 | three repos, agent-agnostic, no plugin, personal vs shared repos, siblings, one-way links, one layer per instruction |
| 36 | session project, `## Other repos` format, fallback, sweeps, worktrees, `copy-skills` from `origin/main` |
| 06 | `.agents/skills` + junction rules, per-agent setup and permissions in home, Matt's pinned clone, agent-neutral skill bodies |
| 41 and decision 0013 | `idea` script, `inbox/<machine>.md`, pre-commit exception, idea batch, log and undo |
| 30 | git hooks first, agent hooks only start scripts, the first portable hook (`/idea`), the private-terms and secret checks |
| 23 and decision 0012 | refit's update path and migrations (removing project skill copies) |
| 17 and decision 0011 | beta skills side by side, which `copy-skills` must carry |
| 40 | context layers: home's `AGENTS.md` is layer 0, `## Other repos` layer 1 |
| 07 and decision 0010 | repo profile seeds; `kind` in the `## Other repos` table |
| 39 (once resolved) | what `/start-session` reads; idea counts; the status page in home |
| `notes/ideas.md`: `## For home`, `## For knowledge` | starting checklists (machine inventory; ICM ideas for learning) |
| `notes/research/2026-11-23 Home repo pattern.md` and the article | the pattern and its setup steps |
| `notes/upstream.md` | the pinned commit for Matt Pocock's skills |
| `GLOSSARY.md` | Home repo, Knowledge repo, Session project, Project harness, Idea batch, Context layer |

## Picks

| Source | What it does about this question | Owner's call |
|---|---|---|
| Pocock | `chief-of-staff`'s dated, commit-cited wiki; his setup skill | **park** for the knowledge repo to weigh; setup already mirrored by `/setup-workflow` |
| Osmani | `AGENTS.md` near 60 lines, each line from a real failure | **pick**: home's `AGENTS.md` starts small |
| pstack / fstack | "What we're NOT doing" | **pick**: the Not-in-home list |
| ICM (from 40) | Context layers | **pick**: home's `AGENTS.md` layer 0, `## Other repos` layer 1 |

Also taken (AI Hero, research 27, not a primary source): the four-step inventory setup, coding standards as the first shared doc, start small, pushing left to the owner, never reading `.env`.
