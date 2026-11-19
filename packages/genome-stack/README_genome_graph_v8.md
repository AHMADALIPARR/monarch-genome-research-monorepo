# Genome Stack v8 — local read-only SPARQL query engine

This extension reconstructs the **user-described** CRISPR schematic ontology with the exact `https://example.org/genome-stack#` namespace. The original OWL attachment was not accessible, so the RDF/XML and Turtle files are **reconstructions**, not byte-for-byte copies. No gene sequences, real genome coordinates, confirmed edits, biological approvals, or physical outcomes have been inferred.

## Run

```sh
python -m pip install 'rdflib>=7'
python query.py list
python query.py 01_visible_labels
python query.py 13_ingestion_reaches_audit
python query.py 09_interpretation_annotations --csv
python query.py sparql/18_missing_sequence.rq
python test_queries.py
```

`query.py` parses the local ontology only and rejects mutation and remote SERVICE operations. It uses a standard RDF query library rather than inventing a new SPARQL parser. The biological design is descriptive and does not authorize experimentation.

## Corpus expectations

* 7 label occurrences, representing 6 schematic entities.
* `gs:target` has two image-label observations.
* 7 annotated biological relations; missing annotations query should return zero results.
* 6 architecture layers and a path from ingestion to audit.
* Zero actual mapping records; no recorded DNA/RNA sequences.
* Proposal contains a required-review link, not an approval record.

Historical MKULTRA claims, post-recovery cognition, and chronology are **separate named research domains**. This ontology does not imply biological causation for those studies.
