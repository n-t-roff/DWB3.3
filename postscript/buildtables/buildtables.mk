MAKE=/bin/make
MAKEFILE=buildtables.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

FONTDIR=/usr/lib/font
POSTBIN=/usr/lbin/postscript
POSTLIB=/usr/lib/postscript
MAN1DIR=/usr/man/u_man/man1

all : buildtables

install : all
	@if [ ! -d $(POSTBIN) ]; then \
	    mkdir -p $(POSTBIN); \
	    chmod 755 $(POSTBIN); \
	    chgrp $(GROUP) $(POSTBIN); \
	    chown $(OWNER) $(POSTBIN); \
	fi
	cp buildtables $(POSTBIN)/buildtables
	@chmod 755 $(POSTBIN)/buildtables
	@chgrp $(GROUP) $(POSTBIN)/buildtables
	@chown $(OWNER) $(POSTBIN)/buildtables
	sed -e 's" /usr/lib/font$$" $(FONTDIR)"' \
	    -e 's" /usr/lib/postscript$$" $(POSTLIB)"' \
	    buildtables.1 > $(MAN1DIR)/buildtables.1
	@chmod 644 $(MAN1DIR)/buildtables.1
	@chgrp $(GROUP) $(MAN1DIR)/buildtables.1
	@chown $(OWNER) $(MAN1DIR)/buildtables.1

clean :

clobber : clean
	rm -f buildtables

buildtables : buildtables.sh
	sed \
	    -e "s'^FONTDIR=.*'FONTDIR=$(FONTDIR)'" \
	    -e "s'^POSTBIN=.*'POSTBIN=$(POSTBIN)'" \
	    -e "s'^POSTLIB=.*'POSTLIB=$(POSTLIB)'" \
	buildtables.sh >buildtables
	@chmod 755 buildtables

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^FONTDIR=.*'FONTDIR=$(FONTDIR)'" \
	    -e "s'^POSTBIN=.*'POSTBIN=$(POSTBIN)'" \
	    -e "s'^POSTLIB=.*'POSTLIB=$(POSTLIB)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	$(MAKEFILE) >XXX.mk; \
	mv XXX.mk $(MAKEFILE); \
	sed \
	    -e "s'^.ds dF.*'.ds dF $(FONTDIR)'" \
	    -e "s'^.ds dQ.*'.ds dQ $(POSTLIB)'" \
	buildtables.1 >XXX.1; \
	mv XXX.1 buildtables.1

