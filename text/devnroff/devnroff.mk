MAKE=/bin/make
MAKEFILE=devnroff.mk

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
	@if [ ! -d $(FONTDIR)/devnroff ]; then \
	    mkdir $(FONTDIR)/devnroff; \
	    chmod 755 $(FONTDIR)/devnroff; \
	    chgrp $(GROUP) $(FONTDIR)/devnroff; \
	    chown $(OWNER) $(FONTDIR)/devnroff; \
	fi
	cp $(FONTFILES) $(FONTDIR)/devnroff
	@for i in $(FONTFILES); do \
	    chmod 644 $(FONTDIR)/devnroff/$$i; \
	    chgrp $(GROUP) $(FONTDIR)/devnroff/$$i; \
	    chown $(OWNER) $(FONTDIR)/devnroff/$$i; \
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
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE)

