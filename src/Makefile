.PHONY: all pull-image build-image start-srv stop-srv restart-srv install-pkgs get-rdf import-rdf update-rdf post-install clean

VOS_USER = dba
VOS_PASS = dba
VOS_PORT = 1111
VOS_SHARE = /tmp/share
VOS = isql $(VOS_PORT) $(VOS_USER) $(VOS_PASS) verbose=off errors=stdout
DOCKER_IMAGE = candygene/docker-virtuoso
CONTAINER_NAME = virtuoso
CONTAINER_PORT = 8890
DATA_DIR = data

all: pull-image start-srv install-pkgs get-rdf import-rdf update-rdf post-install

pull-image:
	docker pull $(DOCKER_IMAGE)

start-srv:
	docker run --name $(CONTAINER_NAME) -v $(PWD):$(VOS_SHARE) -p $(CONTAINER_PORT):8890 -d $(DOCKER_IMAGE)
	sleep 20
	docker ps -a

stop-srv:
	docker stop $(CONTAINER_NAME)
	docker ps -a

restart-srv:
	docker restart $(CONTAINER_NAME)
	docker ps -a

install-pkgs:
	docker exec $(CONTAINER_NAME) $(VOS) install_pkgs.sql

get-rdf:
	./get_rdf.sh $(DATA_DIR)

import-rdf:
	tar xvzf ../data/*.tar.gz -C ../data && mv ../data/rdf/* $(DATA_DIR)
	sed -i.org "s:__DATA_DIR__:$(DATA_DIR):" import_rdf.sql
	docker exec $(CONTAINER_NAME) $(VOS) import_rdf.sql

update-rdf:
	docker exec $(CONTAINER_NAME) $(VOS) update_rdf.sql

post-install:
	docker exec $(CONTAINER_NAME) $(VOS) post_install.sql

clean:
	rm -fr $(DATA_DIR)
