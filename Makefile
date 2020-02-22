DOCS=$(wildcard dsd_*.tex) 
DOC=main
PWD=$(shell pwd)
DEPEND=Makefile $(wildcard *.sty) $(wildcard figs/*) $(wildcard src/*)

$(DOC).pdf: $(DOC).tex $(DEPEND)

%.pdf: %.tex $(DEPEND)
	@ - pdflatex -interaction=nonstopmode $< 2>&1 | tee out.txt || true
	@ echo "RUBBER:"
	@ - rubber-info $(<:pdf=log)   	

.PHONY: all
all: $(DOCS:.tex=.pdf)
	
.PHONY: tar
tar: clean
	echo $(DOCS)
	@ echo taring to file $(PWD).tgz...
	@ cd .. && tar cz --exclude=*~ --exclude=*.bak --exclude=Visio --exclude=OldExe -f $(PWD).tgz $(PWD) 
	
.PHONY: clean
clean:
	- @ rm -f out.txt *.vrb *.nav *.out *.snm *.log *.err *.dvi *.aux *.toc *.idx *.ilg *.ind *.pdf *.ps *.bbl *.blg *.backup
	- @ rm -f Figs/*-converted-to.pdf
