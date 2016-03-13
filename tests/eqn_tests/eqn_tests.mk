MAKE=/bin/make
MAKEFILE=eqn_tests.mk

SYSTEM=SYSV

MACROS=-mm
TDEVNAME=post

all :
	for i in eqn??; do \
		pic $$i | tbl | neqn | nroff | col -x > $$i.more; \
		pic $$i | tbl | eqn | troff -T$(TDEVNAME) $(MACROS) | \
		    dpost > $$i.ps; \
	done

install : all
	@if [ ! -d ../$(SYSTEM) ]; then \
	    mkdir ../$(SYSTEM); \
	    chmod 755 ../$(SYSTEM); \
	fi
	cp *.out ../$(SYSTEM)
	@chmod 644 ../$(SYSTEM)/*.out

clean :
	rm -f *.more *.ps

clobber : clean

changes :

