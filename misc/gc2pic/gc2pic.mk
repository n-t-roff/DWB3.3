#MAKE=/bin/make
MAKEFILE=gc2pic.mk

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

OFILES=aligned.o\
       boxes.o\
       globals.o\
       main.o\
       out.o\
       process.o\
       rules.o\
       save_sym.o\
       sm_mem.o\
       util.o

all : gc2pic

install : all
	cp gc2pic $(BINDIR)/gc2pic
	@chmod 755 $(BINDIR)/gc2pic
	@chgrp $(GROUP) $(BINDIR)/gc2pic
	@chown $(OWNER) $(BINDIR)/gc2pic
	cp gc2pic.1 $(MAN1DIR)/gc2pic.1
	@chmod 644 $(MAN1DIR)/gc2pic.1
	@chgrp $(GROUP) $(MAN1DIR)/gc2pic.1
	@chown $(OWNER) $(MAN1DIR)/gc2pic.1

clean :
	rm -f *.o

clobber : clean
	rm -f gc2pic

gc2pic : $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o gc2pic $(OFILES)

aligned.o : structs.h
boxes.o : structs.h
globals.o : structs.h
main.o : structs.h
out.o : structs.h
process.o : structs.h
rules.o : structs.h
save_sym.o : structs.h
util.o : structs.h

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

