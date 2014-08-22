MAKE=/bin/make
MAKEFILE=pic.mk

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
YFLAGS=-d

OFILES=picl.o\
       main.o\
       print.o\
       misc.o\
       symtab.o\
       blockgen.o\
       boxgen.o\
       circgen.o\
       arcgen.o\
       linegen.o\
       movegen.o\
       textgen.o\
       input.o\
       for.o\
       pltroff.o

all : pic

install : pic
	cp pic $(BINDIR)/pic
	@chmod 755 $(BINDIR)/pic
	@chgrp $(GROUP) $(BINDIR)/pic
	@chown $(OWNER) $(BINDIR)/pic
	cp pic.1 $(MAN1DIR)/pic.1
	@chmod 644 $(MAN1DIR)/pic.1
	@chgrp $(GROUP) $(MAN1DIR)/pic.1
	@chown $(OWNER) $(MAN1DIR)/pic.1

clean :
	rm -f *.o y.tab.h picl.c picy.c lex.yy.c

clobber : clean
	rm -f pic

pic : $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o pic picy.o $(OFILES) -lm

$(OFILES) : pic.h picy.o

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

