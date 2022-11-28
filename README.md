# OWL

[`dogs.ttl`](dogs.ttl) is our dogs dataset. Note that this data does not use
OWL at all, and the meanings of the properties and classes used are
left unspecified.

[`ontology.ttl`](ontology.ttl) is an OWL ontology that specifies some meanings
for the properties and classes used in the dogs dataset. It also
defines some new classes that will allow us to infer which dogs are
Danes and which dogs are Lagotto Romagnolos.

The [`rules`](rules) directory contains logic rules used to implement
OWL+RDFS reasoning. We're only using the specific rules needed to make
the inferences we want to make.

Run `make` to generate:

* `inferred.ttl` which contains new triples inferred on the basis of
  the dataset, the ontology, and the rules.
* `all.html` which contains all the original triples in `dogs.ttl`
  plus the new triples inferred.

