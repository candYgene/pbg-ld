# Linked Data Platform for Plant Breeding & Genomics

[![Build Status](https://travis-ci.org/candYgene/pbg-ld.svg?branch=dev)](https://travis-ci.org/candYgene/pbg-ld)

This software provides semantically integrated genotypic/phenotypic data on plants to enable ranking of candidate genes associated with traits of interest (e.g. fruit ripening in tomato).

**1. Clone this git repo.**

`git clone https://github.com/candYgene/pbg-ld.git`

**2. Start a [Docker container](https://hub.docker.com/r/candygene/docker-virtuoso/) with [Virtuoso Universal Server](http://virtuoso.openlinksw.com/) & ingest data in [RDF](https://www.w3.org/RDF/).**

```
cd pbg-ld/src
make # with defaults: CONTAINER_NAME=virtuoso and CONTAINER_PORT=8890 (in development)
make -e CONTAINER_NAME=pbg-ld CONTAINER_PORT=80 # override defaults (in production)
```

Note: other `make` rules: `pull-image`, `build-image`, `start-srv`, `stop-srv`, `restart-srv`, `install-pkgs`, `get-rdf`, `import-rdf`, `update-rdf`, `post-install` and `clean`.

**3. [Login](http://localhost:8890/conductor) to running Virtuoso instance for admin tasks.**

Use `dba` for both account name and password.

**4. Run queries via Virtuoso [SPARQL endpoint](http://localhost:8890/sparql) or browse data via [Faceted Browser](http://localhost:8890/fct/) (no login required).**

RDF graphs:IRIs (_A-Box_)
  * SGN:
    * `http://solgenomics.net/genome/Solanum_lycopersicum`
    * `http://solgenomics.net/genome/Solanum_pennellii`
  * Ensembl: `http://plants.ensembl.org/Solanum_lycopersicum`
  * UniProt: `http://www.uniprot.org/proteomes/Solanum_lycopersicum`
  * QTLs: `http://europepmc.org/articles`

RDF graphs:IRIs (_T-Box_)
  * FALDO: `http://biohackathon.org/resource/faldo.rdf`
  * SO[FA]: `http://purl.obolibrary.org/obo/so.owl`
  * SIO: `http://semanticscience.org/ontology/sio.owl`
  * RO: `http://purl.obolibrary.org/obo/ro.owl`
  * GO: `http://purl.obolibrary.org/obo/go.owl`
  * UniProt Core: `http://purl.uniprot.org/core/`
  * PO: `http://purl.obolibrary.org/obo/po.owl`
  * TO: `http://purl.obolibrary.org/obo/to.owl`
  * SPTO: `http://purl.bioontology.org/ontology/SPTO`
  * PATO: `http://purl.obolibrary.org/obo/pato.owl`

Further details can be found on the [wiki](../../wiki).
