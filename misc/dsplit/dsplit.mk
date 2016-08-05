#MAKE=/bin/make
MAKEFILE=dsplit.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
MAN1DIR=/usr/man/u_man/man1

CFLGS=-Wall -Wextra
LDFLGS=-s

CFLAGS=$(CFLGS)
LDFLAGS=$(LDFLGS)

all : dsplit

install : all
	cp dsplit $(BINDIR)/dsplit
	@chmod 755 $(BINDIR)/dsplit
	@chgrp $(GROUP) $(BINDIR)/dsplit
	@chown $(OWNER) $(BINDIR)/dsplit
	cp dsplit.1 $(MAN1DIR)/dsplit.1
	@chmod 644 $(MAN1DIR)/dsplit.1
	@chgrp $(GROUP) $(MAN1DIR)/dsplit.1
	@chown $(OWNER) $(MAN1DIR)/dsplit.1

clean :
	rm -f *.o

clobber : clean
	rm -f dsplit

dsplit : dsplit.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o dsplit dsplit.c

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

