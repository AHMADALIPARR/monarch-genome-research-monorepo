#!/usr/bin/env python3
"""Local read-only SPARQL query entry; requires rdflib >= 7."""
import argparse, pathlib, sys, re, csv
from rdflib import Graph
p=argparse.ArgumentParser(description="Query local ontology; SELECT/ASK only")
p.add_argument("query",help="Query name (e.g. 01_visible_labels), path to .rq, or 'list'")
p.add_argument("--ontology",default=str(pathlib.Path(__file__).with_name("genome_stack.ttl")))
p.add_argument("--csv",action="store_true")
a=p.parse_args()
base=pathlib.Path(__file__).parent
if a.query=='list':
 print('\n'.join(x.stem for x in sorted((base/'sparql').glob('*.rq'))));sys.exit(0)
qfile=pathlib.Path(a.query)
if not qfile.exists():qfile=base/'sparql'/(a.query if a.query.endswith('.rq') else a.query+'.rq')
if not qfile.is_file():p.error('Query not found: '+a.query)
q=qfile.read_text()
# Comments and prefix statements are not SPARQL query operations.
body=re.sub(r'(?m)^\s*#.*$','',q)
body=re.sub(r'(?im)^\s*PREFIX\s+[^\n]+','',body).strip()
if not re.match(r'(?is)^(SELECT|ASK)\b',body):p.error('Only SELECT and ASK queries are supported')
if re.search(r'(?i)\b(SERVICE|LOAD|CLEAR|DROP|INSERT|DELETE|CREATE|MOVE|COPY|ADD|WITH)\b',body):p.error('Remote access and updates are disabled')
g=Graph();g.parse(a.ontology)
r=g.query(q)
if r.type=='ASK':print(str(bool(r.askAnswer)).lower());sys.exit(0)
w=csv.writer(sys.stdout) if a.csv else None
fields=[str(v) for v in r.vars]
if w:w.writerow(fields)
else:print('\t'.join(fields))
for row in r:
 values=['' if v is None else str(v) for v in row]
 if w:w.writerow(values)
 else:print('\t'.join(values))
