# pbg-ld: Linked Data Platform for Plant Breeding & Genomics

[![Build Status](https://travis-ci.org/candYgene/pbg-ld.svg?branch=dev)](https://travis-ci.org/candYgene/pbg-ld)
https://hub.docker.com/r/candygene/pbg-ld

[![Docker Automated Build](https://img.shields.io/docker/automated/candygene/pbg-ld.svg?logo=docker)](https://hub.docker.com/r/candygene/pbg-ld)

The _pbg-ld_ software provides access to semantically integrated geno- &
pheno-typic data on [Solanaceae](http://dbpedia.org/resource/Solanaceae) species
(such as tomato and potato) and enables ranking of candidate genes associated
with traits of interest.

## Prerequisites

-   [Docker CE](https://docs.docker.com/install/) (e.g., on Ubuntu)
-   [Docker Compose](https://docs.docker.com/compose/install/)
-   [Ansible](https://www.ansible.com/)

## Install & deploy

**1. Clone this repository.**

```bash
git clone https://github.com/candYgene/pbg-ld.git
cd pbg-ld
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

Note: `grlc` requires (remote) access to a GitHub repo with SPARQL
[queries](https://github.com/candYgene/queries). For this, edit
`docker-compose.yml` file and set the environment variables:

-   `GRLC_GITHUB_ACCESS_TOKEN`
-   `GRLC_SERVER_NAME` (don't include URI scheme `http(s)//:`)
-   `GRLC_SPARQL_ENDPOINT`

Alternatively, deploy the services on a remote server using Ansible Playbook.

`ansible-playbook -i inventory playbook.yml`

**3. Access (meta)data in RDF.**

-   Virtuoso [Faceted Browser](http://localhost:8890/fct/) and
    [SPARQL endpoint](http://localhost:8890/sparql)
-   grlc [Web API](http://localhost:8088/api/candYgene/queries/)
-   FAIR Data Point [API](http://localhost:8080/)

Note: For admin tasks on Virtuoso, [login](http://localhost:8890/conductor) to
an instance (use `dba` for both account name and password).

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
