SHELL := /usr/bin/env bash
RULES := $(shell find rules -name '*.n3')

.PHONY: \
all clean superclean \
lagottos danes birthplace-is-denmark has-a-dane-ancestor

all: all.ttl

clean:
	rm -f inferred.ttl all.ttl

superclean: clean
	$(MAKE) -s -C tools/eye clean
	$(MAKE) -s -C tools/jena clean

lagottos: all.ttl queries/lagottos.rq | tools/jena/bin/arq
	./tools/jena/bin/arq --data $< --query $(word 2,$^)

danes: all.ttl queries/danes.rq | tools/jena/bin/arq
	./tools/jena/bin/arq --data $< --query $(word 2,$^)

birthplace-is-denmark: \
all.ttl queries/birthplace-is-denmark.rq | tools/jena/bin/arq
	./tools/jena/bin/arq --data $< --query $(word 2,$^)

has-a-dane-ancestor: \
all.ttl queries/has-a-dane-ancestor.rq | tools/jena/bin/arq
	./tools/jena/bin/arq --data $< --query $(word 2,$^)

tools/eye/bin/eye:
	$(MAKE) -s -C tools/eye

tools/jena/bin/arq \
tools/jena/bin/riot:
	$(MAKE) -s -C tools/jena

inferred.ttl: \
$(RULES) ontology.ttl dogs.ttl \
| tools/eye/bin/eye tools/jena/bin/riot
	./tools/eye/bin/eye $^ --pass-only-new \
	| ./tools/jena/bin/riot --syntax=ttl --formatted=ttl - \
	> $@

all.ttl: ontology.ttl dogs.ttl inferred.ttl | tools/jena/bin/riot
	./tools/jena/bin/riot --formatted=ttl $^ \
	> $@
