MAKE=/bin/make
MAKEFILE=mm.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
LIBDIR=/usr/lib/dwb
MAN1DIR=/usr/man/u_man/man1
PUBDIR=/usr/pub

all : mm

install : all
	@if [ ! -d $(LIBDIR) ]; then \
	    mkdir $(LIBDIR); \
	    chmod 755 $(LIBDIR); \
	    chgrp $(GROUP) $(LIBDIR); \
	    chown $(OWNER) $(LIBDIR); \
	fi
	cp mm $(BINDIR)/mm
	@chmod 755 $(BINDIR)/mm
	@chgrp $(GROUP) $(BINDIR)/mm
	@chown $(OWNER) $(BINDIR)/mm
	cp terminals $(LIBDIR)
	@chmod 644 $(LIBDIR)/terminals
	@chgrp $(GROUP) $(LIBDIR)/terminals
	@chown $(OWNER) $(LIBDIR)/terminals
	cp mm.1 $(MAN1DIR)/mm.1
	@chmod 644 $(MAN1DIR)/mm.1
	@chgrp $(GROUP) $(MAN1DIR)/mm.1
	@chown $(OWNER) $(MAN1DIR)/mm.1

clean :

clobber : clean
	rm -f mm

mm : mm.sh
	cp mm.sh mm; chmod 755 mm

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^BINDIR=.*'BINDIR=$(BINDIR)'" \
	    -e "s'^LIBDIR=.*'LIBDIR=$(LIBDIR)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	    -e "s'^PUBDIR=.*'PUBDIR=$(PUBDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^LIBDIR=.*'LIBDIR=$(LIBDIR)'" \
	    -e "s'^PUBDIR=.*'PUBDIR=$(PUBDIR)'" \
	mm.sh >Xmm.sh; \
	mv Xmm.sh mm.sh; \
	sed \
	    -e "s'^.ds dP.*'.ds dP $(PUBDIR)'" \
	mm.1 >Xmm.1; \
	mv Xmm.1 mm.1

