LATEX=pdflatex
LATEXOPT=--shell-escape
NONSTOP=--interaction=nonstopmode
BIBTEX=bibtex

LATEXMK=latexmk
LATEXMKOPT=-pdf
CONTINUOUS=-pvc

BIBLIO=references
MAIN=main
SOURCES=$(MAIN).tex Makefile
FIGURES := $(shell find figures/* -type f)

all: $(MAIN).pdf

.refresh:
	touch .refresh

$(MAIN).pdf: $(MAIN).tex .refresh $(SOURCES) $(FIGURES)
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
            -pdflatex="$(LATEX) $(LATEXOPT) $(NONSTOP) %O %S" $(MAIN)
$(BIBLIO):
	$(BIBTEX) $(MAIN).aux

force:
	touch .refresh
	rm $(MAIN).pdf
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

clean:
	$(LATEXMK) -C $(MAIN)
	$(LATEXMK) -C $(MAIN)$(CHANGES_POSTFIX)
	rm -f $(MAIN).pdfsync
	rm -f $(MAIN)$(CHANGES_POSTFIX).pdfsync
	rm -rf *~ *.tmp
	rm -f *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk

once:
	$(LATEXMK) $(LATEXMKOPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

debug:
	$(LATEX) $(LATEXOPT) $(MAIN)

.PHONY: clean force once all debug
