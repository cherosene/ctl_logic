OCAMLC = ocamlopt.opt -thread -I /usr/lib/ocaml/camlimages graphics.cmxa camlimages_core.cmxa camlimages_graphics.cmxa unix.cmxa threads.cmxa
OCAML = ocaml

EXE4 = stl_test4

PARSOBJ = lexer.cmx parser.cmx

# Quarto test

test : compile $(EXE4)
	rlwrap ./$(EXE4) data/map data/time.dot data/formula.fr

compile : obj_1 parsergraph obj_2 parser

$(EXE4) : StlLogic.cmx Graph.cmx Model.cmx StlConvert.cmx Interface.cmx lexerGraph.cmx parserGraph.cmx Test.cmx main.ml
	$(OCAMLC) $(PARSOBJ) $^ -o $@

obj_1 : StlLogic.ml Graph.ml Model.ml StlConvert.ml Interface.ml
	$(OCAMLC) -c $^

obj_2 : Test.ml
	$(OCAMLC) -c $^

parser :
	ocamllex lexer.mll
	ocamlyacc parser.mly
	$(OCAMLC) -c parser.mli
	$(OCAMLC) -c lexer.ml
	$(OCAMLC) -c parser.ml

parsergraph :
	ocamllex lexerGraph.mll
	ocamlyacc parserGraph.mly
	$(OCAMLC) -c parserGraph.mli
	$(OCAMLC) -c lexerGraph.ml
	$(OCAMLC) -c parserGraph.ml





# Comandi per pulizia

almostclean :
	rm -f *.cm* *~ \#* *.o

clean : almostclean
	rm -f $(EXE1) $(EXE2) $(EXE3) $(EXE4) $(EXE5) $(EXE6)
