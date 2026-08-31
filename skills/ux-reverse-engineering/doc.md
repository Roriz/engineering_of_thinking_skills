# UX Reverse-Engineering Procedure for an Existing Feature

## 0. Define the objective

Before touching the screen, establish exactly what is being reviewed.

The objective is:

> **Produce a UX specification for one existing feature, in its existing location and context within an existing platform.**

This means the designer should answer:

* What is the feature?
* Where does it live?
* Who can access it?
* Why does it exist?
* What problem does it solve?
* What does the user need to know before using it?
* What does the user need to do to reach it?
* What happens when they use it?
* What happens when things go wrong?
* What happens before, during, and after the interaction?
* What surrounding platform conventions does it inherit?
* What business/product rules constrain it?
* What does the feature currently do that the specification must capture without distortion?

The final artifact should describe the feature **as a part of the platform**, not as an isolated screen.

## The deliverable is descriptive

This procedure produces **a description of what exists**. It does not produce a redesign, a critique, a backlog, or a set of recommendations.

> **Everything in the final artifact must be a statement about how the feature currently behaves, or an explicit statement of what is not known about it.**

That rule has three consequences worth stating plainly, because several later sections will look like they contradict it:

**No prescriptive language.** No *should*, *must be improved*, *recommend*, *better*, *fix*, *instead*. If a sentence proposes a change, it does not belong in the artifact.

**No ratings or verdicts.** No severity scores, no priorities, no pass/fail against heuristics, no "this is a poor experience." Judgement of that kind is a separate deliverable with a separate audience.

**Consequences are still description.** "The confirmation appears for four seconds and is the only indication the export succeeded" is descriptive, and it is precise enough that a reader can draw their own conclusion. "The confirmation is too brief" is not. Describe the mechanism and what it leaves the user able or unable to determine; stop there.

**Claims about users carry sources.** Interface behaviour can be verified by looking at it; what users think, expect, or understand cannot. Any statement about a user's knowledge or expectations is tagged for provenance under the rule in §10: otherwise the artifact smuggles the designer's assumptions in as observed fact, which is the one failure a descriptive document cannot survive.

Sections 39-42 are evaluative *investigation techniques*, not evaluative *output*. They exist because looking for problems is the fastest way to find the places where your description is still vague. Their yield is recorded as observed behaviour and its consequences, never as advice. Each of those sections restates this.

Anything you find yourself wanting to recommend has one of two homes: it is a behaviour you can describe precisely, or it is an open question (Spec §19). It is never a suggestion.

## How to use these sections without repeating work

Some sections deliberately look at the same material from different angles. They are not duplicates, and an aspect covered in one is **not** to be re-covered in the other. Three pairs are easy to confuse:

| Pair | Divides on | Left section covers | Right section covers |
| ---- | ---------- | ------------------- | -------------------- |
| **4** Path to the feature ↔ **13** Task flow | The feature boundary defined in §2 | Everything *before* the entry point: how the user finds and reaches the feature | Everything *from* the entry point to the exit point: how the user operates the feature |
| **8** Information hierarchy ↔ **9** Spatial context | Intent vs. encoding | What the page ranks as important, as a logical order | Where things physically sit, and what that placement implies about relationships |
| **16** Outputs ↔ **29** Feedback loops | Production vs. perception | What the system *produces*, including results the user never sees | Whether the user *notices, understands, and can act on* what was produced |

When an aspect is documented on one side of a pair, cross-reference it from the other rather than restating it. An aspect is fully addressed when both sides of its pair have been answered once.

---

# 1. Start with the evidence, not the solution

The first principle is:

> **Do not design the feature before understanding where and why it exists.**

The initial inputs might be surprisingly small:

* Screenshot
* Feature name
* URL
* Product name
* Short description
* Existing design file
* Existing requirements
* User story

For example:

> Screenshot + "Export Report"

That is **not enough information to design the feature**, but it is enough to start the investigation.

At this point, the designer should explicitly separate:

### Known

Things directly observable.

Example:

* There is an "Export" button.
* It is located next to "Filter".
* The screen is called "Reports".
* The button appears in the upper-right corner.

### Inferred

Things that appear likely but haven't been confirmed.

Example:

* Export probably exports the currently filtered data.
* The export probably downloads a CSV.
* The user probably needs permission to export.

### Unknown

Things that must be investigated.

Example:

* Does export include filters?
* What formats are supported?
* What happens for 100,000 records?
* Is export synchronous?
* Where does the downloaded file appear?
* Is export available to all roles?

This distinction is extremely important.

---

# 2. Identify the feature's exact boundary

Before understanding the feature, define **what counts as the feature**.

A feature rarely equals one UI element.

For example:

> "Export Report"

could actually include:

```text
Reports
 └── Report list
      ├── Filters
      ├── Sorting
      ├── Pagination
      ├── Export
      │    ├── Export button
      │    ├── Format selection
      │    ├── Date range
      │    ├── Permission validation
      │    ├── Processing
      │    ├── Download
      │    ├── Success feedback
      │    └── Error handling
      └── Empty state
```

Therefore define:

### Feature entry point

Where the user starts interacting with the feature.

### Feature scope

Everything necessary to accomplish the feature's job.

### Feature exit point

Where the feature's task is considered complete.

For example:

> Entry: User opens Reports and clicks Export
> Exit: User successfully receives the exported file

This prevents the UX specification from becoming just a description of a button.

---

# 3. Locate the feature inside the platform

This is the first major investigation.

Given a screenshot and feature name, determine:

> **Where does this feature exist in the platform's information architecture?**

Start from the platform's highest-level hierarchy.

For example:

```text
Platform
│
├── Dashboard
├── Customers
│   ├── Customer list
│   └── Customer details
├── Reports
│   ├── Overview
│   ├── Financial
│   └── Operational
└── Settings
```

Then locate the feature:

```text
Platform
└── Reports
    └── Operational
        └── Report details
            └── Export
```

Document:

* Product
* Application
* Main navigation
* Section
* Subsection
* Page
* Subpage
* Tab
* Component
* Feature

This gives the feature its **hierarchical context**.

---

# 4. Reconstruct the user's path to the feature

> **Scope:** this section stops at the entry point defined in §2. What happens *after* the user engages the feature belongs to §13 and is not documented here.

Next ask:

> **How does a real user get here?**

Do not only describe the URL.

Describe the cognitive and interaction path: the wayfinding problem, not the operating problem.

For example:

```text
Login
 ↓
Dashboard
 ↓
Reports
 ↓
Operational Reports
 ↓
Select report
 ↓
Report details
 ↓
Export
```

But this should be investigated at a deeper level.

For each step ask:

### What does the user see?

### What does the user know?

### What decision does the user make?

### What action does the user perform?

### What feedback does the platform provide?

Example:

| Step      | User sees         | User thinks                  | User does           | System response     |
| --------- | ----------------- | ---------------------------- | ------------------- | ------------------- |
| Dashboard | Main navigation   | "I need a report"            | Clicks Reports      | Reports opens       |
| Reports   | Report categories | "Which report?"              | Selects Operational | Report loads        |
| Report    | Data table        | "I need this data elsewhere" | Locates Export      | Entry point reached |

The last row is the handoff: the user has arrived at the entry point and has not yet acted on the feature. §13 picks up from exactly this row.

This starts turning navigation into a **user journey**, rather than merely a sitemap.

---

# 5. Understand the user's intent

Now investigate:

> **Why does the user enter this part of the platform?**

There are three useful layers.

## User goal

What the user ultimately wants.

Example:

> Analyze monthly sales performance.

## Feature goal

What the feature enables.

Example:

> Export sales data for external analysis.

## Interaction goal

What the current interaction needs to accomplish.

Example:

> Allow the user to select export parameters and initiate an export.

These should not be confused.

A feature may be technically about "exporting", while the user's actual goal is "share the data with finance."

---

# 6. Identify the user/persona and context

The same feature can have completely different UX depending on who uses it.

Identify:

* User role
* Expertise
* Frequency of use
* Motivation
* Environment
* Device
* Time pressure
* Permissions
* Previous knowledge
* Expected outcome

For example:

### Administrator

May understand:

* Reports
* Filters
* Export formats
* Permissions

### Occasional manager

May need:

* More guidance
* Clearer terminology
* Simpler defaults

Therefore document:

> **Who is performing this task?**

And:

> **What do they already know?**

Split those two questions by how knowable they are. *Who* is usually a fact in the system (roles, permissions, and usage frequency come from configuration and analytics, and should be stated as such). *What they already know* is a claim about people's heads, and falls under the provenance rule in §10: tag it `Evidenced` / `Inferred` / `Unknown` and name the source.

The two illustrative personas above are `Inferred`: reasonable, conventional, and entirely unverified. Written into an artifact without that label, an invented persona becomes the thing every later section is validated against, and the whole description inherits an error nobody can locate afterwards.

---

# 7. Identify the user's starting state

A UX interaction always happens from a state.

Determine:

* Where is the user?
* What page are they on?
* What data is currently loaded?
* What filters are active?
* What selections exist?
* What permissions apply?
* What previous actions have happened?

For example:

```text
User is viewing:

Report: Sales
Date: Jan 1 - Jan 31
Region: Brazil
Status: Active
```

Then:

> What exactly does "Export" mean in this state?

Does it export:

```text
A. All sales
B. Filtered sales
C. Visible rows
D. Selected rows
E. Current page
```

This is one of the most important UX questions.

---

# 8. Map the information hierarchy

> **Scope:** this section captures the *logical* ranking of information and actions: what the page treats as important, expressed as an ordered structure. It is deliberately layout-agnostic: pixels, position, and grouping belong to §9.

Now inspect the actual screen.

Don't immediately look at individual components.

First determine the **information hierarchy**.

For example:

```text
Page
│
├── Page identity
│   ├── Breadcrumb
│   ├── Title
│   └── Description
│
├── Primary actions
│   ├── Create
│   └── Export
│
├── Controls
│   ├── Search
│   ├── Filters
│   └── Sorting
│
├── Main content
│   └── Data table
│
└── Secondary information
    ├── Pagination
    └── Metadata
```

Ask:

* What is the most important information?
* What is secondary?
* What is the primary action?
* What is the secondary action?
* What establishes context?
* Which items are peers, and which are subordinate?
* Where does this feature rank among the page's actions?

The output is a **ranking with a rationale**: what this page is fundamentally for, and where the feature sits in that order of importance.

Carry that ranking into §9, which checks whether the layout actually encodes it.

---

# 9. Understand spatial context

> **Scope:** §8 established what *should* be dominant. This section examines how the layout physically encodes that, and what the placement implies about relationships. Two distinct outputs: (a) does position match the ranking from §8, and (b) what does adjacency claim the feature belongs to.

Then investigate the feature's physical location.

Document:

* Position
* Alignment
* Grouping
* Proximity
* Relationship with neighboring controls
* Relationship with page title
* Relationship with data
* Relationship with primary actions

For example:

```text
                    Page title

                          [Create] [Export]
                          
        [Search] [Filter] [Sort]

        ┌───────────────────────────────┐
        │             Data              │
        │                               │
        └───────────────────────────────┘
```

Ask:

> Why is Export next to Create?

> Why is it above the table?

> Why isn't it inside the table toolbar?

> Is it associated with the page or with the dataset?

> Does its prominence match the rank §8 assigned it, or does the layout over- or under-state its importance?

Spatial positioning often communicates **semantic relationships**. A mismatch between the §8 ranking and the §9 placement is a finding in itself, and should be recorded rather than smoothed over.

---

# 10. Identify the feature's conceptual model

Now ask:

> **What does the user believe this feature represents?**

This is the **mental model**, and it is the single most dangerous claim in the entire artifact.

## The validity problem, stated plainly

Everything else in this procedure can be verified by looking: the IA is there, the states are there, the business rules are in the code. This one cannot. **You are making a claim about the contents of someone else's head, and you are sitting at a desk.**

Written without a source, "the user expects Archive to preserve the item" means "*I* expect Archive to preserve the item, and I am a person who has been staring at this product for three days." That is not the user's model. It is the designer's model wearing the user's name. Because §0 requires a descriptive artifact, it is worse than an unsourced recommendation: a recommendation announces itself as opinion, whereas an unsourced mental model presents opinion as an observed fact about a population.

Designers are also systematically the wrong instrument here. You know what the labels mean, you know what happens after the click, you have seen the empty state. Expertise is exactly what destroys your access to the naive reading, and no amount of care compensates for it.

So the rule:

> **Every mental-model statement carries its provenance. No exceptions, including the ones that feel obvious.**

## Tag every claim

| Tag | Meaning |
| --- | ------- |
| `Evidenced` | A user said or did this. Cite the source. |
| `Inferred` | Reasoned from the interface, conventions, or analogous products. Plausible, unverified. |
| `Contested` | Evidence exists on both sides, or different segments differ. |
| `Unknown` | Nobody has asked. Say so. |

`Inferred` is a perfectly respectable tag. The failure is not inferring (desk analysis is most of what you have); it is inferring silently, so that a reader six months later cannot tell which lines were earned and which were assumed.

## Triangulate before you infer

Most teams have more evidence than they think, sitting in places nobody calls research. Work down this ladder and stop as soon as you have something:

1. **Usability tests / user interviews**: direct, strongest. Rare.
2. **Session recordings**: hesitation, repeated clicking, abandoned flows, back-button use. These show the model failing in real time.
3. **Support tickets and their wording**: the highest-yield source almost nobody reads. The *phrasing* of a complaint is a direct sample of the user's vocabulary and model.
4. **Community channels**: forums, Discord, Reddit, app-store reviews. Unprompted and unfiltered, which is precisely their value.
5. **In-product search queries and help-centre searches**: what people type when they cannot find something is a description of the model they arrived with.
6. **Analytics drop-off at specific decision points** (§37): shows *where* the model breaks, not what it is.
7. **Sales, onboarding, and support staff**: they explain this feature to confused humans weekly. They can recite the misunderstanding verbatim.
8. **Designer inference**: the floor, not the default. Tag it `Inferred` and move on.

Sources 3, 4, 5, and 7 usually already exist and cost an afternoon. Reaching for #8 without checking them is the failure this section exists to prevent.

## Document it like this

### User's mental model

Each claim tagged, with source.

### Product's actual model

What actually happens. Verifiable, so no tags needed.

### Divergence

Where the two differ, and whether the divergence itself is evidenced or inferred.

For example, "Archive" could mean:

* Delete
* Hide
* Move somewhere else
* Make inactive
* Preserve but remove from normal workflow

The UI label alone isn't enough to know which. Written properly:

> **User's mental model** (`Evidenced`): Users expect Archive to remove an item from active lists while preserving it for later retrieval. Source: 14 support tickets Q1-Q2 asking "how do I get my archived projects back", plus 2 of 5 participants in the March usability test.
> **Product's actual model**: Archive sets `status=archived`; records remain queryable via the Archived filter for 90 days, then are purged.
> **Divergence** (`Evidenced` for the retrieval expectation, `Unknown` for the 90-day window: no evidence exists that any user is aware of it.

Compare the same thing written the way it usually is:

> Users expect "Archive" to preserve the item for future retrieval.

Identical surface claim, zero traceability, and a reader has no way to tell it apart from a guess.

## A worked example of a well-sourced model

`statups/Enrichreader/reader-persona.md` in this repo is a good illustration, because its mental-model section rests on verbatim user language rather than on the designer's reading of the UI:

> "A reading companion that remembers characters so I don't have to."

That sentence is defensible because the document carries the raw material behind it: user quotes gathered unprompted from Reddit ("I don't even remember who that is", "half the time I have to stop reading to Google who they are, and sometimes I get distracted and don't even make it back to the book"), ranked frustrations traceable to specific threads, and analytics for the geographic claims. The frustrations are `Evidenced`. The tap-dismiss-continue rhythm attributed to Vikram is `Inferred` (a reasonable reading of those quotes, but an interpretation), and the document would be stronger for saying which is which.

That is the standard: a mental model is only as good as the sentences underneath it, and the artifact should let a reader see them.

## This section is provisional

You are writing §10 long before §37 and §38, where the actual behavioural evidence gets examined. That ordering is deliberate: recording your hypothesis *before* looking at the data is what makes the data able to contradict you.

So mark this section **provisional on first pass, and return to it after §38.** On the return trip, every claim either gets upgraded to `Evidenced` with a source, gets corrected, or stays `Inferred` with that status visible in the final artifact. A §10 that comes out of §38 completely unchanged usually means the evidence was read looking for confirmation.

---

# 11. Map the feature's conceptual relationships

Determine what entities the feature operates on.

For example:

```text
Organization
   ↓
Project
   ↓
Report
   ↓
Dataset
   ↓
Record
```

Then determine:

> What object does this feature act upon?

For "Export":

```text
Export
 ↓
Report
 ↓
Current dataset
 ↓
Filtered records
```

For "Edit":

```text
Edit
 ↓
Customer
 ↓
Customer profile
 ↓
Specific attributes
```

This is critical because the same action can exist at multiple levels.

---

# 12. Identify ownership of the action

Ask:

> **Who or what does this action belong to?**

For example:

### Page-level action

```text
Reports
[Export]
```

Means:

> Export the report.

### Selection-level action

```text
[x] Customer A
[x] Customer B

[Export selected]
```

Means:

> Export selected records.

### Row-level action

```text
Customer A    [...] 
```

Means:

> Export this specific customer.

These are fundamentally different UX models.

---

# 13. Reconstruct the task flow

> **Scope:** this section begins where §4 ended: the user is already at the entry point. Do not re-document the navigation that brought them there. This is the operating problem: what happens between entry point and exit point, including every branch.

Now model the complete interaction.

Use a flow such as:

```text
Entry point reached
 ↓
Understand context
 ↓
Initiate action
 ↓
Configure
 ↓
Confirm
 ↓
System processes
 ↓
Feedback
 ↓
Outcome
 ↓
Next action
```

Example:

```text
Export visible in toolbar
 ↓
Click Export
 ↓
Export dialog
 ↓
Choose CSV
 ↓
Choose current filters
 ↓
Click Export
 ↓
Processing
 ↓
Download ready
 ↓
File downloaded
 ↓
User continues working
```

Every branch should be captured.

---

# 14. Map every decision point

At every point where the user has to make a decision, document:

* What decision?
* What options?
* What information is available?
* What is the default?
* Is the default safe?
* What happens if they choose each option?
* Can they change the choice later?

Example:

```text
Export format

CSV
Excel
PDF
```

Questions:

* Which option is default?
* Why?
* Are all formats equivalent?
* Does format affect available filters?
* Does format affect processing time?
* Can the user cancel?

---

# 15. Identify all inputs

For every interaction, list the input mechanisms.

Examples:

* Button
* Link
* Dropdown
* Select
* Checkbox
* Radio
* Toggle
* Text field
* Search
* Date picker
* Drag/drop
* Keyboard shortcut
* Context menu
* Modal
* Wizard

Then document:

| Input            | Purpose       | Required? | Default       | Validation           |
| ---------------- | ------------- | --------: | ------------- | -------------------- |
| Format           | File type     |       Yes | CSV           | Must be supported    |
| Date             | Data range    |        No | Current range | Valid date           |
| Include archived | Dataset scope |        No | No            | Permission dependent |

---

# 16. Map every output

> **Scope:** this is an inventory of what the system *produces*: every artifact, state change, and side effect, including the ones the user never perceives. Whether the user notices, understands, or can act on an output is not evaluated here; that is §29.

The feature isn't just about inputs.

Determine what the system produces.

Possible outputs:

* New page
* Modal
* Toast
* Inline message
* Download
* Email
* Notification
* Updated record
* Redirect
* State change
* Background job
* External action

For every output document:

> **What changed in the system's state?**

And classify it:

| Output | What changed | Perceivable by the user? | Where |
| ------ | ------------ | ------------------------ | ----- |
| Downloaded file | File written to disk | Yes | Browser download bar |
| Audit log entry | Record created | No | - |
| Background job | Job queued | Only via later notification | Notification centre |

The "Perceivable?" column is the handoff to §29: every `No` or `Only via…` is a loop that section has to close.

---

# 17. Document the complete state machine

This is one of the most important parts of a good UX specification.

Don't document only the happy path.

Identify states such as:

```text
Idle
 ↓
Initiated
 ↓
Loading
 ↓
Ready
 ↓
Processing
 ↓
Success
```

But also:

```text
Idle
 ├── Invalid input
 ├── Unauthorized
 ├── No data
 ├── Network error
 ├── Timeout
 ├── Partial failure
 ├── Cancelled
 └── Session expired
```

A feature specification should explicitly describe:

### Initial state

What happens when the user first encounters the feature?

### Hover/focus state

If relevant.

### Active state

What happens while interacting?

### Loading state

What does the user see while waiting?

### Empty state

What if there is nothing to act upon?

### Success state

What tells the user the action worked?

### Error state

What went wrong and what can the user do?

### Disabled state

Why can't the user interact?

### Permission state

What if they aren't authorized?

### Partial state

What if only some items succeed?

### Interrupted state

What if the user closes the page?

### Recovery state

How can the user recover?

---

# 18. Investigate system behavior

The UX designer needs to understand enough of the underlying behavior to describe the UX correctly.

This doesn't mean becoming an engineer.

It means answering questions such as:

* Is the operation synchronous?
* Is it asynchronous?
* Does the page refresh?
* Does the operation persist?
* Is data cached?
* Is there a background process?
* Can the operation be cancelled?
* Can it be retried?
* Is it idempotent?
* Does it affect other users?
* Does it trigger notifications?
* Does it trigger another workflow?

For example:

> Clicking "Export" might not actually download anything immediately. It may start a background job.

That fundamentally changes the UX.

---

# 19. Identify temporal behavior

Time is a UX dimension.

Document:

* Immediate response
* Loading duration
* Long-running operation
* Timeout
* Expiration
* Delayed notification
* Scheduled action
* Background processing

For example:

```text
Click Export
      ↓
Immediate feedback
      ↓
"Preparing your file..."
      ↓
Background processing
      ↓
Notification
      ↓
Download
```

This is a completely different experience from:

```text
Click Export
 ↓
Browser download immediately
```

---

# 20. Investigate permissions and roles

For an existing platform, permissions are often part of the UX.

Map:

```text
Role
 ↓
Permission
 ↓
Feature visibility
 ↓
Feature availability
 ↓
Action authorization
```

There are at least three different cases:

### Hidden

User doesn't see the feature.

### Visible but disabled

User sees it but cannot use it.

### Visible and actionable

User can use it.

These communicate different things.

Document why the product uses one approach.

---

# 21. Identify dependencies

Determine what the feature depends on.

Examples:

* Existing data
* User permissions
* Account configuration
* Subscription level
* Another feature
* Previous step
* Selected records
* External service
* Network
* Device capability

Create a dependency map:

```text
Feature
 ├── Requires permission
 ├── Requires data
 ├── Requires configuration
 └── Requires selected records
```

This is especially important for edge cases.

---

# 22. Understand platform conventions

The feature shouldn't be evaluated independently from the rest of the product.

Investigate:

### Navigation conventions

* Breadcrumbs
* Tabs
* Side navigation
* Back behavior

### Action conventions

* Primary button style
* Secondary action
* Destructive action
* Icon usage

### Feedback conventions

* Toast
* Banner
* Inline validation
* Modal

### Form conventions

* Labels
* Required indicators
* Validation
* Defaults

### Interaction conventions

* Dropdown behavior
* Modal behavior
* Pagination
* Search
* Filters

Ask:

> **What does the platform normally do in situations like this?**

Then:

> **Does this feature follow or violate that convention?**

---

# 23. Compare analogous features

One of the strongest UX investigation techniques is **pattern triangulation**.

Find similar features elsewhere in the product.

For example:

```text
Feature under review:
Reports → Export

Analogous:
Customers → Export
Invoices → Export
Transactions → Export
```

Compare:

| Aspect      | Reports | Customers | Invoices |
| ----------- | ------- | --------- | -------- |
| Entry point | Toolbar | Toolbar   | Row menu |
| Format      | CSV     | CSV/XLSX  | PDF      |
| Feedback    | Toast   | Download  | Modal    |
| Loading     | None    | Spinner   | Progress |

Now ask:

> Why is this feature different?

Differences may be intentional or inconsistencies.

---

# 24. Investigate the design system

Determine which existing design-system components are being used.

Document:

* Component
* Variant
* Size
* Spacing
* Typography
* Icon
* Color
* Interaction
* Accessibility behavior

For example:

```text
Button
 ├── Component: Button
 ├── Variant: Secondary
 ├── Size: Medium
 ├── Icon: Download
 ├── Label: Export
 └── Position: Page action group
```

But don't reduce the UX specification to component specifications.

The design system explains **how it looks and behaves**.

The UX specification explains **why it exists and how it works in context**.

---

# 25. Analyze information scent

A user needs to understand:

> "Is this where I should go?"

and:

> "Is this what I should click?"

Analyze the clarity of:

* Labels
* Icons
* Headings
* Breadcrumbs
* Descriptions
* Navigation names
* Button names
* Status messages

For every important interaction ask:

> Can the user predict what happens before clicking?

If not, investigate why.

---

# 26. Analyze discoverability

Ask:

> How would a user know this feature exists?

Consider:

* Navigation
* Search
* Contextual actions
* Empty states
* Onboarding
* Tooltips
* Documentation
* Icons
* Labels
* Progressive disclosure

Also distinguish:

### Discoverability

Can I find the feature?

### Understandability

Do I understand what it does?

### Predictability

Can I predict what happens?

These are separate UX qualities.

---

# 27. Analyze cognitive load

For every step, ask:

* How much information must the user remember?
* How many decisions must they make?
* Are choices meaningful?
* Are irrelevant options exposed?
* Are defaults appropriate?
* Is terminology familiar?
* Does the user need to understand technical concepts?

A useful measure is:

```text
Task complexity =
number of steps
+ number of decisions
+ amount of information
+ amount of memory required
+ uncertainty
```

The exact formula isn't mathematical; it is a thinking tool.

---

# 28. Analyze affordances

For every interactive element:

> Does it look and behave like something the user can interact with?

Document:

* Visual affordance
* Label
* Icon
* Cursor
* Hover
* Focus
* Active state
* Disabled state

Especially check icon-only controls.

For example:

```text
[↓]
```

might mean:

* Download
* Export
* Collapse
* Move down

An icon can be visually elegant but semantically ambiguous.

---

# 29. Analyze feedback loops

> **Scope:** §16 listed what the system produces. This section does not re-list it. It takes that inventory and asks, for each entry, whether the loop closes: does the user perceive it, in time, and does it tell them what they need in order to decide what to do next.

Every user action should have an appropriate response.

Use:

```text
User action
    ↓
System response
    ↓
User interpretation
    ↓
Next action
```

Example:

```text
Click Save
 ↓
Button changes
 ↓
"Saved successfully"
 ↓
User knows action completed
```

Walk the §16 output table and ask, per row:

> What does the user use as evidence that the system understood them?

> How long do they wait before that evidence appears?

> If the output is not perceivable, does the user need to know about it, and if so, what carries that knowledge?

An output with no perceivable counterpart is a broken loop. So is one whose evidence arrives too late to be connected to the action that caused it.

This is particularly important for asynchronous actions.

---

# 30. Analyze error recovery

Don't only ask:

> "What error message appears?"

Ask:

> **What does the user do next?**

An error message can carry up to four things:

```text
Problem
 ↓
Explanation
 ↓
Possible cause
 ↓
Recovery action
```

Record which of the four the product's actual message carries, quoting it verbatim, and state what the user is left unable to determine.

Take the same underlying failure (the dataset exceeds the synchronous export limit) expressed three ways:

| Actual message | Carries | User is left unable to determine |
| -------------- | ------- | -------------------------------- |
| "Export failed." | Problem | Why it failed; whether retrying would help; whether anything can be changed |
| "This report contains too much data to export at once. Narrow the date range and try again." | Problem, explanation, cause, one recovery action | Whether any route exists for exporting the full range |
| "This report contains too much data to export at once. Narrow the date range or request a background export." | Problem, explanation, cause, two recovery actions | - |

Quote the row that matches the product and note the gap. Do not write the row you wish it said.

---

# 31. Analyze destructive and irreversible actions

For:

* Delete
* Archive
* Disable
* Publish
* Send
* Submit
* Transfer
* Cancel
* Reset

determine:

* Is it reversible?
* Does it affect other people?
* Is confirmation necessary?
* What happens after confirmation?
* Can the action be undone?
* How is the consequence communicated?

Use a **consequence model**:

```text
Action
 ↓
Immediate consequence
 ↓
Persistent consequence
 ↓
External consequence
 ↓
Recovery possibility
```

---

# 32. Analyze accessibility

Accessibility should be part of the feature model, not a final checklist.

Investigate:

### Keyboard

* Can every action be reached?
* Is focus logical?
* Can dialogs be operated without a mouse?

### Screen reader

* Are controls named?
* Are states announced?
* Are dynamic changes communicated?

### Visual

* Contrast
* Focus indicators
* Color dependence
* Text size
* Error indicators

### Interaction

* Touch target
* Keyboard alternatives
* Motion
* Timing

---

# 33. Analyze responsive behavior

If the platform supports multiple screen sizes, determine:

```text
Desktop
Tablet
Mobile
```

For each:

* What remains visible?
* What collapses?
* What moves?
* What becomes a menu?
* What becomes scrollable?
* What changes interaction model?

Don't assume responsive design means "everything shrinks."

Sometimes the feature becomes a different interaction.

---

# 34. Analyze localization

For international platforms investigate:

* Text expansion
* Date formats
* Number formats
* Currency
* Time zones
* Translated terminology
* Pluralization
* Right-to-left languages if applicable

Especially for:

* Dates
* Reports
* Financial data
* Notifications
* Validation

---

# 35. Analyze data semantics

A designer needs to understand what the displayed data actually means.

Document:

* Data source
* Entity
* Field
* Definition
* Units
* Format
* Precision
* Status
* Relationship
* Freshness
* Nullability

For example:

> "Active users"

Could mean:

* Logged in today
* Logged in this month
* Account not disabled
* Subscription active

The UX cannot be properly specified without knowing what the information means.

---

# 36. Analyze business rules

Now identify rules that influence the UX.

Examples:

```text
IF user.role != admin
THEN export unavailable

IF records.count > 10,000
THEN background export

IF subscription == free
THEN CSV only
```

These rules should become part of the specification.

A UX specification should distinguish:

### UX rule

How the interface behaves.

### Business rule

Why the interface behaves that way.

---

# 37. Analyze analytics and measurable behavior

For mature platforms, investigate what interactions are measured.

Potential events:

```text
feature_viewed
feature_opened
feature_started
feature_completed
feature_cancelled
feature_failed
feature_retried
```

Then determine:

* What defines activation?
* What defines success?
* Where users abandon?
* What errors are frequent?
* Which options are commonly selected?

Analytics can reveal that the **intended UX** and **actual UX** differ.

---

# 38. Analyze actual user behavior

If research data exists, investigate:

* Support tickets
* User interviews
* Session recordings
* Usability tests
* Analytics
* Feedback
* NPS comments
* Customer complaints
* Sales feedback
* Product requests

This is where the process moves from:

> "What does the interface appear to do?"

to:

> "What actually happens when people use it?"

## Then go back to §10 and §6

This section is not only a source of new findings. It is the **audit** of the two sections that were written from inference.

Reopen §10 and §6 with this evidence in hand and settle every claim one of three ways:

| Outcome | What to write |
| ------- | ------------- |
| Confirmed | Upgrade the tag to `Evidenced` and cite the source |
| Contradicted | Replace the claim with what the evidence shows, and keep a line noting what was assumed; a corrected assumption is useful information about the feature's legibility |
| Still untouched | Leave it `Inferred` or `Unknown`, visibly, in the final artifact |

Two failure modes to watch for. The first is reading the evidence looking for confirmation: if nothing in §10 changed, suspect this before concluding you were right. The second is treating the absence of tickets as evidence of comprehension: users who misunderstand a feature usually stop using it rather than write in, so silence is `Unknown`, never `Evidenced`.

If no evidence of any kind exists, that is itself a finding, and the artifact says so: *"No behavioural evidence available for this feature; all mental-model claims are `Inferred`."* One honest sentence tells a reader exactly how much weight the persona and mental-model sections can bear.

---

# 39. Identify points of friction

> **Descriptive output.** This section finds friction; it does not judge or fix it. Each item is recorded as *what the interface does* and *what that leaves the user unable to do*, with the evidence it rests on. The categories below are a vocabulary for describing friction precisely, not a scoring rubric.

Only after reconstructing the experience should you look for friction in it.

Write each observation in this shape:

```text
Observation: <what the interface does>
Consequence: <what the user can or cannot determine / do as a result>
Evidence:    <screenshot, analytics, ticket, test, or "inferred, unverified">
Category:    <from the list below>
```

For example:

> **Observation:** Export produces no visible response until the file download begins, which takes 4-20 seconds depending on dataset size.
> **Consequence:** During that window the user has no indication the click registered; §38 session recordings show repeated clicking in 12% of exports.
> **Evidence:** Session recordings, Q2 sample.
> **Category:** Feedback.

Not:

> Export needs a loading indicator.

The second sentence may well be true. It is a design decision, made later, by whoever owns that decision; recording it here disguises a proposal as a finding.

Classify the friction.

### Navigation

Can't find it.

### Discoverability

Doesn't know it exists.

### Comprehension

Doesn't understand it.

### Interaction

Can't figure out how to use it.

### Feedback

Doesn't know whether it worked.

### Error handling

Can't recover.

### Consistency

Behaves differently from similar features.

### Accessibility

Some users cannot operate it.

### Efficiency

Too many steps.

### Cognitive load

Too many decisions.

### Trust

User can't predict consequences.

### Information architecture

Feature lives in the wrong conceptual location.

---

# 40. Separate presentation friction from model friction

> **Descriptive output.** This section classifies *where* an observation originates. It does not propose what to do about it: naming a cause and naming a cure are different acts, and only the first belongs in the artifact.

This distinction is extremely valuable, because the two have different causes and are described differently.

### Presentation-level (UI)

The model is coherent; how it is rendered obscures it.

> The Export button is rendered at 2.9:1 contrast against the toolbar background.

### Model-level (UX)

The rendering is faithful; the underlying model is what users cannot reconstruct.

> Two Export controls exist on the page (one in the toolbar, one in the row menu), and nothing in the interface distinguishes their scope. Users cannot determine which records either will export.

Notice that both are statements of fact, and neither names a remedy. The first implies a colour change and the second implies something much larger, but the artifact records only what is there.

Always ask:

> **Does this observation originate in presentation, or in the underlying experience model?**

The answer changes who the observation concerns, which is why it is worth recording: a presentation observation is usually one team's material, a model observation is usually several.

---

# 41. Identify inconsistencies

Compare the feature against:

* Same platform
* Same product area
* Same user role
* Same action
* Same component
* Same terminology

Create an inconsistency matrix:

| Pattern      | Current feature | Platform standard | Difference |
| ------------ | --------------- | ----------------- | ---------- |
| Save action  | Top right       | Bottom right      | Yes        |
| Error        | Toast           | Inline            | Yes        |
| Confirmation | Modal           | Inline            | Yes        |

Then determine whether the difference is:

1. Intentional
2. Necessary
3. Legacy
4. Accidental
5. Unknown

> **Descriptive output.** This classification is a claim about origin, and it needs a source: a decision record, a changelog, a person who remembers. Where no source exists, the honest entry is *Unknown*, never *Accidental* because it looks wrong to you. "Unknown" is a finding; a guess dressed as a classification is not. And note what the matrix does not say: that the feature ought to match the platform standard.

---

# 42. Record how the feature behaves against UX principles

> **Descriptive output.** Principles are used here as a **question generator**, not a scorecard. Each one prompts an observation about behaviour; none of them produces a grade. Answer with what happens, not with how well it does.

At this point, walk the feature against principles such as:

### Visibility

Can users see what they need?

### Feedback

Does the system communicate what happened?

### Consistency

Does it behave like the rest of the platform?

### Affordance

Can users understand what is interactive?

### Predictability

Can users anticipate outcomes?

### Error prevention

Can mistakes be avoided?

### Error recovery

Can mistakes be fixed?

### Recognition over recall

Does the interface show necessary information instead of requiring memory?

### User control

Can users cancel, undo, or recover?

### Progressive disclosure

Is complexity exposed only when needed?

### Efficiency

Can experienced users complete the task quickly?

Each question resolves to a described behaviour, not a verdict:

| Principle | Descriptive answer | Not |
| --------- | ------------------ | --- |
| Feedback | "Success is signalled only by the browser's download indicator; the page itself does not change." | "Feedback is weak." |
| Predictability | "The label reads *Export*; the dialog is the first place the record count appears." | "Poor predictability: 2/5." |
| User control | "Once started, the job cannot be cancelled from the interface." | "Users should be able to cancel." |

The right-hand column is the failure mode: it compresses an observation into an opinion and loses the detail that made the observation useful.

---

# 43. Build the complete UX model

At this point, combine everything into one model.

A useful structure is:

```text
PLATFORM
│
├── Information Architecture
│
├── User
│
│   ├── Role
│   ├── Goal
│   └── Context
│
├── Entry Point
│
├── Current Context
│
├── Feature
│
│   ├── Purpose
│   ├── Objects
│   ├── Actions
│   ├── Inputs
│   ├── Decisions
│   └── Outputs
│
├── State Machine
│
├── Business Rules
│
├── Permissions
│
├── Dependencies
│
├── Error Handling
│
├── Accessibility
│
├── Responsive Behavior
│
├── Platform Conventions
│
└── Exit / Outcome
```

This is essentially the **context model** of the feature.

---

# 44. Produce the UX specification

Only now should the designer create the final UX spec.

Everything below is written in the descriptive register established in §0: present tense, current behaviour, sources named, uncertainty declared. Sections 1-17 describe the feature as it is. Section 18 holds the friction observed while describing it. Sections 19-20 hold what is still unresolved. Nothing anywhere proposes a change.

Use this exact structure.

---

# UX Specification Template

## 1. Feature Overview

**Feature:**
`Export Report`

**Platform:**
`Analytics Platform`

**Location:**
`Reports → Operational → Report Details`

**Purpose:**
What the feature allows users to accomplish.

**Primary user:**
Who uses it.

**User goal:**
What the user is ultimately trying to accomplish.

---

## 2. Feature Context

### Information architecture

```text
Platform
 → Reports
   → Operational
     → Report Details
       → Export
```

### Entry point

Where the feature is accessed.

### Exit point

What constitutes completion.

### Feature ownership

What object/entity the feature operates on.

---

# 3. User Journey

```text
Dashboard
 ↓
Reports
 ↓
Operational
 ↓
Select report
 ↓
Report details
 ↓
Export
 ↓
Configure export
 ↓
Confirm
 ↓
Processing
 ↓
Download
```

---

# 4. User Context

Document each attribute with its provenance (§10), because this section mixes verifiable system facts with claims about people:

| Attribute | Value | Provenance | Source |
| --------- | ----- | ---------- | ------ |
| Role | Operations manager | System fact | Role config |
| Frequency | 2-3 exports/week | System fact | Analytics, 90d |
| Goal | Share data with finance | `Evidenced` | 6 support tickets, 2 interviews |
| Knowledge level | Unfamiliar with CSV/XLSX difference | `Inferred` | - |
| Mental model | Export = "download what I'm looking at" | `Contested` | Interviews say filtered; tickets suggest some expect all records |
| Environment | Desktop, office hours | `Inferred` | - |
| Permissions | Export granted | System fact | Permission matrix |

A reader can then tell at a glance which rows would survive contact with a real user and which are the author's best guess. Rows still marked `Inferred` after §38 stay that way in the delivered artifact; that is honest reporting, not an incomplete section.

---

# 5. Screen Context

Describe:

* Page purpose
* Page hierarchy
* Navigation
* Breadcrumb
* Header
* Main content
* Related controls
* Primary actions
* Secondary actions
* Feature location

---

# 6. Feature Anatomy

For each UI element:

| Element | Type   | Purpose       | Behavior       | Condition           |
| ------- | ------ | ------------- | -------------- | ------------------- |
| Export  | Button | Start export  | Opens dialog   | User has permission |
| Format  | Select | Choose format | Updates format | Always              |
| Export  | Button | Confirm       | Starts job     | Valid input         |

---

# 7. Interaction Flow

Document every interaction:

```text
User action
→ System response
→ New state
→ User decision
```

---

# 8. State Specification

Create a table:

| State   | Trigger        | UI                   | User action   | System behavior |
| ------- | -------------- | -------------------- | ------------- | --------------- |
| Default | Page loaded    | Export enabled       | Click         | Open dialog     |
| Loading | Export started | Spinner              | Wait          | Process         |
| Success | Job completed  | Success feedback     | Download      | File available  |
| Error   | Job fails      | Error message        | Retry         | Restart         |
| Empty   | No records     | Disabled/alternative | Adjust filter | Reload data     |

---

# 9. Business Rules

List explicit rules.

```text
BR-001: Only administrators can export.
BR-002: Export respects active filters.
BR-003: Files larger than X are processed asynchronously.
```

---

# 10. Permission Rules

```text
Admin       → Full access
Manager     → Export
Analyst     → Export
Viewer      → No export
```

---

# 11. Validation Rules

For every input:

* Required?
* Format?
* Range?
* Dependencies?
* Error message?
* Recovery?

---

# 12. Error & Recovery

Document every known failure.

```text
Network failure
→ Explain problem
→ Preserve user's configuration
→ Offer Retry
```

---

# 13. Accessibility

Document:

* Keyboard
* Focus
* Screen reader
* Contrast
* Labels
* Error announcements
* Dynamic content

---

# 14. Responsive Behavior

Document:

```text
Desktop:
Toolbar action

Mobile:
Overflow menu → Export
```

---

# 15. Content / Microcopy

Specify:

* Labels
* Button names
* Titles
* Descriptions
* Errors
* Empty states
* Success messages
* Confirmation text

---

# 16. Analytics

Define:

```text
feature_viewed
feature_started
feature_completed
feature_cancelled
feature_failed
```

if analytics are part of the product's requirements.

---

# 17. UX Decisions Already Embodied in the Feature

This is particularly important.

These are **reconstructed**, not proposed. Every row describes a decision the product has already made and is currently enforcing. The rationale column records *why it appears to be that way*, with its source; where no source exists, the rationale is `Unknown`, which is a legitimate and useful entry.

| Decision                     | Rationale                        | Source |
| ---------------------------- | -------------------------------- | ------ |
| Export lives at page level   | It applies to the current report | Inferred from placement (§9) |
| Current filters are exported | Preserves user's working context | Confirmed with engineering |
| No confirmation dialog       | Action is non-destructive        | Inferred, unverified |
| Background processing        | Large exports exceed request timeout | Confirmed, BR-003 |

Never enter a decision you think the product *should* make. If the rationale reads like an argument rather than an account, it is a recommendation in disguise.

This transforms the specification from:

> "Here is what the screen looks like."

into:

> **"Here is how the experience currently works, and why it works that way."**

---

# 18. Observed Friction

Where the findings from §39-42 land.

Each entry is an observation, its consequence, and its evidence, in the shape §39 defines. No remedies, no severity, no ordering by importance.

```text
F-001  The export button gives no response for 4-20s before the download starts.
       → User cannot tell the click registered.
       → Session recordings; repeat-clicking in 12% of exports.
       → Category: Feedback. Origin: model-level (§40).

F-002  Toolbar Export and row-menu Export use identical labels and icons.
       → User cannot determine the scope of either without trying one.
       → Screenshot; 3 support tickets Q2.
       → Category: Comprehension. Origin: model-level (§40).
```

Keeping this section separate from §1-17 is what lets the specification stay usable as a neutral reference: a reader who wants only the current behaviour can stop before it, and a reader working on improvements has the raw material without the artifact having chosen for them.

---

# 19. Open Questions

Never hide uncertainty.

Maintain:

```text
Q-001: Does export include hidden columns?
Q-002: What is the maximum synchronous export size?
Q-003: Is any notification sent when background processing completes?
```

Note the form: every question asks what *is*, not what *should be*. "Should users be notified after background processing?" is a design question and does not belong here; it belongs to whoever owns that decision. If a question can only be answered by making a choice rather than by investigating, it is out of scope for this artifact.

This is extremely useful in collaborative product development.

---

# 20. Assumptions

Separate assumptions from requirements.

Example:

```text
A-001: Export uses the currently applied filters.
A-002: Users can only export records they can view.
```

Until validated, these should not silently become "facts."

---

# 21. UX Acceptance Criteria

Finally, translate the specification into testable criteria.

These assert **current behaviour**, so that the description can be verified against the running product rather than taken on trust. They are not targets for a future state.

For example:

```text
Given a user with export permission
When viewing a filtered report
Then the Export action is available.

Given a filtered report
When the user exports the data
Then the exported dataset respects the active filters.

Given an export that exceeds the synchronous limit
When the user starts the export
Then the system provides progress/background-processing feedback.
```

This is where the UX spec becomes useful to:

* Product
* Design
* Engineering
* QA
* Customer support

---

# The Complete Mental Process

**This checklist is an index, not a method.**

Each line below is a *recall cue* for a section of the procedure: a way to notice, mid-review, that you skipped something. It is not a shorter version of the work. A question here can be answered in one sentence; the section it points to cannot. Answering the 30 questions without opening the sections produces a plausible-sounding document with none of the rigour the procedure exists to enforce.

So each step carries two extra columns: **where the real work lives**, and **the condition that says you are actually finished**. If the second column isn't satisfied, the step isn't done, no matter how confidently the question can be answered.

| # | Question | Where the work lives | Not done until |
| -: | -------- | -------------------- | -------------- |
| 1 | What is it, and where does it start and stop? | §0, §2 | Entry point, scope, and exit point are written down |
| 2 | Where is it in the platform? | §3 | The feature is placed in the full IA tree, not just named |
| 3 | How does a real user get here? | §4 | Each step has see / think / do / response, ending at the entry point |
| 4 | Who uses it? | §6 | At least two personas contrasted; role/frequency stated as system fact, prior knowledge tagged for provenance |
| 5 | Why do they come here, and what are they ultimately after? | §5 | User goal, feature goal, and interaction goal stated separately |
| 6 | What do they know before arriving? | §6 | Prior knowledge and expected terminology identified |
| 7 | What state are they in on arrival? | §7 | Active filters, selections, and loaded data enumerated, and what the action means *in that state* |
| 8 | What does the screen tell them? | §25, §26, §28 | Scent, discoverability, and affordance assessed as three separate qualities |
| 9 | What is important, and does the layout say so? | §8, §9 | A ranking exists, and any mismatch with placement is recorded |
| 10 | What object does it act on, at what level? | §11, §12 | Page-, selection-, and row-level ownership disambiguated |
| 11 | What does the user expect it to do, and how do I know? | §10 | Mental model, actual model, and divergence written, **every claim tagged `Evidenced` / `Inferred` / `Contested` / `Unknown` with sources**, and the triangulation ladder worked before settling for inference |
| 12 | What does the system actually do, over what timescale? | §18, §19 | Sync/async, persistence, cancellation, retry, and timing answered |
| 13 | What is the full task flow, including branches? | §13 | Every branch captured, not only the happy path |
| 14 | What are the inputs? | §15 | Purpose, required, default, and validation per input |
| 15 | What decisions must the user make, and what do they cost? | §14, §27 | Defaults justified, and complexity assessed against §27 |
| 16 | What are the outputs, and which does the user perceive? | §16, §29 | Output inventory built, then every unperceived output resolved as a loop |
| 17 | **What are all the states, and every transition between them?** | §17 | Not a list of states: a state machine. Triggers, transitions, terminal states, and all twelve state types in §17, including partial, interrupted, and recovery |
| 18 | What can go wrong, and what is irreversible? | §17, §31 | Failure modes enumerated, and the consequence model applied to anything destructive |
| 19 | How does the user recover? | §30 | Every failure has explanation → cause → recovery action |
| 20 | What does the data actually mean? | §35 | Definition, units, freshness, and nullability of displayed fields |
| 21 | What business rules constrain it? | §36 | Rules written as explicit conditionals, separated from UX rules |
| 22 | What permissions constrain it? | §20 | Hidden vs. disabled vs. available decided per role, with rationale |
| 23 | What does it depend on? | §21 | Dependency map, used to generate edge cases |
| 24 | What platform patterns does it follow or violate? | §22, §41 | Each divergence classified: intentional, necessary, legacy, accidental, unknown |
| 25 | What similar features exist, and why does this one differ? | §23 | Comparison table across at least two analogues |
| 26 | What design-system patterns apply? | §24 | Components identified *without* the spec collapsing into a component list |
| 27 | Can every user operate it, on every screen, in every locale? | §32, §33, §34 | Keyboard, screen reader, visual, and touch answered; breakpoints treated as possible interaction changes, not shrinking |
| 28 | What does real user behaviour say? | §37, §38 | Intended UX compared against evidence (analytics, tickets, research), **and §10/§6 revisited and re-tagged in light of it** |
| 29 | Where is the friction, and does it originate in presentation or in the model? | §39, §40, §42 | Each observation carries consequence + evidence + origin, and contains no proposed remedy |
| 30 | What has the product already decided, and what remains unknown? | §1, spec §17-20 | Existing decisions reconstructed with sources; open questions and assumptions recorded, not silently resolved |

## Where this checklist most often goes shallow

Four steps compress the most material, and are the ones to distrust when they feel quick:

**Step 17 (states):** "What are all the states?" invites a list of five nouns. §17 asks for a machine: what triggers each transition, which states are terminal, what happens on partial success, and what the user sees if they close the tab mid-operation. A list of states is not a state machine, and the difference is where most implementation ambiguity hides.

**Step 21 (business rules):** One line here can stand in for the entire rule set that governs the feature's behaviour. §36 wants them written as conditionals, and the UX rule kept distinct from the business rule that causes it.

**Step 27 (accessibility, responsive, localization):** Three full sections behind one question. Compressing them is exactly how accessibility becomes a final checklist item instead of part of the feature model, which §32 explicitly warns against.

**Step 28 (real behaviour):** Cheap to answer with "no data available", which is sometimes true and often just unchecked; support-ticket wording and community channels usually exist and are rarely read. This step also carries a second job the question doesn't hint at: it is the audit that settles the inferred claims in §10 and §6. Skipping it leaves the artifact's statements about users permanently unverified while looking exactly like its verified ones.

## The quality gate

The checklist does not end the process. This does:

> **Can the spec be implemented and tested without guessing?**

Ask it of the specification produced in §44, not of the checklist. If an engineer or QA would have to guess at any point, the gap points back to whichever step's "not done until" was skipped.

And a second gate, on tone and validity:

> **Can every sentence be checked against the running product or, where it cannot, does it name its source or declare itself unverified?**

A sentence fails the first half by proposing, rating, or wishing rather than describing: delete it, or convert it into the observation it was built on. It fails the second half by asserting something about users with nothing behind it: give it a source, or tag it `Inferred` (§10). Claims about the interface are settled by looking. Claims about people are settled by evidence or by admission, never by confidence.

> **A good UX specification should eliminate as much implementation ambiguity as possible without prescribing implementation unnecessarily.**

---

# A useful distinction: 5 levels of context

I would also explicitly structure the investigation into **five concentric contexts**.

### Level 1: Platform context

> Where does this feature exist?

* Product
* Application
* Navigation
* Information architecture
* Permissions
* Platform conventions

### Level 2: Page context

> What is happening on this particular screen?

* Page purpose
* Data
* Hierarchy
* Controls
* Neighboring features
* Current state

### Level 3: Task context

> What is the user trying to accomplish?

* Goal
* Motivation
* Starting state
* Desired outcome
* Decisions
* Workflow

### Level 4: Interaction context

> How does the feature actually behave?

* Inputs
* Outputs
* States
* Feedback
* Validation
* Errors
* Recovery
* Timing

### Level 5: System context

> What rules make the experience behave this way?

* Business rules
* Data model
* Permissions
* Dependencies
* Integrations
* Analytics
* Technical constraints

A designer who only studies Level 2 is essentially doing **screen analysis**.

A designer who gets through all five is doing **UX analysis**.

---

# The fundamental principle

The most important mental shift is this:

**Don't start with:**

> "What should this screen look like?"

Start with:

> **"What experience is the platform currently providing to this user, at this point in their journey, and what system of information, decisions, actions, states, and rules makes that experience possible?"**

Then progressively zoom in:

```text
Platform
   ↓
Information architecture
   ↓
User journey
   ↓
Task
   ↓
Page
   ↓
Feature
   ↓
Interaction
   ↓
Component
   ↓
State
```

And when you finish, reverse the direction:

```text
Context
   ↓
UX model
   ↓
Interaction model
   ↓
Behavior specification
   ↓
UI specification
   ↓
Acceptance criteria
```

That produces a UX spec that is **contextual rather than cosmetic**: it explains not merely *what the feature looks like*, but **where it belongs, why it exists, how users reach it, what they expect, how it behaves, what constraints govern it, and what experience the platform currently provides at that exact point in the product.**

And it stops there. The artifact's authority comes from being checkable: every claim traceable to the product, a source, or a declared assumption. The moment it starts arguing for a different feature, it stops being the thing everyone can agree on and becomes one more opinion in the discussion. Describe the feature so completely and so neutrally that the people who decide what to change can do so without having to re-derive any of it.
