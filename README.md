# pbg-ld: Linked Data Platform for Plant Breeding & Genomics

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1458168.svg)](https://doi.org/10.5281/zenodo.1458168)
[![Published in PeerJ](https://img.shields.io/badge/published%20in-Appl.Sci.-blue.svg)](https://doi.org/10.3390/app10196813)
[![CI](https://github.com/candYgene/pbg-ld/actions/workflows/docker-build.yaml/badge.svg?branch=master)](https://github.com/candYgene/pbg-ld/actions/workflows/docker-build.yaml)


The _pbg-ld_ software provides access to semantically integrated geno- &
pheno-typic data on [Solanaceae](http://dbpedia.org/resource/Solanaceae) species
(such as tomato and potato) and enables ranking of candidate genes associated
with traits of interest.

## Prerequisites

-   [Docker CE](https://docs.docker.com/install/)
-   [Docker Compose](https://docs.docker.com/compose/install/)
-   [Ansible](https://www.ansible.com/)

## Install & deploy

**1. Clone this repository.**

```bash
git clone https://github.com/candYgene/pbg-ld.git
```

**2. Start Docker service(s).**

-   `pbg-ld` - [Virtuoso](http://virtuoso.openlinksw.com/)-based RDF store including data 
-   `fdp` - [FAIR Data Point](https://www.research-software.nl/software/fairdatapoint) (requires _pbg-ld_)
-   `grlc` - [grlc WebAPI](https://www.research-software.nl/software/grlc) (requires _pbg-ld_)

```bash
cd pbg-ld
# list available services
docker-compose config --services
# start all services or one-by-one
docker-compose up -d # or add [SERVICE]
```

Alternatively, deploy the services on a remote server using Ansible Playbook.

```bash
ansible-playbook -i inventory playbook.yml
```

Note: `grlc` API can be deployed with SPARQL [queries](https://github.com/candYgene/queries) stored

-   locally (in the container)

```bash
git clone https://github.com/candYgene/queries.git
docker cp queries grlc:/home/grlc/
```

-   remotely (in a GitHub repo)

Set the environment variables in `docker-compose.yml`:

-   `GRLC_GITHUB_ACCESS_TOKEN`
-   `GRLC_SERVER_NAME` (or _CNAME_, excluding URI scheme `http(s)//:`)
-   `GRLC_SPARQL_ENDPOINT`


**3. Access (meta)data in RDF.**

-   Virtuoso [Conductor](http://localhost:8890/conductor/) use for admin tasks (default account name/password: `dba/dba`)
-   Virtuoso [Faceted Browser](http://localhost:8890/fct/)
-   Virtuoso [SPARQL endpoint](http://localhost:8890/sparql/)
-   grlc Web API using [local](http://localhost:8088/api-local/) or [remote](http://localhost:8088/api-git/candYgene/queries/) SPARQL queries
-   FAIR Data Point [API](http://localhost:8080/)

## Overview of datasets

RDF graphs:IRIs (_A-Box_)
  * SGN:
    * `http://solgenomics.net/genome/Solanum_lycopersicum`
    * `http://solgenomics.net/genome/Solanum_pennellii`
    * `http://solgenomics.net/genome/Solanum_tuberosum`
  * Ensembl:
    * `http://plants.ensembl.org/Solanum_lycopersicum`
    * `http://plants.ensembl.org/Solanum_tuberosum`
  * UniProt:
    * `http://www.uniprot.org/proteomes/Solanum_lycopersicum`
    * `http://www.uniprot.org/proteomes/Solanum_tuberosum`
  * QTLs: `http://europepmc.org`

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
