# Survey of other skill sets and workflows

Type: research
Status: resolved
Blocked by: none

## Question

Which other agent skill sets and workflows are worth a deep look? Start from obra's Superpowers, GitHub Spec Kit, BMAD Method, Anthropic's skills repo and Matt Pocock's latest changes; add any notable others. Output a shortlist of at most 5 with one paragraph each on why.

## Answer

Full survey (12 skill sets and workflows, with a comparison table): [notes/research/2026-11-22 Survey of skill sets and workflows.md](../../../notes/research/2026-11-22%20Survey%20of%20skill%20sets%20and%20workflows.md).

Shortlist for deep dives:

1. **Matt Pocock skills, v1.3.2 and `main`**: upstream drift. `setup-workflow` replaces `setup-matt-pocock-skills`, so its v1.3.2 fixes (remote wiring, triage label creation, `GLOSSARY` rename, tracker template changes) need porting; this machine still has 1.3.1. New `retro`, `chief-of-staff` (dated, commit-cited wiki) and `software-factory` overlap toolbox plans.
2. **obra's Superpowers**: the most popular skills-plugin methodology; strong on discipline (mandatory skill checks, verification-before-completion, two-stage review). `finishing-a-development-branch` compares with `/ship` and `/end-session`; `diagnosing-superpowers` (explain a bad session from its transcript) has no equivalent here.
3. **Compound Engineering (Every)**: `ce-compound` writes durable learnings that later plans read, the gap between STATUS/HANDOFF/LOG and lasting lessons; PR shepherding skills cover what happens after `/ship`.
4. **GitHub Spec Kit**: study its customisation layers (presets, extensions, hooks, overlays, bundles, project-local overrides, artifact inventory) before building the toolbox's update flow; its bug-fix and idea-assessment flows are small-preset candidates.
5. **OpenSpec**: lightest brownfield SDD; change folders archived into living specs answer what happens to `.scratch/` specs after merge.

Runners-up: BMAD (planning-path picker idea), GSD Core (if `full` is reworked), anthropics/skills `skill-creator` (evals, for plugin packaging).
