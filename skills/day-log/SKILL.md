---
name: day-log
description: End-of-day log for an Obsidian vault: gathers today's LOG lines, commits and PRs across all sessions and writes one plain-English day note (done, decisions, learned, next, hours). Run once at the end of the working day.
disable-model-invocation: true
tier: optional
needs: vault_folder set in workflow-settings.md
---

Read `docs/agents/workflow-settings.md` first; names in `backticks` below are its settings. If `vault_folder` is empty, say so and stop. Call it V.

1. **Gather today only.** `log_file` lines dated today; `git log --since=midnight --all --oneline`; PRs created or completed today (`pr_list_command` with status all, then keep those created or closed today); STATUS "Next action". No real customer or personal data.
2. **Ask `owner`** in one message: hours worked today, and anything learned or worth noting that the record would miss. Wait for the answer.
3. **Write** `V\Logs\YYYY-MM-DD.md` (UTF-8, Obsidian-native) with frontmatter (`note-type: log`, `project: <vault_project_link>`, `date:`) and sections:
   - **Done**: what was done, a little expanded from the LOG lines, in plain English, with PR numbers.
   - **Decisions**: plain English, linking ADR numbers.
   - **Learned**: the owner's notes plus up to 3 bullets you can stand behind.
   - **Next**: from STATUS.
   - **Hours**: what the owner said.
   If the file exists (a second run today), update it rather than add a new one.
4. **Tracker sources (only if `vault_workspace_note` / `vault_plan_note` are set).** In the workspace note add (or refresh) a `#### YYYY-MM-DD` heading with short numbered entries for today and replace the bullets under `## NEXT STEP` with the STATUS next action; in the plan note tick the phase's `- [ ]` only when a phase closed today. Hours go only in the day note. Never change the layout or any dataview blocks.
5. Report the note path in one line.
