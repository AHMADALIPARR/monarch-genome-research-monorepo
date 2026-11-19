# V10 and V11 modules only

Copy `v10_nde/` and `gcp_import_v11/` into your existing monorepo. V10 has a near-death research ontology, Prolog, Lean, SPARQL, CSV, and tests. V11 contains GCP 15-minute historical CSV, Prolog, source registry, and README. No v1–v9 files included.

V10 test: `python3 v10_nde/test_nde.py` (rdflib required). V11 Prolog: `swipl -q -s gcp_import_v11/gcp_observations.pl`.

The GCP CSV is a 32-row 15-minute historical aggregate sample, not original one-second RNG output.
