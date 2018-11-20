#!/usr/bin/env bash

PREFIX=$1
echo "Processing $PREFIX ..."
python SIGA.py rdf -c $PREFIX.ini $PREFIX.db 
echo Done.

