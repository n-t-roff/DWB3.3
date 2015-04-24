MAKE=/bin/make
MAKEFILE=ptx.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
LIBDIR=/usr/lib/dwb
MAN1DIR=/usr/man/u_man/man1
TMACDIR=/usr/lib/tmac

CFLGS=-O
LDFLGS=-s

CFLAGS=$(CFLGS)
LDFLAGS=$(LDFLGS)

all : ptx

install : all
	@if [ ! -d $(LIBDIR) ]; then \
	    mkdir $(LIBDIR); \
	    chmod 755 $(LIBDIR); \
	    chgrp $(GROUP) $(LIBDIR); \
	    chown $(OWNER) $(LIBDIR); \
	fi
	cp ptx $(BINDIR)/ptx
	@chmod 755 $(BINDIR)/ptx
	@chgrp $(GROUP) $(BINDIR)/ptx
	@chown $(OWNER) $(BINDIR)/ptx
	cp eign $(LIBDIR)
	@chmod 644 $(LIBDIR)/eign
	@chgrp $(GROUP) $(LIBDIR)/eign
	@chown $(OWNER) $(LIBDIR)/eign
	sed -e 's" /usr/lib/dwb$$" $(LIBDIR)"' \
	    -e 's" /usr/lib/tmac$$" $(TMACDIR)"' \
	    ptx.1 > $(MAN1DIR)/ptx.1
	@chmod 644 $(MAN1DIR)/ptx.1
	@chgrp $(GROUP) $(MAN1DIR)/ptx.1
	@chown $(OWNER) $(MAN1DIR)/ptx.1

clean :
	rm -f *.o

clobber : clean
	rm -f ptx

ptx : ptx.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o ptx ptx.c

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
	    -e "s'^TMACDIR=.*'TMACDIR=$(TMACDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^#define[ 	]*DEFLTX.*'#define DEFLTX \"$(LIBDIR)/eign\"'" \
	ptx.c >Xptx.c; \
	mv Xptx.c ptx.c; \
	sed \
	    -e "s'^.ds dL.*'.ds dL $(LIBDIR)'" \
	    -e "s'^.ds dT.*'.ds dT $(TMACDIR)'" \
	ptx.1 >Xptx.1; \
	mv Xptx.1 ptx.1

