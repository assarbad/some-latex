.PHONY: all clean CLEAN rebuild
TARGETS:=Pimsleur-Swedish.pdf

all: $(TARGETS)

%.pdf: %.tex
	latexmk -lualatex $<

CLEAN: clean
	rm -f $(TARGETS)

clean:
	rm -f *.aux *.log *.out *.synctex.gz *.fdb_latexmk *.fls

rebuild: CLEAN all
