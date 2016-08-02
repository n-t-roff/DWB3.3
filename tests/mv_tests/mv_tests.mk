MAKE=/bin/make
MAKEFILE=mv_tests.mk

SYSTEM=SYSV

MACROS=-mv
TDEVNAME=post

all :
	for i in mv??; do \
		mv $$i.more $$i.more.orig; \
		pic $$i | tbl | neqn | nroff -mv | col -x | \
		    sed 's"[0-9]\{1,2\}/[0-9]\{1,2\}/[0-9]\{4\}"2/4/1993"g' \
		    > $$i.more; \
		if diff $$i.more $$i.more.orig; then \
			rm $$i.more; \
			mv $$i.more.orig $$i.more; \
		fi; \
		mv $$i.ps $$i.ps.orig; \
		pic $$i | tbl | eqn | troff -mv -T$(TDEVNAME) | dpost | \
		    sed 's"[0-9]\{1,2\}/[0-9]\{1,2\}/[0-9]\{4\}"2/4/1993"g' \
		    > $$i.ps; \
		if diff $$i.ps $$i.ps.orig; then \
			rm $$i.ps; \
			mv $$i.ps.orig $$i.ps; \
		fi; \
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

