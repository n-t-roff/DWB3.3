MAKE=/bin/make
MAKEFILE=postnprint.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

MAN1DIR=/usr/man/u_man/man1
POSTBIN=/usr/lbin/postscript
POSTLIB=/usr/lib/postscript

COMMONDIR=../common

CFLGS=-O
LDFLGS=-s

CFLAGS=$(CFLGS) -I$(COMMONDIR)
LDFLAGS=$(LDFLGS)

HFILES=postnprint.h\
       $(COMMONDIR)/comments.h\
       $(COMMONDIR)/ext.h\
       $(COMMONDIR)/gen.h\
       $(COMMONDIR)/path.h

OFILES=postnprint.o\
       $(COMMONDIR)/glob.o\
       $(COMMONDIR)/misc.o\
       $(COMMONDIR)/request.o

all : postnprint

install : all
	@if [ ! -d "$(POSTBIN)" ]; then \
	    mkdir $(POSTBIN); \
	    chmod 755 $(POSTBIN); \
	    chgrp $(GROUP) $(POSTBIN); \
	    chown $(OWNER) $(POSTBIN); \
	fi
	@if [ ! -d "$(POSTLIB)" ]; then \
	    mkdir $(POSTLIB); \
	    chmod 755 $(POSTLIB); \
	    chgrp $(GROUP) $(POSTLIB); \
	    chown $(OWNER) $(POSTLIB); \
	fi
	cp postnprint $(POSTBIN)/postnprint
	@chmod 755 $(POSTBIN)/postnprint
	@chgrp $(GROUP) $(POSTBIN)/postnprint
	@chown $(OWNER) $(POSTBIN)/postnprint
	cp postnprint.ps $(POSTLIB)/postnprint.ps
	@chmod 644 $(POSTLIB)/postnprint.ps
	@chgrp $(GROUP) $(POSTLIB)/postnprint.ps
	@chown $(OWNER) $(POSTLIB)/postnprint.ps
	cp postnprint.1 $(MAN1DIR)/postnprint.1
	@chmod 644 $(MAN1DIR)/postnprint.1
	@chgrp $(GROUP) $(MAN1DIR)/postnprint.1
	@chown $(OWNER) $(MAN1DIR)/postnprint.1

clean :
	rm -f *.o

clobber : clean
	rm -f postnprint

postnprint : $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o postnprint $(OFILES)

postnprint.o : $(HFILES)

$(COMMONDIR)/glob.o\
$(COMMONDIR)/misc.o\
$(COMMONDIR)/request.o :
	@cd $(COMMONDIR); $(MAKE) -f common.mk $(@F)

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	    -e "s'^POSTBIN=.*'POSTBIN=$(POSTBIN)'" \
	    -e "s'^POSTLIB=.*'POSTLIB=$(POSTLIB)'" \
	$(MAKEFILE) >XXX.mk; \
	mv XXX.mk $(MAKEFILE); \
	sed \
	    -e "s'^.ds dQ.*'.ds dQ $(POSTLIB)'" \
	postnprint.1 >XXX.1; \
	mv XXX.1 postnprint.1

