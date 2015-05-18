#
# Makefile for LaserJet support programs.
#

MAKE=/bin/make
MAKEFILE=laserjet.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
FONTDIR=/usr/lib/font
MAN1DIR=/usr/man/u_man/man1
MAN5DIR=/usr/man/p_man/man5
RASTDIR=/usr/lib/raster

CURRENTDIR=.

CFLGS=-O
LDFLGS=-s

#
# $(TARGETS) is the default list of things built by make.
#

TARGETS=devpcl\
	dpcl\
	rastpcl

ACTION=all

all : $(TARGETS)

clean clobber :
	@$(MAKE) -e -f $(MAKEFILE) MAKE=$(MAKE) ACTION=$@ $(TARGETS)

install :
	@SYSTEM='$(SYSTEM)'; export SYSTEM; \
	VERSION='$(VERSION)'; export VERSION; \
	GROUP='$(GROUP)'; export GROUP; \
	OWNER='$(OWNER)'; export OWNER; \
	BINDIR='$(BINDIR)'; export BINDIR; \
	FONTDIR='$(FONTDIR)'; export FONTDIR; \
	MAN1DIR='$(MAN1DIR)'; export MAN1DIR; \
	MAN5DIR='$(MAN5DIR)'; export MAN5DIR; \
	RASTDIR='$(RASTDIR)'; export RASTDIR; \
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
	BINDIR='$(BINDIR)'; export BINDIR; \
	FONTDIR='$(FONTDIR)'; export FONTDIR; \
	MAN1DIR='$(MAN1DIR)'; export MAN1DIR; \
	MAN5DIR='$(MAN5DIR)'; export MAN5DIR; \
	RASTDIR='$(RASTDIR)'; export RASTDIR; \
	$(MAKE) -e -f $(MAKEFILE) MAKE=$(MAKE) ACTION=$@ $(TARGETS)
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^BINDIR=.*'BINDIR=$(BINDIR)'" \
	    -e "s'^FONTDIR=.*'FONTDIR=$(FONTDIR)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	    -e "s'^MAN5DIR=.*'MAN5DIR=$(MAN5DIR)'" \
	    -e "s'^RASTDIR=.*'RASTDIR=$(RASTDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE)

