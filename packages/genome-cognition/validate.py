from pathlib import Path
from rdflib import Graph, Namespace, RDF
root=Path(__file__).resolve().parent
G=Graph();G.parse(root/'ontology/genome_cognition_v9.ttl',format='turtle')
GS=Namespace('https://example.org/genome-stack#'); GC=Namespace('https://example.org/genome-cognition#')
assert len(list(G.subjects(RDF.type,GS.LabelObservation)))==7
assert len(set(G.objects(GS.image01,GS.depicts)))==6
assert (GC.cognitionMappingHypothesis,RDF.type,GC.HypothesizedInfluence) in G
assert not list(G.subjects(RDF.type,GC.CognitiveObservation))
for filename,expected in [('01_evidence_boundaries.rq',1),('02_measured_cognition.rq',0),('03_missing_measurement_sources.rq',0),('04_unreviewed_studies.rq',0)]:
 result=list(G.query((root/'sparql'/filename).read_text()))
 assert len(result)==expected,(filename,len(result),expected)
 print(filename,len(result))
print('PASS: seven image labels; six entities; abstract hypothesis; zero measured cognition; four SPARQL checks; triples:',len(G))
