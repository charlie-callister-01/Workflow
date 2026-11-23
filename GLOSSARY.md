# Workflow toolbox

The language of this repo: a personal toolbox of skills, templates and processes that is copied into the projects its owner works on, and improved over time.

## The toolbox

**Toolbox**:
This repo: the skills, templates, presets, platforms, tools and notes that make up the owner's way of working.
_Avoid_: framework, kit

**Primed project**:
A project the toolbox has been set up in by `/setup-workflow` or `/refit-workflow`; it records the toolbox commit it took as `workflow_version`.
_Avoid_: onboarded repo, installed project

**v1**:
The toolbox as it was imported from the first project (tag `v1.0`, described in `notes/v1.md`). Changed only by fixes; `main` has moved on to v2 changes.

**v2**:
The toolbox the roadmap describes; being planned, and reaching `skills/` and `templates/` one change at a time (first: `AGENTS.md` as the instruction file, decision 0006).

**Track**:
Which copy of the toolbox a project runs: **production** (everything on `main` outside `beta/`, tagged per release) or **beta** (production with the `beta/` folder's trial copies laid on top).
_Avoid_: channel, test branch

**Trial**:
One change being tried on the beta track in a real project before promotion, recorded as a row in `notes/trials.md` with its success check and verdict (keep, tune, drop).
_Avoid_: experiment (that is a spike)

## Configuring a project

**Repo profile**:
What kind of repo a project is (solo or team, platform, agents, whether it has phases and state files); chosen once at setup, changed by refit. Decides where things live and how much ceremony surrounds them.
_Avoid_: repo type, category

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
v1's word for a bundle of profile and flow (`full`, `fast-lane`, `lite`, `team`). Being replaced by repo profile plus change flow.

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
