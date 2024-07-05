INFILE = main

BIB = ref/fire.bib  ref/fmc.bib ref/ml.bib 

pdf: $(INFILE).pdf

$(INFILE).pdf: $(INFILE).tex $(BIB) 
	pdflatex $(INFILE)
	bibtex $(INFILE)
	pdflatex $(INFILE)
	pdflatex $(INFILE)

mac: $(INFILE).pdf
	open $(INFILE).pdf

clean:
	-rm -f *.aux *.bbl *.out *.log *.thm *.blg

dos2unix:
	dos2unix *.tex Makefile ref/*.bib

sync: pdf dos2unix
	-git commit -a -m update
	git push
	-git push github

veryclean: clean
	-rm $(INFILE).pdf
	-git clean -fd

copy_ref:
	cp daseminar/references/{geo,other,ml,slides}.bib ref
