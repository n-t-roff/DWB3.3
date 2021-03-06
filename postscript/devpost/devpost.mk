MAKE=/bin/make
MAKEFILE=devpost.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

FONTDIR=/usr/lib/font
FONTFILES=DESC ? ?? shell.lib

all :

install :
	@rm -f $(FONTDIR)/devpost/*.out
	@if [ ! -d $(FONTDIR) ]; then \
	    mkdir $(FONTDIR); \
	    chmod 755 $(FONTDIR); \
	    chgrp $(GROUP) $(FONTDIR); \
	    chown $(OWNER) $(FONTDIR); \
	fi
	@if [ ! -d $(FONTDIR)/devpost ]; then \
	    mkdir $(FONTDIR)/devpost; \
	    chmod 755 $(FONTDIR)/devpost; \
	    chgrp $(GROUP) $(FONTDIR)/devpost; \
	    chown $(OWNER) $(FONTDIR)/devpost; \
	fi
	@if [ ! -d $(FONTDIR)/devpost/charlib ]; then \
	    mkdir $(FONTDIR)/devpost/charlib; \
	    chmod 755 $(FONTDIR)/devpost/charlib; \
	    chgrp $(GROUP) $(FONTDIR)/devpost/charlib; \
	    chown $(OWNER) $(FONTDIR)/devpost/charlib; \
	fi
	cp $(FONTFILES) $(FONTDIR)/devpost
	cd $(FONTDIR)/devpost; rm -f HM; ln -s H HM
	@for i in $(FONTFILES); do \
	    chmod 644 $(FONTDIR)/devpost/$$i; \
	    chgrp $(GROUP) $(FONTDIR)/devpost/$$i; \
	    chown $(OWNER) $(FONTDIR)/devpost/$$i; \
	done
	cp charlib/* $(FONTDIR)/devpost/charlib
	@for i in charlib/*; do \
	    chmod 644 $(FONTDIR)/devpost/$$i; \
	    chgrp $(GROUP) $(FONTDIR)/devpost/$$i; \
	    chown $(OWNER) $(FONTDIR)/devpost/$$i; \
	done

clean :
	rm -f HM

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

