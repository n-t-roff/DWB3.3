#MAKE=/bin/make
MAKEFILE=picpack.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
MAN1DIR=/usr/man/u_man/man1
POSTBIN=/usr/lbin/postscript

COMMONDIR=../common

CFLGS=-O
LDFLGS=-s

CFLAGS=$(CFLGS) -I$(COMMONDIR)
LDFLAGS=$(LDFLGS)

HFILES=$(COMMONDIR)/ext.h\
       $(COMMONDIR)/gen.h\
       $(COMMONDIR)/path.h

OFILES=picpack.o\
       $(COMMONDIR)/glob.o\
       $(COMMONDIR)/misc.o\
       $(COMMONDIR)/tempnam.o

all : picpack

install : all
	@rm -f $(POSTBIN)/picpack
	cp picpack $(BINDIR)/picpack
	@chmod 755 $(BINDIR)/picpack
	@chgrp $(GROUP) $(BINDIR)/picpack
	@chown $(OWNER) $(BINDIR)/picpack
	cp picpack.1 $(MAN1DIR)/picpack.1
	@chmod 644 $(MAN1DIR)/picpack.1
	@chgrp $(GROUP) $(MAN1DIR)/picpack.1
	@chown $(OWNER) $(MAN1DIR)/picpack.1

clean :
	rm -f *.o

clobber : clean
	rm -f picpack

picpack : $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o picpack $(OFILES)

picpack.o : $(HFILES)

$(COMMONDIR)/glob.o\
$(COMMONDIR)/misc.o\
$(COMMONDIR)/tempnam.o :
	@cd $(COMMONDIR); $(MAKE) -f common.mk SYSTEM=$(SYSTEM) $(@F)

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^BINDIR=.*'BINDIR=$(BINDIR)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	    -e "s'^POSTBIN=.*'POSTBIN=$(POSTBIN)'" \
	$(MAKEFILE) >XXX.mk; \
	mv XXX.mk $(MAKEFILE)

