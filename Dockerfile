FROM ghcr.io/candygene/virtuoso
LABEL description="pbg-ld: Linked Data Platform for Plant Breeding & Genomics"
LABEL maintainer="Arnold Kuzniar"
LABEL email="a.kuzniar@esciencecenter.nl"
LABEL orcid="0000-0003-1711-7961"
LABEL version="1.1.0"

ENV VOS_DATA_DIR=/tmp/pbg-ld/data
ENV VOS_ISQL="isql 1111 dba dba ECHO=ON VERBOSE=ON ERRORS=STDOUT"

WORKDIR /tmp
RUN python update_config.py -c ${VOS_CFG_FILE} \
    "Parameters:DirsAllowed=.,/usr/local/virtuoso-opensource/share/virtuoso/vad,${VOS_DATA_DIR}"
COPY src /tmp/pbg-ld/src
COPY data ${VOS_DATA_DIR}
WORKDIR /tmp/pbg-ld/src
RUN sed -i.org "s:__DATA_DIR__:${VOS_DATA_DIR}:" import_rdf.sql
RUN virtuoso-t +wait +configfile ${VOS_CFG_FILE} && \
    sleep 20 && \
    ${VOS_ISQL} EXEC=SHUTDOWN install_pkgs.sql import_rdf.sql update_rdf.sql post_install.sql
