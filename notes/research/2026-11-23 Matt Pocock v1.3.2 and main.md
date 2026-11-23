# Matt Pocock v1.3.2 and main

## Question

`/setup-workflow` replaces Matt Pocock's `setup-matt-pocock-skills`, and `templates/docs/agents/*` stand in for the tracker, labels and domain docs it writes. Which of his changes between v1.3.1 and v1.3.2, and between v1.3.2 and `main`, must the toolbox mirror, and which overlap with roadmap tickets? Feeds decision ticket 11.

## Sources

- Repo: https://github.com/mattpocock/skills (from the plugin's `plugin.json` `repository` field).
- Release v1.3.2 (2026-10-29), the changelog for the release: https://github.com/mattpocock/skills/releases/tag/v1.3.2. v1.3.1 was released 2026-10-04.
- Compare v1.3.1...v1.3.2 (51 commits): https://github.com/mattpocock/skills/compare/v1.3.1...v1.3.2
- Compare v1.3.2...main (9 commits, to 2026-11-19): https://github.com/mattpocock/skills/compare/v1.3.2...main. Unreleased changes are in `.changeset/*.md` on `main`.
- Files read at each tag (tarballs via `gh api`): `skills/engineering/setup-matt-pocock-skills/{SKILL.md, issue-tracker-github.md, issue-tracker-local.md, triage-labels.md, domain.md}`, `to-tickets`, `wayfinder`, `research`, `implement-spec`, `skills/in-progress/{chief-of-staff, software-factory}/SKILL.md`, `.claude-plugin/plugin.json`.
- Key PRs: [#1228](https://github.com/mattpocock/skills/pull/1228) (git remote, `CONTEXT.md` migration, GitHub template), [#1197](https://github.com/mattpocock/skills/pull/1197) (triage labels), [#1188](https://github.com/mattpocock/skills/pull/1188) (sub-issues), [#1341](https://github.com/mattpocock/skills/pull/1341) (fresh-context subagents), [#1181](https://github.com/mattpocock/skills/pull/1181) (wayfinder), [#1208](https://github.com/mattpocock/skills/pull/1208) (code-review), [#1342](https://github.com/mattpocock/skills/pull/1342), [#1363](https://github.com/mattpocock/skills/pull/1363), [#1316](https://github.com/mattpocock/skills/pull/1316).
- This repo: `skills/setup-workflow/SKILL.md`, `skills/refit-workflow/SKILL.md`, `templates/docs/agents/*.md`, `platforms/github.md`, roadmap tickets 13, 15, 23, 30, 34, 35.

## What I learned

**The local "1.3.1" is not the v1.3.1 tag.** The plugin cache labelled 1.3.1 (`~/.claude/plugins/cache/claude-plugins-official/mattpocock-skills/1.3.1/`) sits between the two tags: it already has triage label creation, sub-issue commands, `to-tickets` sub-issues and `chief-of-staff`, but not the git-remote step, the `CONTEXT.md` migration, the Blocking move or the fresh-context wording. Diffing against the cache under-counts the change; diff against the tags.

**Already true at v1.3.1.** The `CONTEXT.md` -> `GLOSSARY.md` rename happened before v1.3.1 (the v1.3.1 tag has no `CONTEXT.md` in any skill). `retro` graduated into the plugin in v1.3.0. The toolbox's `domain.md` template already uses `GLOSSARY.md` / `GLOSSARY-MAP.md`.

**v1.3.2: the setup skill and its templates.**
- Git remote first: a GitHub or GitLab *tracker* now needs a reachable repo; the skill wires `git remote add origin` and checks `gh repo view` before going on (#1228).
- Legacy migration: if `CONTEXT.md` / `CONTEXT-MAP.md` exist, it offers `git mv` to the `GLOSSARY` names and rewrites `docs/agents/domain.md` (#1228).
- Triage labels: creates any missing label with `gh label create` / `glab label create`; the template now names the "Label in our tracker" column (#1197). The toolbox's `triage-labels.md` already uses that wording.
- GitHub tracker template: read issues with `--json`; sub-issues via `gh issue create --parent` or `--add-sub-issue` (`gh` 2.94+); **Blocking** moved into Conventions with native `--blocked-by` / `--add-blocked-by`; a "count open blockers" command; comment then close (`gh issue close --comment` drops the comment on a closed issue); read a PR's body as well as its comments; file issues only into the user's own repo, checking `gh repo view --json nameWithOwner` first (#1169, #1187, #1188, #1228). The local-markdown template (`issue-tracker-local.md`) did not change.
- `to-tickets`: each ticket becomes a sub-issue of its source issue; `## Blocked by` is omitted when blockers are native edges (#1188). Local files keep their `Blocked by` line.

**v1.3.2: other skills.**
- Fresh-context subagents: `implement-spec`, `code-review`, `codebase-design`, `improve-codebase-architecture`, `wayfinder`, `research`, `grilling` and `chief-of-staff` now say to start each subagent with a fresh context window, not a fork of the conversation (#1341).
- `wayfinder`: maps and tickets carry only `wayfinder:` labels, never `ready-for-agent`; cross-references only with real ids; research branches are pushed but get no PR; each ticket is resolved as the type its label names (#1181).
- `code-review`: searches for standards files and always passes `CODING_STANDARDS.md` / `CONTRIBUTING.md` to the Standards sub-agent; runs both sub-agents in the foreground; finds the tracker through the tracker doc, not a fixed path (#1208).
- Smaller: `grilling` words questions so "yes" accepts the recommendation (#1193); `handoff` names `%TEMP%` on Windows (#1184); `implement` calls `tdd` and `code-review` through the Skill tool and states the ticket title first (#1189, #1196); `diagnosing-bugs` diffs a forced mutation before trusting a red test (#1209); `ask-matt` reads a skill's `SKILL.md` before describing it (#1194); `chief-of-staff` keeps a dated, commit-cited LLM wiki (#1304).

**main, after v1.3.2 (unreleased).**
- `implement-spec`: a fresh implementer subagent per ticket and for the code-review fixes (#1342).
- `chief-of-staff` (in-progress, not in the plugin): looks for a shared wiki first; runs `retro` on about one in five subagent sessions, worst first, and acts on the findings itself; runs `to-spec` -> `to-tickets` -> `implement-spec` for large work, reading each by relative path so they stay user-invoked (#1363).
- `software-factory` (new, in-progress, not in the plugin): a glossary for designing a factory of agents (task, trigger, run, runner, ticket tracker, git host, orchestrator) with surveys of trackers, runners, git hosts and observability platforms (#1316).
- CI now checks every `SKILL.md` frontmatter parses with a strict YAML parser; `software-factory`'s description had to be quoted because of a colon.
- The plugin manifest still lists only the engineering and productivity skills: `chief-of-staff` and `software-factory` do not ship with the plugin.

**Where the toolbox stands.** The toolbox's tracker is local Markdown in `.scratch/`; `platform: github` covers PRs and CI only (`platforms/github.md`). So the GitHub *tracker* template changes do not reach toolbox projects today. The toolbox already matches on `GLOSSARY.md` and the label column name. It does not yet handle a legacy `CONTEXT.md`, check that a GitHub remote exists before `/ship` needs one, or say "fresh context" in `refit-workflow`'s one subagent.

| Change | In | Must the toolbox mirror it? | Where | Related ticket |
|---|---|---|---|---|
| Wire a git remote before a GitHub/GitLab tracker | v1.3.2 | yes, adapted: for `platform: github`, check `gh repo view` in step 1 so `/ship` can reach the repo | `skills/setup-workflow/SKILL.md` | 15 |
| Offer `git mv CONTEXT.md` -> `GLOSSARY.md` (and `-MAP`) | v1.3.2 | yes | `skills/refit-workflow/SKILL.md` (analysis row), `skills/setup-workflow/SKILL.md` step 1 | 23 |
| `CONTEXT.md` -> `GLOSSARY` rename itself | before v1.3.1 | already done | `templates/docs/agents/domain.md` | none |
| Create missing triage labels on the tracker | v1.3.2 | no while the tracker is local Markdown; later if a GitHub Issues tracker is offered | `templates/docs/agents/triage-labels.md`, `skills/setup-workflow` | 35, 06 |
| "Label in our tracker" column named | v1.3.2 | already done | `templates/docs/agents/triage-labels.md` | none |
| GitHub tracker: sub-issues, native blocking, open-blocker count, comment-then-close, `--json` reads, own-repo guard | v1.3.2 | later, only with a GitHub Issues tracker option (copy his template then) | a new `templates/docs/agents/issue-tracker-github.md` | 35, 06 |
| `to-tickets` omits `Blocked by` with native edges | v1.3.2 | no: local tickets keep the line | `templates/docs/agents/issue-tracker.md` | none |
| Subagents start with a fresh context, not a fork | v1.3.2 | yes, one phrase | `skills/refit-workflow/SKILL.md` step 2; `templates/AGENTS.md` delegate line | 06, 18 |
| `wayfinder`: no triage labels on maps; resolve by type; real ids; research branch gets no PR | v1.3.2 | mostly already true (Type: line, no labels); note the deliberate divergence: toolbox research notes merge into `notes/research/` | `templates/docs/agents/issue-tracker.md` Wayfinding section | 10 |
| `code-review` always reads `CODING_STANDARDS.md` / `CONTRIBUTING.md` | v1.3.2 | no change needed; supports `SETUP.md` step 6 (short `CODING_STANDARDS.md`) | `SETUP.md`, `templates/` if a standards stub is added | 32 |
| `grilling`: "yes" accepts the recommendation | v1.3.2 | no: `setup-workflow` step 2 already works this way | none | none |
| `implement-spec`: fresh implementer per ticket and for review fixes | main | no copy; mention in the change-flow text that it costs more tokens | `notes/workflow-guide.md`, `CUSTOMISING.md` | 13, 19 |
| `retro` (in plugin since v1.3.0); `chief-of-staff` runs it on 1 in 5 sessions | v1.3.0 / main | later: decide where `retro` sits after `/ship` and in the evolution loop | `skills/end-session` or the change flows | 15, 09, 21 |
| `chief-of-staff` LLM wiki: shared wiki first, dated, commit-cited claims | v1.3.2 / main | later: input to the wiki question | `notes/` | 35, 10 |
| `chief-of-staff` reads other skills by relative path to keep them user-invoked | main | later: a pattern for chaining without model invocation | toolbox skills | 34 |
| `ask-matt` reads a skill's `SKILL.md` before routing | v1.3.2 | later: a rule for any toolbox router | a router skill, if built | 34 |
| `software-factory` glossary (task, run, runner, orchestrator) | main | no; read when designing loops or hooks | none | 25, 30 |
| CI check that `SKILL.md` frontmatter parses (quote descriptions with colons) | main | yes, cheap: toolbox descriptions already quoted; keep it a rule | `DEVELOPING.md` or a smoke test in `tools/` | 30 |

## What the toolbox might change

1. `setup-workflow` step 1: when platform is `github` and no remote points at GitHub, ask for the URL and check `gh repo view`, as Pocock now does for trackers. One line.
2. `setup-workflow` step 1 and `refit-workflow`'s analysis: spot `CONTEXT.md` / `CONTEXT-MAP.md` and offer `git mv` to the `GLOSSARY` names. One line each.
3. Say "with a fresh context window" wherever a toolbox skill or template starts a subagent (`refit-workflow` step 2, `templates/AGENTS.md`).
4. Keep a frontmatter rule: quote any `description` with a colon in it, as his CI now enforces.
5. Leave the GitHub tracker template alone until ticket 35 (or 06) decides whether projects can use GitHub Issues; if so, copy his v1.3.2 `issue-tracker-github.md` wholesale rather than rewriting it.
6. Feed tickets 15 and 09 with `retro` and `chief-of-staff`'s "retro one in five sessions"; feed 34 with `ask-matt` reading `SKILL.md` and the relative-path chaining; feed 35 with the shared, dated wiki.
7. When comparing against upstream again, diff against release tags, not the plugin cache: the cache's version label lags its content.
