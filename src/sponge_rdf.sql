SET u{FDP_URI} http://pbg-ld.candygene-nlesc.surf-hosted.nl:8080 ;

SPARQL
define get:soft "soft"
define get:method "GET"
SELECT *
FROM <$u{FDP_URI}/fdp>
FROM <$u{FDP_URI}/catalog/pbg-ld>
FROM <$u{FDP_URI}/dataset/sly-genes>
FROM <$u{FDP_URI}/dataset/spe-genes>
FROM <$u{FDP_URI}/dataset/stu-genes>
FROM <$u{FDP_URI}/distribution/sly-genes-gff>
FROM <$u{FDP_URI}/distribution/spe-genes-gff>
FROM <$u{FDP_URI}/distribution/stu-genes-gff>
WHERE { ?s ?p ?o } ;
