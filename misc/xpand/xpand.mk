MAKE=/bin/make
MAKEFILE=xpand.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
MAN5DIR=/usr/man/p_man/man5

CFLGS=-O
LDFLGS=-s

CFLAGS=$(CFLGS)
LDFLAGS=$(LDFLGS)

all : xpand

install : all
	@if [ ! -d "$(BINDIR)" ]; then \
	    mkdir $(BINDIR); \
	    chmod 755 $(BINDIR); \
	    chgrp $(GROUP) $(BINDIR); \
	    chown $(OWNER) $(BINDIR); \
	fi
	cp xpand $(BINDIR)
	@chmod 755 $(BINDIR)/xpand
	@chgrp $(GROUP) $(BINDIR)/xpand
	@chown $(OWNER) $(BINDIR)/xpand
	sed -e 's" /usr/lib/dwb$$" $(BINDIR)"' \
	    xpand.5 > $(MAN5DIR)/xpand.5
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
	    -e "s'^BINDIR=.*'BINDIR=$(BINDIR)'" \
	    -e "s'^MAN5DIR=.*'MAN5DIR=$(MAN5DIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^.ds dL.*'.ds dL $(BINDIR)'" \
	xpand.5 >Xxpand.5; \
	mv Xxpand.5 xpand.5

