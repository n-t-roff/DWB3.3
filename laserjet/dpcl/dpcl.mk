#MAKE=/bin/make
MAKEFILE=dpcl.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
FONTDIR=/usr/lib/font
MAN1DIR=/usr/man/u_man/man1
RASTDIR=/usr/lib/raster

CFLGS=-Wall -Wextra
LDFLGS=-s

CFLAGS=$(CFLGS) -D$(SYSTEM)
LDFLAGS=$(LDFLGS)

OFILES=dpcl.o\
       draw.o\
       font.o\
       glob.o\
       misc.o\
       rast.o\
       rotate.o\
       tempnam.o

all : dpcl

install : all
	cp dpcl $(BINDIR)/dpcl
	@chmod 755 $(BINDIR)/dpcl
	@chgrp $(GROUP) $(BINDIR)/dpcl
	@chown $(OWNER) $(BINDIR)/dpcl
	sed -e 's" /usr/lib/font$$" $(FONTDIR)"' \
	    dpcl.1 > $(MAN1DIR)/dpcl.1
	@chmod 644 $(MAN1DIR)/dpcl.1
	@chgrp $(GROUP) $(MAN1DIR)/dpcl.1
	@chown $(OWNER) $(MAN1DIR)/dpcl.1

clean :
	rm -f *.o

clobber : clean
	rm -f dpcl

dpcl : $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o dpcl $(OFILES) -lm

dpcl.o : ext.h gen.h dpcl.h font.h path.h rast.h
draw.o : ext.h gen.h motion.h
font.o : gen.h font.h
glob.o : gen.h
misc.o : ext.h gen.h
rast.o : rast.h ext.h gen.h
rotate.o : ext.h gen.h path.h

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^BINDIR=.*'BINDIR=$(BINDIR)'" \
	    -e "s'^FONTDIR=.*'FONTDIR=$(FONTDIR)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	    -e "s'^RASTDIR=.*'RASTDIR=$(RASTDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'FONTDIR.*'FONTDIR	\"$(FONTDIR)\"'" \
	    -e "s'RASTDIR.*'RASTDIR	\"$(RASTDIR)\"'" \
	path.h >Xpath.h; \
	mv Xpath.h path.h; \
	sed \
	    -e "s'^.ds dF.*'.ds dF $(FONTDIR)'" \
	    -e "s'^.ds dR.*'.ds dR $(RASTDIR)'" \
	dpcl.1 >Xdpcl.1; \
	mv Xdpcl.1 dpcl.1

