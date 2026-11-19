# Monarch / Genome Research Monorepo

Production-style monorepo for the full provenance-first research pipeline. It organizes historical claims extraction, recovery annotation, post-recovery cognition modeling, torus geometry and entropy, Lean chronology predicates, hermetic graph recursion, a genome-stack SPARQL engine, and a genome-cognition bridge.

**License:** GNU Affero General Public License v3.0 (see [LICENSE](LICENSE))

All layers share one interpretive contract: source attribution is not verification, shared sources are not independent corroboration, and recovered or modeled narratives are not historical proof.

## Table of Contents

1. [Epistemic Stance](#epistemic-stance)
2. [Monorepo Layout](#monorepo-layout)
3. [Claims Corpus](#claims-corpus)
4. [Recovery Extension](#recovery-extension)
5. [Post-Recovery Cognition](#post-recovery-cognition)
6. [Torus Simulation and Entropy](#torus-simulation-and-entropy)
7. [Chronology Predicates](#chronology-predicates)
8. [Hermetic Graph Recursion](#hermetic-graph-recursion)
9. [Genome Stack Query Engine](#genome-stack-query-engine)
10. [Genome-Cognition Bridge](#genome-cognition-bridge)
11. [Cross-Layer Invariants](#cross-layer-invariants)
12. [Build and Validation](#build-and-validation)
13. [What This Pipeline Does Not Claim](#what-this-pipeline-does-not-claim)
14. [Next Refinements](#next-refinements)

## Epistemic Stance

Every package preserves the originating URL, evidence class, and epistemic status of its inputs. No automated step may promote a self-published narrative, a synthetic trace, or an algebraic identity into a documented historical or clinical fact. Prolog modules contain explicit `fail` goals for causal conclusions. Lean modules are accompanied by comments that limit their interpretation to the definitions they formalize. SPARQL runners reject updates and remote SERVICE clauses.

## Monorepo Layout

```
packages/
├── claims-corpus/          # seed CSV, extracted claims, source clusters, Prolog
├── recovery/               # deprogramming / recovery claims and module
├── post-recovery/          # state-machine cognition model + plunit tests
├── torus-chronology/       # C torus sim, Prolog analysis, Lean chronology
├── hermetic-graph/         # Lean + BQN two-node witness
├── genome-stack/           # OWL/TTL reconstruction, SPARQL queries, query.py
└── genome-cognition/       # bridge ontology, Prolog, Lean, validation scripts
```

Each package owns its data, source, and tests. Cross-package coupling is limited to documented imports (the v9 ontology loads the v8 Turtle unchanged).

## Claims Corpus

The pipeline begins with a seed CSV of story rows. A deterministic extraction produces claim fragments (summary, reported method, outcome/limit, research caveat). Each claim carries an evidence status and the epistemic label `source_attributed`. Source clustering and shared-source pairs are computed by exact URL match and are explicitly marked as non-independent. The Prolog module implements load, claim lookup, cluster, shared-source, and needs-review predicates. It does not assert that any program existed.

## Recovery Extension

Recovery and memory-verification claims are kept in a separate table and module. Narrative rows from self-published accounts remain labeled as such. Clinical guidance rows (treatment guidelines, systematic reviews, memory-accuracy statements) stay in their professional-guideline class. Shared URLs are recorded but never treated as independent corroboration. A self-published claim cannot be promoted by repetition.

## Post-Recovery Cognition

Observational traces are sequences of states that record consent, coercion, recall pressure, and ordinal self-report scores (agency, orientation, distress, function, memory confidence) together with an independent-corroboration flag. The process invariant requires consent and the absence of coercion and recall pressure. Cognition may fluctuate. The proof predicate returns “requires independent evidence” unless the corroboration flag is verified. Synthetic observation rows match the example trace used by the test suite. Scores are not validated clinical instruments.

## Torus Simulation and Entropy

A deterministic C program integrates changes in agency and distress into angular coordinates on a flat 2-torus, builds occupancy histograms, and computes Shannon entropy. A “throat” region is defined as a small neighborhood around (π, π) and is an analysis region of the flat torus, not a physical wormhole. All output is labeled synthetic. The companion Prolog module reimplements circular distance, mixture entropy, and the Shannon bound, and refuses correlation claims when calibrated clinical scores are absent.

## Chronology Predicates

The Lean module defines a sovereign theta constant, a chronological state, and a closure predicate based on cubit and duration conditions. The retained theorem name does not prove that an epoch anchor is necessary; a refined structure makes the anchor flag explicit. Dated arithmetic (start 800, interval 1260, terminus 2060) is stated directly and proved by decision procedures. Historical, biblical, or metrological interpretations remain hypotheses external to the proofs.

## Hermetic Graph Recursion

A two-node witness uses an adjacency operator that swaps vertices and a diagonal operator that labels them with 89 and 2462. Their commutator on (1, 0) is (0, -2373). Orbit under adjacency has period 2. Identical algebra is implemented in Lean (proved by `decide`) and in BQN (checked by assertions). The construction is purely algebraic and does not imply physical noncommutativity or historical coupling.

## Genome Stack Query Engine

A reconstructed CRISPR schematic ontology lives under a fixed example namespace. The RDF/XML and Turtle files are reconstructions, not byte-for-byte copies. A Python runner accepts only SELECT and ASK queries, rejects updates and remote SERVICE, and uses a standard RDF library. Numbered SPARQL files cover labels, cleavage, repair, architecture layers, missing review, and mapping records. No gene sequences or confirmed edits are present. The ontology does not imply biological causation for any other package in the monorepo.

## Genome-Cognition Bridge

The bridge loads the genome-stack ontology unchanged and extends it with a cognition namespace. A cognitive phenotype is represented as the abstract conditional probability of next cognition given genome, expression, environment/history, and current cognition. Hypotheses are marked unverified; cited bases are marked schematic-only. The Lean counterexample shows that identical genome identifiers need not preserve cognition scores. The Prolog module records bounded observations and evidence tiers and refuses causal conclusions. No sequence design or editing authorization is present.

## Cross-Layer Invariants

- Source identity travels with every claim.
- Shared sources remain non-independent.
- Synthetic and algebraic results stay labeled as such.
- No package may raise the epistemic status of another package’s outputs without an explicit external review record.
- Formal proofs establish properties of definitions, not historical or clinical facts.

## Build and Validation

Package-local entry points:

- Claims: SWI-Prolog load and run goals against the seed CSV.
- Post-recovery: plunit suite on the example trace.
- Genome stack: `python query.py list` and individual numbered queries (requires rdflib).
- Hermetic graph: BQN file or Lean module.
- Chronology and bridge: Lean files in a Mathlib project.

SWI-Prolog, Lean, and CBQN were not available in the original authoring environment; runtime results are not claimed. Python validation can be run wherever rdflib is installed.

## What This Pipeline Does Not Claim

It does not claim the existence of an operational program, the efficacy of any deprogramming technique, the clinical validity of the ordinal scales, a physical wormhole, a noncommutative physical parameter, a causal genome-to-cognition mapping, or authorization for biological experimentation.

## Next Refinements

- Passage-level source identifiers and speaker/author IDs.
- Decomposition of multi-assertion summaries into atomic triples.
- An explicit human-review table for controlled status elevation.
- Mathlib project wrappers for the Lean modules.
- Continuous integration for the Python validation and available Prolog suites.

---

*All modules remain subject to the interpretive contract above.*
