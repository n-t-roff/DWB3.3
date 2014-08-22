#
# Makefile for the doc portion of the DWB package.
#

MAKE=/bin/make
MAKEFILE=doc.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

PUBDIR=/usr/pub

CURRENTDIR=.

#
# $(TARGETS) is the default list of things built by make.
#

TARGETS=pub\
	pub.att\
	pub.ext

ACTION=all

all : $(TARGETS)

clean clobber :
	@$(MAKE) -e -f $(MAKEFILE) MAKE=$(MAKE) ACTION=$@ $(TARGETS)

install :
	@SYSTEM='$(SYSTEM)'; export SYSTEM; \
	VERSION='$(VERSION)'; export VERSION; \
	GROUP='$(GROUP)'; export GROUP; \
	OWNER='$(OWNER)'; export OWNER; \
	PUBDIR='$(PUBDIR)'; export PUBDIR; \
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
	PUBDIR='$(PUBDIR)'; export PUBDIR; \
	$(MAKE) -e -f $(MAKEFILE) MAKE=$(MAKE) ACTION=$@ $(TARGETS)
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^PUBDIR=.*'PUBDIR=$(PUBDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE)

