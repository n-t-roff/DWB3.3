MAKE=/bin/make
MAKEFILE=hyphen.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
MAN1DIR=/usr/man/u_man/man1

CFLGS=-O
LDFLGS=-s

CFLAGS=$(CFLGS)
LDFLAGS=$(LDFLGS)

all : hyphen

install : all
	cp hyphen $(BINDIR)/hyphen
	@chmod 755 $(BINDIR)/hyphen
	@chgrp $(GROUP) $(BINDIR)/hyphen
	@chown $(OWNER) $(BINDIR)/hyphen
	cp hyphen.1 $(MAN1DIR)/hyphen.1
	@chmod 644 $(MAN1DIR)/hyphen.1
	@chgrp $(GROUP) $(MAN1DIR)/hyphen.1
	@chown $(OWNER) $(MAN1DIR)/hyphen.1

clean :
	rm -f *.o

clobber : clean
	rm -f hyphen

hyphen : hyphen.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o hyphen hyphen.c

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

