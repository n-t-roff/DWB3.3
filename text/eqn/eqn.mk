#MAKE=/bin/make
MAKEFILE=eqn.mk

SYSTEM=BSD4_2
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
MAN1DIR=/usr/man/u_man/man1

CFLGS=-Wall -Wextra
LDFLGS=-s

CFLAGS=$(CFLGS)
LDFLAGS=$(LDFLGS)
YFLAGS=-d

OFILES=main.o\
       tuning.o\
       diacrit.o\
       eqnbox.o\
       font.o\
       fromto.o\
       funny.o\
       glob.o\
       integral.o\
       input.o\
       lex.o\
       lookup.o\
       mark.o\
       matrix.o\
       move.o\
       over.o\
       paren.o\
       pile.o\
       shift.o\
       size.o\
       sqrt.o\
       text.o

all : eqn

install : all
	cp eqn $(BINDIR)/eqn
	@chmod 755 $(BINDIR)/eqn
	@chgrp $(GROUP) $(BINDIR)/eqn
	@chown $(OWNER) $(BINDIR)/eqn
	cp eqn.1 $(MAN1DIR)/eqn.1
	@chmod 644 $(MAN1DIR)/eqn.1
	@chgrp $(GROUP) $(MAN1DIR)/eqn.1
	@chown $(OWNER) $(MAN1DIR)/eqn.1

clean :
	rm -f *.o y.tab.*

clobber : clean
	rm -f eqn

eqn : eqn.o $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o eqn $(OFILES) eqn.o

$(OFILES) : e.h eqn.o

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

