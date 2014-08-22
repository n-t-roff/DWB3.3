MAKE=/bin/make
MAKEFILE=manshell.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin

all : man

install : all
	cp man $(BINDIR)/man
	@chmod 755 $(BINDIR)/man
	@chgrp $(GROUP) $(BINDIR)/man
	@chown $(OWNER) $(BINDIR)/man

clean :

clobber : clean
	rm -f man

man : man.sh
	cp man.sh man; chmod 755 man

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^BINDIR=.*'BINDIR=$(BINDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE)

