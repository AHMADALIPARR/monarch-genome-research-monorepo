from rdflib import Graph, Namespace, RDF, RDFS, OWL, Literal, XSD
from pathlib import Path
root=Path(__file__).resolve().parent
G=Graph(); G.parse(root.parent/'genome_graph_v8/genome_stack.ttl',format='turtle')
GS=Namespace('https://example.org/genome-stack#'); GC=Namespace('https://example.org/genome-cognition#'); G.bind('gs',GS); G.bind('gc',GC)
classes=['GenomeState','GeneExpressionState','CognitiveState','CognitiveFunction','CognitiveObservation','BiologicalObservation','HypothesizedInfluence','EvidenceRecord','SyntheticTrace','ObservedAssociation','Intervention','ApprovedStudy','SourceGroundedClaim']
props=['hasGenomeState','hasExpressionState','hasCognitiveState','hasCognitiveObservation','hasBiologicalObservation','hypothesizesInfluenceOn','supportedBy','hasEvidenceStatus','hasMeasurementScale','hasValue','hasTimepoint','hasGeneIdentifier','derivedFromModel','hasConsentRecord','hasObservationSource']
for x in classes:G.add((GC[x],RDF.type,OWL.Class))
for x in props:G.add((GC[x],RDF.type,OWL.ObjectProperty if x in ['hasGenomeState','hasExpressionState','hasCognitiveState','hasCognitiveObservation','hasBiologicalObservation','hypothesizesInfluenceOn','supportedBy','derivedFromModel','hasConsentRecord','hasObservationSource'] else OWL.DatatypeProperty))
G.add((GC.CognitiveFunction,RDFS.comment,Literal('Abstract mapping from a biological and environmental state to a cognitive observation distribution; no parameters or causal effects inferred from a schematic.')))
G.add((GC.HypothesizedInfluence,RDFS.comment,Literal('A proposed relation, not proof of causal effect.')))
G.add((GC.imageSchematicModel,RDF.type,GC.EvidenceRecord))
G.add((GC.imageSchematicModel,GC.hasEvidenceStatus,Literal('schematic_only')))
G.add((GC.imageSchematicModel,RDFS.comment,Literal('Inherited illustration observations from Genome Stack v8; these contain no identified gene or measured cognition.')))
G.add((GC.cognitionMappingHypothesis,RDF.type,GC.HypothesizedInfluence))
G.add((GC.cognitionMappingHypothesis,GC.hasEvidenceStatus,Literal('unverified_hypothesis')))
G.add((GC.cognitionMappingHypothesis,RDFS.comment,Literal('Conceptual genome/expression/environment-to-cognition mapping, not an observed or causal molecular relationship.')))
G.add((GC.cognitionMappingHypothesis,GC.supportedBy,GC.imageSchematicModel))
G.add((GC.cognitionMappingHypothesis,GC.derivedFromModel,GC.abstractCognitiveFunction))
G.add((GC.abstractCognitiveFunction,RDF.type,GC.CognitiveFunction))
G.serialize(root/'ontology/genome_cognition_v9.ttl',format='turtle')
G.serialize(root/'ontology/genome_cognition_v9.owl',format='xml')
print('triples',len(G))
