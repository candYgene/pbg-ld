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
        ORDER BY DESC(?n)
    """)
    sparql.setReturnFormat(JSON)
    res = sparql.query().convert()

    for r in res["results"]["bindings"]:
        g = r['g']['value']
        n = r['n']['value']
        if g in graphs:
            graphs[g] = n
except:
    sys.exit("Couldn't connect to the SPARQL endpoint '{0}'.".format(endpoint))

exit_code = 0
std = sys.stdout
for g,n in graphs.items():
    if n == 0:
        exit_code = 1
        std = sys.stderr
    print("{0} triples found in graph '{1}'.".format(n,g), file=std)
sys.exit(exit_code)
