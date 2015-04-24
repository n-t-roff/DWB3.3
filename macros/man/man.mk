MAKE=/bin/make
MAKEFILE=man.mk

SYSTEM=SYSV
VERSION=3.3

OWNER=bin
GROUP=bin

MACRODIR=/usr/lib/macros
MAN5DIR=/usr/man/p_man/man5
TMACDIR=/usr/lib/tmac

all : an

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
	cp tmac.an $(TMACDIR)/tmac.an
	@chmod 644 $(TMACDIR)/tmac.an
	@chgrp $(GROUP) $(TMACDIR)/tmac.an
	@chown $(OWNER) $(TMACDIR)/tmac.an
	sed -e 's" /usr/lib/tmac$$" $(TMACDIR)"' \
	    man.5 > $(MAN5DIR)/man.5
	@chmod 644 $(MAN5DIR)/man.5
	@chgrp $(GROUP) $(MAN5DIR)/man.5
	@chown $(OWNER) $(MAN5DIR)/man.5

minstall :
	@if [ ! -d $(MACRODIR) ]; then \
	    mkdir $(MACRODIR); \
	    chmod 755 $(MACRODIR); \
	    chgrp $(GROUP) $(MACRODIR); \
	    chown $(OWNER) $(MACRODIR); \
	fi
	cp an $(MACRODIR)/an
	@chmod 644 $(MACRODIR)/an
	@chgrp $(GROUP) $(MACRODIR)/an
	@chown $(OWNER) $(MACRODIR)/an

clean :
	rm -f an tmac.an

clobber : clean

an : an.sr
	@sed \
	    -e "/^''*\\\\\"/d" \
	    -e "s/	*\\\\\".*//" \
	    -e "s/@//g" \
	    -e "s/^\(['.]\)[ 	]*/\1/" \
	    -e "s/^\\([.'][a-z][a-z]\\)  */\\1/" \
	    -e "s/\\\\{[ 	]*/\\\\{/g" \
	    -e "s:MACRODIR:$(MACRODIR):" \
	an.sr >an
	@if [ $(MACRODIR) != $(TMACDIR) ]; \
	    then echo ".so $(MACRODIR)/an" >tmac.an; \
	    else cp an tmac.an; \
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
	man.5 >Xman.5; \
	mv Xman.5 man.5

