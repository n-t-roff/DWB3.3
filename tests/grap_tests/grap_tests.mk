MAKE=/bin/make
MAKEFILE=grap_tests.mk

SYSTEM=SYSV

MACROS=-mm
TDEVNAME=post
TROFF=TRUE

all :
	@for i in grap??; do \
	    if [ -f "$$i" ]; then \
		if [ $(TROFF) = FALSE ]; \
		    then \
			echo "	grap $$i >$$i.out"; \
			grap $$i >$$i.out; \
		    else \
			echo "	grap $$i | pic | tbl | eqn | troff -T$(TDEVNAME) $(MACROS)>$$i.out"; \
			grap $$i | pic | tbl | eqn | troff -T$(TDEVNAME) $(MACROS)>$$i.out; \
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

