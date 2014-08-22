MAKE=/bin/make
MAKEFILE=devnroff-12.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

FONTDIR=/usr/lib/font
FONTFILES=DESC ? ??

all :

install : all
	@if [ ! -d $(FONTDIR) ]; then \
	    mkdir $(FONTDIR); \
	    chmod 755 $(FONTDIR); \
	    chgrp $(GROUP) $(FONTDIR); \
	    chown $(OWNER) $(FONTDIR); \
	fi
	@if [ ! -d $(FONTDIR)/devnroff-12 ]; then \
	    mkdir $(FONTDIR)/devnroff-12; \
	    chmod 755 $(FONTDIR)/devnroff-12; \
	    chgrp $(GROUP) $(FONTDIR)/devnroff-12; \
	    chown $(OWNER) $(FONTDIR)/devnroff-12; \
	fi
	cp $(FONTFILES) $(FONTDIR)/devnroff-12
	@for i in $(FONTFILES); do \
	    chmod 644 $(FONTDIR)/devnroff-12/$$i; \
	    chgrp $(GROUP) $(FONTDIR)/devnroff-12/$$i; \
	    chown $(OWNER) $(FONTDIR)/devnroff-12/$$i; \
	done

clean :

clobber : clean

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^FONTDIR=.*'FONTDIR=$(FONTDIR)'" \
	$(MAKEFILE) >XXX.mk; \
	mv XXX.mk $(MAKEFILE)

