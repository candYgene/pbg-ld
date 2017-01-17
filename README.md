# Tomato [SGN](https://solgenomics.net/) Linked Data deployment

**1. Build a [Docker](https://www.docker.com/) container with [Virtuoso Universal Server](http://virtuoso.openlinksw.com/) (open source edition).**

```
cd src
docker build -t nlesc/virtuoso .
```

**2. Start the server.**

`docker run --name vlpb -v $(pwd):/tmp/share -p 8890:8890 -d nlesc/virtuoso`

**3. Build & deploy tomato SGN-LD.**

```
tar xvzf ../data/SGN.tar.gz -C ../data
mv ../data/*.ttl .
docker exec vlpb ./build.sh
```
**4. [Login](http://localhost:8890/conductor) to running Virtuoso instance for admin tasks.**

Use `dba` for both account name and password.

**5. Query tomato SGN-LD via Virtuoso [SPARQL endpoint](http://localhost:8890/sparql) or [Faceted Browser](http://localhost:8890/fct/) (no login required).**

RDF graphs (IRIs):

* SGN: `http://solgenomics.net/genome/Solanum_lycopersicum`

* SGN: `http://solgenomics.net/genome/Solanum_pennellii`

* Ensembl Plants: `http://plants.ensembl.org/Solanum_lycopersicum`

* UniProt: `http://www.uniprot.org/proteomes/Solanum_lycopersicum`

For further details visit the [wiki](https://github.com/DTL-FAIRData/ODEX4all-UseCases/wiki/VLPB) page.
