MAKE=/bin/make
MAKEFILE=msafe.mk

SYSTEM=SYSV
VERSION=3.3

OWNER=bin
GROUP=bin

MACRODIR=/usr/lib/macros
MAN5DIR=/usr/man/p_man/man5
TMACDIR=/usr/lib/tmac

all : safe
	@cp safe tmac.safe

install : all
	@if [ $(MACRODIR) != $(TMACDIR) ]; then \
	    GROUP=$(GROUP); export GROUP; \
	    OWNER=$(OWNER); export OWNER; \
	    MACRODIR=$(MACRODIR); export MACRODIR; \
	    $(MAKE) -e -f $(MAKEFILE) minstall; \
	fi
	@if [ ! -d $(TMACDIR) ]; then \
	    mkdir $(TMACDIR); \
	    chmod 755 $(TMACDIR); \
	    chgrp $(GROUP) $(TMACDIR); \
	    chown $(OWNER) $(TMACDIR); \
	fi
	@rm -f $(TMACDIR)/tmac.safe
	cp tmac.safe $(TMACDIR)/tmac.safe
	@chmod 644 $(TMACDIR)/tmac.safe
	@chgrp $(GROUP) $(TMACDIR)/tmac.safe
	@chown $(OWNER) $(TMACDIR)/tmac.safe
	sed -e 's" /usr/lib/tmac$$" $(TMACDIR)"' \
	    msafe.5 > $(MAN5DIR)/msafe.5
	@chmod 644 $(MAN5DIR)/msafe.5
	@chgrp $(GROUP) $(MAN5DIR)/msafe.5
	@chown $(OWNER) $(MAN5DIR)/msafe.5

minstall :
	@if [ ! -d $(MACRODIR) ]; then \
	    mkdir $(MACRODIR); \
	    chmod 755 $(MACRODIR); \
	    chgrp $(GROUP) $(MACRODIR); \
	    chown $(OWNER) $(MACRODIR); \
	fi
	@rm -f $(MACRODIR)/safe
	cp safe $(MACRODIR)/safe
	@chmod 644 $(MACRODIR)/safe
	@chgrp $(GROUP) $(MACRODIR)/safe
	@chown $(OWNER) $(MACRODIR)/safe

clean :
	rm -f safe tmac.safe

clobber : clean

safe : safe.sr
	@cp safe.sr safe

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^MACRODIR=.*'MACRODIR=$(MACRODIR)'" \
	    -e "s'^MAN5DIR=.*'MAN5DIR=$(MAN5DIR)'" \
	    -e "s'^TMACDIR=.*'TMACDIR=$(TMACDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^.ds dM.*'.ds dM $(MACRODIR)'" \
	    -e "s'^.ds dT.*'.ds dT $(TMACDIR)'" \
	msafe.5 >Xmsafe.5; \
	mv Xmsafe.5 msafe.5

