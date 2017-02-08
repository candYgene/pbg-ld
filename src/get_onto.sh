#!/bin/bash
#
# Batch script to download required ontologies in *.rdf.gz files and
# to write graph URIs in *.graph files for RDF bulk loading.
#

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

gzip -9 *.rdf
