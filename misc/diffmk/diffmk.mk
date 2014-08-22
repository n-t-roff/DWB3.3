MAKE=/bin/make
MAKEFILE=diffmk.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
MAN1DIR=/usr/man/u_man/man1

all : diffmk

install : all
	cp diffmk $(BINDIR)/diffmk
	@chmod 755 $(BINDIR)/diffmk
	@chgrp $(GROUP) $(BINDIR)/diffmk
	@chown $(OWNER) $(BINDIR)/diffmk
	cp diffmk.1 $(MAN1DIR)/diffmk.1
	@chmod 644 $(MAN1DIR)/diffmk.1
	@chgrp $(GROUP) $(MAN1DIR)/diffmk.1
	@chown $(OWNER) $(MAN1DIR)/diffmk.1

clean :

clobber : clean
	rm -f diffmk

diffmk : diffmk.sh
	cp diffmk.sh diffmk; chmod 755 diffmk

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^BINDIR=.*'BINDIR=$(BINDIR)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE)

