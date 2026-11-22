---
name: vault-note
description: "[wf] Save something worth keeping to an Obsidian vault as a knowledge note: a lesson (a concept explained) or a plain-English decision summary. Use when the owner asks to keep or note something, or when /end-session offers it."
disable-model-invocation: true
tier: optional
needs: vault_folder set in workflow-settings.md
---

Read `docs/agents/workflow-settings.md` first. If `vault_folder` is empty, say so and stop. Call it V.

1. **Kind.** Lesson (a concept, how something works) -> `V\Notes\<Topic> - Lesson.md`. Decision summary (what was decided and why, no repo jargon) -> `V\Notes\YYYY-MM-DD <topic>.md`. Ask only if unclear.
2. **Content.** Plain English first, jargon defined on first use; short sections; a small mermaid diagram if it teaches something; links to ADRs, PRs or explainers instead of copying them. Never copy repo state (specs, status, tickets, logs) and never real customer or personal data.
3. **Format.** UTF-8; frontmatter `note-type: note`, `project: <vault_project_link>`, `date:`; `[[wikilinks]]` to related notes. Full path under ~200 characters.
4. **Write only inside V**, never in the owner's own notes; to replace a note, move the old one to `V\Project Archive\` first. Report the path in one line.
