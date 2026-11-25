# Workflow Guide

How work flows from an idea to `main`, which skill does what, where every file lives, and how agents keep their context small. First written for the PoReader project (2026-11-20, preset `full`, platform `azure`); kept here as the starting point. A project's `CLAUDE.md` is what agents follow; this is the human map of it.

> **The short version.** **Start** with `/start-session`. **Think** with `/grill-with-docs`. **Plan** with `/to-spec` and `/to-tickets`. **Build** with `/implement`. **Check** with `/code-review`. **Ship** with `/open-pr`. **Close** with `/end-session`. At the end of the day, `/day-log`.

---

## 1. The map: where everything lives

```mermaid
flowchart LR
  subgraph REPO["Repo (the truth)"]
    CL["CLAUDE.md<br/>rules agents follow"]
    ST["docs/STATUS.md<br/>where we are"]
    HO["docs/HANDOFF.md<br/>what to read next"]
    LG["docs/LOG.md<br/>one line per session"]
    PH["docs/phases/P-NN.md<br/>phase + Specs list"]
    SC[".scratch/pNN-slug/<br/>spec + tickets"]
    AD["docs/adr/<br/>decisions"]
    SK[".claude/skills/<br/>start, end, open-pr,<br/>day-log, vault-note"]
  end
  subgraph PF["Platform (Azure DevOps or GitHub)"]
    PR["Pull requests"]
    PL["Pipeline<br/>build, test, format"]
    BO["Boards<br/>phases + specs, by hand"]
  end
  subgraph VA["Vault (optional: my knowledge)"]
    NO["Notes<br/>lessons, decision summaries"]
    LO["Logs<br/>day logs"]
    AR["Artifacts<br/>explainer copies + index"]
    PA["Project Archive"]
  end
  SK -->|"/open-pr opens"| PR
  PR -->|"must pass"| PL
  SC -.->|"reminder to mirror"| BO
  SK -->|"/day-log, /vault-note"| NO
  SK -->|"/day-log"| LO
  SK -->|"/open-pr copies explainer"| AR
```

| Where | What lives there | Who writes it |
|---|---|---|
| Repo | Rules, state, plans, specs, tickets, decisions, code | Agents (I review the diff) |
| Platform | PRs, builds, board items | `/open-pr` opens PRs; I approve and complete; boards by hand |
| Vault, agent folder | Lessons, decision summaries, day logs, explainer copies, archive | Agents, only in that folder |
| Vault, my notes | My own notes, hours and status | Me |

---

## 2. A session from start to finish

```mermaid
sequenceDiagram
  actor Me as Me
  participant A as Agent
  participant R as Repo
  participant P as Platform
  participant V as Vault
  Me->>A: /start-session
  A->>R: git fetch, read STATUS + files HANDOFF lists
  A->>P: list open PRs
  A-->>Me: branch current? PRs, next step (under 10 lines)
  Me->>A: go
  A->>R: work on a branch (never main)
  A->>P: /open-pr opens PR
  P-->>Me: build result on the PR
  Me->>P: approve + complete
  Me->>A: /end-session
  A->>R: STATUS, HANDOFF pointers, one LOG line, re-slice Specs
  A-->>Me: reminders (boards, thermo at phase end, vault-note)
  Me->>A: /day-log (end of day)
  A->>V: Logs/YYYY-MM-DD.md
```

---

## 3. The coding chain

```mermaid
flowchart TD
  IDEA["Change to make"] --> SIZE{"Docs, config,<br/>or fix under ~30 lines?"}
  SIZE -->|yes: fast lane| SHIP
  SIZE -->|no| GRILL["/grill-with-docs<br/>questions + glossary/ADR edits"]
  GRILL --> SPEC["/to-spec"]
  SPEC --> TIX["/to-tickets<br/>.scratch/pNN-slug/issues/"]
  TIX --> HOW{"3+ independent<br/>tickets and tokens to spare?"}
  HOW -->|no: default| IMP["/implement<br/>ticket by ticket, TDD"]
  HOW -->|yes| IMPS["/implement-spec<br/>parallel subagents"]
  IMP --> REV["/code-review"]
  IMPS --> REV
  REV --> EST{"Fix work estimate"}
  EST -->|"under 160k tokens"| FIX["Fix in place"]
  EST -->|"over 160k: suggest<br/>over 200k: must"| FIXSPEC["New fix spec<br/>in the phase Specs list"]
  FIXSPEC --> SPEC
  FIX --> SHIP["/open-pr"]
  SHIP --> CODE{"code_pattern matched?"}
  CODE -->|yes| EXP["/pr-explainer<br/>+ vault copy + index row"]
  CODE -->|no| BODY
  EXP --> BODY["PR body<br/>/pr"]
  BODY --> NEWPR["platform PR command<br/>squash for docs, merge for code"]
  NEWPR --> PIPE["Pipeline must be green<br/>+ my approval"]
  PIPE --> END["/end-session"]
```

**One PR per spec**, tickets as commits; split if the diff passes about 400 lines.

**Size check.** After review the agent prints a rough estimate: lines it must read or change x about 12 tokens, plus about 20k. Over 160k it suggests a fix spec; over 200k it must.

**Why `/implement` is the default.** `implement-spec` runs several agents at once, and each re-reads the spec and code, so it uses more tokens in total and burns them faster. Use it when time matters more than the usage limit.

---

## 4. Phases are sliced as we go

```mermaid
flowchart LR
  START["Phase starts"] --> SLICE["Write a short Specs list<br/>in P-NN.md"]
  SLICE --> NEXT["Detail only the next spec"]
  NEXT --> BUILD["Build + ship it"]
  BUILD --> RESLICE["/end-session re-slices:<br/>reorder, add fix lines, drop"]
  RESLICE -->|more specs| NEXT
  RESLICE -->|phase checkpoint met| ENDP["Phase end"]
  ENDP --> THERMO["/thermo-nuclear review<br/>of the phase diff"]
  THERMO --> REF["docs/REFACTOR.md<br/>the one refactor backlog"]
  ENDP --> ARCH["Archive .scratch/pNN-*"]
  REF -->|"pulled into"| NEXTPHASE["Next phase's Specs list"]
```

- **Why not slice everything up front?** Specs written early go stale as earlier work teaches us things. Only the next spec gets detail.
- **Specs list states:** `next`, `planned`, `done`, `dropped`, plus `fix:` lines.
- **Fixes by size:** tiny -> fast lane; medium -> a `fix:` spec in the current list; belongs later -> a line in that phase's list.
- **Refactoring:** found by the phase-end thermo review, kept in `docs/REFACTOR.md`, scheduled into the next phase.

---

## 5. Context: what an agent reads

```mermaid
flowchart TD
  subgraph ALWAYS["Every session (small)"]
    C1["CLAUDE.md (auto)"]
    C2["docs/STATUS.md"]
    C3["files listed in HANDOFF (2-4)"]
  end
  subgraph DEMAND["Only when needed"]
    D1["GLOSSARY.md, design digest"]
    D2["ADRs for the area"]
    D3["LOG.md"]
    D4["the vault"]
  end
  subgraph NEVER["Never"]
    N1["build output"]
    N2[".scratch/archive/, old phase files"]
  end
  ALWAYS --> WORK["Work"]
  DEMAND -.->|grep first, read ranges| WORK
```

- Session start is about 3-4k tokens: no duplicated state (STATUS holds state, HANDOFF only points).
- Wide searches and reviews go to subagents; only their conclusions come back.
- Agents remember a few working habits in their memory (archive don't delete, UTF-8 edits, ASCII PR text on Azure, check git before claiming); project facts stay in the repo.

---

## 6. Skills at a glance

| Skill | When | What it writes |
|---|---|---|
| `/start-session` | Start of a session | Nothing; reports branch, PRs, next step |
| `/grill-with-docs` | Before a non-trivial spec | `GLOSSARY.md`, ADRs (with the PR) |
| `/to-spec`, `/to-tickets` | Planning a spec | `.scratch/pNN-slug/` |
| `/implement` / `implement-spec` | Building | Code, tests, commits |
| `/code-review` | Before every code PR | Review findings + size estimate |
| `/open-pr` | Opening any PR | PR body, explainer (code only), PR |
| `/pr-explainer` | Called by `/open-pr`, or on request | explainer HTML + vault copy + index row |
| `/end-session` | End of a session | STATUS, HANDOFF, one LOG line, Specs list |
| `/thermo-nuclear-code-quality-review` | End of a phase | Findings in `docs/REFACTOR.md` |
| `/day-log` | End of the day | `Logs/YYYY-MM-DD.md` |
| `/vault-note` | Something worth keeping | A lesson or decision summary |
| `/wayfinder` | Only for a very foggy phase | A decision map in `.scratch/` |

**How `/grill-with-docs` works:** it runs `grilling` (questions in rounds, each with a recommended answer, facts looked up by subagents, nothing done until we agree) together with `domain-modeling` (checks my words against `GLOSSARY.md`, updates it as terms settle, offers an ADR only if a decision is hard to reverse, surprising, and a real trade-off).

---

## 7. Tips
- If STATUS and git disagree, trust git and the platform; `/start-session` says so.
- Open PRs only with `/open-pr`; it checks the branch is pushed and picks squash or merge.
- On Azure, PR text must be plain ASCII; the CLI drops other characters.
- Archive, never delete: repo `.scratch/archive/`, `docs/archive/`; vault `Project Archive`.
- Keep vault paths short (under ~200 characters); OneDrive and Windows choke on long ones.
- Learning is opt-in: ask "explain this" any time.
