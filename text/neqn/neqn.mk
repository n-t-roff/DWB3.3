MAKE=/bin/make
MAKEFILE=neqn.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
MAN1DIR=/usr/man/u_man/man1

CFLGS=-O
LDFLGS=-s

CFLAGS=$(CFLGS) -DNEQN
LDFLAGS=$(LDFLGS)
YFLAGS=-d

OFILES=diacrit.o\
       eqnbox.o\
       font.o\
       fromto.o\
       funny.o\
       glob.o\
       integral.o\
       io.o\
       lex.o\
       lookup.o\
       mark.o\
       matrix.o\
       move.o\
       over.o\
       paren.o \
       pile.o\
       shift.o\
       size.o\
       sqrt.o\
       text.o

all : neqn

install : all
	cp neqn $(BINDIR)/neqn
	@chmod 755 $(BINDIR)/neqn
	@chgrp $(GROUP) $(BINDIR)/neqn
	@chown $(OWNER) $(BINDIR)/neqn
	cp neqn.1 $(MAN1DIR)/neqn.1
	@chmod 644 $(MAN1DIR)/neqn.1
	@chgrp $(GROUP) $(MAN1DIR)/neqn.1
	@chown $(OWNER) $(MAN1DIR)/neqn.1

clean :
	rm -f *.o y.tab.c y.tab.h e.c

clobber : clean
	rm -f neqn

neqn : $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o neqn $(OFILES) e.o

$(OFILES) : e.h e.o

e.c: e.y
	$(YACC) -d e.y
	sed -f yyval.sed <y.tab.c >$@

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

