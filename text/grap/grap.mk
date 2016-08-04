#MAKE=/bin/make
MAKEFILE=grap.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
#LIBDIR=/usr/lib/dwb
LIBDIR=/usr/local/dwb/lib/dwb
MAN1DIR=/usr/man/u_man/man1

CFLGS=-Wall -Wextra
LDFLGS=-s

CFLAGS=$(CFLGS) -D'GRAPDEFINES="$(LIBDIR)/grap.defines"'
LDFLAGS=$(LDFLGS)
YFLAGS=-d

OFILES=main.o\
       input.o\
       print.o\
       frame.o\
       for.o\
       coord.o\
       ticks.o\
       plot.o\
       label.o\
       misc.o

all : grap

install : all
	@if [ ! -d $(LIBDIR) ]; then \
	    mkdir $(LIBDIR); \
	    chmod 755 $(LIBDIR); \
	    chgrp $(GROUP) $(LIBDIR); \
	    chown $(OWNER) $(LIBDIR); \
	fi
	cp grap $(BINDIR)/grap
	@chmod 755 $(BINDIR)/grap
	@chgrp $(GROUP) $(BINDIR)/grap
	@chown $(OWNER) $(BINDIR)/grap
	cp grap.defines $(LIBDIR)
	@chmod 644 $(LIBDIR)/grap.defines
	@chgrp $(GROUP) $(LIBDIR)/grap.defines
	@chown $(OWNER) $(LIBDIR)/grap.defines
	sed -e 's" /usr/lib/dwb$$" $(LIBDIR)"' \
	    grap.1 > $(MAN1DIR)/grap.1;
	@chmod 644 $(MAN1DIR)/grap.1
	@chgrp $(GROUP) $(MAN1DIR)/grap.1
	@chown $(OWNER) $(MAN1DIR)/grap.1

clean :
	rm -f *.o grap.c y.tab.h

clobber : clean
	rm -f grap

grap : $(OFILES) grap.o grapl.o
	$(CC) $(CFLAGS) $(LDFLAGS) -o grap grap.o grapl.o $(OFILES) -lm

$(OFILES) grapl.o :  grap.h grap.o
grap.o : grap.h grap.y

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^BINDIR=.*'BINDIR=$(BINDIR)'" \
	    -e "s'^LIBDIR=.*'LIBDIR=$(LIBDIR)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^.ds dL.*'.ds dL $(LIBDIR)'" \
	grap.1 >Xgrap.1; \
	mv Xgrap.1 grap.1

