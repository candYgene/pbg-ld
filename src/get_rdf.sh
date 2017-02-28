#!/bin/bash
#
# Batch script to download (compressed) data in RDF and to write graph URIs into *.graph files
# required for loading RDF into Virtuoso RDF Quad Store.

ENSEMBLPLANTS_RELEASE=33
#UNIPROT_RELEASE=2016_11

# download ontologies
curl --stderr - -LH "Accept: application/rdf+xml" -o faldo.rdf "http://biohackathon.org/resource/faldo.rdf" \
	&& echo "http://biohackathon.org/resource/faldo.rdf" > faldo.rdf.graph

curl --stderr - -LH "Accept: application/rdf+xml" -o so.rdf "http://purl.obolibrary.org/obo/so.owl" \
	&& echo "http://purl.obolibrary.org/obo/so.owl" > so.rdf.graph

curl --stderr - -LH "Accept: application/rdf+xml" -o sio.rdf "http://semanticscience.org/ontology/sio.owl" \
	&& echo "http://semanticscience.org/ontology/sio.owl" > sio.rdf.graph

curl --stderr - -LH "Accept: application/rdf+xml" -o ro.rdf "http://purl.obolibrary.org/obo/ro.owl" \
	&& echo "http://purl.obolibrary.org/obo/ro.owl" > ro.rdf.graph

curl --stderr - -LH "Accept: application/rdf+xml" -o uniprot_core.rdf "http://purl.uniprot.org/core/" \
	&& echo "http://purl.uniprot.org/core/" > uniprot_core.rdf.graph

curl --stderr - -LH "Accept: application/rdf+xml" -o go.rdf "http://purl.obolibrary.org/obo/go.owl" \
	&& echo "http://purl.obolibrary.org/obo/go.owl" > go.rdf.graph

gzip -9 *.rdf

# download tomato genome and proteome from Ensembl Plants and UniProt Reference Proteomes, respectively
curl --stderr - -LO "ftp://ftp.ensemblgenomes.org/pub/plants/release-${ENSEMBLPLANTS_RELEASE}/rdf/solanum_lycopersicum/solanum_lycopersicum.ttl.gz" \
	&& echo "http://plants.ensembl.org/Solanum_lycopersicum" > solanum_lycopersicum.ttl.graph

curl --stderr - -LO "ftp://ftp.ensemblgenomes.org/pub/plants/release-${ENSEMBLPLANTS_RELEASE}/rdf/solanum_lycopersicum/solanum_lycopersicum_xrefs.ttl.gz" \
	&& echo "http://plants.ensembl.org/Solanum_lycopersicum" > solanum_lycopersicum_xrefs.ttl.graph

curl --stderr - -L -o uniprot_tomato.rdf.gz "http://www.uniprot.org/uniprot/?format=rdf&compress=yes&query=proteome:UP000004994" \
	&& echo "http://www.uniprot.org/proteomes/Solanum_lycopersicum" > uniprot_tomato.rdf.graph
