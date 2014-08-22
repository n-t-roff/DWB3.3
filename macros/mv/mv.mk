MAKE=/bin/make
MAKEFILE=mv.mk

SYSTEM=SYSV
VERSION=3.3

OWNER=bin
GROUP=bin

MACRODIR=/usr/lib/macros
MAN5DIR=/usr/man/p_man/man5
TMACDIR=/usr/lib/tmac

all : v

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
	cp tmac.v $(TMACDIR)/tmac.v
	@chmod 644 $(TMACDIR)/tmac.v
	@chgrp $(GROUP) $(TMACDIR)/tmac.v
	@chown $(OWNER) $(TMACDIR)/tmac.v
	cp mv.5 $(MAN5DIR)/mv.5
	@chmod 644 $(MAN5DIR)/mv.5
	@chgrp $(GROUP) $(MAN5DIR)/mv.5
	@chown $(OWNER) $(MAN5DIR)/mv.5

minstall :
	@if [ ! -d $(MACRODIR) ]; then \
	    mkdir $(MACRODIR); \
	    chmod 755 $(MACRODIR); \
	    chgrp $(GROUP) $(MACRODIR); \
	    chown $(OWNER) $(MACRODIR); \
	fi
	cp v $(MACRODIR)/v
	@chmod 644 $(MACRODIR)/v
	@chgrp $(GROUP) $(MACRODIR)/v
	@chown $(OWNER) $(MACRODIR)/v

clean :
	rm -f v tmac.v

clobber : clean

v : v.sr
	@sed \
	    -e "/^''*\\\\\"/d" \
	    -e "s/	*\\\\\".*//" \
	    -e "s/@//g" \
	    -e "s/^\(['.]\)[ 	]*/\1/" \
	    -e "s/^\\([.'][a-z][a-z]\\)  */\\1/" \
	    -e "s/\\\\{[ 	]*/\\\\{/g" \
	    -e "s:MACRODIR:$(MACRODIR):" \
	v.sr >v
	@if [ $(MACRODIR) != $(TMACDIR) ]; \
	    then echo ".so $(MACRODIR)/v" >tmac.v; \
	    else cp v tmac.v; \
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
	mv.5 >Xmv.5; \
	mv Xmv.5 mv.5

