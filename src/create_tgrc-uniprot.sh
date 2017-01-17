#!/bin/bash
#
# Populate db with TGRC tomato mutants (phenotypes) and (alternative) gene names from UniProt.
#
# Prerequisites:
#   Download TGRC data at http://tgrc.ucdavis.edu/Data/Acc/Genes.aspx
#   Post-process downloaded 'data.csv' file.
#     dos2unix data.csv
#     cut -f 1,3,6,7 -d ',' data.csv | sort -u # columns: Gene, Locus Name, Phenoptype, Chromosome
#
#   Download tomato reference proteome in RDF/XML from UniProt
#     http://www.uniprot.org/proteomes/UP000004994
#   Import the graph into RDF store & query
#

DB=tgrc-uniprot.db

rm -f $DB

sqlite3 $DB -init create_db.sql '.q'
sqlite3 $DB -init tgrc-uniprot_query.sql '.q'
