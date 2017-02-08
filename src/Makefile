.PHONY: all install-pkgs get-onto import-rdf update-rdf post-install clean

USER = dba
PASS = dba
PORT = 1111
LOG_FILE = virtuoso.log
ISQL = isql $(PORT) $(USER) $(PASS) verbose=off errors=stdout

all: install-pkgs get-onto import-rdf update-rdf post-install

install-pkgs:
	$(ISQL) install_pkgs.sql > $(LOG_FILE)

get-onto:
	./get_onto.sh >> $(LOG_FILE)

import-rdf:
	$(ISQL) import_rdf.sql >> $(LOG_FILE)

update-rdf:
	$(ISQL) update_rdf.sql >> $(LOG_FILE)

post-install:
	$(ISQL) post_install.sql >> $(LOG_FILE)

clean:
	rm -f *.rdf.*
