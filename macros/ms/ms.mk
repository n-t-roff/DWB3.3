MAKE=/bin/make
MAKEFILE=ms.mk

SYSTEM=SYSV
VERSION=3.3

OWNER=bin
GROUP=bin

MAN5DIR=/usr/man/p_man/man5
TMACDIR=/usr/lib/tmac

all : tmac.s

install : all
	@if [ ! -d $(TMACDIR) ]; then \
	    mkdir $(TMACDIR); \
	    chmod 755 $(TMACDIR); \
	    chgrp $(GROUP) $(TMACDIR); \
	    chown $(OWNER) $(TMACDIR); \
	fi
	cp tmac.s tmac.sdisp tmac.scover tmac.skeep tmac.srefs $(TMACDIR)
	@for i in tmac.s tmac.sdisp tmac.scover tmac.skeep tmac.srefs; do \
	    chmod 644 $(TMACDIR)/$$i; \
	    chgrp $(GROUP) $(TMACDIR)/$$i; \
	    chown $(OWNER) $(TMACDIR)/$$i; \
	done
	sed -e 's" /usr/lib/tmac$$" $(TMACDIR)"' \
	    ms.5 > $(MAN5DIR)/ms.5
	@chmod 644 $(MAN5DIR)/ms.5
	@chgrp $(GROUP) $(MAN5DIR)/ms.5
	@chown $(OWNER) $(MAN5DIR)/ms.5

clean :
	rm -f tmac.s

clobber : clean

tmac.s : tmac.s.sr
	@sed \
	    -e "s:TMACDIR:$(TMACDIR):" \
	tmac.s.sr >tmac.s

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^MAN5DIR=.*'MAN5DIR=$(MAN5DIR)'" \
	    -e "s'^TMACDIR=.*'TMACDIR=$(TMACDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^.ds dT.*'.ds dT $(TMACDIR)'" \
	ms.5 >Xms.5; \
	mv Xms.5 ms.5


