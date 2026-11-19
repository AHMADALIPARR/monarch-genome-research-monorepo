from pathlib import Path
from rdflib import Graph
root=Path(__file__).parent
g=Graph();g.parse(root/'genome_stack.ttl')
expected={'01_visible_labels':7,'02_depicted_entities':6,'03_duplicate_labels':1,'04_cleavage':1,'05_cleavage_pam':1,'06_repair':1,'07_cleavage_repair_join':1,'08_source_locator':1,'09_interpretation_annotations':7,'10_missing_claim_basis':0,'11_architecture_layers':6,'12_architecture_order':6,'13_ingestion_reaches_audit':True,'14_review_proposals':1,'15_missing_review':0,'16_mapping_records':0,'17_mapping_missing_fields':0,'18_missing_sequence':3,'19_classes':25,'20_object_properties':15}
for name,want in expected.items():
 q=(root/'sparql'/(name+'.rq')).read_text()
 res=g.query(q)
 got=bool(res.askAnswer) if res.type=='ASK' else len(list(res))
 assert got==want,(name,got,want)
 print('PASS',name,got)
