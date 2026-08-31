---
name: tune-against-eval
description: Iteratively improve a prompt or pipeline step against an existing eval with gold labels/ground truth - read the error breakdown to find the dominant failure bucket, form one falsifiable hypothesis, get cheap debug evidence before spending compute, change exactly one variable, measure with a paired comparison, keep or revert by whether the flip list matches the hypothesis (not the headline number), document every outcome including reverts. Use when the user wants to raise accuracy/F1/precision/recall on something measured, asks "why is this failing" about a prompt or classifier, or wants to iterate/loop on quality against an eval or gold set.
---

# Tuning against an eval

This is the mindset for improving something an eval already measures - a
classifier's prompt, an extractor's instructions, a ranking step, any LLM
component that turns an input into a judged output. It is not a checklist to
run once; it's how a senior engineer thinks through a tuning session, iteration
by iteration, so the metric that moves is a metric you understand.

**Preconditions.** You need: gold labels or ground truth for a set of items, a
way to score a set of predictions against that gold (even a rough one), and a
component whose prompt/config you're allowed to change. If any of these don't
exist yet, that's a different job (building the eval) - this skill starts once
they do.

## The mindset, as principles

1. **Read the breakdown, not the headline.** A single accuracy or pass-rate
   number hides where the system actually fails. Get precision/recall/F1 per
   category (or whatever slicing applies - per class, per rule, per input
   type) and find the *dominant* error bucket: the one cluster of mistakes
   that, if fixed, would move the needle most. Tuning against the headline
   metric is debugging a crash from the exit code alone.

2. **Form ONE falsifiable hypothesis, tied to a mechanism.** "The model
   doesn't get X" isn't falsifiable. "Clause Y in the prompt is causing the
   model to read Z as W" is - you can check it, and it can turn out wrong. If
   you can't picture what evidence would disprove your hypothesis, you don't
   have one yet, you have a vibe.

3. **Get cheap evidence before spending compute.** Before regenerating the
   whole eval, make the component explain itself: add an opt-in field that
   asks for the reasoning behind its decision (a "why did you answer this way"
   field in the output), log it, keep it off by default so production is
   unaffected. Run it on a small, deliberately chosen sample of known-wrong
   items - six to a dozen, not all of them - and read what it actually says.
   This costs seconds, not minutes. If the stated reasoning doesn't match your
   hypothesis, you just saved a full regen cycle; revise the hypothesis and
   check again before writing any fix.

4. **Change exactly one variable.** Wording *or* structure, never both in the
   same edit. The moment you reorder priority *and* reword a clause together,
   you've lost the ability to know which one did anything, if either did. This
   is the single most common way a promising session turns into an argument
   with your own past self a few iterations later - you cannot attribute a
   result you didn't isolate.

5. **Measure with a paired comparison, not two independent numbers.** Score
   the same items before and after the change, and read the *flip list* -
   which specific items changed, and in which direction - not just the delta.
   A paired significance test (McNemar or equivalent) or, at small n, just
   eyeballing the flip list, tells you whether the direction is even
   distinguishable from noise.

6. **Judge success by mechanism match, not the number.** This is the one
   lesson worth remembering above the rest: a metric that moved for the
   reason you predicted is a fix; a metric that moved for unrelated reasons is
   noise wearing a fix's clothes, and it will not replicate. Before keeping
   anything, check the flip list against your hypothesis: are the items you
   meant to fix actually in it? If the number went up but your target items
   didn't move, you have not fixed what you think you fixed - something else
   moved, unexplained, and keeping the change means shipping a prompt/config
   you don't actually understand. A smaller, well-explained win beats a
   bigger, unexplained one every time - the unexplained one is a liability
   that will resurface as confusion later, usually at a worse time.

7. **Check for regressions outside the sandbox you're tuning in.** If what
   you're changing is shared - one prompt used across several domains, one
   config read by several callers - re-measure on whatever else depends on it
   before calling the change done. A local win that's a silent loss elsewhere
   is not a net win, and "elsewhere" won't announce itself unless you check.

8. **Document every outcome, kept or reverted, with the why.** A revert with
   no record gets re-attempted later by someone (very often future-you) who
   didn't see what you saw. Write down: the hypothesis, the evidence that
   supported or refuted it, exactly what changed, the measured result, and -
   this part matters most for a revert - specifically why it failed and what
   a smarter next attempt would need (a tiebreak rule, a worked example, a
   narrower scope). The goal is that the next attempt starts past your dead
   end, not back at its entrance.

9. **Decide autonomously when the evidence is clear; escalate when it's a
   judgment call.** A keep/revert decision driven by mechanism-match evidence
   and a clean regression check is yours to make without checking in every
   iteration - that's what the evidence is for. But if getting the fix right
   requires deciding a *new domain rule or policy*, not just correcting a
   mechanical bug - something two reasonable people could disagree about even
   looking at the same evidence - that decision belongs to whoever owns the
   product, not to you alone. Surface it, don't guess it.

10. **Know when to stop.** Diminishing returns (the last couple of iterations
    produced only noise-level flips), a sample too small to detect anything
    smaller than what you're chasing (compare the flip count to the eval's
    minimum-detectable-effect, if it reports one), or you've tried a hard
    problem's two closest variants and both failed cleanly - these are signals
    to stop tuning this component and either grow the eval or work on
    something else. Tuning past this point mostly produces war stories about
    noise, not improvements.

## The cycle, one iteration

1. Get the current baseline score with a full breakdown, not just the
   headline.
2. Identify the dominant error bucket - the cluster of mistakes with the same
   shape.
3. Form one falsifiable hypothesis about *why*, tied to a specific mechanism.
4. Cheap-instrument and spot-check: add debug output, run it on a handful of
   known-wrong items, read the reasoning.
5. If the spot-check refutes the hypothesis, revise it and check again -
   don't spend the full run on a hypothesis that already failed a cheap test.
6. If it supports the hypothesis, make the one isolated change.
7. Regenerate/re-run the full eval.
8. Paired-compare against the baseline; read the flip list, not just the
   delta.
9. Judge: does the flip list actually contain the items the hypothesis was
   about? Any regression outside the sandbox you're tuning in?
10. Keep or revert accordingly.
11. Document the outcome unconditionally - the reverts are often more useful
    to future you than the keeps.
12. Loop back to step 2 with the next-highest-impact bucket, or stop per the
    stopping criteria above.

## Pairing with a background loop

Each iteration usually has a slow step in the middle (step 7 - regenerating
predictions can take minutes). Where you can leave the coordinator free while
that runs - a `/loop`-style session, a background job with a completion
watcher, whatever your environment offers - kick step 7 off in the background,
watch for its completion, and pick the cycle back up rather than blocking on
it synchronously. This isn't required - the cycle works exactly the same as a
single manual iteration - but it's what lets several iterations happen across
a session without someone babysitting a terminal.

## A short example, genericized

Say a support-ticket priority classifier scores 0.71 macro-F1, and the
breakdown shows `urgent` recall at 0.40 - the dominant bucket. Hypothesis: the
prompt's definition of `urgent` requires an explicit deadline phrase, so
tickets that are urgent by *consequence* ("the site is down for every
customer") rather than by stated deadline get called `normal`. Debug spot
-check on eight known-wrong `urgent` items confirms it: the model's logged
reasoning repeatedly says things like "no deadline mentioned, so not urgent."

Fix: add one sentence to the `urgent` definition covering severity-of-
consequence as an alternative trigger, without touching anything else.
Regenerate, compare: macro-F1 0.71 -> 0.74, and the flip list shows exactly
the severity-worded tickets moving `normal` -> `urgent`, nothing unrelated
moving. Kept, documented with the hypothesis, the debug quotes, and the flip
list.

Second iteration: recall is still short on a `security` sub-case. Try
broadening the same sentence further. Metric ticks up again, but the flip
list shows unrelated `billing` tickets now moving to `urgent` too, and the
targeted security tickets didn't move at all. Reverted - the number moved for
the wrong reason - and documented with what a real fix would need (a separate,
narrower clause for the security case, not a broader version of the same one).

## Pitfalls worth naming

* Trusting a nominal metric increase without reading the flip list.
* Bundling a wording change with a structural/order change in one edit.
* Skipping the cross-domain regression check because the target metric
  improved.
* Reverting silently - a revert with no note gets re-attempted.
* Over-fitting a rule to one ambiguous item instead of the dominant bucket.
* Continuing to tune below the eval's detectable-effect floor and calling the
  noise a trend.
