--
-- Batch installer for Virtuoso VAD packages
--

SET u{PATH} /usr/local/virtuoso-opensource/share/virtuoso/vad/ ;

VAD_INSTALL('$u{PATH}/fct_dav.vad', 0) ;
--VAD_INSTALL('$u{PATH}/rdb2rdf_dav.vad', 0) ;
--VAD_INSTALL('$u{PATH}/rdf_mappers_dav.vad', 0) ;

-- grant permissions
GRANT SPARQL_UPDATE TO "SPARQL" ;
GRANT EXECUTE ON "DB.DBA.rdfdesc_http_url" TO "SPARQL" ;
GRANT EXECUTE ON "DB.DBA.EXEC_AS" TO "SPARQL" ;
