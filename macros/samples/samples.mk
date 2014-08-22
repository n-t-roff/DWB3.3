#
# Makefile for sample files.
#

MAKE=/bin/make
MAKEFILE=samples.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

LIBDIR=/usr/lib/dwb

all :

install :
	@if [ ! -d "$(LIBDIR)" ]; then \
	    mkdir $(LIBDIR); \
	    chmod 755 $(LIBDIR); \
	    chgrp $(GROUP) $(LIBDIR); \
	    chown $(OWNER) $(LIBDIR); \
	fi
	@if [ ! -d "$(LIBDIR)/samples" ]; then \
	    mkdir $(LIBDIR)/samples; \
	    chmod 755 $(LIBDIR)/samples; \
	    chgrp $(GROUP) $(LIBDIR)/samples; \
	    chown $(OWNER) $(LIBDIR)/samples; \
	fi
	cp nroff.* mm.* tbl.* eqn.* troff.* pic.* $(LIBDIR)/samples
	@for i in nroff.* mm.* tbl.* eqn.* troff.* pic.*; do \
	    chmod 664 $(LIBDIR)/samples/$$i; \
	    chgrp $(GROUP) $(LIBDIR)/samples/$$i; \
	    chown $(OWNER) $(LIBDIR)/samples/$$i; \
	done

clean clobber :

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^LIBDIR=.*'LIBDIR=$(LIBDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE)

