MAKE=/bin/make
MAKEFILE=rastpcl.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

RASTDIR=/usr/lib/raster

all :

install : all
	@if [ ! -d $(RASTDIR) ]; then \
	    mkdir $(RASTDIR); \
	    chmod 755 $(RASTDIR); \
	    chgrp $(GROUP) $(RASTDIR); \
	    chown $(OWNER) $(RASTDIR); \
	fi
	@if [ ! -d $(RASTDIR)/rastpcl ]; then \
	    mkdir $(RASTDIR)/rastpcl; \
	    chmod 755 $(RASTDIR)/rastpcl; \
	    chgrp $(GROUP) $(RASTDIR)/rastpcl; \
	    chown $(OWNER) $(RASTDIR)/rastpcl; \
	fi
	cp [A-Z]*.* RAST* $(RASTDIR)/rastpcl
	@for i in [A-Z]*.* RAST*; do \
	    chmod 644 $(RASTDIR)/rastpcl/$$i; \
	    chgrp $(GROUP) $(RASTDIR)/rastpcl/$$i; \
	    chown $(OWNER) $(RASTDIR)/rastpcl/$$i; \
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
	    -e "s'^RASTDIR=.*'RASTDIR=$(RASTDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE)

