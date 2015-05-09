#
# Makefile for the text portion of the DWB package.
#

MAKE=/bin/make
MAKEFILE=text.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

HYPHALG=0
NDEVNAME=37
TDEVNAME=post

BINDIR=/usr/bin
FONTDIR=/usr/lib/font
LIBDIR=/usr/lib/dwb
MACRODIR=/usr/lib/macros
MAN1DIR=/usr/man/u_man/man1
MAN5DIR=/usr/man/p_man/man5
NTERMDIR=/usr/lib/nterm
PUBDIR=/usr/pub
TMACDIR=/usr/lib/tmac

CURRENTDIR=.

CFLGS=-O
LDFLGS=-s

#
# $(TARGETS) is the default list of things built by make.
#

TARGETS=devnroff\
	devnroff-12\
	dnroff\
	eqn\
	eqnchar\
	grap\
	neqn\
	nterm\
	pic\
	picasso\
	pm\
	tbl\
	otbl\
	troff

ACTION=all

all : $(TARGETS)

clean clobber :
	@$(MAKE) -e -f $(MAKEFILE) MAKE=$(MAKE) ACTION=$@ $(TARGETS)

install :
	@SYSTEM='$(SYSTEM)'; export SYSTEM; \
	VERSION='$(VERSION)'; export VERSION; \
	GROUP='$(GROUP)'; export GROUP; \
	OWNER='$(OWNER)'; export OWNER; \
	NDEVNAME='$(NDEVNAME)'; export NDEVNAME; \
	TDEVNAME='$(TDEVNAME)'; export TDEVNAME; \
	HYPHALG='$(HYPHALG)'; export HYPHALG; \
	BINDIR='$(BINDIR)'; export BINDIR; \
	FONTDIR='$(FONTDIR)'; export FONTDIR; \
	LIBDIR='$(LIBDIR)'; export LIBDIR; \
	MACRODIR='$(MACRODIR)'; export MACRODIR; \
	MAN1DIR='$(MAN1DIR)'; export MAN1DIR; \
	MAN5DIR='$(MAN5DIR)'; export MAN5DIR; \
	NTERMDIR='$(NTERMDIR)'; export NTERMDIR; \
	PUBDIR='$(PUBDIR)'; export PUBDIR; \
	TMACDIR='$(TMACDIR)'; export TMACDIR; \
	$(MAKE) -e -f $(MAKEFILE) MAKE=$(MAKE) ACTION=$@ $(TARGETS)

$(TARGETS) ::
	@TARGETS=; unset TARGETS; \
	HFILES=; unset HFILES; \
	OFILES=; unset OFILES; \
	CFLAGS=; unset CFLAGS; \
	LDFLAGS=; unset LDFLAGS; \
	YFLAGS=; unset YFLAGS; \
	SYSTEM='$(SYSTEM)'; export SYSTEM; \
	VERSION='$(VERSION)'; export VERSION; \
	CXX='$(CXX)'; export CXX; \
	LEX='$(LEX)'; export LEX; \
	CFLGS='$(CFLGS)'; export CFLGS; \
	LDFLGS='$(LDFLGS)'; export LDFLGS; \
	if [ -d $@ -a -f $@/$@.mk ]; then \
	    cd $@; \
	    echo "---- Making $(ACTION) in directory $(CURRENTDIR)/$@ ----"; \
	    $(MAKE) -e -f $@.mk MAKE=$(MAKE) $(ACTION); \
	    echo; \
	fi

changes :
	@SYSTEM='$(SYSTEM)'; export SYSTEM; \
	VERSION='$(VERSION)'; export VERSION; \
	GROUP='$(GROUP)'; export GROUP; \
	OWNER='$(OWNER)'; export OWNER; \
	HYPHALG='$(HYPHALG)'; export HYPHALG; \
	NDEVNAME='$(NDEVNAME)'; export NDEVNAME; \
	TDEVNAME='$(TDEVNAME)'; export TDEVNAME; \
	BINDIR='$(BINDIR)'; export BINDIR; \
	FONTDIR='$(FONTDIR)'; export FONTDIR; \
	LIBDIR='$(LIBDIR)'; export LIBDIR; \
	MACRODIR='$(MACRODIR)'; export MACRODIR; \
	MAN1DIR='$(MAN1DIR)'; export MAN1DIR; \
	MAN5DIR='$(MAN5DIR)'; export MAN5DIR; \
	NTERMDIR='$(NTERMDIR)'; export NTERMDIR; \
	PUBDIR='$(PUBDIR)'; export PUBDIR; \
	TMACDIR='$(TMACDIR)'; export TMACDIR; \
	$(MAKE) -e -f $(MAKEFILE) MAKE=$(MAKE) ACTION=$@ $(TARGETS)
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^HYPHALG=.*'HYPHALG=$(HYPHALG)'" \
	    -e "s'^NDEVNAME=.*'NDEVNAME=$(NDEVNAME)'" \
	    -e "s'^TDEVNAME=.*'TDEVNAME=$(TDEVNAME)'" \
	    -e "s'^BINDIR=.*'BINDIR=$(BINDIR)'" \
	    -e "s'^FONTDIR=.*'FONTDIR=$(FONTDIR)'" \
	    -e "s'^LIBDIR=.*'LIBDIR=$(LIBDIR)'" \
	    -e "s'^MACRODIR=.*'MACRODIR=$(MACRODIR)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	    -e "s'^MAN5DIR=.*'MAN5DIR=$(MAN5DIR)'" \
	    -e "s'^NTERMDIR=.*'NTERMDIR=$(NTERMDIR)'" \
	    -e "s'^PUBDIR=.*'PUBDIR=$(PUBDIR)'" \
	    -e "s'^TMACDIR=.*'TMACDIR=$(TMACDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE)

