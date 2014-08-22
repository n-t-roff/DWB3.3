#
# Runs troff, preprocessor, and macro tests.
#

MAKE=/bin/make
MAKEFILE=tests.mk

SYSTEM=SYSV

MACROS=-mm
TDEVNAME=post
TROFF=TRUE

CURRENTDIR=.

#
# $(TARGETS) is the default list of things built by make.
#

TARGETS=eqn_tests\
	grap_tests\
	mm_tests\
	mv_tests\
	mview_tests\
	pic_tests\
	picasso_tst\
	tbl_tests

ACTION=all

all : $(TARGETS)

clean clobber :
	@$(MAKE) -e -f $(MAKEFILE) MAKE=$(MAKE) ACTION=$@ $(TARGETS)

install :
	@$(MAKE) -e -f $(MAKEFILE) MAKE=$(MAKE) ACTION=$@ $(TARGETS)

$(TARGETS) ::
	@SYSTEM='$(SYSTEM)'; export SYSTEM; \
	MACROS='$(MACROS)'; export MACROS; \
	TDEVNAME='$(TDEVNAME)'; export TDEVNAME; \
	TROFF='$(TROFF)'; export TROFF; \
	if [ -d $@ -a -f $@/$@.mk ]; then \
	    cd $@; \
	    echo "---- Making $(ACTION) in directory $(CURRENTDIR)/$@ ----"; \
	    $(MAKE) -e -f $@.mk MAKE=$(MAKE) $(ACTION); \
	    echo; \
	fi

changes :
	@SYSTEM='$(SYSTEM)'; export SYSTEM; \
	MACROS='$(MACROS)'; export MACROS; \
	TDEVNAME='$(TDEVNAME)'; export TDEVNAME; \
	TROFF='$(TROFF)'; export TROFF; \
	$(MAKE) -e -f $(MAKEFILE) MAKE=$(MAKE) ACTION=$@ $(TARGETS)
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^TDEVNAME=.*'TDEVNAME=$(TDEVNAME)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE)

