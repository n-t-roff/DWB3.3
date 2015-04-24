MAKE=/bin/make
MAKEFILE=postplot.mk

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

CFLAGS=$(CFLGS) -I$(COMMONDIR)\
    -DPOSTLIB="\"$(POSTLIB)\""
LDFLAGS=$(LDFLGS)

HFILES=postplot.h\
       $(COMMONDIR)/comments.h\
       $(COMMONDIR)/ext.h\
       $(COMMONDIR)/gen.h\
       $(COMMONDIR)/path.h

OFILES=postplot.o\
       $(COMMONDIR)/glob.o\
       $(COMMONDIR)/misc.o\
       $(COMMONDIR)/request.o

all : postplot

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
	cp postplot $(POSTBIN)/postplot
	@chmod 755 $(POSTBIN)/postplot
	@chgrp $(GROUP) $(POSTBIN)/postplot
	@chown $(OWNER) $(POSTBIN)/postplot
	cp postplot.ps $(POSTLIB)/postplot.ps
	@chmod 644 $(POSTLIB)/postplot.ps
	@chgrp $(GROUP) $(POSTLIB)/postplot.ps
	@chown $(OWNER) $(POSTLIB)/postplot.ps
	sed -e 's" /usr/lib/postscript$$" $(POSTLIB)"' \
	    postplot.1 > $(MAN1DIR)/postplot.1
	@chmod 644 $(MAN1DIR)/postplot.1
	@chgrp $(GROUP) $(MAN1DIR)/postplot.1
	@chown $(OWNER) $(MAN1DIR)/postplot.1

clean :
	rm -f *.o

clobber : clean
	rm -f postplot

postplot : $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o postplot $(OFILES)

postplot.o : $(HFILES)

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
	postplot.1 >XXX.1; \
	mv XXX.1 postplot.1

