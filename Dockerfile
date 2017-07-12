FROM candygene/docker-virtuoso

WORKDIR /root
COPY src/get_rdf.sh       get_rdf.sh
RUN ./get_rdf.sh /root/data

COPY src/install_pkgs.sql install_pkgs.sql
COPY src/import_rdf.sql   import_rdf.sql
COPY src/update_rdf.sql   update_rdf.sql
COPY src/post_install.sql post_install.sql

COPY DockerScripts/processData.sh processData.sh
RUN ./processData.sh

COPY DockerScripts/loadData.sh loadData.sh
RUN ./loadData.sh

CMD virtuoso-t +wait +foreground +configfile ${VOS_CONFIG}
