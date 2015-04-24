MAKE=/bin/make
MAKEFILE=mmt.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
MAN1DIR=/usr/man/u_man/man1
PUBDIR=/usr/pub

all : mmt mvt

install : all
	cp mmt $(BINDIR)/mmt
	@chmod 755 $(BINDIR)/mmt
	@chgrp $(GROUP) $(BINDIR)/mmt
	@chown $(OWNER) $(BINDIR)/mmt
	cp mvt $(BINDIR)/mvt
	@chmod 755 $(BINDIR)/mvt
	@chgrp $(GROUP) $(BINDIR)/mvt
	@chown $(OWNER) $(BINDIR)/mvt
	for i in *.1; do \
		sed -e 's" /usr/pub$$" $(PUBDIR)"' \
		    $$i > $(MAN1DIR)/$$i; \
	done
	@chmod 644 $(MAN1DIR)/mmt.1
	@chgrp $(GROUP) $(MAN1DIR)/mmt.1
	@chown $(OWNER) $(MAN1DIR)/mmt.1
	@chmod 644 $(MAN1DIR)/mvt.1
	@chgrp $(GROUP) $(MAN1DIR)/mvt.1
	@chown $(OWNER) $(MAN1DIR)/mvt.1

clean :

clobber : clean
	rm -f mmt mvt

mmt : mmt.sh
	cp mmt.sh mmt; chmod 755 mmt

mvt : mmt.sh
	cp mmt.sh mvt; chmod 755 mvt

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^BINDIR=.*'BINDIR=$(BINDIR)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	    -e "s'^PUBDIR=.*'PUBDIR=$(PUBDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^PUBDIR=.*'PUBDIR=$(PUBDIR)'" \
	mmt.sh >Xmmt.sh; \
	mv Xmmt.sh mmt.sh; \
	sed \
	    -e "s'^.ds dP.*'.ds dP $(PUBDIR)'" \
	mmt.1 >Xmmt.1; \
	mv Xmmt.1 mmt.1; \
	sed \
	    -e "s'^.ds dP.*'.ds dP $(PUBDIR)'" \
	mvt.1 >Xmvt.1; \
	mv Xmvt.1 mvt.1

