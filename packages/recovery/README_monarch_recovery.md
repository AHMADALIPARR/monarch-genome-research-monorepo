# Deprogramming / recovery research extension

## Data / interpretation
`data/monarch_deprogramming_recovery.csv` contains 17 source-attributed recovery and memory-verification claims. `src/monarch_recovery.pl` is an add-on module that keeps these claims distinct from conditioning and coercion allegations in the earlier corpus.

**MONARCH has not been established as a documented CIA program.** Cathy O’Brien/Mark Phillips and Brice Taylor narratives are their self-published claims. This project records them as testimony, not as verified scientific deprogramming techniques. The clinical rows are drawn from professional guidelines and research; they are not proof of an alleged program.

## Schema
`recovery_id,story_id,framework,stage,claim_text,reported_practice,reported_outcome,evidence_class,source_url,verification_note`

`story_id` is blank for general clinical evidence. A shared URL or repeated allegation is **not independent corroboration**. `research_design_inference` records a proposed analytic convention rather than a published finding.

## SWI-Prolog queries
```
?- [monarch_recovery].
?- load_recovery('data/monarch_deprogramming_recovery.csv').
?- count_recovery(N).
?- narrative_recovery(ID, Claim).
?- clinical_recovery(ID, Claim).
?- story_recovery('S018', ID).
?- recovery_claim_review(ID, Flag).
?- shared_recovery_source(A, B).
```

There is no SWI-Prolog installation in this environment, so the Prolog module has been structurally written but not runtime-verified. The CSV was generated directly, rather than falsely presenting it as Prolog-produced output.

## Research invariants (proposed, not established psychology)
- `source_identity`: each claim retains the URL and evidence class it came from.
- `no_promotion`: a self-published claim cannot automatically become `documented_historical_event` via repetition or source clustering.
- `no_conflation`: a clinical treatment recommendation does not entail that the alleged MONARCH program existed.
- `memory_epistemics`: recovering a memory is not automatically equivalent to independent validation of the memory's content.

## Main sources
- O'Brien and Phillips, *TRANCE Formation of America*, publisher summary: https://trance-formation.com/product/trance-formation-of-america/
- Phillips narrative excerpt: https://www.rulit.me/books/trance-formation-of-america-w-o-documents-read-65453-8.html
- Taylor, *Thanks for the Memories* (author text): https://www.rulit.me/books/thanks-for-the-memories-read-64757-136.html
- ISSTD adult DID treatment guidelines: https://www.isst-d.org/publications-resources/resources-for-professionals/adult-treatment-guidelines/
- Systematic review: https://pmc.ncbi.nlm.nih.gov/articles/PMC12406319/
- VA PTSD treatment guidance: https://ptsd.va.gov/professional/treat/txessentials/overview_therapy.asp
- APA and memory accuracy: https://www.apa.org/topics/trauma/memories.aspx?item=4
