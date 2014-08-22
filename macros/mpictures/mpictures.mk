MAKE=/bin/make
MAKEFILE=mpictures.mk

SYSTEM=SYSV
VERSION=3.3

OWNER=bin
GROUP=bin

MACRODIR=/usr/lib/macros
MAN5DIR=/usr/man/p_man/man5
TMACDIR=/usr/lib/tmac

all : pictures

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
	cp tmac.pictures $(TMACDIR)/tmac.pictures
	@chmod 644 $(TMACDIR)/tmac.pictures
	@chgrp $(GROUP) $(TMACDIR)/tmac.pictures
	@chown $(OWNER) $(TMACDIR)/tmac.pictures
	cp mpictures.5 $(MAN5DIR)/mpictures.5
	@chmod 644 $(MAN5DIR)/mpictures.5
	@chgrp $(GROUP) $(MAN5DIR)/mpictures.5
	@chown $(OWNER) $(MAN5DIR)/mpictures.5

minstall :
	@if [ ! -d $(MACRODIR) ]; then \
	    mkdir $(MACRODIR); \
	    chmod 755 $(MACRODIR); \
	    chgrp $(GROUP) $(MACRODIR); \
	    chown $(OWNER) $(MACRODIR); \
	fi
	cp pictures $(MACRODIR)/pictures
	@chmod 644 $(MACRODIR)/pictures
	@chgrp $(GROUP) $(MACRODIR)/pictures
	@chown $(OWNER) $(MACRODIR)/pictures

clean :
	rm -f pictures tmac.pictures

clobber : clean

pictures : pictures.sr
	@cp pictures.sr pictures
	@if [ $(MACRODIR) != $(TMACDIR) ]; \
	    then echo ".so $(MACRODIR)/pictures" >tmac.pictures; \
	    else cp pictures tmac.pictures; \
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
	    -e "s'^.ds dT.*'.ds dT $(TMACDIR)'" \
	mpictures.5 >Xmpictures.5; \
	mv Xmpictures.5 mpictures.5

