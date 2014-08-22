MAKE=/bin/make
MAKEFILE=mm.mk

SYSTEM=SYSV
VERSION=3.3

OWNER=bin
GROUP=bin

MACRODIR=/usr/lib/macros
MAN5DIR=/usr/man/p_man/man5
TMACDIR=/usr/lib/tmac

DOTSODIR=$(MACRODIR)

all : mmn mmt

install : all
	@GROUP=$(GROUP); export GROUP; \
	OWNER=$(OWNER); export OWNER; \
	if [ $(MACRODIR) != $(TMACDIR) ]; \
	    then MACRODIR=$(MACRODIR); export MACRODIR; \
	    else MACRODIR=$(TMACDIR); export MACRODIR; \
	fi; \
	$(MAKE) -e -f $(MAKEFILE) minstall
	@if [ ! -d $(TMACDIR) ]; then \
	    mkdir $(TMACDIR); \
	    chmod 755 $(TMACDIR); \
	    chgrp $(GROUP) $(TMACDIR); \
	    chown $(OWNER) $(TMACDIR); \
	fi
	cp tmac.m $(TMACDIR)/tmac.m
	@chmod 644 $(TMACDIR)/tmac.m
	@chgrp $(GROUP) $(TMACDIR)/tmac.m
	@chown $(OWNER) $(TMACDIR)/tmac.m
	cp strings.* $(DOTSODIR)
	@for i in strings.*; do \
	    chmod 644 $(DOTSODIR)/$$i; \
	    chgrp $(GROUP) $(DOTSODIR)/$$i; \
	    chown $(OWNER) $(DOTSODIR)/$$i; \
	done
	cp mm.5 $(MAN5DIR)/mm.5
	@chmod 644 $(MAN5DIR)/mm.5
	@chgrp $(GROUP) $(MAN5DIR)/mm.5
	@chown $(OWNER) $(MAN5DIR)/mm.5

minstall :
	@if [ ! -d $(MACRODIR) ]; then \
	    mkdir $(MACRODIR); \
	    chmod 755 $(MACRODIR); \
	    chgrp $(GROUP) $(MACRODIR); \
	    chown $(OWNER) $(MACRODIR); \
	fi
	cp mmn mmt $(MACRODIR)
	@chmod 644 $(MACRODIR)/mmn $(MACRODIR)/mmt
	@chgrp $(GROUP) $(MACRODIR)/mmn $(MACRODIR)/mmt
	@chown $(OWNER) $(MACRODIR)/mmn $(MACRODIR)/mmt

clean :
	rm -f mmn mmt tmac.m

clobber : clean

mmn mmt : mmn.sr mmt.sr
	@sed \
	    -e "/^''*\\\\\"/d" \
	    -e "s/	*\\\\\".*//" \
	    -e "s/@//g" \
	    -e "s/^\(['.]\)[ 	]*/\1/" \
	    -e "s/^\\([.'][a-z][a-z]\\)  */\\1/" \
	    -e "s/\\\\{[ 	]*/\\\\{/g" \
	    -e "s:MACRODIR:$(MACRODIR):" \
	mmn.sr >mmn
	@sed \
	    -e "/^''*\\\\\"/d" \
	    -e "s/	*\\\\\".*//" \
	    -e "s/@//g" \
	    -e "s/^\(['.]\)[ 	]*/\1/" \
	    -e "s/^\\([.'][a-z][a-z]\\)  */\\1/" \
	    -e "s/\\\\{[ 	]*/\\\\{/g" \
	    -e "s:MACRODIR:$(MACRODIR):" \
	mmt.sr >mmt
	@if [ $(MACRODIR) != $(TMACDIR) ]; \
	    then echo ".if n .so $(MACRODIR)/mmn" >tmac.m; \
		 echo ".if t .so $(MACRODIR)/mmt" >>tmac.m; \
	    else echo ".if n .so $(TMACDIR)/mmn" >tmac.m; \
		 echo ".if t .so $(TMACDIR)/mmt" >>tmac.m; \
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
	mm.5 >Xmm.5; \
	mv Xmm.5 mm.5

