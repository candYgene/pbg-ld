#!/bin/bash -xe
#
# Batch script to download (compressed) data in RDF and to write graph URIs into *.graph files
# required for loading RDF into Virtuoso RDF Quad Store.


ENSEMBL_RELEASE=33
#UNIPROT_RELEASE=2019_04
DATA_DIR=$1
FILE_G_URI="graphs.txt" # list of RDF graph URI/IRIs

if [ "${DATA_DIR}" != "" ]; then
	mkdir -p $DATA_DIR && cd $DATA_DIR
fi

# download ontologies
curl --stderr - -LH "Accept: application/rdf+xml" -o faldo.rdf "http://biohackathon.org/resource/faldo.rdf" \
	&& echo "http://biohackathon.org/resource/faldo.rdf" > faldo.rdf.graph

curl --stderr - -LH "Accept: application/rdf+xml" -o so.rdf "http://purl.obolibrary.org/obo/so.owl" \
	&& echo "http://purl.obolibrary.org/obo/so.owl" > so.rdf.graph

curl --stderr - -LH "Accept: application/rdf+xml" -o sio.rdf "http://semanticscience.org/ontology/sio.owl" \
	&& echo "http://semanticscience.org/ontology/sio.owl" > sio.rdf.graph

curl --stderr - -LH "Accept: application/rdf+xml" -o ro.rdf "http://purl.obolibrary.org/obo/ro.owl" \
	&& echo "http://purl.obolibrary.org/obo/ro.owl" > ro.rdf.graph

curl --stderr - -o uniprot_core.rdf "ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/rdf/core.owl" \
	&& echo "http://purl.uniprot.org/core/" > uniprot_core.rdf.graph

curl --stderr - -LH "Accept: application/rdf+xml" -o go.rdf "http://purl.obolibrary.org/obo/go.owl" \
	&& echo "http://purl.obolibrary.org/obo/go.owl" > go.rdf.graph

curl --stderr - -LH "Accept: application/rdf+xml" -o po.rdf "http://purl.obolibrary.org/obo/po.owl" \
        && echo "http://purl.obolibrary.org/obo/po.owl" > po.rdf.graph

curl --stderr - -LH "Accept: application/rdf+xml" -o to.rdf "http://purl.obolibrary.org/obo/to.owl" \
        && echo "http://purl.obolibrary.org/obo/to.owl" > to.rdf.graph

curl --stderr - -LH "Accept: application/rdf+xml" -o pato.rdf "http://purl.obolibrary.org/obo/pato.owl" \
        && echo "http://purl.obolibrary.org/obo/pato.owl" > pato.rdf.graph

curl --stderr - -LH "Accept: application/rdf+xml" -o spto.rdf "http://data.bioontology.org/ontologies/SPTO/download?apikey=8b5b7825-538d-40e0-9e9e-5ab9274a9aeb&download_format=rdf" \
        && echo "http://purl.bioontology.org/ontology/SPTO" > spto.rdf.graph

# download tomato genome from Ensembl Plants and proteome from UniProt Reference Proteomes
curl --stderr - -LO "ftp://ftp.ensemblgenomes.org/pub/plants/release-${ENSEMBL_RELEASE}/rdf/solanum_lycopersicum/solanum_lycopersicum.ttl.gz" \
	&& echo "http://plants.ensembl.org/Solanum_lycopersicum" > solanum_lycopersicum.ttl.graph

curl --stderr - -LO "ftp://ftp.ensemblgenomes.org/pub/plants/release-${ENSEMBL_RELEASE}/rdf/solanum_lycopersicum/solanum_lycopersicum_xrefs.ttl.gz" \
	&& echo "http://plants.ensembl.org/Solanum_lycopersicum" > solanum_lycopersicum_xrefs.ttl.graph

curl --stderr - -L -o uniprot_tomato.rdf.gz "http://www.uniprot.org/uniprot/?format=rdf&compress=yes&query=proteome:UP000004994" \
	&& echo "http://www.uniprot.org/proteomes/Solanum_lycopersicum" > uniprot_tomato.rdf.graph

# download potato genome from Ensembl Plants and proteome from UniProt Reference Proteomes
curl --stderr - -LO "ftp://ftp.ensemblgenomes.org/pub/plants/release-${ENSEMBL_RELEASE}/rdf/solanum_tuberosum/solanum_tuberosum.ttl.gz" \
	&& echo "http://plants.ensembl.org/Solanum_tuberosum" > solanum_tuberosum.ttl.graph

curl --stderr - -LO "ftp://ftp.ensemblgenomes.org/pub/plants/release-${ENSEMBL_RELEASE}/rdf/solanum_tuberosum/solanum_tuberosum_xrefs.ttl.gz" \
	&& echo "http://plants.ensembl.org/Solanum_tuberosum" > solanum_tuberosum_xrefs.ttl.graph

curl --stderr - -L -o uniprot_potato.rdf.gz "http://www.uniprot.org/uniprot/?format=rdf&compress=yes&query=proteome:UP000011115" \
	&& echo "http://www.uniprot.org/proteomes/Solanum_tuberosum" > uniprot_potato.rdf.graph

ls -lh

cat *.graph > ${FILE_G_URI}

# exit with non-zero code if one or more files are empty
[ $(find . -size 0 -print | wc -l) -gt 0 ] && exit 1 || gzip -f *.rdf
