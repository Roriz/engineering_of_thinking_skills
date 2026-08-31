---
name: ux-reverse-engineering
description: |
  Reverse-engineer a descriptive UX specification for one existing feature from whatever
  evidence is given — screenshot, component path, URL, design file, or any subset.
  Use for "document this feature", "write a UX spec", "reverse-engineer this screen",
  "what does this component actually do", or a bare screenshot + path.
  Do NOT use for redesign, critique, improvement, "make this better", code review, or
  building a new screen: this skill structurally cannot produce recommendations.
---

# UX Reverse-Engineering

Produce a UX specification for **one existing feature, in its existing location and context within an existing platform**. Descriptive only: what the feature currently does, and what is not known about it.

## Register — every sentence obeys these

1. **Descriptive.** No *should / must / recommend / better / improve / fix / instead*. No severity, priority, ratings, verdicts. Consequences are description: "the toast renders 4s and is the only success signal" is in; "too brief" is out.
2. **Interface claims carry citations** — `path/file.tsx:120` or "visible in screenshot". Uncitable → open question or assumption, never a claim.
3. **Claims about people carry tags** — `Evidenced` (cite source) / `Inferred` / `Contested` / `Unknown`. Tags are for what you cannot check by looking; citations are for what you can. Never both, never neither.

Reading code is not research. A spec whose persona reads as confidently as its state machine has failed.

**The Dual-Lens Mindset (Design Vision + Technical Rigor):**
Every feature must be described simultaneously through two lenses:
1. **The Human & Cognitive Design Lens (The "Why" & "How it Feels")**: The user's emotional and spatial experience, cognitive load, visual rhythms, ergonomics, and interaction intent. Name design patterns by their conceptual role (e.g. *The Breathing Immersion Canvas*, *Living Ink*, *Narrative Ribbon*, *Focus Spotlight*) so the design philosophy is unmistakable.
2. **The Deep Engineering Lens (The "How it Works")**: Exact state variables, reactive state machines, decay timers, coordinate boundaries, CSS tokens, DOM geometry math, lifecycle hooks, and data models with precise citations (`path/file.svelte:120`).

Never choose one over the other: explain how the underlying code mechanics directly generate the sensory, spatial, and cognitive experience of the human using the product.

**Three pairs, each covered once, cross-referenced not repeated:** path-to-feature ↔ task flow (splits at the entry point) · information hierarchy ↔ spatial context (intent vs. encoding) · outputs ↔ feedback loops (production vs. perception).

## Roles

**Designer (this thread)** — owns the boundary, the screenshot, reconciliation, all prose, and the cognitive design vision.


**Coders (subagents)** — read source, answer questions. Default partition by evidence source; re-partition mid-session as the feature reveals itself:

| Coder | Traces | Sole author of spec § |
| --- | --- | --- |
| A Runtime | state, handlers, network, sync/async, timing, cancellation, errors | 7, 8, 12 |
| B Constraints | permission guards, flags, rule conditionals, validation, data semantics | 9, 10, 11 |
| C Surface | design-system imports, i18n strings, a11y attributes, breakpoints | 13, 14, 15 |
| D Explore | route/IA placement, analogous features elsewhere | 2, 23-comparison |

Persist coders across rounds via `SendMessage` — never re-spawn cold. Keep an **ownership ledger**: one line per spec section → current owner. Re-partition by *reassignment only*; two agents may read one file, never claim one section.

**Answer contract.** Every coder reply is a citation + verbatim snippet + exactly one verdict:
- `Found` — `path:line` + snippet.
- `Absent` — **plus the surface searched**: "no cancel handler; searched component, hook, request layer."
- `Outside this codebase` — backend-enforced, config-driven, or absent repo.

`Absent (searched …)` is what makes an observed absence defensible. Absence is a finding, not a gap to fix.

**Escalation to the user** is permitted only when: the verdict is `Outside this codebase`; `Absent` on something that must exist for the feature to work; or the question is inherently un-codeable (intent, user expectation, history/legacy). **Never escalate a question no coder has been asked.** Batch escalations into one round per phase, numbered, each with a recommended answer.

## Phases

Write the sections a phase owns into the working file **as that phase settles** — citations decay if prose waits.

**P1 Boundary.** Take whatever evidence was given; state the evidence ceiling it implies. Name the feature (ask only if the screenshot has several candidates — the one fork worth blocking on). Fix **entry point / scope / exit point**. Open the Known / Inferred / Unknown ledger and the ownership ledger. *Checkpoint: confirm boundary before anything else — a wrong boundary invalidates everything downstream.*

**P2 Interrogate.** Spawn coders. Generate questions from the coverage checklist below; send each to its owner. Iterate until every row is `Found` or `Absent (searched …)`. *Checkpoint: escalation round.*

**P3 Human layer.** Journey, persona, goals, mental model, real behaviour. Almost nothing here is codeable — work the evidence ladder before inferring: usability tests → session recordings → support-ticket *wording* → community channels → in-product search queries → analytics drop-off → support/sales staff → designer inference (the floor, not the default). Tag every claim. If nothing exists, say so in one sentence and leave the tags visible. Silence is `Unknown`, never `Evidenced` — users who misunderstand a feature stop using it rather than write in. *Checkpoint: escalation round.*

**P4 Screenshot.** Name which state this is, against P2's machine; list which states stay unobserved. Then hierarchy (logical ranking), spatial context (placement + adjacency), and scent / discoverability / affordance as three separate qualities. Icon-only controls get explicit attention.

**P5 Reconcile.** Three outputs: code paths the screenshot can't confirm (mark code-only); screenshot facts the code doesn't explain (find them or make them open questions); **divergences between the two** — state both observations, stop there. Then friction, in this shape only:

```
F-001  <what the interface does>
       → <what the user can/cannot determine as a result>
       → <evidence: path:line, screenshot, or "inferred, unverified">
       → Category: navigation | discoverability | comprehension | interaction | feedback |
         error-handling | consistency | accessibility | efficiency | cognitive-load |
         trust | information-architecture.  Origin: presentation | model.
```

Presentation = the model is coherent, the rendering obscures it. Model = the rendering is faithful, the model is what users can't reconstruct. Neither names a remedy.

**P6 Decisions & unknowns.** Reconstruct decisions the product already enforces, each with rationale + source (`Inferred from placement`, `Confirmed, BR-003`, `Unknown`). A rationale that reads like an argument is a recommendation in disguise. Record open questions (asking what *is*, never what *should be* — if answering requires a choice rather than an investigation, it's out of scope) and assumptions.

**P7 Audit & deliver.** Gates below, then write `<feature-slug>-ux-spec.md` beside the inputs unless a path was named. Offer to publish as an Artifact; don't publish unasked. Report: path, states observed vs. code-only, evidence unavailable, the open questions that most limit the spec.

## Coverage checklist

A recall index and the coder question-bank — each "not done until" is a question to send down. Answering these from your own head instead of from the phases produces a plausible document with none of the rigour.

| # | Question | Phase | Not done until |
|--:|---|---|---|
| 1 | What is it, where does it start and stop? | P1 | Entry, scope, exit written down |
| 2 | Where is it in the platform? | P2-D | Placed in the full IA tree, not merely named |
| 3 | How does a real user reach it? | P3 | Each step has see / think / do / response, ending at the entry point |
| 4 | Who uses it? | P3 | ≥2 personas contrasted; role & frequency as system fact, prior knowledge tagged |
| 5 | Why do they come, what are they ultimately after? | P3 | User goal, feature goal, interaction goal stated separately |
| 6 | What do they know before arriving? | P3 | Prior knowledge and expected terminology identified |
| 7 | What state are they in on arrival? | P3 | Filters, selections, loaded data enumerated — and what the action means *in that state* |
| 8 | What does the screen tell them? | P4 | Scent, discoverability, affordance answered as three separate qualities |
| 9 | What is important, does the layout say so? | P4 | A ranking exists; any mismatch with placement recorded, not smoothed |
| 10 | What object does it act on, at what level? | P1 | Page- / selection- / row-level ownership disambiguated |
| 11 | What does the user expect — and how do I know? | P3 | Mental model, actual model, divergence; every claim tagged; ladder worked before inferring |
| 12 | What does the system do, over what timescale? | P2-A | Sync/async, persistence, cancellation, retry, timing answered |
| 13 | Full task flow including branches? | P2-A | Every branch captured, not only the happy path |
| 14 | What are the inputs? | P2-A/B | Purpose, required, default, validation per input |
| 15 | What decisions must the user make, at what cost? | P2-A | Defaults stated and accounted for; steps/decisions/memory/uncertainty assessed |
| 16 | What are the outputs, which are perceived? | P2-A | Inventory built incl. invisible ones; every unperceived output resolved as a loop |
| 17 | **All states and every transition?** | P2-A | A machine, not a list: triggers, terminal states, partial, interrupted, recovery, permission, empty, disabled |
| 18 | What can go wrong, what is irreversible? | P2-A | Failure modes enumerated; consequence model applied to anything destructive |
| 19 | How does the user recover? | P2-A | Per failure: message quoted verbatim, which of problem/explanation/cause/recovery it carries, what the user still can't determine |
| 20 | What does the data actually mean? | P2-B | Definition, units, precision, freshness, nullability of displayed fields |
| 21 | What business rules constrain it? | P2-B | Written as explicit conditionals, UX rule kept distinct from the business rule causing it |
| 22 | What permissions constrain it? | P2-B | Hidden vs. disabled vs. available decided per role, with rationale |
| 23 | What does it depend on? | P2-B | Dependency map, used to generate edge cases |
| 24 | What platform patterns does it follow or violate? | P2-D | Each divergence classified intentional / necessary / legacy / accidental / unknown — `Unknown` unless sourced |
| 25 | What similar features exist, why does this differ? | P2-D | Comparison across ≥2 analogues |
| 26 | What design-system patterns apply? | P2-C | Components identified *without* the spec collapsing into a component list |
| 27 | Every user, every screen size, every locale? | P2-C | Keyboard, screen reader, visual, touch answered; breakpoints treated as possible interaction changes, not shrinking; text expansion, dates, numbers, RTL |
| 28 | What does real behaviour say? | P3 | Intended vs. evidence, **and rows 4 and 11 revisited and re-tagged**; a row 11 that survives untouched means confirmation-seeking |
| 29 | Where is friction, and does it originate in presentation or model? | P5 | Each observation carries consequence + evidence + origin, and no proposed remedy |
| 30 | What has the product decided, what is unknown? | P6 | Decisions reconstructed with sources; questions and assumptions recorded, not silently resolved |

Rows 17, 21, 27, 28 compress the most and are the ones to distrust when they feel quick.

## Output contract

Open with an **Evidence Base** block (≈5 lines, before §1): evidence provided · code traced · what was unavailable · states observed vs. code-only · whether any user research exists. A reader must be able to weigh the document in ten seconds. Repeat caveats inline where they bite.

Then all 21 sections, always, in this order — depth scales with the feature, presence never does. A section with nothing in it states why in one line ("16 — no analytics calls in the traced code"), which is itself a finding. **Sections 8, 9 and 19 are never one-liners**; that is where implementation ambiguity hides.

```
1 Feature Overview      6 Feature Anatomy      11 Validation Rules   16 Analytics
2 Feature Context (IA)  7 Interaction Flow     12 Error & Recovery   17 Decisions Already Embodied
3 User Journey          8 State Specification  13 Accessibility      18 Observed Friction
4 User Context          9 Business Rules       14 Responsive         19 Open Questions
5 Screen Context       10 Permission Rules     15 Microcopy          20 Assumptions
                                                                     21 UX Acceptance Criteria
```

§4 is a table with `Provenance` and `Source` columns per row — role/frequency/permissions are system facts, goal/knowledge/mental-model/environment are tagged. Rows still `Inferred` at the end stay `Inferred` in the delivered artifact. §18 stays strictly separate from §1–17, so a reader wanting only current behaviour can stop before it. §21 asserts **current** behaviour in Given/When/Then, verifiable against the running product — not targets.

## Gates — all five before delivery

1. **Implementable** — could an engineer and QA rebuild and verify this without guessing? Each gap points back at a skipped "not done until".
2. **Checkable** — every sentence verifiable against the product, or naming its source, or declaring itself unverified.
3. **Dual-Lens Balance** — does every section explain BOTH the human cognitive/design experience (intent, visual rhythm, emotional ergonomics) AND the concrete engineering mechanics (exact timers, coordinate math, CSS tokens, reactive models, citations) without collapsing into an abstract essay or a dry code dump?
4. **Register sweep** — grep the draft for *should, must, recommend, better, improve, fix, instead, unfortunately, poor, weak, confusing, unclear*. Convert each hit back into the observation it came from, or delete it. (*Unclear* survives only as "nothing in the interface distinguishes X from Y".)
5. **Provenance sweep** — every sentence about what a user thinks, expects, knows or wants carries a tag. Untagged, it is your model wearing the user's name.

Drift enters late, through §17's rationale column and §18's phrasing, after the earlier discipline has worn off.

## Re-run

If the target spec exists: read it, update in place, **preserve answered open questions and assumptions** — those came from a human, not the code, and are the one unrecoverable loss. Append a dated line to the Evidence Base noting what changed. Never overwrite unread.
