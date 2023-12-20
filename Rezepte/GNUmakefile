BASENAME:=dal-makhni Mürbeplätzchen Brownies Pfefferkuchen Einheitentabelle
TEX:=$(addsuffix .tex,$(BASENAME))
# The following list also includes the generated .tex files
TEXMORE:=$(TEX) Mürbeplätzchen-Fraktur.tex Pfefferkuchen-Fraktur.tex
ALL:=$(TEXMORE:.tex=.pdf)
INTERMEDIATE:=$(TEXMORE:.tex=.aux) $(TEXMORE:.tex=.fdb_latexmk) $(TEXMORE:.tex=.fls) $(TEXMORE:.tex=.log) $(TEXMORE:.tex=.nav) $(TEXMORE:.tex=.out) $(TEXMORE:.tex=.snm) $(TEXMORE:.tex=.synctex.gz) $(TEXMORE:.tex=.toc) $(TEXMORE:.tex=.vrb)

all: $(ALL)

%.pdf: %.tex
	-@echo "NOTE: use 'luaotfload-tool -u' if you experience any looping of latexmk"
	latexmk -f -pdflatex=lualatex -pdf -synctex=1 -interaction=nonstopmode $<

Mürbeplätzchen: Mürbeplätzchen-Fraktur.pdf Mürbeplätzchen.pdf
Pfefferkuchen: Pfefferkuchen-Fraktur.pdf Pfefferkuchen.pdf

Plätzchen: Plätzchen.tar
Plätzchen.tar: Mürbeplätzchen Pfefferkuchen
	tar -cvf $@ $(addsuffix *.pdf,$^)

%-Fraktur.tex: %.tex
	sed '/\\documentclass/ s|,fraktur=false|,fraktur=true|' $< > $@

dustoff:
	rm -f $(wildcard $(INTERMEDIATE))

clean CLEAN: dustoff
	rm -f $(wildcard $(TEXMORE:.tex=.pdf) *-Fraktur.tex) Plätzchen.tar

rebuild: clean all
REBUILD: CLEAN all

.INTERMEDIATE: $(INTERMEDIATE)
.PHONY: all clean CLEAN rebuild REBUILD dustoff Pfefferkuchen Mürbeplätzchen Plätzchen
