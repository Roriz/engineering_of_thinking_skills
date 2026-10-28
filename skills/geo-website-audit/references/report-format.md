# Report content

Deliver Markdown that lets the owner see what each inspected page satisfies, lacks, why it matters, and what to do first. Adapt detail to scope; do not fill a long template with speculative findings.

## Opening and scope

Start with the strongest observed support and most consequential gaps. Identify the required company discovery pack, its date/version and review coverage, the business/audience context taken from it, and material unresolved claims or assumptions. Include audit date, supplied screenshots, inspected URLs, page roles, and access/coverage limits. Distinguish screenshots from live pages when they differ. Describe readiness/content evidence, not measured AI visibility. Without the pack, stop as directed in SKILL.md instead of creating this report.

## Priority tiers

Show T0, T1, T2, and T3 even when empty. Empty means "No confirmed finding in the inspected scope," not a whole-site guarantee. Keep shared issues deduplicated:

| Tier / ID | Action and affected pages | Why now | Effort / dependencies | Completion check |
| --- | --- | --- | --- | --- |

Estimate effort qualitatively only when context supports it; otherwise say Unknown. Do not invent budgets or deadlines. Put verification tasks outside confirmed defect tiers.

## Page-by-page assessment

For each inspected page, state its role and target questions. Give applicable aspects a status with evidence and explanation. Account for exclusions with Not applicable or a site-level pointer. Include positive findings. A compact matrix may precede details linked by finding IDs.

| Aspect | Status | Evidence and location | Why it meets the need or what remains deficient |
| --- | --- | --- | --- |

Evidence must be locatable: URL plus section or short excerpt, screenshot filename/ID plus region, inspected HTML/metadata, or path/user-agent plus response. State the inspection scope behind absence. A matrix without explanations does not complete the audit.

## Finding details

Expand material findings instead of repeating every cell:

- **ID, scope, aspect, status, tier:** Pages, template, or site-level issue.
- **Observation and evidence:** What was inspected; separate inference. For an alignment or mismatch finding, cite both the discovery document/passage or claim ID and the observed website content. State whether the reference is supported, interview-reported, proposed, or unresolved.
- **Why it matters:** Customer question affected; qualify unmeasured AI consequences.
- **Change:** Concrete repair. Examples must not invent facts, certifications, prices, or research.
- **Confidence:** Certainty in the finding, distinct from expected GEO benefit.
- **Completion check:** Observable resolution; separate outcome measurement if claiming changed AI behavior.

One finding can explain multiple cells. Positive findings may be brief but must explain what satisfies the need and should be retained.

## Verification queue and limits

| Unknown | Why undecidable | Smallest useful check | Decision it unlocks |
| --- | --- | --- | --- |

Include crawler behavior, external evidence, AI visibility, and analytics only where relevant. Describe precise access limits. Do not fabricate certainty from a screenshot, search snippet, or one response. End with important limits and conditional experiments; do not turn uncertain tests into mandatory features.
