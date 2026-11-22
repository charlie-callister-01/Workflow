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
The toolbox as it was imported from the first project and is used today (tag `v1.0`, described in `notes/v1.md`). Changed only by fixes.

**v2**:
The toolbox the roadmap describes; in planning, not yet in `skills/` or `templates/`.

## Configuring a project

**Repo profile**:
What kind of repo a project is (solo or team, platform, agents, whether it has phases and state files); chosen once at setup, changed by refit. Decides where things live and how much ceremony surrounds them.
_Avoid_: repo type, category

**Change flow**:
The route one piece of work takes (start project, new feature, small feature, small change, bug fix, research or spike); chosen at the start of the work. Decides which skills run.
_Avoid_: pipeline (for one change), mode

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
