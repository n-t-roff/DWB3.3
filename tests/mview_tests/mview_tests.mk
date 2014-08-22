MAKE=/bin/make
MAKEFILE=mview_tests.mk

SYSTEM=SYSV

TDEVNAME=post

all :
	@for i in mview??; do \
	    if [ -f "$$i" ]; then \
		echo "	pic $$i | tbl | eqn | troff -mview -T$(TDEVNAME)>$$i.out"; \
		pic $$i | tbl | eqn | troff -mview -T$(TDEVNAME)>$$i.out; \
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
	rm -f *.out

clobber : clean

changes :

