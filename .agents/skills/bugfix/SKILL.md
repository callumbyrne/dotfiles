---
name: bugfix
description: Diagnose and fix a bug using evidence-first debugging. Use when an observed failure or regression must be understood and corrected without guessing at the cause.
---

# Bugfix

Fix `<work-id>` by establishing what is actually failing and why.

Do not jump from suspicious code directly to a patch.

## 1. Establish the failure

Reproduce the bug, or establish the strongest available observable evidence of it.

Record the important dimensions of the failure:

- triggering input/state/sequence;
- expected behavior;
- actual behavior;
- relevant logs/errors/outputs;
- whether the failure is deterministic or conditional.

If the bug cannot be reproduced, say so and work from evidence without pretending reproduction succeeded.

## 2. Form hypotheses

Generate a small set of plausible root-cause hypotheses.

Prefer hypotheses that explain the full observed behavior rather than isolated suspicious lines.

## 3. Eliminate with evidence

Trace runtime/code paths, inspect state, run focused experiments, or add temporary diagnostics as appropriate.

For each serious hypothesis, seek evidence that confirms or rules it out.

Do not implement a defensive change merely because it might hide the symptom.

## 4. Establish root cause

Before making the production fix, be able to explain:

- what actually causes the failure;
- why it produces the observed behavior;
- why the proposed fix addresses that cause rather than only the symptom.

If root cause remains uncertain, be explicit rather than presenting a guess as fact.

## 5. Fix the cause

Make the smallest coherent production change that resolves the established cause while preserving required behavior.

Add or update regression coverage where appropriate.

## 6. Prove the fix

Rerun the original reproduction or closest real-surface equivalent.

Then run relevant focused and repository-standard validation.

When a repository verification skill exists, use it when it covers the affected runtime path.

## Artifacts

If the investigation is substantial, findings may be recorded in:

```text
.work/active/<work-id>/investigation.md
```

Do not create an artifact merely for ceremony.
