---
name: tune-against-eval
description: >-
  Iteratively improve a prompt or pipeline step against an existing eval with gold labels or ground truth: read the error breakdown to find the dominant failure bucket, form one falsifiable hypothesis, get cheap debug evidence before spending compute, change exactly one variable, measure with a paired comparison, keep or revert by whether the flip list matches the hypothesis (not the headline number), and document every outcome including reverts. Use when the user wants to raise accuracy, F1, precision, or recall on something measured, asks "why is this failing" about a prompt or classifier, or wants to iterate on quality against an eval or gold set.
---

# Tuning against an eval

This is the mindset for improving something an eval already measures: a
classifier's prompt, an extractor's instructions, a ranking step, or any LLM
component that turns an input into a judged output. It is not a checklist to
run once; it is how an experienced engineer thinks through a tuning session,
iteration by iteration, so that every metric movement is understood.

**Preconditions.** You need: gold labels or ground truth for a set of items, a
way to score a set of predictions against that gold (even a rough one), and a
component whose prompt or configuration you are allowed to change. If any of
these do not exist yet, that is a separate job (building the eval); this skill
starts once they do.

## The mindset, as principles

1. **Read the breakdown, not the headline.** A single accuracy or pass-rate
   number hides where the system actually fails. Get precision, recall, and F1
   per category (or whatever slicing applies: per class, per rule, per input
   type) and find the *dominant* error bucket: the cluster of mistakes that,
   if fixed, would yield the largest improvement. Tuning against the headline
   metric alone is like debugging a crash from the exit code.

2. **Form ONE falsifiable hypothesis, tied to a mechanism.** "The model
   doesn't get X" isn't falsifiable. "Clause Y in the prompt causes the
   model to read Z as W" is: you can check it, and it can turn out wrong. If
   you cannot picture what evidence would disprove your hypothesis, you do not
   have one yet.

3. **Get cheap evidence before spending compute.** Before regenerating the
   whole eval, make the component explain itself: add an opt-in field that
   asks for the reasoning behind its decision (a "why did you answer this way"
   field in the output), log it, and keep it off by default so production is
   unaffected. Run it on a small, deliberately chosen sample of known-wrong
   items (six to twelve items, not all of them) and read what it actually
   says. This costs seconds. If the stated reasoning does not match your
   hypothesis, revise the hypothesis and check again before writing any fix.

4. **Change exactly one variable.** Wording *or* structure, never both in the
   same edit. The moment you reorder priority *and* reword a clause together,
   you lose the ability to know which change had an effect. This is the single
   most common reason tuning sessions become confusing later: you cannot
   attribute a result you did not isolate.

5. **Measure with a paired comparison, not two independent numbers.** Score
   the same items before and after the change, and read the *flip list* (which
   specific items changed, and in which direction), not just the delta.
   A paired significance test (McNemar or equivalent) or, at small sample sizes,
   inspecting the flip list directly, indicates whether the change is
   distinguishable from noise.

6. **Judge success by mechanism match, not the number.** A metric that moved
   for the reason you predicted is a fix; a metric that moved for unrelated
   reasons is noise that will not replicate. Before keeping anything, check
   the flip list against your hypothesis: did the items you intended to fix
   actually change? If the overall score increased but your target items did
   not move, something else changed without explanation. Shipping an unexplained
   prompt change introduces hidden liabilities. A smaller, well-explained win
   beats a larger, unexplained one.

7. **Check for regressions outside the sandbox you are tuning in.** If the
   prompt or configuration is shared across several callers or domains,
   re-measure across those dependencies before declaring the change complete.
   A local gain that introduces a silent loss elsewhere is not an improvement.

8. **Document every outcome, kept or reverted, with the rationale.** A revert
   with no record gets re-attempted later. Record the hypothesis, the evidence
   that supported or refuted it, the exact diff, the measured result, and
   (most importantly for a revert) specifically why it failed and what a
   subsequent attempt would require (a tiebreak rule, a worked example, or a
   narrower scope).

9. **Decide autonomously when evidence is clear; escalate for policy decisions.**
   A keep or revert decision backed by mechanism-match evidence and a clean
   regression check can be made directly. However, if resolving an issue
   requires establishing a *new domain rule or product policy* rather than
   fixing a mechanical defect, escalate that choice to the product owner.

10. **Know when to stop.** Diminishing returns (subsequent iterations produce
    only noise-level flips), a sample too small to detect subtle shifts, or
    repeated clean failures on the two closest variants of a problem are all
    signals to stop tuning this component and either expand the eval dataset
    or focus on a different area.

## The cycle, one iteration

1. Get the current baseline score with a full breakdown, not just the
   headline.
2. Identify the dominant error bucket: the cluster of mistakes with the same
   shape.
3. Form one falsifiable hypothesis about *why*, tied to a specific mechanism.
4. Add debug output and spot-check on a handful of known-wrong items to read
   the model's reasoning.
5. If the spot-check refutes the hypothesis, revise it and check again; do not
   spend a full eval run on a failed hypothesis.
6. If the spot-check supports the hypothesis, make one isolated change.
7. Re-run the full eval.
8. Paired-compare against the baseline; inspect the flip list, not just the
   delta.
9. Verify mechanism match: does the flip list contain the items targeted by the
   hypothesis? Are there regressions in shared dependencies?
10. Keep or revert accordingly.
11. Document the outcome unconditionally; reverts provide essential context for
    future iterations.
12. Loop back to step 2 with the next-highest-impact bucket, or stop when
    criteria are met.

## Pairing with a background loop

Each iteration usually includes a slower evaluation step (step 7: regenerating
predictions can take minutes). When possible, run step 7 in the background (using
a background task or loop session), watch for completion, and resume the cycle
without blocking interactively. This allows multiple iterations to proceed
efficiently across a session.

## A short example, genericized

Suppose a support-ticket priority classifier scores 0.71 macro-F1, and the
breakdown shows `urgent` recall at 0.40: the dominant bucket. Hypothesis: the
prompt's definition of `urgent` requires an explicit deadline phrase, so
tickets that are urgent by *consequence* ("the service is unavailable for all
users") rather than by stated deadline are classified as `normal`. A debug
spot-check on eight known-wrong `urgent` items confirms this: the logged
reasoning repeatedly states "no deadline mentioned, so not urgent."

Fix: add one sentence to the `urgent` definition covering severity of
consequence as an alternative trigger, without changing anything else.
Re-evaluating shows macro-F1 moving 0.71 -> 0.74, and the flip list shows
specifically the consequence-worded tickets moving `normal` -> `urgent` with
no unrelated changes. The change is kept and documented with the hypothesis,
the debug quotes, and the flip list.

Second iteration: recall remains low on a `security` sub-case. Broadening the
same sentence further increases the headline metric, but the flip list reveals
that unrelated `billing` tickets also shifted to `urgent`, while the target
security tickets were unaffected. The change is reverted because the metric
moved for the wrong reason, and the outcome is documented along with the need
for a dedicated, narrower security clause.

## Pitfalls to avoid

* Trusting a headline metric increase without inspecting the flip list.
* Bundling a wording change with a structural or ordering change in one edit.
* Skipping cross-domain regression checks after target metric improvement.
* Reverting silently without documenting the failure mode.
* Over-fitting a rule to one ambiguous item instead of the dominant bucket.
* Continuing to tune below the evaluation set's detectable-effect floor.
