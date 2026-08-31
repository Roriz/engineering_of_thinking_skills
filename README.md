# Engineering of Thinking Skills 🧠

Personal skills for Claude Code, Google Antigravity, Agents, and Codex. Covers prompt evaluation, edge-case grilling, defect triage, UX specs, multi-perspective reviews, and structured debates.

---

## 📦 Included Skills

| Skill | Purpose | Triggers / Use Cases |
|---|---|---|
| [`bootstrap-gold-dataset`](skills/bootstrap-gold-dataset/SKILL.md) | Builds an initial eval dataset: runs system inputs, labels ground truth independently, clusters edge cases, and grills on ambiguities | *"create gold dataset"*, *"bootstrap eval data"*, dataset prep for `tune-against-eval` |
| [`tune-against-eval`](skills/tune-against-eval/SKILL.md) | Improves prompts and pipelines against evals using falsifiable hypotheses and isolated single-variable edits | Improving precision/recall/F1, *"why is this failing"*, prompt tuning |
| [`adversarial-debate`](skills/adversarial-debate/SKILL.md) | Runs a structured debate between two options (Player A vs Player B) with opening pitches, cross-attacks, counters, and an impartial judge verdict | `/debate`, `/compare`, *"debate A vs B"*, binary comparisons |
| [`dialectic-consensus`](skills/dialectic-consensus/SKILL.md) | Evaluates complex decisions or scores using a 3-perspective jury bench with competing lenses, synthesizing tensions into a clear consensus | `/jury`, `/consensus`, *"evaluate with 3 perspectives"*, multi-angle reviews |
| [`grilling`](skills/grilling/SKILL.md) | Stress-tests plans and decisions through an interactive design-tree interview | `/grill-me`, *"grill me on this plan"*, stress-testing architecture |
| [`humanizer`](skills/humanizer/SKILL.md) | Strips AI writing tells, marketing fluff, and robotic syntax based on Wikipedia's AI cleanup guidelines | Making text sound natural and human-written |
| [`designer-cognitive`](skills/designer-cognitive/SKILL.md) | Runs 6-phase cognitive UX audits, JTBD action decomposition, hierarchy taxonomies, and redesign grilling | UI redesigns, feature integrations, UX audits |
| [`defensive-bug-fixing`](skills/defensive-bug-fixing/SKILL.md) | 6-phase defect remediation workflow (SPEC-ENG-BUG-0042) with Rollbar parsing, 5-Whys RCA, and regression tests | Bug fixing, Rollbar error JSONs, stack traces |
| [`ux-reverse-engineering`](skills/ux-reverse-engineering/SKILL.md) | Reverse-engineers descriptive dual-lens UX specifications (user experience + code mechanics) from existing components and screenshots | *"document this feature"*, reverse-engineering UI components |

---

## 🚀 Installation & Syncing

To link these skills into your local agent directories (`~/.agents/skills`, `~/.claude/skills`, `~/.gemini/config/skills`, and `~/.codex/skills`):

```bash
./install.sh
```

The script symlinks each skill into the active agent folders and removes stale copies.

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
    ├── bootstrap-gold-dataset/
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

1. Create a directory under `skills/<new-skill-name>/`.
2. Add a `SKILL.md` with YAML frontmatter:
   ```yaml
   ---
   name: your-skill-name
   description: >-
     What it does and explicit trigger phrases.
   ---
   ```
3. Run `./install.sh` to update symlinks.
4. Commit and push your changes.
