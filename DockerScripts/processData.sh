#~/bin/sh

DATA_DIR=$PWD/data
gunzip $DATA_DIR/*.gz
sed -i.org "s:/tmp/share/__DATA_DIR__:$DATA_DIR:" ~/import_rdf.sql
