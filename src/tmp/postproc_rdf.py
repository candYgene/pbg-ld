import sys
from rdflib import (Graph, URIRef, Literal)
from rdflib.namespace import (Namespace, RDF, RDFS, XSD, DCTERMS)

SO = Namespace('http://purl.obolibrary.org/obo/so#')
OBO = Namespace('http://purl.obolibrary.org/obo/')
BIBO = Namespace('http://purl.org/ontology/bibo/')
PMC = Namespace('http://identifiers.org/pmc/')
DCTYPE = Namespace('http://purl.org/dc/dcmitype/')

infile, outfile = sys.argv[1:3]
g = Graph()
g.parse(infile, format='turtle')
g.bind('so', SO)
g.bind('obo', OBO)
g.bind('bibo',BIBO)
g.bind('pmc', PMC)
g.bind('dcterms', DCTERMS)
g.bind('dctype', DCTYPE)
g.serialize(outfile, format='turtle')
