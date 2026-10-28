# GEO audit rubric

This is a practical synthesis of the user's Ranqia knowledge base, not an official Ranqia scoring system or verified model ranking factors. Assess each aspect by page role, user intent, evidence, and business importance. No feature automatically earns a tier or proves AI visibility.

Apply the rubric only after reading the required company discovery output. Use it to define the actual offering, audience, market, buying questions, and claim boundaries; use inspected website evidence to judge whether pages communicate them. Preserve the pack's source statuses and unresolved conflicts. A draft reference is not unquestionable ground truth, and internal evidence is not automatically public content.

## Aspects

### A1. Access to essential public information

Can the intended reader or inspected retrieval path reach and read information needed for the target decision? Look for broken primary URLs, authentication or interaction barriers, unavailable essential facts, and critical content absent from the inspected text representation. Compare delivered HTML and rendered content when relevant. Screenshots cannot establish text delivery. JavaScript use, visual richness, or a slow audit fetch alone does not establish exclusion from AI search.

Evidence: observed HTTP response, rendered page, HTML/metadata, and relevant public crawl directives. Record user agent, requested path, and response context when they matter. `noindex`, crawl restrictions, and training permissions differ; do not conflate them or assert current provider behavior without checking primary documentation. Do not recommend lifting intentional restrictions without understanding their purpose.

Typical urgency: T0 for a confirmed critical public-page failure; T1/T2 for material discoverability gaps according to scope. A missing sitemap alone is not T0. Unverified crawler limitations belong in the check queue.

### A2. Brand and offering identity

Can a reader identify what the organization does, for whom, in which market, and which brand, group, product, or model the page describes? Compare names, descriptions, relationships, geography, and links across inspected pages. Distinguish abbreviations from different entities or product generations.

Evidence: visible descriptions, organization/contact pages, product details, and inspected structured data. A consistent logo does not establish product relationships or authority. Organization markup can express identity, but its absence does not prove models cannot recognize the brand.

Typical urgency: T1 for unclear core identity or material mismatch; T2 for minor naming cleanup or appropriate markup. Reserve T0 for a critical contradiction that materially misidentifies the offering.

### A3. Customer-intent coverage

Does the page or a reachable supporting page answer questions relevant to its role? Separate discovery, suitability, comparison, pricing/terms, trust, and purchase-channel intent. Select questions using the actual audience rather than keyword volume or a generic "best brand" prompt. Label inferred questions versus user research or supplied monitoring.

Evidence: full sections, product/pricing pages, linked destinations, and known audience needs. Pricing outside a cropped hero is Unknown, not Missing. A homepage can be Met if it orients readers and links to decision-support detail. Do not require every page to answer every question.

Typical urgency: T1 for an unanswered primary decision; T2 for secondary intent coverage. Verify scope before recommending a new page.

### A4. Direct answers and semantic structure

Can a reader locate an answer, understand it without guessing, and see its qualifications? Look for descriptive headings, coherent sections, direct explanations, useful tables, self-contained answers, and links to deeper evidence. Specificity must reflect real facts, not fabricated precision. Proposed fan-out headings must correspond to useful subquestions; do not present guesses as observed model queries.

Evidence: screenshots/rendered text for visible hierarchy; HTML/DOM for heading semantics. FAQ is one format, not a mandatory feature. Equivalent answers in prose or a table may satisfy the need. Repeated keywords or merely having an H1 tag do not establish answer quality.

Typical urgency: T1 when core meaning is unclear; T2 for better presentation of adequate information. Shape alone does not prove citation lift.

### A5. Evidence and claim integrity

Are important assertions supported by accessible facts? Inspect methodology, dates on time-sensitive data, units, denominators, scope, source links, authorship or appropriate expertise, and qualifications. Separate product facts from independent evaluation. A number, testimonial, logo, or award badge is not self-validating evidence.

Evidence: the actual claim and linked substantiation. If the source cannot be inspected, distinguish "source link present" from "claim verified." Prefer documented specifications, real terms, reproducible comparisons, and scoped research to generic superiority claims. Do not impose review dates on timeless material without a reason.

Typical urgency: T1 for important unsupported or stale buying claims; T0 only for a confirmed critical contradiction making decision information unusable. Missing bios or update dates are not automatic blockers.

### A6. Comparisons and competitive context

Where readers choose among alternatives, are criteria, trade-offs, limits, and use-case differences clear? Compare the right entities: product, manufacturer, retailer, and sales channel differ. Use consistent criteria and disclose ownership or conflicts.

Evidence: comparison/decision-support content and linked facts. Comparisons need not name competitors when requirements, options, and suitability can be explained honestly another way. Do not require competitor names on every homepage or recommend co-mention stuffing. A real competitor/co-occurrence analysis needs scoped response data; a site alone cannot establish it.

Typical urgency: T1 when comparative intent is central and decision support is missing; T2 for secondary comparisons. Unmeasured co-mention tactics remain T3.

### A7. Connected information architecture

Do related pages provide a path from orientation to evidence and action? Review actual links between categories, details, comparisons, terms, methodology, and organization identity. Check a link before declaring its destination broken. Shared template issues get one action, not inflated issue counts.

Evidence: inspected navigation/links; sitemap or HTML when relevant. Do not infer orphan pages from a short sample or require separate pages when one structured page answers the need. Flag canonicalization only from inspected evidence of a relevant issue.

Typical urgency: T1 when essential details cannot be reached through the reviewed journey; T2 for secondary organization improvements.

### A8. External corroboration and source fit

Which inspected independent evidence corroborates relevant brand claims? Official records, specialist comparisons, reporting, user experience, reviews, and reference works serve different roles. Owned pages may be especially useful for current fees and specifications. Do not prescribe Reddit, Wikipedia, LinkedIn, or particular publications because they dominated one study.

Evidence: actual external pages and their coverage, not company-selected logos or excerpts alone. Without an external review, mark this Unknown at site level and identify the smallest useful check. Without observed AI answers, do not claim these sources influence the target prompts. Separate a factual evidence gap from a source-strategy hypothesis.

Typical urgency: T1/T2 for demonstrated, relevant gaps. Unmeasured strategies remain conditional. Never recommend fabricated reviews, undisclosed promotion, or encyclopedia entries regardless of eligibility.

### A9. Language and local relevance

Does content fit the primary audience's language, terminology, availability, units, geography, and constraints? Inspect localized pages rather than treating a language switcher as complete coverage. An interview's English retrieval observation does not make translation universal; domain suffixes do not establish page language.

Evidence: page text/offerings and established market requirements. Do not propose translation merely because an international audience could exist.

Typical urgency: T1 for a primary-market mismatch; T2 for established secondary-market gaps; T3 for unmeasured bilingual expansion.

### A10. Measurement and experimental aids

A page audit assesses available information, not actual model recommendations. Keep mention frequency, position conditional on mention, displayed citations, retrieved sources, and conversions distinct. Use supplied monitoring within its model/interface, prompts, dates, location, and sample. A single response is an example, not a visibility estimate.

If measured outcomes are also requested, propose a bounded baseline and repeated comparable runs; do not silently start paid research. Traffic and revenue require separate evidence and attribution.

`llms.txt`, robot-facing replicas, keyword domains, and schema as a direct visibility lever have uncertain benefit in this corpus. They never outrank confirmed critical information/access defects solely because they sound AI-specific. Consider relevant T3 tests with a hypothesis and evaluation check. Do not prescribe replicas or separate domains by default.

## Tier rules

| Tier | Decision rule | Required rationale |
| --- | --- | --- |
| T0 — Blocking | Confirmed essential-access or critical-information failure preventing a primary task. | Exact failure, scope, affected task, verification evidence. |
| T1 — High | Observed core-intent, identity, or evidence gap affecting the main audience. | Customer decision affected and why it precedes lower-tier work. |
| T2 — Next | Useful improvements after core information and journey are sound. | Remaining deficiency, pages, dependencies. |
| T3 — Experiment | Plausible bounded optimizations with uncertain benefit. | Hypothesis, effort, baseline, and evidence for keeping the change. |

Unknown is not a defect tier. Put checks in a separate queue and state the decision they unlock. Page-level Met does not mean site perfection; site-level Missing needs site-level inspection. Avoid numerical readiness grades that conceal evidence coverage.
