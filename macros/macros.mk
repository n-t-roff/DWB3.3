#
# Makefile for macro packages.
#

MAKE=/bin/make
MAKEFILE=macros.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

LIBDIR=/usr/lib/dwb
MACRODIR=/usr/lib/macros
MAN1DIR=/usr/man/u_man/man1
MAN5DIR=/usr/man/p_man/man5
POSTLIB=/usr/lib/postscript
PUBDIR=/usr/pub
TMACDIR=/usr/lib/tmac

CURRENTDIR=.

CFLGS=-O
LDFLGS=-s

#
# $(TARGETS) is the default list of things built by make.
#

TARGETS=man\
	mcolor\
	mcs\
	mm\
	mpictures\
	mps\
	ms\
	msafe\
	mv\
	mview

ACTION=all

all : $(TARGETS)

clean clobber :
	@$(MAKE) -e -f $(MAKEFILE) MAKE=$(MAKE) ACTION=$@ $(TARGETS)

install :
	@SYSTEM='$(SYSTEM)'; export SYSTEM; \
	VERSION='$(VERSION)'; export VERSION; \
	GROUP='$(GROUP)'; export GROUP; \
	OWNER='$(OWNER)'; export OWNER; \
	LIBDIR='$(LIBDIR)';export LIBDIR; \
	MACRODIR='$(MACRODIR)'; export MACRODIR; \
	MAN1DIR='$(MAN1DIR)'; export MAN1DIR; \
	MAN5DIR='$(MAN5DIR)'; export MAN5DIR; \
	PUBDIR='$(PUBDIR)';export PUBDIR; \
	TMACDIR='$(TMACDIR)'; export TMACDIR; \
	$(MAKE) -e -f $(MAKEFILE) MAKE=$(MAKE) ACTION=$@ $(TARGETS)

$(TARGETS) ::
	@TARGETS=; unset TARGETS; \
	HFILES=; unset HFILES; \
	OFILES=; unset OFILES; \
	CFLAGS=; unset CFLAGS; \
	LDFLAGS=; unset LDFLAGS; \
	DOTSODIR=; unset DOTSODIR; \
	SYSTEM='$(SYSTEM)'; export SYSTEM; \
	VERSION='$(VERSION)'; export VERSION; \
	CFLGS='$(CFLGS)'; export CFLGS; \
	LDFLGS='$(LDFLGS)'; export LDFLGS; \
	if [ -d $@ -a -f $@/$@.mk ]; then \
	    cd $@; \
	    echo "---- Making $(ACTION) in directory $(CURRENTDIR)/$@ ----"; \
	    $(MAKE) -e -f $@.mk MAKE=$(MAKE) $(ACTION) && \
	    echo; \
	fi

changes :
	@SYSTEM='$(SYSTEM)'; export SYSTEM; \
	VERSION='$(VERSION)'; export VERSION; \
	GROUP='$(GROUP)'; export GROUP; \
	OWNER='$(OWNER)'; export OWNER; \
	LIBDIR='$(LIBDIR)'; export LIBDIR; \
	MACRODIR='$(MACRODIR)'; export MACRODIR; \
	MAN1DIR='$(MAN1DIR)'; export MAN1DIR; \
	MAN5DIR='$(MAN5DIR)'; export MAN5DIR; \
	POSTLIB='$(POSTLIB)'; export POSTLIB; \
	PUBDIR='$(PUBDIR)'; export PUBDIR; \
	TMACDIR='$(TMACDIR)'; export TMACDIR; \
	$(MAKE) -e -f $(MAKEFILE) MAKE=$(MAKE) ACTION=$@ $(TARGETS)
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^LIBDIR=.*'LIBDIR=$(LIBDIR)'" \
	    -e "s'^MACRODIR=.*'MACRODIR=$(MACRODIR)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	    -e "s'^MAN5DIR=.*'MAN5DIR=$(MAN5DIR)'" \
	    -e "s'^POSTLIB=.*'POSTLIB=$(POSTLIB)'" \
	    -e "s'^PUBDIR=.*'PUBDIR=$(PUBDIR)'" \
	    -e "s'^TMACDIR=.*'TMACDIR=$(TMACDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE)

