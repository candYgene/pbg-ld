log_enable(2) ; -- disable transaction logging & enable row-by-row autocommit
SET u{BASE_URI} http://localhost:8890 ;
SET u{ENSEMBL_RELEASE} 33 ;
SET u{ENSEMBL-SL_G_URI} http://plants.ensembl.org/Solanum_lycopersicum ;
SET u{ENSEMBL-ST_G_URI} http://plants.ensembl.org/Solanum_tuberosum ;
SET u{SGN-SL_G_URI} http://solgenomics.net/genome/Solanum_lycopersicum ;
SET u{SGN-SP_G_URI} http://solgenomics.net/genome/Solanum_pennellii ;
SET u{SGN-ST_G_URI} http://solgenomics.net/genome/Solanum_tuberosum ;
SET u{EPMC_G_URI} http://europepmc.org ;

--
-- Link tomato chromosomes to ENA accessions.
--

SPARQL
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX chr: <$u{BASE_URI}/genome/Solanum_lycopersicum/chromosome/>
PREFIX ena: <http://identifiers.org/ena.embl/>
INSERT INTO <$u{SGN-SL_G_URI}> {
   chr:1 rdfs:seeAlso ena:CM001064.2 .
   chr:2 rdfs:seeAlso ena:CM001065.2 .
   chr:3 rdfs:seeAlso ena:CM001066.2 .
   chr:4 rdfs:seeAlso ena:CM001067.2 .
   chr:5 rdfs:seeAlso ena:CM001068.2 .
   chr:6 rdfs:seeAlso ena:CM001069.2 .
   chr:7 rdfs:seeAlso ena:CM001070.2 .
   chr:8 rdfs:seeAlso ena:CM001071.2 .
   chr:9 rdfs:seeAlso ena:CM001072.2 .
   chr:10 rdfs:seeAlso ena:CM001073.2 .
   chr:11 rdfs:seeAlso ena:CM001074.2 .
   chr:12 rdfs:seeAlso ena:CM001075.2 .
} ;

--
-- Delete triples
--
--SPARQL
--PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
--PREFIX ena: <http://identifiers.org/ena.embl/>
--WITH <$u{SGN-SL_G_URI}>
--DELETE { ?s rdfs:seeAlso ?o }
--WHERE { ?s rdfs:seeAlso ?o . FILTER regex(?o, ena:) } ;
--

--
-- Fix database cross-references in EnsemblPlants RDF graphs.
--

SPARQL
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
WITH <$u{ENSEMBL-SL_G_URI}>
DELETE { ?s rdfs:seeAlso ?o }
INSERT { ?s rdfs:seeAlso ?fixed }
WHERE {
   ?s rdfs:seeAlso ?o .
   FILTER regex(?o, 'http://identifiers.org/(go|kegg)') .
   BIND(uri(replace(str(?o), '%253A', ':')) AS ?fixed)
} ;

SPARQL
WITH <$u{ENSEMBL-SL_G_URI}>
DELETE { ?s <http://semanticscience.org/resource/SIO:000630> ?o }
INSERT { ?s <http://semanticscience.org/resource/SIO_000630> ?o }
WHERE { ?s <http://semanticscience.org/resource/SIO:000630> ?o } ;

SPARQL
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
WITH <$u{ENSEMBL-SL_G_URI}>
DELETE { ?s rdfs:seeAlso ?o }
INSERT { ?s rdfs:seeAlso ?fixed }
WHERE {
   ?s rdfs:seeAlso ?o .
   FILTER regex(?o, 'http://identifiers.org/ensembl') .
   BIND(uri(replace(str(?o), 'ensembl', 'ensembl.plant')) AS ?fixed)
} ;

SPARQL
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
WITH <$u{ENSEMBL-ST_G_URI}>
DELETE { ?s rdfs:seeAlso ?o }
INSERT { ?s rdfs:seeAlso ?fixed }
WHERE {
   ?s rdfs:seeAlso ?o .
   FILTER regex(?o, 'http://identifiers.org/(go|kegg)') .
   BIND(uri(replace(str(?o), '%253A', ':')) AS ?fixed)
} ;

SPARQL
WITH <$u{ENSEMBL-ST_G_URI}>
DELETE { ?s <http://semanticscience.org/resource/SIO:000630> ?o }
INSERT { ?s <http://semanticscience.org/resource/SIO_000630> ?o }
WHERE { ?s <http://semanticscience.org/resource/SIO:000630> ?o } ;

SPARQL
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
WITH <$u{ENSEMBL-ST_G_URI}>
DELETE { ?s rdfs:seeAlso ?o }
INSERT { ?s rdfs:seeAlso ?fixed }
WHERE {
   ?s rdfs:seeAlso ?o .
   FILTER regex(?o, 'http://identifiers.org/ensembl') .
   BIND(uri(replace(str(?o), 'ensembl', 'ensembl.plant')) AS ?fixed)
} ;

--
-- Fix SO predicates in EnsemblPlants RDF graphs
--

SPARQL
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX so: <http://purl.obolibrary.org/obo/so#>
WITH <$u{ENSEMBL-SL_G_URI}>
DELETE { ?s obo:SO_translates_to ?o }
INSERT { ?s so:translates_to ?o }
WHERE { ?s obo:SO_translates_to ?o } ;

SPARQL
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX so: <http://purl.obolibrary.org/obo/so#>
WITH <$u{ENSEMBL-SL_G_URI}>
DELETE { ?s obo:SO_has_part ?o }
INSERT { ?s so:has_part ?o }
WHERE { ?s obo:SO_has_part ?o } ;

SPARQL
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX so: <http://purl.obolibrary.org/obo/so#>
WITH <$u{ENSEMBL-SL_G_URI}>
DELETE { ?s obo:SO_transcribed_from ?o }
INSERT { ?s so:transcribed_from  ?o }
WHERE { ?s obo:SO_transcribed_from ?o } ;

SPARQL
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX so: <http://purl.obolibrary.org/obo/so#>
WITH <$u{ENSEMBL-ST_G_URI}>
DELETE { ?s obo:SO_translates_to ?o }
INSERT { ?s so:translates_to ?o }
WHERE { ?s obo:SO_translates_to ?o } ;

SPARQL
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX so: <http://purl.obolibrary.org/obo/so#>
WITH <$u{ENSEMBL-ST_G_URI}>
DELETE { ?s obo:SO_has_part ?o }
INSERT { ?s so:has_part ?o }
WHERE { ?s obo:SO_has_part ?o } ;

SPARQL
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX so: <http://purl.obolibrary.org/obo/so#>
WITH <$u{ENSEMBL-ST_G_URI}>
DELETE { ?s obo:SO_transcribed_from ?o }
INSERT { ?s so:transcribed_from  ?o }
WHERE { ?s obo:SO_transcribed_from ?o } ;

--
-- Link protein-coding genes in SGN and EnsemblPlants RDF graphs.
--   graph URI: http://solgenomics.net/genome/Solanum_lycopersicum
--     gene URI: e.g. http://.../genome/Solanum_lycopersicum/gene/Solyc07g049530.2
--
--   graph URI: http://plants.ensembl.org/Solanum_lycopersicum
--     gene URI: e.g. http://rdf.ebi.ac.uk/resource/ensembl/Solyc07g049530.2
--
--   graph URI: http://solgenomics.net/genome/Solanum_tuberosum
--     gene URI: e.g. http://.../genome/Solanum_tuberosum/gene/PGSC0003DMG400045235
--
--   graph URI: http://plants.ensembl.org/Solanum_tuberosum
--     gene URI: e.g. http://rdf.ebi.ac.uk/resource/ensembl/PGSC0003DMG400045235

SPARQL
PREFIX Gene: <http://purl.obolibrary.org/obo/SO_0001217>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
INSERT INTO <$u{SGN-SL_G_URI}> {
   ?gene1 owl:sameAs ?gene2
}
WHERE {
   GRAPH <$u{SGN-SL_G_URI}> {
      ?gene1 a Gene: .
      BIND(uri(concat('http://rdf.ebi.ac.uk/resource/ensembl/', replace(str(?gene1), '.+/', ''))) AS ?gene2)
   }
   GRAPH <$u{ENSEMBL-SL_G_URI}> {
      ?gene2 a Gene: .
   }
} ;

SPARQL
PREFIX Gene: <http://purl.obolibrary.org/obo/SO_0001217>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
INSERT INTO <$u{SGN-ST_G_URI}> {
   ?gene1 owl:sameAs ?gene2
}
WHERE {
   GRAPH <$u{SGN-ST_G_URI}> {
      ?gene1 a Gene: .
      BIND(uri(concat('http://rdf.ebi.ac.uk/resource/ensembl/', replace(str(?gene1), '.+/', ''))) AS ?gene2)
   }
   GRAPH <$u{ENSEMBL-ST_G_URI}> {
      ?gene2 a Gene: .
   }
} ;

--
-- Delete triples
--
--SPARQL
--PREFIX owl: <http://www.w3.org/2002/07/owl#>
--WITH  <$u{SGN-SL_G_URI}>
--DELETE WHERE { ?gene1 owl:sameAs ?gene2 } ;
--
--SPARQL
--PREFIX owl: <http://www.w3.org/2002/07/owl#>
--WITH  <$u{SGN-ST_G_URI}>
--DELETE WHERE { ?gene1 owl:sameAs ?gene2 } ;

--
-- Add primary trascript type to EnsemblPlants RDF graphs.
--

SPARQL
PREFIX PrimTranscript: <http://purl.obolibrary.org/obo/SO_0000120>
INSERT INTO <$u{ENSEMBL-SL_G_URI}> {
   ?chr2 a PrimTranscript:
}
WHERE {
   GRAPH <$u{SGN-SL_G_URI}> {
      ?chr1 a PrimTranscript: .
      BIND(uri(concat('http://rdf.ebi.ac.uk/resource/ensembl.transcript/', replace(str(?chr1), '.+/', ''))) AS ?chr2)
   }
} ;

SPARQL
PREFIX PrimTranscript: <http://purl.obolibrary.org/obo/SO_0000120>
INSERT INTO <$u{ENSEMBL-ST_G_URI}> {
   ?chr2 a PrimTranscript:
}
WHERE {
   GRAPH <$u{SGN-ST_G_URI}> {
      ?chr1 a PrimTranscript: .
      BIND(uri(concat('http://rdf.ebi.ac.uk/resource/ensembl.transcript/', replace(str(?chr1), '.+/', ''))) AS ?chr2)
   }
} ;

--
-- Delete triples
--
--SPARQL
--PREFIX PrimTranscript: <http://purl.obolibrary.org/obo/SO_0000120>
--WITH  <$u{ENSEMBL-SL_G_URI}>
--DELETE WHERE { ?s a PrimTranscript: } ;
--
--SPARQL
--PREFIX PrimTranscript: <http://purl.obolibrary.org/obo/SO_0000120>
--WITH  <$u{ENSEMBL-ST_G_URI}>
--DELETE WHERE { ?s a PrimTranscript: } ;

--
-- Delete miRNA type for protein-coding transcripts in EnsemblPlants RDF graphs.
--

SPARQL
PREFIX miRNA: <http://purl.obolibrary.org/obo/SO_0000276>
PREFIX PrimTranscript: <http://purl.obolibrary.org/obo/SO_0000120>
WITH  <$u{ENSEMBL-SL_G_URI}>
DELETE { ?s a miRNA: }
WHERE { ?s a PrimTranscript: } ;

SPARQL
PREFIX miRNA: <http://purl.obolibrary.org/obo/SO_0000276>
PREFIX PrimTranscript: <http://purl.obolibrary.org/obo/SO_0000120>
WITH  <$u{ENSEMBL-ST_G_URI}>
DELETE { ?s a miRNA: }
WHERE { ?s a PrimTranscript: } ;

--
-- Link primary transcripts in SGN and EnsemblPlants RDF graphs.
--   graph URI: http://solgenomics.net/genome/Solanum_lycopersicum
--     transcript URI: e.g. http://.../genome/Solanum_lycopersicum/prim_transcript/Solyc02g079500.2.1
--
--   graph URI: http://plants.ensembl.org/Solanum_lycopersicum
--     transcript URI: e.g. http://rdf.ebi.ac.uk/resource/ensembl.transcript/Solyc02g079500.2.1
--
--   graph URI: http://solgenomics.net/genome/Solanum_tuberosum
--     transcript URI: e.g. http://.../genome/Solanum_tuberosum/prim_transcript/PGSC0003DMT400040463
--
--   graph URI: http://plants.ensembl.org/Solanum_tuberosum
--     transcript URI: e.g. http://rdf.ebi.ac.uk/resource/ensembl.transcript/PGSC0003DMT400040463
--

SPARQL
PREFIX PrimTranscript: <http://purl.obolibrary.org/obo/SO_0000120>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
INSERT INTO <$u{SGN-SL_G_URI}> {
   ?chr1 owl:sameAs ?chr2
}   
WHERE {
   GRAPH <$u{SGN-SL_G_URI}> {
      ?chr1 a PrimTranscript: .
      BIND(uri(concat('http://rdf.ebi.ac.uk/resource/ensembl.transcript/', replace(str(?chr1), '.+/', ''))) AS ?chr2)
   }
} ;

SPARQL
PREFIX PrimTranscript: <http://purl.obolibrary.org/obo/SO_0000120>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
INSERT INTO <$u{SGN-ST_G_URI}> {
   ?chr1 owl:sameAs ?chr2
}   
WHERE {
   GRAPH <$u{SGN-ST_G_URI}> {
      ?chr1 a PrimTranscript: .
      BIND(uri(concat('http://rdf.ebi.ac.uk/resource/ensembl.transcript/', replace(str(?chr1), '.+/', ''))) AS ?chr2)
   }
} ;

--
-- Delete triples
--
--SPARQL
--PREFIX owl: <http://www.w3.org/2002/07/owl#>
--WITH  <$u{SGN-SL_G_URI}>
--DELETE WHERE { ?s owl:sameAs ?o } ;
--
--SPARQL
--PREFIX owl: <http://www.w3.org/2002/07/owl#>
--WITH  <$u{SGN-ST_G_URI}>
--DELETE WHERE { ?s owl:sameAs ?o } ;

--
-- Link corresponding SGN markers in both tomato species
--

SPARQL
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX Marker: <http://purl.obolibrary.org/obo/SO_0001645>
PREFIX is_orthologous_to: <http://semanticscience.org/resource/SIO_000558>
INSERT INTO <$u{SGN-SL_G_URI}> {
   ?marker_sl is_orthologous_to: ?marker_sp
}
WHERE {
   GRAPH <$u{SGN-SL_G_URI}> {
      ?marker_sl a Marker: ;
         rdfs:comment ?aliases_sl ;
         dcterms:identifier ?marker_sl_id .
   }
   GRAPH <$u{SGN-SP_G_URI}> {
      ?marker_sp a Marker: ;
         rdfs:comment ?aliases_sp ;
         dcterms:identifier ?marker_sp_id .
   }
   BIND(bif:strcontains(?aliases_sl, str(?marker_sp_id)) AS ?match)
   FILTER(?match = 1)
} ;

--
-- Delete triples
--
--SPARQL
--PREFIX Marker: <http://purl.obolibrary.org/obo/SO_0001645>
--PREFIX is_orthologous_to: <http://semanticscience.org/resource/SIO_000558>
--WITH  <$u{SGN-SL_G_URI}>
--DELETE WHERE {
--   ?s a Marker: ;
--      is_orthologous_to: ?o
--} ;


--
-- Delineate QTL regions based on flanking markers.
-- Note: If there are more than two markers per QTL, take the longest region
-- delineated by the markers.
--

SPARQL
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX dcmitype: <http://purl.org/dc/dcmitype/>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX so: <http://purl.obolibrary.org/obo/so#>
PREFIX faldo: <http://biohackathon.org/resource/faldo#>
PREFIX sly: <http://purl.obolibrary.org/obo/NCBITaxon_4081>
INSERT INTO <$u{EPMC_G_URI}> {
   ?qtl faldo:location ?qtl_loc .
   ?qtl_loc a faldo:Region ;
      rdfs:label ?chr_loc ;
      faldo:begin ?qtl_begin ;
      faldo:end ?qtl_end
}
WHERE {
   SELECT
      ?qtl
      concat(?chr_lb, ':', ?min_begin, '-', ?max_end) AS ?chr_loc
      uri(concat(?chr, '#', ?min_begin, '-', ?max_end)) AS ?qtl_loc
      uri(concat(?chr, '#', ?min_begin)) AS ?qtl_begin
      uri(concat(?chr, '#', ?max_end)) AS ?qtl_end
   WHERE {
      SELECT
         ?qtl
         ?chr_lb
         min(?begin_pos) AS ?min_begin
         max(?end_pos) AS ?max_end
         uri(replace(GROUP_CONCAT(DISTINCT ?loc, ''), '#.+', '')) AS ?chr
      WHERE {
         GRAPH <$u{EPMC_G_URI}> {
            ?dts a dcmitype:Dataset ;
               so:genome_of sly: ;
               dcterms:hasPart ?qtl .
            ?qtl a obo:SO_0000771 ;
               obo:RO_0002610 ?marker ;
               dcterms:identifier ?qtl_id .
            ?marker a obo:SO_0001645 .
         }
         GRAPH <$u{SGN-SL_G_URI}> {
            ?marker faldo:location ?loc .
            ?loc faldo:begin ?begin ;
               faldo:end/faldo:position ?end_pos .
            ?begin faldo:position ?begin_pos ;
               faldo:reference/rdfs:label ?chr_lb .
         }
      }
      GROUP BY ?qtl ?chr_lb
   }
} ;

SPARQL
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX dcmitype: <http://purl.org/dc/dcmitype/>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX so: <http://purl.obolibrary.org/obo/so#>
PREFIX faldo: <http://biohackathon.org/resource/faldo#>
PREFIX stu: <http://purl.obolibrary.org/obo/NCBITaxon_4113>
INSERT INTO <$u{EPMC_G_URI}> {
   ?qtl faldo:location ?qtl_loc .
   ?qtl_loc a faldo:Region ;
      rdfs:label ?chr_loc ;
      faldo:begin ?qtl_begin ;
      faldo:end ?qtl_end
}
WHERE {
   SELECT
      ?qtl
      concat(?chr_lb, ':', ?min_begin, '-', ?max_end) AS ?chr_loc
      uri(concat(?chr, '#', ?min_begin, '-', ?max_end)) AS ?qtl_loc
      uri(concat(?chr, '#', ?min_begin)) AS ?qtl_begin
      uri(concat(?chr, '#', ?max_end)) AS ?qtl_end
   WHERE {
      SELECT
         ?qtl
         ?chr_lb
         min(?begin_pos) AS ?min_begin
         max(?end_pos) AS ?max_end
         uri(replace(GROUP_CONCAT(DISTINCT ?loc, ''), '#.+', '')) AS ?chr
      WHERE {
         GRAPH <$u{EPMC_G_URI}> {
            ?dts a dcmitype:Dataset ;
               so:genome_of stu: ;
               dcterms:hasPart ?qtl .
            ?qtl a obo:SO_0000771 ;
               obo:RO_0002610 ?marker ;
               dcterms:identifier ?qtl_id .
            ?marker a obo:SO_0001645 .
         }
         GRAPH <$u{SGN-ST_G_URI}> {
            ?marker faldo:location ?loc .
            ?loc faldo:begin ?begin ;
               faldo:end/faldo:position ?end_pos .
            ?begin faldo:position ?begin_pos ;
               faldo:reference/rdfs:label ?chr_lb .
         }
      }
      GROUP BY ?qtl ?chr_lb
   }
} ;

--
-- Delete triples
--
--SPARQL
--PREFIX faldo: <http://biohackathon.org/resource/faldo#>
--WITH <$u{EPMC_G_URI}>
--DELETE WHERE {
--  ?qtl faldo:location ?qtl_loc .
--  ?qtl_loc a faldo:Region ;
--     rdfs:label ?chr_loc ;
--     faldo:begin ?qtl_begin ;
--     faldo:end ?qtl_end
--} ;

--
-- Link SGN genes to QTLs using overlapping regions.
--

SPARQL
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX dcmitype: <http://purl.org/dc/dcmitype/>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX sly: <http://purl.obolibrary.org/obo/NCBITaxon_4081>
PREFIX so: <http://purl.obolibrary.org/obo/so#>
PREFIX faldo: <http://biohackathon.org/resource/faldo#>
INSERT INTO <$u{EPMC_G_URI}> {
   ?qtl so:overlaps ?gene
}
WHERE {
   GRAPH <$u{EPMC_G_URI}> {
      ?dts a dcmitype:Dataset ;
         so:genome_of sly: ;
         dcterms:hasPart ?qtl .
      ?qtl a obo:SO_0000771 ;
         faldo:location ?loc ;
         obo:RO_0003308 ?trait .
      ?loc faldo:begin ?begin ;
         faldo:end ?end
   }
   GRAPH <$u{SGN-SL_G_URI}> {
      ?begin faldo:position ?begin_pos ;
         faldo:reference ?chr .
      ?end faldo:position ?end_pos
   }
   GRAPH <$u{SGN-SL_G_URI}> {
      ?loc2 faldo:begin ?begin2 ;
         faldo:end ?end2 ;
         ^faldo:location ?gene .
      ?gene a obo:SO_0001217 .
      ?begin2 faldo:position ?begin_pos2 ;
         faldo:reference ?chr2 .
      ?end2 faldo:position ?end_pos2
   }
   FILTER(?chr = ?chr2)
   FILTER((xsd:integer(?begin_pos) > xsd:integer(?begin_pos2) &&
     xsd:integer(?begin_pos) < xsd:integer(?end_pos2)) ||
     (xsd:integer(?end_pos) > xsd:integer(?begin_pos2) &&
     xsd:integer(?end_pos) < xsd:integer(?end_pos2)) ||
     (xsd:integer(?begin_pos) < xsd:integer(?begin_pos2) &&
     xsd:integer(?end_pos) > xsd:integer(?end_pos2)) ||
     xsd:integer(?begin_pos) > xsd:integer(?begin_pos2) &&
     xsd:integer(?end_pos) < xsd:integer(?end_pos2))
} ;

SPARQL
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX dcmitype: <http://purl.org/dc/dcmitype/>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX stu: <http://purl.obolibrary.org/obo/NCBITaxon_4113>
PREFIX so: <http://purl.obolibrary.org/obo/so#>
PREFIX faldo: <http://biohackathon.org/resource/faldo#>
INSERT INTO <$u{EPMC_G_URI}> {
   ?qtl so:overlaps ?gene
}
WHERE {
   GRAPH <$u{EPMC_G_URI}> {
      ?dts a dcmitype:Dataset ;
         so:genome_of stu: ;
         dcterms:hasPart ?qtl .
      ?qtl a obo:SO_0000771 ;
         faldo:location ?loc ;
         obo:RO_0003308 ?trait .
      ?loc faldo:begin ?begin ;
         faldo:end ?end
   }
   GRAPH <$u{SGN-ST_G_URI}> {
      ?begin faldo:position ?begin_pos ;
         faldo:reference ?chr .
      ?end faldo:position ?end_pos
   }
   GRAPH <$u{SGN-ST_G_URI}> {
      ?loc2 faldo:begin ?begin2 ;
         faldo:end ?end2 ;
         ^faldo:location ?gene .
      ?gene a obo:SO_0001217 .
      ?begin2 faldo:position ?begin_pos2 ;
         faldo:reference ?chr2 .
      ?end2 faldo:position ?end_pos2
   }
   FILTER(?chr = ?chr2)
   FILTER((xsd:integer(?begin_pos) > xsd:integer(?begin_pos2) &&
     xsd:integer(?begin_pos) < xsd:integer(?end_pos2)) ||
     (xsd:integer(?end_pos) > xsd:integer(?begin_pos2) &&
     xsd:integer(?end_pos) < xsd:integer(?end_pos2)) ||
     (xsd:integer(?begin_pos) < xsd:integer(?begin_pos2) &&
     xsd:integer(?end_pos) > xsd:integer(?end_pos2)) ||
     xsd:integer(?begin_pos) > xsd:integer(?begin_pos2) &&
     xsd:integer(?end_pos) < xsd:integer(?end_pos2))
} ;

--
-- Delete triples
--
--SPARQL
--PREFIX so: <http://purl.obolibrary.org/obo/so#>
--WITH <$u{EPMC_G_URI}>
--DELETE WHERE { ?qtl so:overlaps ?gene } ;

--
-- Link QTLs to SGN's genome browser (JBrowse).
--

SPARQL
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX dcmitype: <http://purl.org/dc/dcmitype/>
PREFIX faldo: <http://biohackathon.org/resource/faldo#>
PREFIX so: <http://purl.obolibrary.org/obo/so#>
PREFIX sly: <http://purl.obolibrary.org/obo/NCBITaxon_4081>
INSERT INTO <$u{EPMC_G_URI}> {
   ?loc rdfs:seeAlso ?jbrowse
}
WHERE {
   GRAPH <$u{EPMC_G_URI}> {
      ?dts a dcmitype:Dataset ;
         so:genome_of sly: ;
         dcterms:hasPart ?qtl .
      ?qtl faldo:location ?loc .
      ?loc a faldo:Region .
      BIND(bif:atoi(bif:regexp_substr('.+/([0-9]+)#([0-9]+)-([0-9]+)', ?loc, 1)) AS ?chr)
      BIND(bif:atoi(bif:regexp_substr('.+/([0-9]+)#([0-9]+)-([0-9]+)', ?loc, 2)) AS ?begin)
      BIND(bif:atoi(bif:regexp_substr('.+/([0-9]+)#([0-9]+)-([0-9]+)', ?loc, 3)) AS ?end)
      BIND(uri(bif:sprintf('https://solgenomics.net/jbrowse_solgenomics/?data=data/json/SL2.50&loc=SL2.50ch%02d:%d..%d&tracks=DNA,gene_models,SGN_markers,SolCAP_SNPs', ?chr, ?begin, ?end)) AS ?jbrowse)
   }
} ;

SPARQL
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX dcmitype: <http://purl.org/dc/dcmitype/>
PREFIX faldo: <http://biohackathon.org/resource/faldo#>
PREFIX so: <http://purl.obolibrary.org/obo/so#>
PREFIX stu: <http://purl.obolibrary.org/obo/NCBITaxon_4113>
INSERT INTO <$u{EPMC_G_URI}> {
   ?loc rdfs:seeAlso ?jbrowse
}
WHERE {
   GRAPH <$u{EPMC_G_URI}> {
      ?dts a dcmitype:Dataset ;
         so:genome_of stu: ;
         dcterms:hasPart ?qtl .
      ?qtl faldo:location ?loc .
      ?loc a faldo:Region .
      BIND(bif:atoi(bif:regexp_substr('.+/([0-9]+)#([0-9]+)-([0-9]+)', ?loc, 1)) AS ?chr)
      BIND(bif:atoi(bif:regexp_substr('.+/([0-9]+)#([0-9]+)-([0-9]+)', ?loc, 2)) AS ?begin)
      BIND(bif:atoi(bif:regexp_substr('.+/([0-9]+)#([0-9]+)-([0-9]+)', ?loc, 3)) AS ?end)
      BIND(uri(bif:sprintf('https://solgenomics.net/jbrowse_solgenomics/?data=data/json/PGSC_DM_v4.03&loc=ST4.03ch%02d:%d..%d&tracks=DNA,gene_models,DArT_marker,SOLCAP_SNP_marker', ?chr, ?begin, ?end)) AS ?jbrowse)
   }
} ;

--
-- Delete triples
--
--SPARQL
--PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
--PREFIX faldo: <http://biohackathon.org/resource/faldo#>
--WITH <$u{EPMC_G_URI}>
--DELETE { ?loc rdfs:seeAlso ?jbrowse }
--WHERE {
--   ?loc rdfs:seeAlso ?jbrowse ;
--      a faldo:Region
--} ;
