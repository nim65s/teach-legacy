PREFIX ?= public
SOURCES = $(filter-out README.md, $(wildcard */*/*.md))
OUTPUTS = $(SOURCES:%.md=public/%.pdf)
UML_SOURCES = $(wildcard media/*.uml)
UML_OUTPUTS = $(UML_SOURCES:%.uml=%.png)
DEST = "/usr/local/homepages/gsaurel/teach"

all: ${OUTPUTS} ${UML_OUTPUTS} public/index.html

media/%.png: media/%.uml
	plantuml $<

public/%.pdf: %.md
	mkdir -p public/$(shell dirname $<)
	pandoc -s \
		-t beamer \
		--highlight-style kate \
		--pdf-engine xelatex \
		-o $@ $<

public/index.html: ${SOURCES} index.py
	python3 index.py

check: all

deploy: check
	chmod a+r,g+w ${OUTPUTS}
	rsync -avzP --delete -e "ssh -o UserKnownHostsFile=.known_hosts" public/ gsaurel-deploy@memmos.laas.fr:${DEST}

clean:
	rm -f ${OUTPUTS} public/index.html

install: all
	if [ "$(PREFIX)" != "public" ]; then cp -r public/* $(PREFIX); fi

watch:
	watchexec -r -e md -c reset make -j
