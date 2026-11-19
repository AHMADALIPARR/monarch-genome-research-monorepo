# MONARCH / MKULTRA research: post-recovery cognition model

This is a **research representation**, not a clinical test, treatment protocol, diagnostic tool, or proof that the alleged MONARCH program existed. Historical deprogramming narratives and evidence-based trauma care must remain distinct.

## Two independent model layers

1. **Process invariant:** For a recovery interaction to meet the model's ethical criteria, consent must be present, coercion must be absent, and there must be no pressure to recall memories. This is an explicit normative research requirement; it is **not** an empirical finding about people or a claim of continuous consent across all real-world situations.
2. **Post-recovery cognition:** Observation at each timepoint records agency, orientation, distress, day-to-day functioning, and confidence in memories, on illustrative ordinal scales 0–4. These are **not validated clinical scales** and should not be used to diagnose anyone. Values may improve or worsen. A transition never asserts that recovery must be monotonic.

## Separate epistemic invariant

A recalled memory or the account of being deprogrammed does **not**, on its own, independently verify the historical mechanism alleged to have caused it. `independent_corroboration` is modeled separately from `memory_confidence`.

## Files
- `src/monarch_post_recovery.pl`: standalone SWI-Prolog module and queries
- `src/test_monarch_post_recovery.pl`: plunit test suite
- `data/post_recovery_synthetic_observations.csv`: three **synthetic** records matching `example_trace/1`
- `src/monarch_recovery.pl`, `data/monarch_deprogramming_recovery.csv`: previous historical/recovery-source corpus

## Try in SWI-Prolog

```sh
swipl -q -s src/test_monarch_post_recovery.pl -g run_tests -t halt
swipl -q -s src/monarch_post_recovery.pl
```

```prolog
?- example_trace(T), assess_trace(T, Report).
?- example_trace(T), cognition_after(T, 2, Profile).
?- example_trace([S|_]), recovery_invariant(S, consent_and_noncoercion).
?- example_trace([S|_]), recovery_claim_is_not_proof(S, Verdict).
```

## Validation status
Source and tests were written for SWI-Prolog; SWI-Prolog was not available in the build environment, so runtime test results are **not** claimed.

## Interpreting observations
A low ordinal orientation value is a self-report in this toy model, not clinical evidence of disorientation. In actual research, standardized instruments, informed consent, clear operational definitions, and qualified ethics/clinical oversight are needed. Do not use coercive conditioning, forced memory retrieval, or unverified claims as research interventions.
