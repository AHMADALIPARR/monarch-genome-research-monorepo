# STATUS — monarch-genome-research-monorepo

Verification scope and known limits. Plain facts; what was run, on what,
and what is not covered.

## How the repo got complete (2026-11-18)

Grok pushed 6 fragment repos to GitHub, but the GitHub copies were
incomplete — Grok never pushed the ontologies, the chronology Lean file,
the NDE test, the historical facts, or most of the SPARQL queries. The
owner supplied the 9 original source bundles as zip files. Those zips are
the ground truth. The missing files were folded in from them (40 files),
and the content was verified by execution. The GitHub fragment repos were
deleted after the fold-in; the zips are the surviving source.

## Verified by execution (this VM, 2026-11-18)

Run with `make check`. All runnable checks pass; absent tools are
reported as SKIP, not hidden.

- **C — torus simulation.** `gcc 13.3.0`, `-O2 -std=c11 -Wall -Wextra`.
  `packages/torus-chronology/src/monarch_torus_sim.c` compiles and runs,
  exit 0, prints its PASS line, and writes `torus_synthetic_trace.csv`
  and `torus_entropy_metrics.csv`. Both regenerated files diff
  byte-identically against the committed records in
  `packages/torus-chronology/data/`.
- **Lean 4 — 3 standalone files.** `lean` 4.12.0 (elan). The three files
  typecheck with 0 errors and import nothing, so plain `lean` suffices
  (no Mathlib project needed):
  `packages/hermetic-graph/lean/HermeticGraphBridge.lean`,
  `packages/genome-cognition/lean/GenomeCognitionBridge.lean`,
  `packages/nde-v10/lean/NearDeathCognition.lean`.
- **SWI-Prolog — 9 files.** `swipl` 9.0.4. Every `.pl` file consult-loads
  with no ERROR output. The post-recovery plunit suite passes 10/10 and
  the genome-cognition plunit suite passes. The GCP goal
  `well_formed(0)` succeeds. The torus evidence predicates resolve:
  `source_supported('S001')` succeeds against the historical facts,
  `reported_association('S001', drug_exposure, textual_mention_only)`
  succeeds, and `correlation_ready('S001')` fails cleanly (by design —
  no paired, calibrated clinical scores exist).
- **Python — SPARQL suites.** `python3` 3.12.3 with `rdflib` 7.6.0.
  The genome-stack suite passes 20/20 (`test_queries.py`), the NDE suite
  passes 5/5 plus the sampleSize assertion (`test_nde.py`), and the
  genome-cognition validator passes (`validate.py`). `query.py` runs real
  queries against `genome_stack.ttl` and returns rows.

## Repairs made during the fold-in (source files are verbatim from the
## owner's zips; only the integration points below were changed)

- **Historical facts wired in.** `packages/torus-chronology/src/monarch_historical_facts.pl`
  (22 `historical_case/5` facts, 28 `case_effect/3` facts) was in the
  zips but never pushed to GitHub, so the torus evidence predicates
  errored. It now lives in `torus-chronology/src/` and is imported by
  `monarch_torus_analysis.pl`. Two lines were added to the facts file
  (`:- encoding(utf8).` and the `:- module(...)` header) so it loads
  cleanly as a module; the facts themselves are verbatim. The two
  predicate names were restored to the analysis module's export list.
- **Three SPARQL queries fixed to match their ontologies.**
  `genome-stack/sparql/01_visible_labels.rq` asked for `rdfs:label`,
  which no triple uses; it now asks for `gs:visibleText` on
  `gs:LabelObservation` (7 rows). `genome-stack/sparql/02_depicted_entities.rq`
  listed every typed entity (31 rows); it now selects the entities
  `gs:image01` depicts (6 rows). `nde-v10/sparql/01_studies.rq` used the
  wrong namespace (`nde#` instead of `nde-research#`), the wrong class
  (`Study` instead of `NDEStudy`), and the wrong property (`year` instead
  of `studyYear`), and it asked for `sourceURL` on the study where it
  lives on the source document; it now joins through `nde:hasSource` and
  makes `sampleSize` OPTIONAL (one study has none), returning 4 rows.
  The other 26 SPARQL queries were already correct against their
  ontologies and were not changed.
- **Claims export predicates restored.** The GitHub copy of
  `packages/claims-corpus/src/monarch_claims.pl` had the export
  predicates (`export_claims/1`, `export_source_clusters/1`,
  `export_shared_sources/1`, `run/0`) declared but their definitions
  stripped out. The owner's zips carry the complete 95-line file with
  the definitions. It is restored verbatim; `run/0` loads the seed CSV
  and writes `monarch_claims.csv`, `monarch_source_clusters.csv`, and
  `monarch_shared_sources.csv`. Loading the restored seed now yields
  22 stories.
- **Torus sim restored to the complete version.** The GitHub copy of
  `packages/torus-chronology/src/monarch_torus_sim.c` was a 46-line
  variant that printed the metrics to stdout, hardcoded the throat
  fraction to 0.0, and wrote the trace in a different format. The
  owner's zips carry the complete 53-line version, which writes
  `torus_synthetic_trace.csv` and `torus_entropy_metrics.csv` as files
  and asserts the Shannon bound. It is restored verbatim. Running it
  regenerates both recorded files byte-identically (verified by diff),
  and `make check` diffs the regenerated outputs against the committed
  records.
- **Two truncated CSVs restored.** The GitHub copy of
  `packages/claims-corpus/data/monarch_mkultra_stories_seed.csv` had
  only 4 lines (3 stories); the zips carry the full 23 lines (22
  stories, S001–S022, matching the 22 historical facts). It is restored.
  `packages/recovery/data/monarch_deprogramming_recovery.csv` had 15
  lines; the zips carry 18. It is restored.
- **Recorded trace committed as data.**
  `packages/torus-chronology/data/torus_synthetic_trace.csv` (36 synthetic
  time steps) is the sim's recorded output, referenced by the v4 README.
  It is committed as data. The `.gitignore` entry for the trace is now
  anchored to the repo root only, so a stray run from the root stays
  ignored while the data copy stays tracked. `make check` runs the sim
  from /tmp.
- **Plunit import.** `packages/post-recovery/src/test_monarch_post_recovery.pl`
  uses `begin_tests`/`end_tests`/`run_tests` but never imported the plunit
  library, so the suite could not run at all. `:- use_module(library(plunit)).`
  was added at the top. The suite now runs and passes 10/10.

## Known limits (not covered by `make check`)

- **NewtonPyramidChronology.lean needs Mathlib.**
  `packages/torus-chronology/lean/NewtonPyramidChronology.lean` imports
  `Mathlib.Data.Real.Basic`, `Mathlib.Topology.MetricSpace.Basic`, and
  `Mathlib.Tactic.Linarith`, so it needs a lake project with Mathlib to
  typecheck. It is present in the repo (folded in from the owner's zips)
  but has not been typechecked on this VM yet. It is NOT covered by
  `make check`'s plain-`lean` step.
- **CBQN not run here.** `bqn` is not installed on this VM, so
  `packages/hermetic-graph/bqn/HermeticGraph.bqn` was not executed.
  `make check` reports it as SKIP. The Lean counterpart
  (`HermeticGraphBridge.lean`) typechecks.

## Toolchain versions used for the verification above

gcc 13.3.0, Lean 4.12.0 (elan), SWI-Prolog 9.0.4, Python 3.12.3,
rdflib 7.6.0. `make check` detects tools and skips absent ones; a skip is
not a pass.
