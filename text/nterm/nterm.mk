MAKE=/bin/make
MAKEFILE=nterm.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

MAN5DIR=/usr/man/p_man/man5
NTERMDIR=/usr/lib/nterm

all :

install : all
	@if [ ! -d "$(NTERMDIR)" ]; then \
	    mkdir $(NTERMDIR); \
	    chmod 755 $(NTERMDIR); \
	    chgrp $(GROUP) $(NTERMDIR); \
	    chown $(OWNER) $(NTERMDIR); \
	fi
	cp tab.* $(NTERMDIR)
	@for i in tab.*; do \
	    chmod 644 $(NTERMDIR)/$$i; \
	    chgrp $(GROUP) $(NTERMDIR)/$$i; \
	    chown $(OWNER) $(NTERMDIR)/$$i; \
	done
	sed -e 's" /usr/lib/nterm$$" $(NTERMDIR)"' \
	    nterm.5 > $(MAN5DIR)/nterm.5
	@chmod 644 $(MAN5DIR)/nterm.5
	@chgrp $(GROUP) $(MAN5DIR)/nterm.5
	@chown $(OWNER) $(MAN5DIR)/nterm.5

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
	    -e "s'^NTERMDIR=.*'NTERMDIR=$(NTERMDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^.ds dN.*'.ds dN $(NTERMDIR)'" \
	nterm.5 >Xnterm.5; \
	mv Xnterm.5 nterm.5

