MAKE=/bin/make
MAKEFILE=mps.mk

SYSTEM=SYSV
VERSION=3.3

OWNER=bin
GROUP=bin

MACRODIR=/usr/lib/macros
MAN5DIR=/usr/man/p_man/man5
POSTLIB=/usr/lib/postscript
TMACDIR=/usr/lib/tmac

all : tmac.ps

install : all
	@if [ ! -d $(TMACDIR) ]; then \
	    mkdir $(TMACDIR); \
	    chmod 755 $(TMACDIR); \
	    chgrp $(GROUP) $(TMACDIR); \
	    chown $(OWNER) $(TMACDIR); \
	fi
	cp tmac.ps $(TMACDIR)/tmac.ps
	@chmod 644 $(TMACDIR)/tmac.ps
	@chgrp $(GROUP) $(TMACDIR)/tmac.ps
	@chown $(OWNER) $(TMACDIR)/tmac.ps
	cp mps.5 $(MAN5DIR)/mps.5
	@chmod 644 $(MAN5DIR)/mps.5
	@chgrp $(GROUP) $(MAN5DIR)/mps.5
	@chown $(OWNER) $(MAN5DIR)/mps.5

clean :
	rm -f tmac.ps

clobber : clean

tmac.ps : ps.sr
	@sed \
	    -e "s:MACRODIR:$(MACRODIR):" \
	    -e "s:TMACDIR:$(TMACDIR):" \
	ps.sr >tmac.ps

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^MACRODIR=.*'MACRODIR=$(MACRODIR)'" \
	    -e "s'^MAN5DIR=.*'MAN5DIR=$(MAN5DIR)'" \
	    -e "s'^POSTLIB=.*'POSTLIB=$(POSTLIB)'" \
	    -e "s'^TMACDIR=.*'TMACDIR=$(TMACDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^.ds dP.*'.ds dP $(POSTLIB)'" \
	    -e "s'^.ds dT.*'.ds dT $(TMACDIR)'" \
	mps.5 >Xmps.5; \
	mv Xmps.5 mps.5

