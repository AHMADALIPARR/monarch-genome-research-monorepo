# Monarch / Genome Research Monorepo

[![check](https://github.com/AHMADALIPARR/monarch-genome-research-monorepo/actions/workflows/check.yml/badge.svg)](https://github.com/AHMADALIPARR/monarch-genome-research-monorepo/actions/workflows/check.yml)
[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

**This is the single canonical repository.** All research stages (claims corpus through GCP import) live here under `packages/`. Earlier separate repositories created during development were deleted.

Production monorepo for a provenance-first research pipeline. It moves from historical claims corpora through recovery annotation, post-recovery cognition models, torus geometry, Lean chronology, hermetic graph recursion, a genome-stack SPARQL engine, a genome-cognition bridge, near-death experience study summaries, and a Global Consciousness Project historical aggregate import.

**License:** GNU Affero General Public License v3.0 (see [LICENSE](LICENSE))

## Repository layout

```
README.md                    # this file: what the repo is, how to validate it
LICENSE                      # GNU Affero General Public License v3.0
Makefile                     # `make check`: one command validates the whole repo
STATUS.md                    # verification scope and known limits (plain facts)
.github/workflows/check.yml  # CI: runs `make check` on push and pull request
packages/
├── claims-corpus/          # seed stories, extracted claims, Prolog
├── recovery/               # deprogramming / recovery claims
├── post-recovery/          # state-machine cognition model + plunit tests
├── torus-chronology/       # C torus sim, Prolog analysis, entropy metrics
├── hermetic-graph/         # Lean + BQN two-node witness
├── genome-stack/           # reconstructed CRISPR schematic ontology + SPARQL
├── genome-cognition/       # genome/cognition bridge
├── nde-v10/                # near-death study summaries (ontology, Prolog, Lean, SPARQL)
└── gcp-import-v11/         # GCP 15-minute historical aggregate sample + Prolog
```

## Epistemic Contract

Source attribution is not verification. Shared sources are not independent corroboration. Recovered narratives, synthetic traces, algebraic identities, and aggregate statistics are not historical or clinical proof. Every package preserves originating URLs and evidence classes. No automated step may raise epistemic status.

## Validation

One command validates the whole repo. Tools are detected, never assumed;
a missing tool is reported as SKIP, not hidden and not a pass.

```sh
make check
```

`make check` runs, per package, with its real toolchain:

- **C** — the torus simulation compiles (`gcc -O2 -std=c11`) and runs.
- **Lean 4** — the three standalone files typecheck (`lean`, no imports,
  no Mathlib project needed). A fourth Lean file,
  `packages/torus-chronology/lean/NewtonPyramidChronology.lean`, imports
  Mathlib and needs a lake project to typecheck; see STATUS.md.
- **SWI-Prolog** — all nine `.pl` files consult-load with no ERROR, the
  post-recovery plunit suite passes 10/10, the genome-cognition plunit
  suite passes, the GCP `well_formed(0)` goal succeeds, and the torus
  evidence predicates resolve against the historical facts.
- **Python** — the SPARQL suites run against the ontologies now in the
  repo (needs `rdflib>=7`): the genome-stack suite passes 20/20, the
  NDE suite passes 5/5, and the genome-cognition validator passes.
- **CBQN** — the hermetic graph witness runs when `bqn` is installed.

Individual targets: `make check-c`, `make check-lean`, `make check-prolog`,
`make check-python`, `make check-bqn`. See STATUS.md for what was actually
verified by execution and the known limits.

## Installation

Clone the repository and install the runtimes you need. Not every package requires every tool.

```sh
git clone https://github.com/AHMADALIPARR/monarch-genome-research-monorepo.git
cd monarch-genome-research-monorepo
```

### Python (genome-stack)

Requires Python 3.9+ and `rdflib>=7`.

```sh
python3 -m pip install 'rdflib>=7'
python3 packages/genome-stack/query.py list
```

### SWI-Prolog (claims-corpus, recovery, post-recovery, torus analysis, genome-cognition, nde-v10, gcp-import-v11)

Install SWI-Prolog 9.x from https://www.swi-prolog.org/ or your package manager (`brew install swi-prolog`, `apt install swi-prolog`, etc.).

```sh
swipl -q -s packages/gcp-import-v11/gcp_observations.pl
# then at the prompt:
# ?- well_formed(0).
```

### Lean 4 (hermetic-graph, genome-cognition, nde-v10)

Install Lean 4 and elan (https://leanprover.github.io/lean4/doc/setup.html).
The three Lean files import nothing, so plain `lean` typechecks them:

```sh
lean packages/hermetic-graph/lean/HermeticGraphBridge.lean
lean packages/genome-cognition/lean/GenomeCognitionBridge.lean
lean packages/nde-v10/lean/NearDeathCognition.lean
```

### CBQN (hermetic-graph BQN)

Install CBQN from https://github.com/dzaima/CBQN or your package manager.

```sh
bqn packages/hermetic-graph/bqn/HermeticGraph.bqn
```

### C compiler (torus simulation)

Any C11 compiler (gcc, clang).

```sh
cc -O2 -o torus_sim packages/torus-chronology/src/monarch_torus_sim.c -lm
./torus_sim
```

## Pipeline Overview

### Claims Corpus
Seed CSV of story rows is deterministically extracted into source-attributed claim fragments (summary, reported method, outcome, caveat). Clustering and shared-source pairs use exact URL match and are marked non-independent. Prolog provides load, claim, cluster, shared-source, and needs-review predicates. No program existence is asserted.

### Recovery Extension
Deprogramming and memory-verification claims stay in a separate table. Self-published narratives remain labeled as such. Clinical guidance stays in its professional class. Shared URLs are recorded but never treated as independent corroboration.

### Post-Recovery Cognition
Observational traces record consent, coercion, recall pressure, and ordinal self-report scores together with an independent-corroboration flag. The process invariant requires consent and the absence of coercion and pressure. Cognition may fluctuate. Proof requires verified independent corroboration. Scores are not validated clinical instruments.

### Torus Simulation and Entropy
Deterministic C code integrates agency and distress changes into angles on a flat 2-torus, builds occupancy histograms, and computes Shannon entropy. The "throat" is an analysis region of the flat torus, not a wormhole. All output is labeled synthetic. Prolog reimplements distances and entropy bounds and refuses correlation without calibrated scores. The historical facts (`monarch_historical_facts.pl`, 22 cases and 28 effect links) are wired into the analysis module, so the source-link predicates (`source_supported/1`, `reported_association/3`) resolve.

### Chronology Predicates
Lean defines a sovereign theta, a chronological state, and a closure predicate. Refined structures make an epoch-anchor flag explicit. Dated arithmetic (800 + 1260 = 2060) is proved by decision procedures. Historical interpretations remain external hypotheses. The chronology Lean file `packages/torus-chronology/lean/NewtonPyramidChronology.lean` imports Mathlib and needs a lake project to typecheck; see STATUS.md.

### Hermetic Graph Recursion
Adjacency swaps vertices; a diagonal operator labels them 89 and 2462. Commutator on (1, 0) is (0, -2373). Orbit has period 2. Implemented in Lean (proved) and BQN (asserted). Purely algebraic.

### Genome Stack Query Engine
Reconstructed CRISPR schematic ontology under a fixed example namespace. Python runner accepts only SELECT/ASK and rejects updates and remote SERVICE. Numbered SPARQL queries cover labels, cleavage, repair, architecture, and missing records. No gene sequences or confirmed edits. The ontology file `genome_stack.ttl` is in this repo and all 20 SPARQL queries run against it (`python3 packages/genome-stack/test_queries.py`).

### Genome-Cognition Bridge
Loads the genome-stack ontology unchanged and extends it. Cognitive phenotype is the abstract conditional P(C_(t+1) | G_t, E_t, X_t, C_t). Hypotheses are unverified; bases are schematic-only. Lean shows genome identity need not preserve cognition. Prolog refuses causal conclusions.

### Near-Death Experience Studies (v10)
Four source-attributed study summaries (van Lommel 2001, Parnia AWARE I 2014, Parnia AWARE II 2023, Xu et al. 2023). Counts are aggregate descriptions, not new individual-level observations. Ontology, Prolog, Lean, SPARQL, and tests preserve provenance. Shared measurement dimensions with other packages do not imply common causes. Lean properties are internal model facts, not proof of consciousness surviving death. NDE and genome classes remain separate.

### Global Consciousness Project Import (v11)
32 rows of published 15-minute network aggregates from 1 January 1999 (first 8 hours), transcribed from the official egg-summary table. Not raw 1-second device output. Prolog facts and basic numeric invariants (0 ≤ Ones ≤ Trials). Recomputed signed Z uses theoretical half-trial expectation and does not replicate GCP's empirically normalized statistic. No significance claims are made from this small slice. Correlation or fluctuation alone does not establish a global-consciousness mechanism.

## Cross-Layer Invariants

- Source identity travels with every claim.
- Shared sources remain non-independent.
- Synthetic, algebraic, and aggregate results stay labeled as such.
- No package raises another's epistemic status without external review.
- Formal proofs establish properties of definitions, not historical or clinical facts.
- Shared measurement dimensions do not imply identical causes.

## What This Pipeline Does Not Claim

Existence of an operational program, efficacy of deprogramming techniques, clinical validity of ordinal scales, physical wormhole, noncommutative physical parameter, causal genome-to-cognition mapping, consciousness surviving death, or a global-consciousness mechanism. No authorization for biological experimentation.

## Next Refinements

Passage-level identifiers, atomic claim decomposition, controlled human-review status elevation, Mathlib project wrappers, and CI for Python validation plus available Prolog suites.

---

*All modules remain subject to the interpretive contract above.*
