MAKE=/bin/make
MAKEFILE=eqn_tests.mk

SYSTEM=SYSV

MACROS=-mm
TDEVNAME=post
TROFF=TRUE

all :
	@for i in eqn??; do \
	    if [ -f "$$i" ]; then \
		if [ $(TROFF) = FALSE ]; \
		    then \
			echo "	pic $$i | tbl | eqn>$$i.out"; \
			pic $$i | tbl | eqn>$$i.out; \
		    else \
			echo "	pic $$i | tbl | eqn | troff -T$(TDEVNAME) $(MACROS)>$$i.out"; \
			pic $$i | tbl | eqn | troff -T$(TDEVNAME) $(MACROS)>$$i.out; \
		fi; \
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

