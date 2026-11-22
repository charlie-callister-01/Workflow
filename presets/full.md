# Preset: full

For: a multi-week project with phases, where context has to survive many sessions. This is how PoReader runs (`examples/poreader/`).

## Project start (once; exploring)

```
/setup-workflow   prime the repo
  foggy?  yes -> /mattpocock-skills:wayfinder   chart a map (one session)
                 -> work its tickets, one per session (research runs in parallel subagents)
                 -> destination: docs/PLAN.md + Phase 1 Specs list (+ first ADRs, GLOSSARY)
          no  -> /mattpocock-skills:grill-with-docs -> docs/PLAN.md + Phase 1 Specs list
```

A phase that starts foggy can also begin with a map. See `notes/decisions/0005-wayfinder-for-foggy-starts.md`.

## Pipeline

```
/start-session
  -> /mattpocock-skills:grill-with-docs   (non-trivial work; glossary + ADR edits ride with the PR)
  -> /mattpocock-skills:to-spec + to-tickets   (.scratch/pNN-<slug>/)
  -> /mattpocock-skills:implement   ticket by ticket (or implement-spec for 3+ independent tickets)
  -> /mattpocock-skills:code-review
  -> size check   (fix work > 160k tokens: suggest a fix spec; > 200k: make one)
  -> /ship   (explainer for code PRs; PR via the platform)
  -> /end-session   (STATUS, HANDOFF, LOG, re-slice Specs)
end of day:   /day-log      (optional)
end of phase: /thermo-nuclear-code-quality-review -> docs/REFACTOR.md; archive .scratch; branch sweep
```

## Keeps
- All state files: STATUS, HANDOFF, LOG, PLAN, phase files, REFACTOR, ADRs, GLOSSARY.
- Phases sliced as you go: only the `next` spec is detailed.
- Fast lane for docs, config and fixes under ~30 lines (see `fast-lane.md`).
- One PR per spec; split past ~400 lines.

## Costs
- Most ceremony and tokens. Worth it once a project outlives your memory of it (roughly: more than a week, or more than ~5 sessions).
