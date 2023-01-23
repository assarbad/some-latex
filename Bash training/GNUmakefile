BASENAME:=surviving-the-unix-shell
TEX:=$(addsuffix .tex,$(BASENAME))
ALL:=$(TEX:.tex=.pdf)
ZIPFILE:=attachments/unix-survival.zip
INTERMEDIATE:=$(TEX:.tex=.aux) $(TEX:.tex=.fdb_latexmk) $(TEX:.tex=.fls) $(TEX:.tex=.log) $(TEX:.tex=.nav) $(TEX:.tex=.out) $(TEX:.tex=.snm) $(TEX:.tex=.synctex.gz) $(TEX:.tex=.toc) $(TEX:.tex=.vrb)

all: $(ALL)

%.pdf: %.tex
	-@echo "NOTE: use 'luaotfload-tool -u' if you experience any looping of latexmk"
	latexmk -f -pdflatex=lualatex -pdf -synctex=1 -interaction=nonstopmode $<

$(BASENAME).tex: olli-handout.cls zip

dustoff:
	rm -f $(INTERMEDIATE) $(ZIPFILE)

clean CLEAN: dustoff
	rm -f $(ALL:.tex=.pdf)

zip: $(ZIPFILE)
$(ZIPFILE): $(wildcard $(dir $(ZIPFILE))/*.sh)
	zip -9 $@ $^

rebuild: clean all
REBUILD: CLEAN all

.INTERMEDIATE: $(INTERMEDIATE)
.PHONY: all clean CLEAN rebuild REBUILD dustoff zip
