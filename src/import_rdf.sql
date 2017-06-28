--
-- Bulk loading RDF graphs into Virtuoso Quad Store.
--

SET u{DATA_DIR} /tmp/share/__DATA_DIR__ ;
SET u{FILE_NAME} *.gz ;
SET u{LOG_LEVEL} 2 ;

-- delete named graphs
-- SPARQL CLEAR GRAPH <graph-iri> ;

-- register RDF files to load; graph URIs in *.graph files
DELETE FROM DB.DBA.load_list ;
ld_dir('$u{DATA_DIR}', '$u{FILE_NAME}', NULL) ;
SELECT * FROM DB.DBA.load_list ;

-- load RDF files
rdf_loader_run(log_enable=>$u{LOG_LEVEL}) ;

-- count triples per named graph
--SPARQL SELECT
--   ?g COUNT(*) AS ?n
--WHERE {
--   GRAPH ?g { ?s ?p ?o }
--}
--GROUP BY ?g
--ORDER BY DESC(?n) ;
