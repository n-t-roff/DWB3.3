#MAKE=/bin/make
MAKEFILE=dnroff.mk

SYSTEM=BSD4_2
VERSION=3.3

GROUP=bin
OWNER=bin

NDEVNAME=37

BINDIR=/usr/bin
FONTDIR=/usr/lib/font
MAN1DIR=/usr/man/u_man/man1
NTERMDIR=/usr/lib/nterm

CFLGS=-Wall -Wextra
LDFLGS=-s

CFLAGS=$(CFLGS) -D$(SYSTEM) -D'NDEVNAME="$(NDEVNAME)"' -D'NTERMDIR="$(NTERMDIR)"'
LDFLAGS=$(LDFLGS)

all : dnroff

install : all
	cp dnroff $(BINDIR)/dnroff
	@chmod 755 $(BINDIR)/dnroff
	@chgrp $(GROUP) $(BINDIR)/dnroff
	@chown $(OWNER) $(BINDIR)/dnroff
	sed -e 's" /usr/lib/font$$" $(FONTDIR)"' \
	    -e 's" /usr/lib/nterm$$" $(NTERMDIR)"' \
	    dnroff.1 > $(MAN1DIR)/dnroff.1;
	@chmod 644 $(MAN1DIR)/dnroff.1
	@chgrp $(GROUP) $(MAN1DIR)/dnroff.1
	@chown $(OWNER) $(MAN1DIR)/dnroff.1

clean :
	rm -f *.o

clobber : clean
	rm -f dnroff

dnroff : dnroff.c tw.h
	$(CC) $(CFLAGS) $(LDFLAGS) -o dnroff dnroff.c

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^NDEVNAME=.*'NDEVNAME=$(NDEVNAME)'" \
	    -e "s'^BINDIR=.*'BINDIR=$(BINDIR)'" \
	    -e "s'^FONTDIR=.*'FONTDIR=$(FONTDIR)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	    -e "s'^NTERMDIR=.*'NTERMDIR=$(NTERMDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^.ds dF.*'.ds dF $(FONTDIR)'" \
	    -e "s'^.ds dN.*'.ds dN $(NTERMDIR)'" \
	dnroff.1 >Xdnroff.1; \
	mv Xdnroff.1 dnroff.1

