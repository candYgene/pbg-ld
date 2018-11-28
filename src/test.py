import sys
from SPARQLWrapper import SPARQLWrapper, JSON


infile = sys.argv[1] if len(sys.argv) > 1 else "graphs.txt"
endpoint = sys.argv[2] if len(sys.argv) > 2 else "http://localhost:8890/sparql"
graphs = dict()

try:
    with open(infile, "r") as fin:
        for line in fin:
            graphs[line.strip()] = 0
except IOError as err:
    sys.exit(err)

if len(graphs) == 0:
    sys.exit("No graph URIs found.")

try:
    sparql = SPARQLWrapper(endpoint)
    sparql.setQuery("""
        SELECT
            ?g COUNT(*) AS ?n
        WHERE {
            GRAPH ?g { ?s ?p ?o }
        }
        GROUP BY ?g
    """)
    sparql.setReturnFormat(JSON)
    res = sparql.query().convert()

    for r in res["results"]["bindings"]:
        g = r['g']['value']
        n = int(r['n']['value'])
        if g in graphs:
            graphs[g] = n
except:
    sys.exit("Failed to connect to the SPARQL endpoint '{0}'.".format(endpoint))

exit_code = 0
std = sys.stdout

print("# graph_uri\tn_triples")
for g,n in sorted(graphs.items(), key=lambda x: x[1], reverse=True):
    if n == 0:
        exit_code = 1
        std = sys.stderr
    print("{0}\t{1}".format(g,n), file=std)
sys.exit(exit_code)
