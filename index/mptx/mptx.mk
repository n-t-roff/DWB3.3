MAKE=/bin/make
MAKEFILE=mptx.mk

SYSTEM=SYSV
VERSION=3.3

OWNER=bin
GROUP=bin

MACRODIR=/usr/lib/macros
MAN5DIR=/usr/man/p_man/man5
TMACDIR=/usr/lib/tmac

all : ptx

install : all
	@if [ $(MACRODIR) != $(TMACDIR) ]; then \
	    GROUP=$(GROUP); export GROUP; \
	    OWNER=$(OWNER); export OWNER; \
	    MACRODIR=$(MACRODIR); export MACRODIR; \
	    $(MAKE) -e -f $(MAKEFILE) minstall; \
	fi
	@if [ ! -d $(TMACDIR) ]; then \
	    mkdir -p $(TMACDIR); \
	    chmod 755 $(TMACDIR); \
	    chgrp $(GROUP) $(TMACDIR); \
	    chown $(OWNER) $(TMACDIR); \
	fi
	cp tmac.ptx $(TMACDIR)/tmac.ptx
	@chmod 644 $(TMACDIR)/tmac.ptx
	@chgrp $(GROUP) $(TMACDIR)/tmac.ptx
	@chown $(OWNER) $(TMACDIR)/tmac.ptx
	@if [ ! -d $(MAN5DIR) ]; then \
	    mkdir -p $(MAN5DIR); \
	    chmod 755 $(MAN5DIR); \
	    chgrp $(GROUP) $(MAN5DIR); \
	    chown $(OWNER) $(MAN5DIR); \
	fi
	cp mptx.5 $(MAN5DIR)/mptx.5
	@chmod 644 $(MAN5DIR)/mptx.5
	@chgrp $(GROUP) $(MAN5DIR)/mptx.5
	@chown $(OWNER) $(MAN5DIR)/mptx.5

minstall :
	@if [ ! -d $(MACRODIR) ]; then \
	    mkdir -p $(MACRODIR); \
	    chmod 755 $(MACRODIR); \
	    chgrp $(GROUP) $(MACRODIR); \
	    chown $(OWNER) $(MACRODIR); \
	fi
	cp ptx $(MACRODIR)/ptx
	@chmod 644 $(MACRODIR)/ptx
	@chgrp $(GROUP) $(MACRODIR)/ptx
	@chown $(OWNER) $(MACRODIR)/ptx

clean :
	rm -f ptx tmac.ptx

clobber : clean

ptx : ptx.sr
	@sed \
	    -e "/^''*\\\\\"/d" \
	    -e "s/	*\\\\\".*//" \
	    -e "s/@//g" \
	    -e "s/^\(['.]\)[ 	]*/\1/" \
	    -e "s/^\\([.'][a-z][a-z]\\)  */\\1/" \
	    -e "s/\\\\{[ 	]*/\\\\{/g" \
	ptx.sr >ptx
	@if [ $(MACRODIR) != $(TMACDIR) ]; \
	    then echo ".so $(MACRODIR)/ptx" >tmac.ptx; \
	    else cp ptx tmac.ptx; \
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
	mptx.5 >Xmptx.5; \
	mv Xmptx.5 mptx.5

