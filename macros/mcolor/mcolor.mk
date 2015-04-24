MAKE=/bin/make
MAKEFILE=mcolor.mk

SYSTEM=SYSV
VERSION=3.3

OWNER=bin
GROUP=bin

MACRODIR=/usr/lib/macros
MAN5DIR=/usr/man/p_man/man5
POSTLIB=/usr/lib/postscript
TMACDIR=/usr/lib/tmac

all : color

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
	cp tmac.color $(TMACDIR)/tmac.color
	@chmod 644 $(TMACDIR)/tmac.color
	@chgrp $(GROUP) $(TMACDIR)/tmac.color
	@chown $(OWNER) $(TMACDIR)/tmac.color
	sed -e 's" /usr/lib/postscript$$" $(POSTLIB)"' \
	    -e 's" /usr/lib/tmac$$" $(TMACDIR)"' \
	    mcolor.5 > $(MAN5DIR)/mcolor.5
	@chmod 644 $(MAN5DIR)/mcolor.5
	@chgrp $(GROUP) $(MAN5DIR)/mcolor.5
	@chown $(OWNER) $(MAN5DIR)/mcolor.5

minstall :
	@if [ ! -d $(MACRODIR) ]; then \
	    mkdir $(MACRODIR); \
	    chmod 755 $(MACRODIR); \
	    chgrp $(GROUP) $(MACRODIR); \
	    chown $(OWNER) $(MACRODIR); \
	fi
	cp color $(MACRODIR)/color
	@chmod 644 $(MACRODIR)/color
	@chgrp $(GROUP) $(MACRODIR)/color
	@chown $(OWNER) $(MACRODIR)/color

clean :
	rm -f color tmac.color

clobber : clean

color : color.sr
	@cp color.sr color
	@if [ $(MACRODIR) != $(TMACDIR) ]; \
	    then echo ".so $(MACRODIR)/color" >tmac.color; \
	    else cp color tmac.color; \
	fi

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
	mcolor.5 >Xmcolor.5; \
	mv Xmcolor.5 mcolor.5

