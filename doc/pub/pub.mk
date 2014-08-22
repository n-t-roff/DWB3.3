MAKE=/bin/make
MAKEFILE=pub.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

PUBDIR=/usr/pub

all :

install : all
	@if [ ! -d "$(PUBDIR)" ]; then \
	    mkdir -p $(PUBDIR); \
	    chmod 755 $(PUBDIR); \
	    chgrp $(GROUP) $(PUBDIR); \
	    chown $(OWNER) $(PUBDIR); \
	fi
	cp *.ps $(PUBDIR)
	@for i in *.ps; do \
	    chmod 644 $(PUBDIR)/$$i; \
	    chgrp $(GROUP) $(PUBDIR)/$$i; \
	    chown $(OWNER) $(PUBDIR)/$$i; \
	done

clean :

clobber : clean

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^PUBDIR=.*'PUBDIR=$(PUBDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE)

