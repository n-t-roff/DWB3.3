MAKE=/bin/make
MAKEFILE=mcs.mk

SYSTEM=SYSV
VERSION=3.3

OWNER=bin
GROUP=bin

MACRODIR=/usr/lib/macros
MAN5DIR=/usr/man/p_man/man5
PUBDIR=/usr/pub
TMACDIR=/usr/lib/tmac

all : csmacros

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
	cp tmac.cs $(TMACDIR)/tmac.cs
	@chmod 644 $(TMACDIR)/tmac.cs
	@chgrp $(GROUP) $(TMACDIR)/tmac.cs
	@chown $(OWNER) $(TMACDIR)/tmac.cs
	sed -e 's" /usr/pub$$" $(PUBDIR)"' \
	    -e 's" /usr/lib/tmac$$" $(TMACDIR)"' \
	    mcs.5 > $(MAN5DIR)/mcs.5
	@chmod 644 $(MAN5DIR)/mcs.5
	@chgrp $(GROUP) $(MAN5DIR)/mcs.5
	@chown $(OWNER) $(MAN5DIR)/mcs.5

minstall :
	@if [ ! -d $(MACRODIR) ]; then \
	    mkdir $(MACRODIR); \
	    chmod 755 $(MACRODIR); \
	    chgrp $(GROUP) $(MACRODIR); \
	    chown $(OWNER) $(MACRODIR); \
	fi
	cp csmacros $(MACRODIR)/csmacros
	@chmod 644 $(MACRODIR)/csmacros
	@chgrp $(GROUP) $(MACRODIR)/csmacros
	@chown $(OWNER) $(MACRODIR)/csmacros

clean :
	rm -f csmacros tmac.cs

clobber : clean

csmacros : csmacros.sr
	@cp csmacros.sr csmacros
	@if [ $(MACRODIR) != $(TMACDIR) ]; \
	    then echo ".so $(MACRODIR)/csmacros" >tmac.cs; \
	    else cp csmacros tmac.cs; \
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
	    -e "s'^PUBDIR=.*'PUBDIR=$(PUBDIR)'" \
	    -e "s'^TMACDIR=.*'TMACDIR=$(TMACDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^.ds dM.*'.ds dM $(MACRODIR)'" \
	    -e "s'^.ds dP.*'.ds dP $(PUBDIR)'" \
	    -e "s'^.ds dT.*'.ds dT $(TMACDIR)'" \
	mcs.5 >Xmcs.5; \
	mv Xmcs.5 mcs.5

