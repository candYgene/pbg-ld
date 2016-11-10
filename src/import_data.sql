--
-- Script to load SGN (wild) tomato RDF graphs into Virtuoso RDF Quad Store.
--
-- Author: Arnold Kuzniar
--

SET u{GRAPH_IRI} http://solgenomics.net/;
SET u{RDF_FILE} *.ttl
SPARQL CLEAR GRAPH <$u{GRAPH_IRI}>;
DELETE FROM DB.DBA.load_list;
ld_dir('/tmp/share', '$u{RDF_FILE}', '$u{GRAPH_IRI}');
SELECT * FROM DB.DBA.load_list;
rdf_loader_run();
