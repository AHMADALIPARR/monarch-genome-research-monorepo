from pathlib import Path
from rdflib import Graph, Namespace
root = Path(__file__).parent
g = Graph().parse(root / 'nde_extension.ttl', format='turtle')
expected = {'01_studies.rq':4,'02_limitations.rq':4,'03_study_counts.rq':4,'04_missing_cognitive_measure.rq':4,'05_unattributed_claims.rq':0}
for f, n in expected.items():
    rows=list(g.query((root/'sparql'/f).read_text()))
    assert len(rows)==n,(f,len(rows),n)
    print(f, len(rows), 'PASS')
nde=Namespace('https://example.org/nde-research#')
assert int(g.value(nde.NDE001, nde.sampleSize)) == 344
print('Source-linked NDE test suite PASS')
