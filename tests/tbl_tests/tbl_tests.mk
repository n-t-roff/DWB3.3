MAKE=/bin/make
MAKEFILE=tbl_tests.mk

SYSTEM=SYSV

MACROS=-mm
TDEVNAME=post

all :
	for i in tbl??; do \
		mv $$i.more $$i.more.orig; \
		pic $$i | tbl | neqn | nroff $(MACROS) | col -x > $$i.more; \
		diff $$i.more $$i.more.orig; \
		rm $$i.more; \
		mv $$i.more.orig $$i.more; \
		mv $$i.ps $$i.ps.orig; \
		pic $$i | tbl | eqn | troff -T$(TDEVNAME) $(MACROS) | \
		    dpost > $$i.ps; \
		diff $$i.ps $$i.ps.orig; \
		rm $$i.ps; \
		mv $$i.ps.orig $$i.ps; \
	done

install : all
	@if [ ! -d ../$(SYSTEM) ]; then \
	    mkdir ../$(SYSTEM); \
	    chmod 755 ../$(SYSTEM); \
	fi
	cp *.out ../$(SYSTEM)
	@chmod 644 ../$(SYSTEM)/*.out

clean :
	rm -f *.more *.ps *.orig

clobber : clean

changes :

