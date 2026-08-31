---
name: designer-cognitive
description: Grill, debate, brainstorm, and audit UI redesigns or new feature integrations using a 6-phase cognitive UX framework and interactive grilling rounds based purely on the given visual baseline (screenshot), spec document, and redesign goal without external codebase distractions.
---

# Designer Cognitive (Cognitive UX Redesign and Brainstorming)

Execute an interactive cognitive UX audit, debate design trade-offs, brainstorm improvements, and generate modular UX documentation for interface redesigns or new feature integrations.

This skill synthesizes the 6-Phase Cognitive UX Framework with the Interactive Grilling Protocol.

---

## 1. Core Operating Principles

1. **No Silent Assumptions**: Never make layout, hierarchy, or interaction decisions without testing them through interactive rounds.
2. **Interactive Design Tree**: Map redesign decisions as a branching decision tree. Work the tree in rounds of questions at the frontier (decisions whose prerequisites are settled).
3. **Opinionated Recommendations**: Every question presented to the user must include a recommended answer grounded in cognitive UX principles (Fitts's Law, Gestalt proximity, cognitive load, progressive disclosure).
4. **Strict Context Isolation**: Keep all debate, questions, and analysis strictly inside the provided context (the given visual baseline, specification document, and stated design goal). Do not search external codebases or repositories; maintain focus on the user's mental model and avoid distracting code-level noise.
5. **Extreme State First**: The nominal UI state is straightforward; design resilience is proven in overflow, zero-data, error recovery, and permission edge cases.

---

## 2. Input Requirements (Phase 0: Calibration)

Synthesize the three core inputs provided by the user:
1. **Visual Baseline**: Screenshot, wireframe, or existing component reference.
2. **Specification Document / Brief**: Business goals, technical constraints, user personas, and target outcomes.
3. **Core Goal**: The specific reason for change (e.g., *"Reduce checkout churn"*, *"Integrate multi-currency settlement"*, *"Rethink data filtering for high-density tables"*).

*Note: If any detail is omitted from the provided context, state it as an open question within the frontier rounds.*

---

## 3. The 6-Phase Cognitive UX Framework

Structure the debate, brainstorming, and analysis around these 6 core phases:

### Phase 1: Forensic Deconstruction and Cognitive Audit
- **Map "As-Is" Mental Model**: Analyze current scanning patterns ($F$-Pattern for text-heavy interfaces, $Z$-Pattern for dashboards/landing pages). Identify cognitive bottlenecks where users pause, decode jargon, or cross visual paths.
- **Identify UI Debt**: Flag legacy components placed into the layout without spatial consideration.
- **System vs. Mental Model Reconciliation**: Check if the screen is organized around database schemas or user goal completion (*"Is the UI reflecting technical DB tables or user intent?"*).

### Phase 2: Intent and Action Decomposition (JTBD)
Classify screen elements and actions into a 4-tier Jobs-To-Be-Done hierarchy:
- **L1 (Primary Intent)**: The single core reason the user navigates to this screen (e.g., *"Approve invoice"*).
- **L2 (Secondary Intent)**: Supporting actions required to complete L1 (e.g., *"Verify line items"*, *"Check balance"*).
- **L3 (Passive Context)**: Read-only data required for validation (e.g., *"Creation Date"*, *"System ID"*).
- **L4 (Tertiary / Administrative)**: Rare or destructive actions (e.g., *"Export audit log"*, *"Delete record"*).

### Phase 3: Data Hierarchy and Visual Taxonomy (Level Matrix)
Enforce spatial placement and visual weight based on priority level:

| Priority Level | Information Type | Spatial Assignment | Visual Treatment |
|---|---|---|---|
| **L1: Primary Focus** | Hero metrics, core status, primary action button | Top-left / Top-center, focal anchor zone | Maximum visual weight, high contrast, primary color fill |
| **L2: Contextual Support** | Supporting fields, filter controls, primary list items | Below/adjacent to L1, structured containers | Medium weight, neutral backgrounds, outlined components |
| **L3: Secondary Info** | Timestamps, metadata badges, sub-navigation tabs | Peripheral cards, sidebar panels, footer rows | Low weight, muted text, smaller typographic scale |
| **L4: Destruction / Admin** | Delete triggers, deep config settings, export logs | Hidden in overflow menus (`...`), slide-outs, modals | Low contrast, icon-only, or alert accents (red) on demand |

### Phase 4: Spatial Orchestration and Interaction Mechanics
- **Proximity & Chunking (Gestalt)**: Group inputs directly with the outputs they control. Place table filters directly above table headers; row-level actions locked inside rows.
- **Fitts's Law & Touch Trajectories**: Target acquisition time $T = a + b \log_2\left(1 + \frac{D}{W}\right)$ (where $D$ is distance and $W$ is target width). Ensure critical actions have generous hit areas along natural mouse/thumb paths.
- **Progressive Disclosure Strategy**:
  - *Inline Drawers*: Context-preserving sub-details.
  - *Contextual Popovers*: Quick filter adjustments without leaving viewport.
  - *Full-screen Modals*: Reserved for deep workflows requiring uninterrupted focus.

### Phase 5: Dynamic State Engine and Edge-Case Stress Testing
Stress-test every layout proposal against the **Six Interface States**:
1. **Blank / Zero State**: Visual guidance, clear copy, direct primary action trigger (*"Create your first project"*).
2. **Loading / Transition State**: Structural skeletons maintaining layout stability (avoid generic spinners).
3. **Nominal State**: Balanced data amounts.
4. **Overflow / Extreme Stress State**: 65-character user names, 100,000 table rows, +40% localized text expansion (define `ellipsis` truncation vs wrapping rules).
5. **Error / Edge-Case State**: Mid-submission API drops, inline validation, non-destructive retries, auto-save mechanisms.
6. **Permission & Role Variations**: Read-only vs Admin views (grayed-out with tooltips vs hidden elements).

### Phase 6: Handoff Architecture (Modular Documentation)
Deliver 4 modular markdown specifications when consensus is reached:
1. `UX_Layout_Blueprint.md`: Spatial wireframes, content hierarchy, visual grid.
2. `Interaction_Flow_Spec.md`: Action triggers, transitions, hover behaviors, focus orders, modal/drawer orchestration.
3. `EdgeCase_State_Playbook.md`: Dynamic states, zero states, text truncation, latency skeletons, localized text expansion.
4. `Information_Architecture_Taxonomy.md`: Labeling terminology, object relationships, progressive disclosure maps, role permissions.

---

## 4. Grilling Protocol and Round Execution

1. **Compute the Frontier**: Identify open decisions whose prerequisites are settled, drawing exclusively from the provided context.
2. **Format Questions in Rounds**:
   Present questions using this structure:

   ```
   **Q1: <Question Title>**: <Question body detailing spatial, cognitive, or interaction tradeoffs>

   **Recommended**: <Your recommended option and UX rationale referencing cognitive principles>
   ```

3. **Wait for User Response**: Do not execute or write code until the current round is answered and settled.
4. **Recompute and Repeat**: Reshape the design tree based on user answers. Move to the next round until the frontier is empty.

---

## 5. The 5 Rules of Redesign

1. **Never redesign without a clear primary intent.** Every page must have one undisputed primary action.
2. **Respect established muscle memory.** Improve visual logic without breaking fundamental mental habits unless the legacy system was unusable.
3. **Layout reflects data hierarchy.** If spatial layout feels messy, the underlying data priority is wrong.
4. **Design for extremes first.** The nominal state is easy; resilience comes from handling empty lists, missing connections, and multi-line content gracefully.
5. **Document decisions, not just visual assets.** Explain *why* an element lives where it lives so engineering teams implement changes without losing user intent.
