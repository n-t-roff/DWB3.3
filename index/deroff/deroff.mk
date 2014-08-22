MAKE=/bin/make
MAKEFILE=deroff.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

LIBDIR=/usr/lib/dwb

CFLGS=-O
LDFLGS=-s

CFLAGS=$(CFLGS)
LDFLAGS=$(LDFLGS)

all : deroff

install : all
	@if [ ! -d $(LIBDIR) ]; then \
	    mkdir -p $(LIBDIR); \
	    chmod 755 $(LIBDIR); \
	    chgrp $(GROUP) $(LIBDIR); \
	    chown $(OWNER) $(LIBDIR); \
	fi
	cp deroff $(LIBDIR)/deroff
	@chmod 755 $(LIBDIR)/deroff
	@chgrp $(GROUP) $(LIBDIR)/deroff
	@chown $(OWNER) $(LIBDIR)/deroff

clean :
	rm -f *.o

clobber : clean
	rm -f deroff

deroff : deroff.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o deroff deroff.c

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^LIBDIR=.*'LIBDIR=$(LIBDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE)

