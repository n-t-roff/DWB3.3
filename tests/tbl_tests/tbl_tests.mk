MAKE=/bin/make
MAKEFILE=tbl_tests.mk

SYSTEM=SYSV

MACROS=-mm
TDEVNAME=post
TROFF=TRUE

all :
	@for i in tbl??; do \
	    if [ -f "$$i" ]; then \
		if [ $(TROFF) = FALSE ]; \
		    then \
			echo "	pic $$i | tbl >$$i.out"; \
			pic $$i | tbl >$$i.out; \
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

