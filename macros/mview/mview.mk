MAKE=/bin/make
MAKEFILE=mview.mk

SYSTEM=SYSV
VERSION=3.3

OWNER=bin
GROUP=bin

MACRODIR=/usr/lib/macros
MAN5DIR=/usr/man/p_man/man5
TMACDIR=/usr/lib/tmac

all : view

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
	cp tmac.view $(TMACDIR)/tmac.view
	@chmod 644 $(TMACDIR)/tmac.view
	@chgrp $(GROUP) $(TMACDIR)/tmac.view
	@chown $(OWNER) $(TMACDIR)/tmac.view
	cp mview.5 $(MAN5DIR)/mview.5
	@chmod 644 $(MAN5DIR)/mview.5
	@chgrp $(GROUP) $(MAN5DIR)/mview.5
	@chown $(OWNER) $(MAN5DIR)/mview.5

minstall :
	@if [ ! -d $(MACRODIR) ]; then \
	    mkdir $(MACRODIR); \
	    chmod 755 $(MACRODIR); \
	    chgrp $(GROUP) $(MACRODIR); \
	    chown $(OWNER) $(MACRODIR); \
	fi
	cp view $(MACRODIR)/view
	@chmod 644 $(MACRODIR)/view
	@chgrp $(GROUP) $(MACRODIR)/view
	@chown $(OWNER) $(MACRODIR)/view

clean :
	rm -f view tmac.view

clobber : clean

view : view.sr
	@sed \
	    -e "/^''*\\\\\"/d" \
	    -e "s/	*\\\\\".*//" \
	    -e "s/@//g" \
	    -e "s/^\(['.]\)[ 	]*/\1/" \
	    -e "s/^\\([.'][a-z][a-z]\\)  */\\1/" \
	    -e "s/\\\\{[ 	]*/\\\\{/g" \
	    -e "s:MACRODIR:$(MACRODIR):" \
	view.sr >view
	@if [ $(MACRODIR) != $(TMACDIR) ]; \
	    then echo ".so $(MACRODIR)/view" >tmac.view; \
	    else cp view tmac.view; \
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
	    -e "s'^TMACDIR=.*'TMACDIR=$(TMACDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^.ds dM.*'.ds dM $(MACRODIR)'" \
	    -e "s'^.ds dT.*'.ds dT $(TMACDIR)'" \
	mview.5 >Xmview.5; \
	mv Xmview.5 mview.5

