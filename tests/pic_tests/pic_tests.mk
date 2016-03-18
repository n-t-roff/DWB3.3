MAKE=/bin/make
MAKEFILE=pic_tests.mk

SYSTEM=SYSV

MACROS=-mm
TDEVNAME=post

all :
	for i in pic??; do \
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
	rm -f *.ps *.orig

clobber : clean

changes :

