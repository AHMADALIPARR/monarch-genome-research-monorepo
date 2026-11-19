# MONARCH / MKULTRA provenance-first claim corpus

Seed: `data/monarch_mkultra_stories_seed.csv` (22 case/story rows, 15 input fields).

Extracted: `data/monarch_claims.csv` (98 attributed text fragments); `data/monarch_source_clusters.csv` (10 distinct URLs); `data/monarch_shared_sources.csv` (30 pairs of stories that cite an identical URL).

`src/monarch_claims.pl` is an SWI-Prolog program that reads the source CSV, extracts summary, individual reported-method, outcome/caveat fragments, clusters by exact URL, and lists pairs with shared citations. The accompanying CSV files were generated using an equivalent deterministic transformation because SWI-Prolog was not installed in this environment; **the Prolog source has not been runtime-tested here**.

## Run

Install SWI-Prolog 9.x. In the folder with these files:

```sh
swipl -q -s src/monarch_claims.pl -g monarch_claims:run -t halt
```

Explore it interactively:

```prolog
?- [monarch_claims].
?- load_corpus('data/monarch_mkultra_stories_seed.csv').
?- shared_source('S005', Other).
?- source_cluster(URL, StoryIds).
?- claim_needs_review(StoryId, Why).
?- claim(ClaimID, StoryID, Type, Text, EvidenceStatus, URL, EpistemicStatus).
```

## Interpretive contract

* A claim row is a verbatim field or semicolon-separated reported-method fragment from the **seed**, not independently verified testimony.
* `source_attributed` means the fragment has a linked source URL, **not** that the linked document was checked against the exact wording, and **not** that a claim is true.
* `same_source` means two entries use the same URL; it is **not** independent corroboration. Different URLs also do not automatically establish source independence.
* Some summaries may contain multiple factual sub-assertions. These are not yet manually or syntactically decomposed into atomic subject–predicate–object propositions. Method fragments should be read as claims of method use, not evidence of effectiveness.
* The stories mix declassified/documented cases, historical synthesis, personal testimony, and unverified MONARCH narratives. This script does not infer that Project MONARCH existed or that reliable control was demonstrated.
* Next refinement: source-document passage IDs, speaker/author IDs, claim-level page references, assertion triples, direct-support vs cites-another-source relations, and evidence review by a human researcher.
