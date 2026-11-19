# Genome as a Cognitive Function — v9 research bridge

## Model

A cognitive phenotype is represented abstractly as a probabilistic mapping

`P(C_(t+1) | G_t, E_t, X_t, C_t)`

where G = genome, E = expression state, X = environment and history, and C = cognition measurements. This is **not** an identified or calibrated physical function; no effect of a particular gene is claimed. The supplied CRISPR image shows molecular machinery and does not establish any cognitive gene, gene sequence, edited participant, or clinical outcome.

The existing v8 ontology is loaded unchanged, then extended under `https://example.org/genome-cognition#`. A hypothesis is marked `unverified_hypothesis`; its cited basis is marked `schematic_only`. No actual cognitive measurements or human studies are added.

## Files

- `ontology/genome_cognition_v9.ttl`: fully combined v8/v9 graph.
- `ontology/genome_cognition_v9.owl`: RDF/XML serialization.
- `sparql/*.rq`: four read-only safety/provenance queries.
- `prolog/genome_cognition.pl`: bounded-state observations, provenance classes, no causal promotion.
- `prolog/test_genome_cognition.pl`: five illustrative tests.
- `lean/GenomeCognitionBridge.lean`: counterexample showing genome identity does not imply cognition identity, bounded scores, and evidence requirements.
- `build.py`: regeneration using the preceding v8 Turtle graph.

## Checks

Run `python build.py` then `python validate.py`; tests use rdflib. SWI-Prolog and Lean require their own respective runtimes. No genome editing, target selection, sequence design, or autonomous authorization is present.

The theorem `genome_preserved` is **not** a statement about the permanence or reversibility of any real intervention. It only concerns two synthetic records with equal genome identifiers.
