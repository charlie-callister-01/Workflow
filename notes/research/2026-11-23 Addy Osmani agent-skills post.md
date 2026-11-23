# Addy Osmani's agent-skills blog post

## Question

What does Addy Osmani's "Agent Skills" blog post add beyond his agent-skills repo (already covered in `2026-11-22 Addy Osmani agent-skills.md`): his reasoning, how he writes and tests skills, anti-patterns, anything newer than v0.6.17, and what is worth taking?

## Sources

- Addy Osmani, ["Agent Skills"](https://addyosmani.com/blog/agent-skills/) (blog, 2026-05-03): read in full on 2026-11-23
- Follow-ups by the same author, linked from the post's related reading:
  - ["Audit your Agent files"](https://addyosmani.com/blog/audit-your-agent-files/) (2026-08-27): how configuration rots and how to prune it
  - ["Agentic Skill Decay"](https://addyosmani.com/blog/agentic-skill-decay/) (2026-08-31): mostly about the human's skills, with a section on durable lessons
- Repo state: <https://github.com/addyosmani/agent-skills> commits and releases via `gh api` on 2026-11-23

## What I learned

### The post is older than the repo
- Published May 2026, it describes an earlier pack: 20 skills, 7 slash commands, and a library kept within "roughly 5K tokens" by loading skills per phase. The repo is now at 26 skills and 10 commands.
- Nothing is newer than v0.6.17: that is still the latest release (2026-11-18, the accessibility skill and persona, plus recorded behaviour runs for re-grading). The post names no version.
- It says it covers "the part the README doesn't quite cover": the *why*, not new mechanics.

### His reasoning
- Agents take "the shortest path to 'done'" and skip the work a senior engineer does that doesn't show in the diff (specs, tests, review, scope control), for the same reason juniors do: the reward is task completion.
- A skill is a workflow with checkpoints and an exit criterion, not reference docs: "Process over prose. Workflows over reference. Steps with exit criteria over essays without them." An essay on testing gets read and ignored; a list of steps gets done and can be checked.
- Five principles: process over prose; anti-rationalisation tables; verification as a hard exit ("Passing tests are evidence, not proof"; "'Seems right' is never sufficient"); progressive disclosure; scope discipline. He calls "touch only what you're asked to touch" "the single biggest determinant of whether an agent's PR is mergeable".
- Skills matter more the longer an agent runs: "The longer the run, the more the senior-engineer scaffolding has to be enforced rather than suggested." He places skills inside a wider "agent harness" (AGENTS.md, hooks, tools, session log).
- Three ways to use the pack: install the plugin, drop the Markdown into another host, or **read it as a spec** and copy the ideas into your own process and AGENTS.md. "What to steal without installing" lists anti-rationalisation, process over prose, verification as an exit, progressive disclosure and the five non-negotiables.

### How he writes and tests skills
- The post itself gives no template, description rules or test method. Those live in the repo (`docs/skill-anatomy.md`, `evals/`), already covered in the earlier note.

### Anti-patterns and upkeep (from the follow-ups)
- **Configuration rots**: "Your coding agent's configuration has a half-life." It ratchets: the agent errs, you add a rule, the file grows, adherence drops. "You wanted a short decision guide. You built a knowledge base." (Audit post.)
- Named anti-patterns: a rule after every error and none ever removed; content duplicated from the README or other skills; long examples; skill sprawl with overlapping skills that silently override each other; forgotten trial skills; hooks that slow every session; generic clean-code advice. (Audit post.)
- **Prune by experiment**: archive the setup, run `/doctor` in a session, check `/memory`, remove what's flagged, then run a real task *without* the skills. If the agent fails the way a skill was written to prevent, the skill has earned its place; otherwise leave it out. Every two to four weeks. (Audit post.)
- **Rules that must always hold** belong in a test, hook or permission, not in prose. Keep context files under 200 lines and include only what the model can't infer from the code. (Audit post.)
- **Lessons should land somewhere durable** (tests, lint rules, a `lessons.md`), selectively, not in chat memory; "Skills and MCPs can encode a useful workflow. They cannot tell you when its assumptions no longer fit your system." (Skill-decay post.)

## What the toolbox might change

1. **Treat the pack as a spec, not an install.** His own third mode; it confirms the earlier note's call to borrow ideas and individual skills.
2. **Rewrite essay-like skill sections as steps with an exit check.** A quick pass over `skills/` for paragraphs that tell rather than instruct; each skill ends in evidence (fits the "Verification" item in the earlier note).
3. **A removal test for the toolbox's own skills and AGENTS.md**: periodically turn a skill off, run a real task, and keep it only if its absence shows. Fits the "Measure it" idea and `notes/trials.md`; could be a step in `refit-workflow`.
4. **Promote must-hold rules to hooks or checks** (e.g. "never commit to `main`", "edit `skills/` not `.claude/skills/`") instead of only stating them in AGENTS.md.
5. **Keep the AGENTS.md template short**: under 200 lines, only what the code doesn't say, no copy of the README.
6. **Nothing new to track in the repo itself** since v0.6.17.

Candidates for `../ideas.md`: items 2, 3 and 4.
