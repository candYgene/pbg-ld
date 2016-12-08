#!/bin/bash
#
# Batch script to "sponge" required ontologies via Virtuoso RDF Proxy Service.
#
# Author: Arnold Kuzniar
#

RDF_PROXY="http://localhost:8890/describe/"
LOG_FILE=$0.log

# create a lookup for ontologies/URLs
declare -A RDF
RDF[FALDO]="http://biohackathon.org/resource/faldo.rdf"
RDF[SO]="http://purl.obolibrary.org/obo/so.owl"
RDF[RO]="http://purl.obolibrary.org/obo/ro.owl"
RDF[SIO]="http://semanticscience.org/ontology/sio.owl"

rm -f ${LOG_FILE}
for name in "${!RDF[@]}"
do
  url="${RDF_PROXY}?url=${RDF[$name]}&sponger:get=add"
  echo "[$(date +'%d/%b/%Y %T')] Sponging '$name' ontology into Virtuoso RDF Quad Store via '${url}'..." >> ${LOG_FILE}
  curl -Ss -I -H "Accept: application/rdf+xml" "$url" &>> ${LOG_FILE}
done
