#MAKE=/bin/make
MAKEFILE=ndx.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
LIBDIR=/usr/lib/dwb
MAN1DIR=/usr/man/u_man/man1

CFLGS=-Wall -Wextra
LDFLGS=-s

CFLAGS=$(CFLGS) -D$(SYSTEM)
LDFLAGS=$(LDFLGS)

OFILES=case.o\
       ndexer.o\
       rootwd.o\
       space.o\
       str.o\
       strr.o

all : ndx ndexer ndxformat pages sbjprep

install : all
	@if [ ! -d $(LIBDIR) ]; then \
	    mkdir -p $(LIBDIR); \
	    chmod 755 $(LIBDIR); \
	    chgrp $(GROUP) $(LIBDIR); \
	    chown $(OWNER) $(LIBDIR); \
	fi
	@if [ ! -d $(BINDIR) ]; then \
	    mkdir -p $(BINDIR); \
	    chmod 755 $(BINDIR); \
	    chgrp $(GROUP) $(BINDIR); \
	    chown $(OWNER) $(BINDIR); \
	fi
	@if [ ! -d $(MAN1DIR) ]; then \
	    mkdir -p $(MAN1DIR); \
	    chmod 755 $(MAN1DIR); \
	    chgrp $(GROUP) $(MAN1DIR); \
	    chown $(OWNER) $(MAN1DIR); \
	fi
	cp ndx $(BINDIR)/ndx
	@chmod 755 $(BINDIR)/ndx
	@chgrp $(GROUP) $(BINDIR)/ndx
	@chown $(OWNER) $(BINDIR)/ndx
	cp ndexer $(LIBDIR)/ndexer
	@chmod 755 $(LIBDIR)/ndexer
	@chgrp $(GROUP) $(LIBDIR)/ndexer
	@chown $(OWNER) $(LIBDIR)/ndexer
	cp ndxformat $(LIBDIR)/ndxformat
	@chmod 755 $(LIBDIR)/ndxformat
	@chgrp $(GROUP) $(LIBDIR)/ndxformat
	@chown $(OWNER) $(LIBDIR)/ndxformat
	cp pages $(LIBDIR)/pages
	@chmod 755 $(LIBDIR)/pages
	@chgrp $(GROUP) $(LIBDIR)/pages
	@chown $(OWNER) $(LIBDIR)/pages
	cp sbjprep $(LIBDIR)/sbjprep
	@chmod 755 $(LIBDIR)/sbjprep
	@chgrp $(GROUP) $(LIBDIR)/sbjprep
	@chown $(OWNER) $(LIBDIR)/sbjprep
	cp ndx.1 $(MAN1DIR)/ndx.1
	@chmod 644 $(MAN1DIR)/ndx.1
	@chgrp $(GROUP) $(MAN1DIR)/ndx.1
	@chown $(OWNER) $(MAN1DIR)/ndx.1

clean :
	rm -f *.o

clobber : clean
	rm -f ndx ndexer ndxformat pages sbjprep

ndx : ndx.sh
	cp ndx.sh ndx; chmod 755 ndx

ndexer : $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OFILES) -o ndexer

ndexer.o : dstructs.h
rootwd.o : edict.h ehash.h
space.o : dstructs.h

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
	    -e "s'^UL=.*'UL=$(LIBDIR)'" \
	ndx.sh >Xndx.sh; \
	mv Xndx.sh ndx.sh

