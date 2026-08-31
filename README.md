# Engineering of Thinking Skills 🧠⚡

Personal collection of high-leverage agent skills designed for rigorous cognitive engineering, systematic defect remediation, prompt evaluation, UX reverse-engineering, multi-perspective dialectic deliberation, binary adversarial debates, and interactive design-tree stress testing.

Compatible with **Claude Code**, **Google Antigravity / Gemini CLI**, **Agents**, and **Codex**.

---

## 📦 Included Skills

| Skill | Purpose | Primary Triggers / Use Cases |
|---|---|---|
| [`adversarial-debate`](skills/adversarial-debate/SKILL.md) | Conducts multi-round political/Oxford-style adversarial debate between two options (Player A vs Player B) with opening cases, attacks, counters, and an impartial judge verdict | `/debate`, `/compare`, *"debate A vs B"*, head-to-head comparison, binary technical choices |
| [`dialectic-consensus`](skills/dialectic-consensus/SKILL.md) | Deliberates complex decisions, tradeoffs, code architectures, or scoring using a 3-perspective jury with contradictory lenses, synthesizing tensions into a reconciled consensus | `/jury`, `/consensus`, *"evaluate with 3 perspectives"*, multi-vision tradeoffs, high-stakes decisions |
| [`grilling`](skills/grilling/SKILL.md) | Stress-tests plans, ideas, and decisions using an interactive design-tree interview framework | `/grill-me`, *"grill me on this plan"*, stress-testing architecture/decisions |
| [`tune-against-eval`](skills/tune-against-eval/SKILL.md) | Iteratively improves prompts and pipeline steps against gold-standard evals via falsifiable hypotheses and isolated single-variable edits | Raising precision/recall/F1, *"why is this failing"*, prompt iteration |
| [`humanizer`](skills/humanizer/SKILL.md) | Strips AI-generated writing tells, significance inflation, and robotic sentence patterns based on Wikipedia's AI cleanup guidelines | Editing text to sound natural, human-written, and grounded |
| [`designer-cognitive`](skills/designer-cognitive/SKILL.md) | Conducts 6-phase cognitive UX audits, JTBD action decomposition, visual hierarchy taxonomies, and redesign grilling | UI redesigns, feature integrations, UX audits |
| [`defensive-bug-fixing`](skills/defensive-bug-fixing/SKILL.md) | Systematic 6-phase defect remediation workflow (SPEC-ENG-BUG-0042) with Rollbar parsing, 5-Whys RCA, and test-driven fixes | Production failures, Rollbar error JSONs, stack traces, bug fixes |
| [`ux-reverse-engineering`](skills/ux-reverse-engineering/SKILL.md) | Reverse-engineers descriptive dual-lens UX specifications (cognitive feel + code mechanics) from existing components and screenshots | *"document this feature"*, reverse-engineering UI components |
| [`create-a-skill`](skills/create-a-skill/SKILL.md) | Standard Operating Procedure (SOP) to turn executed processes and workflows into reusable agent skills | *"turn this into a skill"*, saving repeatable workflows |

---

## 🚀 Installation & Syncing

To symlink these skills into your local agent configuration directories (`~/.agents/skills`, `~/.claude/skills`, `~/.gemini/config/skills`, and `~/.codex/skills`):

```bash
./install.sh
```

The script automatically detects active agent environments, removes stale files or older duplicates, and symlinks each skill to the centralized repository source.

---

## 📁 Repository Structure

```
engineering_of_thinking_skills/
├── install.sh
├── README.md
├── .gitignore
└── skills/
    ├── adversarial-debate/
    │   └── SKILL.md
    ├── create-a-skill/
    │   └── SKILL.md
    ├── defensive-bug-fixing/
    │   ├── SKILL.md
    │   └── references/
    │       ├── 5_whys_rca.md
    │       └── rollbar_parsing.md
    ├── designer-cognitive/
    │   └── SKILL.md
    ├── dialectic-consensus/
    │   └── SKILL.md
    ├── grilling/
    │   └── SKILL.md
    ├── humanizer/
    │   └── SKILL.md
    ├── tune-against-eval/
    │   └── SKILL.md
    └── ux-reverse-engineering/
        ├── SKILL.md
        └── doc.md
```

---

## 🛠️ Adding a New Skill

1. Create a new directory under `skills/<new-skill-name>/`.
2. Add a `SKILL.md` file following the frontmatter convention:
   ```yaml
   ---
   name: your-skill-name
   description: Actionable description with explicit trigger phrases.
   ---
   ```
3. Run `./install.sh` to update symlinks across all agent environments.
4. Commit and push your changes.
