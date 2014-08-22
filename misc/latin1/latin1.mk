MAKE=/bin/make
MAKEFILE=latin1.mk

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

all : atoL1 L1toa atoL1sim

install : all
	cp atoL1 $(BINDIR)/atoL1
	@chmod 755 $(BINDIR)/atoL1
	@chgrp $(GROUP) $(BINDIR)/atoL1
	@chown $(OWNER) $(BINDIR)/atoL1
	cp L1toa $(BINDIR)/L1toa
	@chmod 755 $(BINDIR)/L1toa
	@chgrp $(GROUP) $(BINDIR)/L1toa
	@chown $(OWNER) $(BINDIR)/L1toa
	cp atoL1sim $(BINDIR)/atoL1sim
	@chmod 755 $(BINDIR)/atoL1sim
	@chgrp $(GROUP) $(BINDIR)/atoL1sim
	@chown $(OWNER) $(BINDIR)/atoL1sim
	cp atoL1.1 $(MAN1DIR)/atoL1.1
	@chmod 644 $(MAN1DIR)/atoL1.1
	@chgrp $(GROUP) $(MAN1DIR)/atoL1.1
	@chown $(OWNER) $(MAN1DIR)/atoL1.1
	cp L1toa.1 $(MAN1DIR)/L1toa.1
	@chmod 644 $(MAN1DIR)/L1toa.1
	@chgrp $(GROUP) $(MAN1DIR)/L1toa.1
	@chown $(OWNER) $(MAN1DIR)/L1toa.1
	cp atoL1sim.1 $(MAN1DIR)/atoL1sim.1
	@chmod 644 $(MAN1DIR)/atoL1sim.1
	@chgrp $(GROUP) $(MAN1DIR)/atoL1sim.1
	@chown $(OWNER) $(MAN1DIR)/atoL1sim.1

clean :

clobber : clean
	rm -f atoL1 L1toa atoL1sim

atoL1 : atoL1.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o atoL1 atoL1.c

L1toa : L1toa.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o L1toa L1toa.c

atoL1sim : atoL1sim.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o atoL1sim atoL1sim.c

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^BINDIR=.*'BINDIR=$(BINDIR)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	$(MAKEFILE) >XXX.mk; \
	mv XXX.mk $(MAKEFILE)

