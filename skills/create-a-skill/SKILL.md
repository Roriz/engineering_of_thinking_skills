---
name: create-a-skill
description: Turn a process just executed (or described) into a reusable Claude Code skill - grill for the open decisions, then write a terse SKILL.md. Use when the user asks to save/reuse a workflow as a skill, turn a process into a skill, or wants to "remember how we did X" for next time.
---

# Creating a skill

1. Repeatable? If one-off, say so - suggest memory or CLAUDE.md instead, no skill.
2. Grill only the open decisions (AskUserQuestion, one round, recommended answer first):
   - Scope: which phase(s) of the process, in vs out
   - Generality: this exact task, or a class of tasks
   - Location: project `.claude/skills/` vs user-level `~/.claude/skills/`
   - Invocation: named command, auto-triggered by description, or both
   - Autonomy: what it decides alone vs. escalates
   - Style: strict SOP vs. principles/mindset
   - Worked example: yes/no, genericized
3. Check sibling `SKILL.md` files first - format, naming, length.
4. Name: short, kebab-case, verb/action-shaped.
5. Description: what it does + explicit trigger phrases - this is the auto-match surface, make it earn its keep.
6. Body, matching the decided style exactly:
   - Principles/mindset: one line each, no rationale unless asked.
   - SOP: numbered steps only.
   - Either way: as short as it survives being.
7. mkdir + write to the decided location.
8. Report back short: name, location, one-line scope, invocation.
