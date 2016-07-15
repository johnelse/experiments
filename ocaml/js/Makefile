test.js: test.byte
	js_of_ocaml $<

test.byte: test.ml
	ocamlfind ocamlc -package js_of_ocaml -package js_of_ocaml.graphics -package js_of_ocaml.syntax -syntax camlp4o -linkpkg $< -o $@

.PHONY: clean
clean:
	rm -f *.byte *.cmi *.cmo *.js
