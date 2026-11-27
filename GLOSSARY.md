# Workflow toolbox

The language of this repo: a personal toolbox of skills, templates and processes that is copied into the projects its owner works on, and improved over time.

## The toolbox

**Toolbox**:
This repo: the skills, templates, presets, platforms, tools and notes that make up the owner's way of working. Kept public-safe (no employer, customer or personal details); public or private is the owner's call.
_Avoid_: framework, kit, skills repo

**Home repo**:
The owner's private repo where development sessions start: it pulls skills from the toolbox, holds pointers to every project repo and to the knowledge repo, and keeps scripts for the owner's private use. A separate repo, not part of the toolbox.
_Avoid_: hub, workspace

**Knowledge repo**:
The owner's private repo of notes and learning, replacing the Obsidian vault; ideas reach it from the home repo. Learning is a folder inside it, not a repo of its own.
_Avoid_: vault, learning repo

**Project harness**:
What one repo builds up for itself over time (its `AGENTS.md`, its own skills, scripts and hooks), focused only on that repo. Toolbox skills are not part of it. Every project repo has one, and so do the home and knowledge repos.
_Avoid_: harness (alone: that is everything around the model, research 25)

**Session project**:
The one repo a session works on, fixed at the start of the session: a project, the toolbox, or the home repo itself (for work across several repos). The session's state (log line, status, next step) belongs to it, wherever the session was started.
_Avoid_: current project, target repo, active repo

**Session note**:
A short note kept on a session branch while its work runs: scope and decisions, status and next step, files and tree, checks run, open questions. Saved before a context is cleared, read by the next session on that branch, and folded into the log line when the work is done.
_Avoid_: STATUS, HANDOFF (retired as shared state files)

**Primed project**:
A project the toolbox has been set up in by `/setup-workflow` or `/refit-workflow`; it records the toolbox commit it took as `workflow_version`.
_Avoid_: onboarded repo, installed project

**v1**:
The toolbox as it was imported from the first project (tag `v1.0`, described in `notes/v1.md`). Changed only by fixes; `main` has moved on to v2 changes.

**v2**:
The toolbox the roadmap describes; being planned, and reaching `skills/` and `templates/` one change at a time (first: `AGENTS.md` as the instruction file, decision 0006).

**Track**:
Which copy of the toolbox's templates a project runs: **production** (everything on `main` outside `beta/`) or **beta** (production with `beta/templates/` laid on top), recorded as `workflow_track`. Skills have no track: beta skills install next to the production ones.
_Avoid_: channel, test branch

**Trial**:
One module switched on in one project and evaluated before promotion, with its own trial file holding a pass condition, the results and a verdict (keep, tune, drop). A change to a skill is carried by a beta copy installed side by side as `<skill>-beta`; a change to templates puts the project on the beta track.
_Avoid_: experiment (that is a spike)

**Pass condition**:
What a trial must show, written before it starts: one to three markers, each with a baseline and a target, a "drop if" line naming the harm that ends it, and a review-by date.
_Avoid_: success check (the old free-text column)

**Marker**:
A number collected automatically about a session or a project (tokens, peak context, turns, CI minutes), used as a trial's evidence. The owner's opinion sits beside markers and is never one.
_Avoid_: metric, KPI, score

**Removal trial**:
A trial in reverse: a module, rule, check or skill switched off in one project to see whether the failure it was added for comes back. Kept only if its absence shows.
_Avoid_: audit, cleanup

**Guide**:
A module's page for someone learning it, with five headings: what it is, why, how to use it, how to configure it, how to tell it's working. Lives in the toolbox only.
_Avoid_: docs (alone), manual, README

**Update**:
Refit's path that brings a primed project's files in step with a later toolbox version: migrations first, then a three-way merge of the templates that keeps the project's own edits.
_Avoid_: upgrade, sync

**Migration**:
One toolbox-authored change to a project's files that a diff can't express (move, rename, delete, retire a setting), with a check and a rollback; run once by an update, oldest first.
_Avoid_: upgrade script, patch

## Configuring a project

**Repo profile**:
What kind of repo a project is when it is set up: its audience, stakes, platform and agents. A seed, not a switch: only setup and refit read it, to choose the project's starting files; after that the project's own rules and settings are what count, and they evolve for its domain.
_Avoid_: repo type, category, preset

**Seed**:
The profile values and toolbox version a project's files were set up from, kept with the project so refit can tell what it started from and how far it has moved.

**Seed file**:
A toolbox starter file chosen by one profile value, copied into a project once at setup and owned by the project afterwards.
_Avoid_: preset file

**Audience**:
Who opens a repo: **personal** (only the owner, working from home) or **shared** (teammates who may not use this workflow, so the repo stands alone).
_Avoid_: solo, team (as profile values)

**Stakes**:
How much rides on a repo's work: **spike** (throwaway), **everyday** (real, low risk) or **production** (ships to users). Seeds how strict the project's checks start out.
_Avoid_: risk level (that is per change), depth

**Checks**:
The `## Checks` section every project carries (in `AGENTS.md`, or behind one pointer line in `docs/agents/checks.md`): plain `stage.knob[.flow]: value` lines saying what a change must show before ship, when review and ADRs are needed, and what the agent may do without asking. Seeded from the stakes, then owned and edited by the project; skills read only these lines.
_Avoid_: verification (that is the stage)

**Check line**:
The one `Check:` line written at define for a unit of code-changing work: a command, a test name, or manual or smoke steps with the expected result. Verify runs it; its output is the evidence the PR shows.
_Avoid_: acceptance criteria (a ticket may list several; the check line is the one that is run)

**Change flow**:
The route one piece of work takes (start project, new feature, small feature, small change, bug fix or spike); proposed by the agent and confirmed by the owner at the start of the work. A fixed sequence of stages.
_Avoid_: pipeline (for one change), mode

**Stage**:
One step of a change flow: define, plan, build, verify, review or ship. A flow may skip stages; each stage has a default skill that can be swapped without changing the flow.
_Avoid_: phase (a set of slices on a roadmap), planning folder

**Flow table**:
`docs/agents/change-flows.md`: one short section per change flow, a row per stage with its skill, model tier, who starts it and what to load (pointers only). The agent reads only the chosen flow's section; there is no router skill.
_Avoid_: router, meta-skill

**Model tier**:
`frontier`, `standard` or `light`: how capable a model a stage or subagent needs. Home's per-agent setup maps each tier to that agent's real model.
_Avoid_: naming a model (models don't carry between vendors)

**Wayfinder first**:
A step taken before start project or new feature when the decisions can't yet be listed; not a flow of its own.

The six change flows (decided in roadmap decision ticket 13):

- **Start project**: from an empty or new repo to a plan and a first spec.
- **New feature**: work needing several decisions, sessions or PRs; spec plus work tickets.
- **Small feature**: one or two decisions, one session, one PR; a spec but no work tickets.
- **Small change**: nothing worth writing down as a decision; done in chat. _Avoid_: fast-lane
- **Bug fix**: something that should work doesn't; starts from a failing test.
- **Spike**: work whose output is knowledge, not merged code. _Avoid_: experiment, POC

**Preset**:
Retired: v1's word for a bundle of profile and flow (`full`, `fast-lane`, `lite`, `team`). Replaced by the repo profile (a seed) plus the change flow; `fast-lane` is the small change flow.

**Platform**:
Where pull requests, CI and boards live (`github` or `azure`).

## Checks and hooks

**Git hook**:
A script git itself runs on its own events (commit, push), kept in the project's `.githooks/` folder. It applies to every agent and person working in that clone, and can refuse the commit or push.
_Avoid_: hook (alone)

**Agent hook**:
A script one agent runs on that agent's own events (a tool call, the start or end of a session). It applies only to that agent, and only where its settings are loaded. In this workflow it only ever starts an existing script.
_Avoid_: hook (alone), Claude hook

**Skill script**:
A script that ships inside a skill's folder and that the skill calls once for a step that does the same thing every run, so the agent only reasons over its output.
_Avoid_: helper, tool

**Session branch**:
The one branch a session's docs and notes go on, shipped as one PR with the LOG line; code, a second repo or a wanted mid-session merge get their own PR.

**Show / Ask**:
How a PR waits: **Show** is opened and merged by the owner without waiting for review (docs-only); **Ask** waits for review (code). Ship, straight to `main`, is not used.

## Planning work

### Plan levels

Every repo uses the same levels, top to bottom: Roadmap > Phase > Slice > Map or Spec > Planning folder (specs only) > Ticket. Refer to each by name first, with its number inside the name.

**Roadmap**:
A repo's direction, split into phases. One per repo.
_Avoid_: plan (alone), backlog

**Phase**:
A set of slices that land together on a roadmap (for the toolbox, a set of module trials), numbered `P1`, `P2` … Phases are a planning grouping, not waterfall gates: work inside one is still sliced and shipped piece by piece.
_Avoid_: milestone (a GitHub due-date marker), stage (a step of a change flow), epic

**Slice**:
One thin, end-to-end change inside a phase that ships something working on its own, planned by one map or spec. Numbered within its phase and always named: "P1-a Session facts".
_Avoid_: section, part, step, story

**Planning folder**:
One numbered folder of a spec, `01-grill`, `02-spec` or `03-tickets`, holding its stage contract and its output. A change is made in the earliest folder affected, and the later ones are re-run.
_Avoid_: stage (a step of a change flow), stage folder, phase

**Map rework**:
Reshaping a map's tickets and fog part-way through (merging, splitting, reordering).
_Avoid_: refit (that is `/refit-workflow` only)

**Roadmap refresh**:
Editing a roadmap's slices in place (reorder, add, remove, mark done) as a small change. A question that can't yet be listed needs a new map instead.
_Avoid_: map rework (reshaping a map part-way)

### Maps, specs and tickets

**Map**:
A wayfinder plan for a foggy effort: a destination, decisions so far, fog, and out of scope. Lives in the repo whose files it will change (in home if it spans several repos), in `.scratch/map-<effort>/map.md`. Closed when its frontier and fog are empty, then archived as one unit.
_Avoid_: plan, roadmap (those are destinations a map can lead to)

**Destination**:
What reaching the end of a map produces: a plan, a spec, a decision or a change. Written by the map's last decision ticket.

**Decision ticket**:
One question on a map whose answer is a decision (research, prototype, grilling or task). Lives in a map's `decisions/` folder; never produces code.
_Avoid_: ticket (alone), issue

**Grilling style**:
How a grilling ticket is questioned: `rounds` (a whole round of questions at a time, each with a recommendation; the default), `nail` (at most five questions, then a short summary to approve), `interview` (one question at a time until confident) or `doubt` (rounds, then a fresh reviewer tries to disprove the result). Set on the ticket; the owner may change it at the start.
_Avoid_: grilling mode, planning style (that covers maps and prototypes too)

**Primary source**:
An outside method the owner draws on first (Pocock, Osmani, pstack / fstack, ICM). Other researched methods are **parked**: looked at only when the owner picks one. Findings reach a decision only through the owner's picks.
_Avoid_: upstream (that is a pinned copy, `notes/upstream.md`)

**Idea batch**:
The run of `/idea` with no text: a fresh-context subagent routes each captured idea to its repo without asking, proposes its place (decision ticket, ticket note, fog, backlog, drop) for one approval, and logs every move.
_Avoid_: triage skill (it is the no-text form of `/idea`)

**Platform route**:
An optional per-repo extra that also sends ideas to the platform's tracker (GitHub issue, Azure DevOps work item). The core route is always the inbox file.

**Context layer**:
One of ICM's five levels of context an agent reads top-down, stopping when it has enough: 0 `AGENTS.md`, 1 routing (settings, LOG or STATUS, the active map), 2 the stage contract, 3 reference (`docs/agents/*.md`, glossary, decisions), 4 working artifacts (specs, tickets, code). Layers 3 and 4 load only when the contract lists them.

**Stage contract**:
What a stage loads, doesn't load, outputs and checks before handing on. In the toolbox it is the skill for that stage; in a planning folder it is a `CONTEXT.md`.
_Avoid_: CONTEXT.md (alone; Pocock used that name for the glossary)

**Spec**:
A description of one piece of work to build, written by `/to-spec`.

**Work ticket**:
A small piece of a spec to build, written by `/to-tickets` into the spec's `issues/` folder and built by `/implement`.
_Avoid_: ticket (alone), task

**Scope block**:
The part of a plan that says what one task may edit (Touch), read, must ask about first (Ask first) or must never touch (Never), plus what it deliberately isn't doing (Not doing). Anything noticed outside it becomes an idea, not an edit.
_Avoid_: boundaries, out of scope (that is a map section)

**Working rules**:
The few standing principles at the top of a project's `AGENTS.md` that apply to every task, whatever the change flow.
_Avoid_: principles, non-negotiables

**Ratchet**:
How `AGENTS.md` grows and shrinks: a line is added only to stop a failure that really happened, and removed once a model no longer needs it.

**Weekly review**:
The owner's one fixed sitting for the evolution loop: reviewing the worst sessions with `retro`, deciding each proposal (accepted, rejected or backlog), sweeping trials past their review date and routing the idea batch; monthly it also checks seed drift and old migrations.
_Avoid_: retro (that is one step of it), standup

## Ideas

**Idea**:
A one-line thought about future work, captured mid-task with `/idea` and not yet sorted. About the current project or, with `wf`, about the toolbox.
_Avoid_: ticket, todo

**Inbox**:
Where unsorted ideas wait: the `## Inbox` section at the top of an ideas file (`docs/IDEAS.md` in a project, `notes/ideas.md` here), plus open `idea` issues for the toolbox.
_Avoid_: backlog (where sorted ideas go)

**Triage** (of ideas):
Sorting each inbox item into one place: a decision ticket, a comment on a ticket, fog in a map, the backlog, or drop. Run by `/idea` with no text.
