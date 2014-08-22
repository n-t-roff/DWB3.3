MAKE=/bin/make
MAKEFILE=otbl.mk

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

OFILES=otbl.o

all : otbl

install : all
	cp otbl $(BINDIR)/otbl
	@chmod 755 $(BINDIR)/otbl
	@chgrp $(GROUP) $(BINDIR)/otbl
	@chown $(OWNER) $(BINDIR)/otbl

clean :
	rm -f *.o

clobber : clean
	rm -f otbl

otbl : $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o otbl $(OFILES)

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

