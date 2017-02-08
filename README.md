# Tomato [SGN](https://solgenomics.net/) Linked Data deployment

**1. Build a [Docker](https://www.docker.com/) container with [Virtuoso Universal Server](http://virtuoso.openlinksw.com/) (open source edition).**

```
cd src
docker build -t vos .
```

**2. Start the Virtuoso server.**

`docker run --name vlpb -v $PWD:/tmp/share -p 8890:8890 -d vos`

**3. Prepare & ingest RDF data.**

```
tar xvzf ../data/sgn-ld.tar.gz -C ../data
mv ../data/rdf/* .
docker exec vlpb make all
```

**4. [Login](http://localhost:8890/conductor) to running Virtuoso instance for admin tasks.**

Use `dba` for both account name and password.

**5. Run queries via Virtuoso [SPARQL endpoint](http://localhost:8890/sparql) or browse data via [Faceted Browser](http://localhost:8890/fct/) (no login required).**

RDF graphs (IRIs):
  * SGN:
    * `http://solgenomics.net/genome/Solanum_lycopersicum`
    * `http://solgenomics.net/genome/Solanum_pennellii`
  * Ensembl: `http://plants.ensembl.org/Solanum_lycopersicum`
  * UniProt: `http://www.uniprot.org/proteomes/Solanum_lycopersicum`

For further details visit the [wiki](https://github.com/DTL-FAIRData/ODEX4all-UseCases/wiki/VLPB) page.
