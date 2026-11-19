# STATUS — monarch-genome-research-monorepo

Verification scope and known limits. Plain facts; what was run, on what,
and what is not covered.

## Verified by execution (this VM, 2026-11-18)

Run with `make check`. All runnable checks pass; absent tools are
reported as SKIP, not hidden.

- **C — torus simulation.** `gcc 13.3.0`, `-O2 -std=c11 -Wall -Wextra`.
  `packages/torus-chronology/src/monarch_torus_sim.c` compiles and runs,
  exit 0, and prints its CSV table (header plus baseline / modeled_impact /
  modeled_recovery rows).
- **Lean 4 — 3 files.** `lean` 4.12.0 (elan). The three files typecheck
  with 0 errors and import nothing, so plain `lean` suffices (no Mathlib
  project needed):
  `packages/hermetic-graph/lean/HermeticGraphBridge.lean`,
  `packages/genome-cognition/lean/GenomeCognitionBridge.lean`,
  `packages/nde-v10/lean/NearDeathCognition.lean`.
- **SWI-Prolog — 7 files.** `swipl` 9.0.4. Every `.pl` file consult-loads
  with no ERROR output. The post-recovery plunit suite passes 10/10
  (`packages/post-recovery/src/test_monarch_post_recovery.pl`). The GCP
  goal `well_formed(0)` succeeds.
- **Python — SPARQL runner.** `python3` 3.12.3 with `rdflib` 7.6.0.
  `packages/genome-stack/query.py list` runs and lists the two SPARQL
  queries. A real query is not runnable (see below).

## Known limits (not covered by `make check`)

- **Genome-stack ontology is missing.** `packages/genome-stack/query.py`
  defaults to `packages/genome-stack/genome_stack.ttl`, which is not in
  this repo. A real SPARQL query fails at the ontology parse. Only
  `query.py list` is runnable. The ontology file was never pushed; it is
  not reconstructed here.
- **Torus evidence predicates error at runtime.**
  `packages/torus-chronology/src/monarch_torus_analysis.pl` defines
  `source_supported/1`, `correlation_ready/1`, and `reported_association/3`,
  but they call `historical_case/5` and `case_effect/3`, which were never
  defined — no fact loader for them was written. Calling any of the three
  raises `existence_error(procedure, historical_case/5)` (or `case_effect/3`).
  The module's math predicates (`torus_angle`, `torus_distance`,
  `entropy_bits`, `mixture_entropy`, `entropy_bound`, `example_checks`)
  all work. The two undefined names were removed from the module's export
  list so it no longer promises what it lacks.
- **CBQN not run here.** `bqn` is not installed on this VM, so
  `packages/hermetic-graph/bqn/HermeticGraph.bqn` was not executed.
  `make check` reports it as SKIP. The Lean counterpart
  (`HermeticGraphBridge.lean`) typechecks.
- **Two files the old README named do not exist.**
  `packages/nde-v10/test_nde.py` and
  `packages/torus-chronology/lean/NewtonPyramidChronology.lean` were
  referenced by the README but were never in the repo. The references were
  removed; the files were not invented.
- **Claims export predicates.** `packages/claims-corpus/src/monarch_claims.pl`
  declared `export_claims/1`, `export_source_clusters/1`,
  `export_shared_sources/1`, and `run/0` in its export list, but none of
  them is defined anywhere in the repo and nothing calls them. They were
  removed from the export list. The remaining exports
  (`load_corpus/1`, `story/16`, `claim/7`, `source_cluster/2`,
  `shared_source/2`, `possible_corrob/2`, `claim_needs_review/2`) are all
  defined and the file consult-loads with no ERROR.
- **Plunit import.** `packages/post-recovery/src/test_monarch_post_recovery.pl`
  uses `begin_tests`/`end_tests`/`run_tests` but never imported the plunit
  library, so the suite could not run at all. `:- use_module(library(plunit)).`
  was added at the top. The suite now runs and passes 10/10.

## Toolchain versions used for the verification above

gcc 13.3.0, Lean 4.12.0 (elan), SWI-Prolog 9.0.4, Python 3.12.3,
rdflib 7.6.0. `make check` detects tools and skips absent ones; a skip is
not a pass.
