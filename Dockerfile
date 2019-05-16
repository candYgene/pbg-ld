FROM candygene/docker-virtuoso:dev

ENV VOS_DATA_DIR=/tmp/pbg-ld/src/data
RUN pip install SPARQLWrapper
WORKDIR /tmp
RUN python update_config.py -c $VOS_CFG_FILE \
    "Parameters:DirsAllowed=.,/usr/local/virtuoso-opensource/share/virtuoso/vad,$VOS_DATA_DIR"
RUN mkdir /tmp/pbg-ld
COPY src /tmp/pbg-ld/src
COPY data /tmp/pbg-ld/data
WORKDIR /tmp/pbg-ld/data
RUN tar xvzf *.tar.gz rdf && \
    mv rdf $VOS_DATA_DIR
WORKDIR /tmp/pbg-ld/src/
RUN ./get_rdf.sh $VOS_DATA_DIR
RUN sed -i.org "s:__DATA_DIR__:$VOS_DATA_DIR:" import_rdf.sql
ENV VOS="isql 1111 dba dba ECHO=ON VERBOSE=ON ERRORS=STDOUT"
RUN virtuoso-t +wait +configfile $VOS_CFG_FILE && \
    sleep 20 && \
    $VOS install_pkgs.sql import_rdf.sql  && \
    python test.py $VOS_DATA_DIR/graphs.txt http://localhost:8890/sparql && \
    $VOS exec=shutdown update_rdf.sql post_install.sql
