MAKE=/bin/make
MAKEFILE=tbl.mk

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

OFILES=tbl.o

all : tbl

install : all
	cp tbl $(BINDIR)/tbl
	@chmod 755 $(BINDIR)/tbl
	@chgrp $(GROUP) $(BINDIR)/tbl
	@chown $(OWNER) $(BINDIR)/tbl
	cp tbl.1 $(MAN1DIR)/tbl.1
	@chmod 644 $(MAN1DIR)/tbl.1
	@chgrp $(GROUP) $(MAN1DIR)/tbl.1
	@chown $(OWNER) $(MAN1DIR)/tbl.1

clean :
	rm -f *.o

clobber : clean
	rm -f tbl

tbl : $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o tbl $(OFILES)

# $(OFILES) : t..c

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

