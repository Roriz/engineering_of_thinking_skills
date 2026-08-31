---
name: designer-cognitive
description: Grill, debate, brainstorm, and audit UI redesigns or new feature integrations using a 6-phase cognitive UX framework and interactive grilling rounds based purely on the given visual baseline (screenshot), spec document, and redesign goal without external codebase distractions.
---

# Designer Cognitive (Cognitive UX Redesign & Brainstorming)

Execute a deep, interactive cognitive UX audit, debate design trade-offs, brainstorm improvements, and generate modular UX documentation for interface redesigns or new feature integrations.

This skill synthesizes the **6-Phase Cognitive UX Framework** (from `designer cognitive.pdf`) with the **Interactive Grilling Protocol** (from `/grill-me`).

---

## 1. Core Operating Principles

1. **No Silent Assumptions**: Never make layout, hierarchy, or interaction decisions without stress-testing them through interactive rounds.
2. **Interactive Design Tree**: Map redesign decisions as a branching decision tree. Work the tree in **rounds** of questions at the **frontier** (decisions whose prerequisites are settled).
3. **Opinionated Recommendations**: Every question presented to the user must include a well-reasoned, recommended answer (`➡️`) grounded in cognitive UX principles (Fitts's Law, Gestalt proximity, cognitive load, progressive disclosure).
4. **Strict Context Isolation**: All debate, questions, and analysis must remain strictly inside the provided context (the given visual baseline, specification document, and stated design goal). Do NOT search external codebases, repositories, or system implementation details—keep focus strictly on the designer's cognitive mental model and avoid distracting code-level noise.
5. **Extreme State First**: Nominal UI state is trivial; true design resilience is proved in overflow, zero-data, error recovery, and permission edge cases.

---

## 2. Input Requirements (Phase 0: Mental Calibration)

To begin a session, synthesize the three core inputs provided by the user:
1. **Legacy Visual Baseline**: Screenshot, wireframe, or existing component reference.
2. **Specification Document / Brief**: Business goals, technical constraints, user personas, and target outcomes.
3. **Core Focus / Directivity (Goal)**: The specific catalyst for change (e.g., *"Reduce checkout churn"*, *"Integrate multi-currency settlement"*, *"Rethink data filtering for high-density tables"*).

*Note: If any detail is omitted from the provided context, state it explicitly as an open question or assumption within the frontier rounds—do NOT attempt to inspect external codebases or repositories.*

---

## 3. The 6-Phase Cognitive UX Framework

Structure the debate, brainstorming, and analysis around these 6 core phases:

### Phase 1: Forensic Deconstruction & Cognitive Audit
- **Map "As-Is" Mental Model**: Analyze current scanning patterns ($F$-Pattern for text-heavy interfaces, $Z$-Pattern for dashboards/landing pages). Identify cognitive load bottlenecks where users pause, decode jargon, or cross visual paths.
- **Identify UI Debt**: Flag legacy components shoehorned into layout without spatial consideration.
- **System vs. Mental Model Reconciliation**: Determine if the current screen is organized around database schemas or user goal completion (*"Is the UI reflecting technical DB tables or user intent?"*).

### Phase 2: Intent & Action Decomposition (JTBD)
Classify all screen elements and actions into a 4-tier Jobs-To-Be-Done hierarchy:
- **L1 (Primary Intent)**: The single core reason the user navigates to this screen (e.g., *"Approve invoice"*).
- **L2 (Secondary Intent)**: Supporting actions required to complete L1 (e.g., *"Verify line items"*, *"Check balance"*).
- **L3 (Passive Context)**: Read-only data required for validation (e.g., *"Creation Date"*, *"System ID"*).
- **L4 (Tertiary / Administrative)**: Rare or destructive actions (e.g., *"Export audit log"*, *"Delete record"*).

### Phase 3: Data Hierarchy & Visual Taxonomy (Level Matrix)
Enforce spatial placement and visual weight based on priority level:

| Priority Level | Information Type | Spatial Assignment | Visual Treatment |
|---|---|---|---|
| **L1: Primary Focus** | Hero metrics, core status, primary action button | Top-left / Top-center, focal anchor zone | Maximum visual weight, high contrast, primary color fill |
| **L2: Contextual Support** | Supporting fields, filter controls, primary list items | Below/adjacent to L1, structured containers | Medium weight, neutral backgrounds, outlined components |
| **L3: Secondary Info** | Timestamps, metadata badges, sub-navigation tabs | Peripheral cards, sidebar panels, footer rows | Low weight, muted text, smaller typographic scale |
| **L4: Destruction / Admin** | Delete triggers, deep config settings, export logs | Hidden in overflow menus (`...`), slide-outs, modals | Low contrast, icon-only, or alert accents (red) on demand |

### Phase 4: Spatial Orchestration & Interaction Mechanics
- **Proximity & Chunking (Gestalt)**: Group inputs directly with the outputs they control. Place table filters directly above table headers; row-level actions locked inside rows.
- **Fitts's Law & Touch Trajectories**: Target acquisition time $T = a + b \log_2\left(1 + \frac{D}{W}\right)$ (where $D$ is distance and $W$ is target width). Ensure critical actions have generous hit areas along natural mouse/thumb paths.
- **Progressive Disclosure Strategy**:
  - *Inline Drawers*: Context-preserving sub-details.
  - *Contextual Popovers*: Quick filter adjustments without leaving viewport.
  - *Full-screen Modals*: Reserved exclusively for deep, complex workflows requiring uninterrupted focus.

### Phase 5: Dynamic State Engine & Edge-Case Stress Testing
Stress-test every layout proposal against the **Six Interface States**:
1. **Blank / Zero State**: Visual guidance, encouraging illustration, direct primary action trigger (*"Create your first project"*).
2. **Loading / Transition State**: Structural skeletons maintaining layout stability (avoid generic spinners).
3. **Nominal State**: Ideal, balanced data amounts.
4. **Overflow / Extreme Stress State**: 65-character user names, 100,000 table rows, +40% German translation text expansion (define `ellipsis` truncation vs wrapping rules).
5. **Error / Edge-Case State**: Mid-submission API drops, inline validation, non-destructive retries, auto-save mechanisms.
6. **Permission & Role Variations**: Read-only vs Admin views (grayed-out with tooltips vs hidden elements).

### Phase 6: Handoff Architecture (Modular Documentation)
Deliver 4 modular, production-ready markdown specifications when consensus is reached:
1. `UX_Layout_Blueprint.md`: Spatial wireframes, content hierarchy, visual grid.
2. `Interaction_Flow_Spec.md`: Action triggers, transitions, hover behaviors, focus orders, modal/drawer orchestration.
3. `EdgeCase_State_Playbook.md`: Dynamic states, zero states, text truncation, latency skeletons, localized text expansion.
4. `Information_Architecture_Taxonomy.md`: Labeling terminology, object relationships, progressive disclosure maps, role permissions.

---

## 4. Grilling Protocol & Round Execution

1. **Compute the Frontier**: Identify all open decisions whose prerequisites are settled, drawing exclusively from the provided context.
2. **Format Questions in Rounds**:
   Present questions using this exact structure:

   ```
   ❓ **Q1** - **<Question Title>**: <Question body detailing spatial, cognitive, or interaction tradeoffs>

   ➡️ **Recommended**: <Your recommended option and deep UX rationale referencing cognitive principles>
   ```

3. **Wait for User Response**: Do not execute or write code until the current round is answered and settled.
4. **Recompute & Repeat**: Reshape the design tree based on user answers. Move to the next round until the frontier is empty.

---

## 5. The 5 Golden Rules of Redesign

Enforce these golden rules in every brainstorm and proposal:
1. **Never redesign without a clear primary intent.** Every page must have one undisputed primary action.
2. **Respect established muscle memory.** Improve visual logic without breaking fundamental mental habits unless the legacy system was unusable.
3. **Layout is data hierarchy brought to life.** If spatial layout feels messy, data priority hierarchy is wrong.
4. **Design for the extremes first.** The nominal state is easy; true design mastery lies in handling empty lists, missing connections, and multi-line content gracefully.
5. **Document decisions, not just visual assets.** Explain *why* an element lives where it lives so engineering teams implement changes without losing user intent.
