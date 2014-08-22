MAKE=/bin/make
MAKEFILE=col.mk

SYSTEM=SYSV
VERSION=3.3

OWNER=bin
GROUP=bin

BINDIR=/usr/bin
MAN1DIR=/usr/man/u_man/man1

CFLGS=-O
LDFLGS=-s

CFLAGS=$(CFLGS)
LDFLAGS=$(LDFLGS)

all : col

install : all
	cp col $(BINDIR)/col
	@chmod 755 $(BINDIR)/col
	@chgrp $(GROUP) $(BINDIR)/col
	@chown $(OWNER) $(BINDIR)/col
	cp col.1 $(MAN1DIR)/col.1
	@chmod 644 $(MAN1DIR)/col.1
	@chgrp $(GROUP) $(MAN1DIR)/col.1
	@chown $(OWNER) $(MAN1DIR)/col.1

clean :
	rm -f *.o

clobber : clean
	rm -f col

col : col.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o col col.c

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

