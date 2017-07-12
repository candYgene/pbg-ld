# Linked Data Platform for Plant Breeding & Genomics

[![Build Status](https://travis-ci.org/candYgene/pbg-ld.svg?branch=master)](https://travis-ci.org/candYgene/pbg-ld)

This software provides semantically integrated genotypic/phenotypic data on plants to enable ranking of candidate genes associated with traits of interest (e.g. fruit ripening in tomato).

**1. Clone this git repo.**

`git clone https://github.com/candYgene/pbg-ld.git`

**2. Build a [Docker container](https://hub.docker.com/r/candygene/docker-virtuoso/) with [Virtuoso Universal Server](http://virtuoso.openlinksw.com/) & loaded data in [RDF](https://www.w3.org/RDF/).**

```
docker build -t myvirtuoso .
```

Note: building the container may take some time, as it must download the data, but once built, it will contain all your data and you can start it straight away. (Arnold: put the container in Dockerhub and then build time is irrelevant).

**3. Start your container.**

```
docker run -it --rm -p 8890:8890 myvirtuoso
```

**4. [Login](http://localhost:8890/conductor) to running Virtuoso instance for admin tasks.**

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
