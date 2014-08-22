MAKE=/bin/make
MAKEFILE=eqnchar.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

MAN5DIR=/usr/man/p_man/man5
PUBDIR=/usr/pub

all :

install : all
	@if [ ! -d "$(PUBDIR)" ]; then \
	    mkdir $(PUBDIR); \
	    chmod 755 $(PUBDIR); \
	    chgrp $(GROUP) $(PUBDIR); \
	    chown $(OWNER) $(PUBDIR); \
	fi
	cp *eqnchar $(PUBDIR)
	@for i in *eqnchar; do \
	    chmod 644 $(PUBDIR)/$$i; \
	    chgrp $(GROUP) $(PUBDIR)/$$i; \
	    chown $(OWNER) $(PUBDIR)/$$i; \
	done
	cp eqnchar.5 $(MAN5DIR)/eqnchar.5
	@chmod 644 $(MAN5DIR)/eqnchar.5
	@chgrp $(GROUP) $(MAN5DIR)/eqnchar.5
	@chown $(OWNER) $(MAN5DIR)/eqnchar.5

clean :

clobber : clean

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^MAN5DIR=.*'MAN5DIR=$(MAN5DIR)'" \
	    -e "s'^PUBDIR=.*'PUBDIR=$(PUBDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^.ds dP.*'.ds dP $(PUBDIR)'" \
	eqnchar.5 >Xeqnchar.5; \
	mv Xeqnchar.5 eqnchar.5

