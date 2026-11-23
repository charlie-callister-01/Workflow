# AGENTS.md is the project's instruction file; CLAUDE.md only imports it

Status: **accepted** (2026-11-23): promoted from the beta track as the first v2 change. Trialled from 2026-11-22 (`notes/trials.md`).

A primed project keeps its rules in `AGENTS.md`, and `CLAUDE.md` is the single line `@AGENTS.md`. Claude Code reads `CLAUDE.md` and imports the file; Antigravity, Cursor, Codex and others read `AGENTS.md` directly, so one file serves every agent and Claude-only projects lose nothing. Every project gets the same layout (no "which agents?" question), because a one-line `CLAUDE.md` is not bloat and a fork in the setup and refit skills would be. `/refit-workflow` moves an existing `CLAUDE.md` with `git mv` so its history follows; where both files exist, the grill decides each extra rule. No `GEMINI.md` or `.agents/rules/`: Antigravity combines every instruction file it finds, which would split the rules.

Over: keeping `CLAUDE.md` as the source (Claude-only, other agents get nothing), or an `AGENTS.md` only when a second agent is chosen (a branch to maintain in two skills and the install script).

Trade-off: Antigravity doesn't expand a bare `@file`, so `CLAUDE.md` is meaningless to it, which is fine because it never reads that file. Skills are not covered: Antigravity loads them from `.agents/skills/`, not `.claude/skills/`, and the trial copies them there by hand. Whether the toolbox installs skills for other agents stays in roadmap decision ticket 06.

Reverse it if: the trial shows the second agent isn't worth keeping and the extra file confuses more than it helps, or Claude Code's import behaves differently from an inline `CLAUDE.md`.
