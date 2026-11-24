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
One change being tried before promotion, recorded as a row in `notes/trials.md` with its success check, review date and verdict (keep, tune, drop). A **skill trial** installs the beta copy side by side as `<skill>-beta`, used wherever it is typed; a **template trial** puts one project on the beta track.
_Avoid_: experiment (that is a spike)

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

**Audience**:
Who opens a repo: **personal** (only the owner, working from home) or **shared** (teammates who may not use this workflow, so the repo stands alone).
_Avoid_: solo, team (as profile values)

**Stakes**:
How much rides on a repo's work: **spike** (throwaway), **everyday** (real, low risk) or **production** (ships to users). Seeds how strict the project's checks start out.
_Avoid_: risk level (that is per change), depth

**Checks**:
The plain lines in a project's `AGENTS.md` saying what a change must show before ship, when review and ADRs are needed, and what the agent may do without asking. Seeded from the stakes, then edited like any other rule.
_Avoid_: verification (that is the stage)

**Change flow**:
The route one piece of work takes (start project, new feature, small feature, small change, bug fix or spike); proposed by the agent and confirmed by the owner at the start of the work. A fixed sequence of stages.
_Avoid_: pipeline (for one change), mode

**Stage**:
One step of a change flow: define, plan, build, verify, review or ship. A flow may skip stages; each stage has a default skill that can be swapped without changing the flow.
_Avoid_: phase (that is a slice of a project's plan)

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

## Planning work

**Map**:
A wayfinder plan for a foggy effort: a destination, decisions so far, fog, and out of scope. Lives in `.scratch/map-<effort>/map.md`.
_Avoid_: plan, roadmap (those are destinations a map can lead to)

**Destination**:
What reaching the end of a map produces: a plan, a spec, a decision or a change.

**Decision ticket**:
One question on a map whose answer is a decision (research, prototype, grilling or task). Lives in a map's `decisions/` folder; never produces code.
_Avoid_: ticket (alone), issue

**Spec**:
A description of one piece of work to build, written by `/to-spec`.

**Work ticket**:
A small slice of a spec to build, written by `/to-tickets` into the spec's `issues/` folder and built by `/implement`.
_Avoid_: ticket (alone), task

**Scope block**:
The part of a plan that says what one task may edit (Touch), read, must ask about first (Ask first) or must never touch (Never), plus what it deliberately isn't doing (Not doing). Anything noticed outside it becomes an idea, not an edit.
_Avoid_: boundaries, out of scope (that is a map section)

**Working rules**:
The few standing principles at the top of a project's `AGENTS.md` that apply to every task, whatever the change flow.
_Avoid_: principles, non-negotiables

**Ratchet**:
How `AGENTS.md` grows and shrinks: a line is added only to stop a failure that really happened, and removed once a model no longer needs it.

## Ideas

**Idea**:
A one-line thought about future work, captured mid-task with `/idea` and not yet sorted. About the current project or, with `wf`, about the toolbox.
_Avoid_: ticket, todo

**Inbox**:
Where unsorted ideas wait: the `## Inbox` section at the top of an ideas file (`docs/IDEAS.md` in a project, `notes/ideas.md` here), plus open `idea` issues for the toolbox.
_Avoid_: backlog (where sorted ideas go)

**Triage** (of ideas):
Sorting each inbox item into one place: a decision ticket, a comment on a ticket, fog in a map, the backlog, or drop. Run by `/idea` with no text.
