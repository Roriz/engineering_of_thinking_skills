---
name: simplify
description: >-
  Review the changed code for reuse, simplification, efficiency, and altitude cleanups, then apply the fixes directly. Quality only — it does not hunt for correctness bugs; pair with a bug-focused code review for that. Use after finishing a feature or fix, before commit or PR, to tighten a diff.
---

# Simplify: Diff Quality Cleanup

Review only the code that changed — the current diff against the base branch, or the working tree if uncommitted — and apply cleanups directly. This is not a bug hunt: skip anything that's a correctness, security, or logic concern and note it separately instead of fixing it (that belongs to a dedicated code review).

Work through four lenses. Not every diff has an instance of every lens — don't force one.

## 1. Reuse

Duplicated logic that already exists elsewhere in the codebase, reimplemented instead of called.

**Before:**
```python
def normalize_email(email):
    return email.strip().lower()

# elsewhere, added in this diff
def clean_user_email(raw):
    return raw.strip().lower()
```

**After:** call the existing `normalize_email` instead of reimplementing it.

Search the codebase for an existing helper before assuming one doesn't exist — this is the one lens that requires looking outside the diff itself.

## 2. Simplification

Code that does something straightforward in a roundabout way: needless indirection, over-parameterization for a single call site, conditionals that collapse, control flow that fights the language's idioms.

**Before:**
```javascript
let result;
if (items.length > 0) {
  result = true;
} else {
  result = false;
}
```

**After:**
```javascript
const result = items.length > 0;
```

## 3. Efficiency

Unnecessary work: redundant recomputation, an O(n²) pattern where an O(n) one is just as clear, a query or loop repeated when it could be hoisted or cached.

**Before:**
```python
for user in users:
    if user.id in [b.user_id for b in blocked]:
        continue
```

**After:**
```python
blocked_ids = {b.user_id for b in blocked}
for user in users:
    if user.id in blocked_ids:
        continue
```

Only flag efficiency issues that are free to fix without changing behavior or adding real complexity — this isn't a license to micro-optimize.

## 4. Altitude

Code operating at the wrong level of abstraction for where it sits: low-level details leaking into a high-level function that should read like a summary, or a trivial one-line wrapper adding a layer of indirection that doesn't earn its keep.

**Before:**
```python
def checkout(cart):
    # 15 lines of tax-rate lookup and rounding logic inline
    ...
    charge(cart.total)
```

**After:** extract the tax logic into a named function so `checkout` reads as a sequence of steps at one altitude; inline a wrapper that does nothing but forward its arguments.

## Process

1. Read the diff. For each hunk, check it against the four lenses above.
2. Apply the fix directly in the working tree — don't just report it. Keep each fix behavior-preserving; if a "simplification" would change observable behavior, it isn't one.
3. If you find a correctness bug while reading (not a quality issue), don't fix it silently — call it out separately so the user can route it to a proper review instead of having it buried in a cleanup diff.
4. Summarize what changed, grouped by lens, so the user can review the cleanup as a distinct pass from their original diff.
