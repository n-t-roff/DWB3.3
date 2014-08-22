MAKE=/bin/make
MAKEFILE=xpand.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

LIBDIR=/usr/lib/dwb
MAN5DIR=/usr/man/p_man/man5

CFLGS=-O
LDFLGS=-s

CFLAGS=$(CFLGS)
LDFLAGS=$(LDFLGS)

all : xpand

install : all
	@if [ ! -d "$(LIBDIR)" ]; then \
	    mkdir $(LIBDIR); \
	    chmod 755 $(LIBDIR); \
	    chgrp $(GROUP) $(LIBDIR); \
	    chown $(OWNER) $(LIBDIR); \
	fi
	cp xpand $(LIBDIR)
	@chmod 755 $(LIBDIR)/xpand
	@chgrp $(GROUP) $(LIBDIR)/xpand
	@chown $(OWNER) $(LIBDIR)/xpand
	cp xpand.5 $(MAN5DIR)/xpand.5
	@chmod 644 $(MAN5DIR)/xpand.5
	@chgrp $(GROUP) $(MAN5DIR)/xpand.5
	@chown $(OWNER) $(MAN5DIR)/xpand.5

clean :
	rm -f *.o

clobber : clean
	rm -f xpand

xpand : xpand.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o xpand xpand.c -lm

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^LIBDIR=.*'LIBDIR=$(LIBDIR)'" \
	    -e "s'^MAN5DIR=.*'MAN5DIR=$(MAN5DIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^.ds dL.*'.ds dL $(LIBDIR)'" \
	xpand.5 >Xxpand.5; \
	mv Xxpand.5 xpand.5

