# The owner's notes on the three workflows

Type: research
Status: resolved
Blocked by: none

## Question

The owner took handwritten notes on Matt Pocock, Addy Osmani and pstack (plus harness engineering and the home repo pattern) and picked out main takeaways. For each takeaway: what it means, what the toolbox already does, which research or decision ticket already covers it, and what is new. Fill the factual gaps the notes raise (Ralph Wiggum loop, sandboxing, session hooks, verification and formal methods, enforceable architecture, trunk-based development, an LLM-maintained wiki), and say which takeaways become new tickets, fog, or answers feeding 05.

Sources: the owner's transcribed notebook and their "My Notes On the Three Workflows" takeaways (kept in their vault, not in this repo).

## Answer

- **Common thread:** move rules out of prose into things that enforce themselves (hooks, lint and architecture tests, verification as a hard exit). The toolbox today is almost all prose, with no hooks or checks of its own. Second thread: less, plainer, smaller (scope discipline, boring design, code as a liability, atomic commits, fewer markdown files and comments).
- **Already covered:** observability (20, 21), doubt-driven development and anti-rationalisation tables (01, 05, 26), intent and lifecycle mapping (13, entry-points fog), home repo distribution (23, 27), fewer PRs (24).
- **Hooks back the session skills, not replace them:** SessionStart can inject git and PR facts; SessionEnd can't talk to the model. PreToolUse can block commits to `main` and stray `.md` writes; branch protection is the real guard.
- **Loops and sandboxes:** use built-in `/goal <condition>` rather than the ralph-loop plugin; unattended work goes to cloud sessions (blocks GitHub GraphQL, so `/ship` needs a `gh api` fallback) or a dev container; the built-in sandbox needs WSL2.
- **Verification:** a pass/fail check plus evidence, on a dial from prompt line to `/goal` to Stop hook; four stages (pre-merge, deploy, release, post-release); a trial `docs/FEATURES.md`; Mermaid state diagrams plus a transition-table test instead of TLA+.
- **Enforceable architecture:** NetArchTest / ArchUnitNET and `.editorconfig` error severities for .NET, eslint-plugin-boundaries or dependency-cruiser for JS/TS; comment bans stay a guideline.
- **Trunk-based:** Ship / Show / Ask fits a solo owner (feeds 24); flags need an expiry. **Karpathy wiki:** this repo has most of it; add `notes/index.md` and a notes lint.
- **Candidate new tickets:** enforcement layer (hooks), verification, enforceable codebase per stack, principles in AGENTS.md (may fold into 05). Fog: autonomous loops and sandboxes, home repo as a workplace and wiki.

Notes: [Owner notes on the three workflows](../../../notes/research/2026-11-23%20Owner%20notes%20on%20the%20three%20workflows.md), [Loops, sandboxes and session hooks](../../../notes/research/2026-11-23%20Loops,%20sandboxes%20and%20session%20hooks.md), [Verification and enforceable architecture](../../../notes/research/2026-11-23%20Verification%20and%20enforceable%20architecture.md)
