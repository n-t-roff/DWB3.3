MAKE=/bin/make
MAKEFILE=dwbv.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
MAN1DIR=/usr/man/u_man/man1

all : dwbv

install : all
	cp dwbv $(BINDIR)/dwbv
	@chmod 755 $(BINDIR)/dwbv
	@chgrp $(GROUP) $(BINDIR)/dwbv
	@chown $(OWNER) $(BINDIR)/dwbv
	cp dwbv.1 $(MAN1DIR)/dwbv.1
	@chmod 644 $(MAN1DIR)/dwbv.1
	@chgrp $(GROUP) $(MAN1DIR)/dwbv.1
	@chown $(OWNER) $(MAN1DIR)/dwbv.1

clean :

clobber : clean
	rm -f dwbv

dwbv ::
	@echo "echo DWB $(VERSION)" >dwbv

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

