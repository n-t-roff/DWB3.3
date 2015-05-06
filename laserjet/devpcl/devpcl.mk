MAKE=/bin/make
MAKEFILE=devpcl.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

FONTDIR=/usr/lib/font
FONTFILES=DESC ? ??

all :

install : all
	@rm -f $(FONTDIR)/devpcl/*.out
	@if [ ! -d $(FONTDIR) ]; then \
	    mkdir $(FONTDIR); \
	    chmod 755 $(FONTDIR); \
	    chgrp $(GROUP) $(FONTDIR); \
	    chown $(OWNER) $(FONTDIR); \
	fi
	@if [ ! -d $(FONTDIR)/devpcl ]; then \
	    mkdir $(FONTDIR)/devpcl; \
	    chmod 755 $(FONTDIR)/devpcl; \
	    chgrp $(GROUP) $(FONTDIR)/devpcl; \
	    chown $(OWNER) $(FONTDIR)/devpcl; \
	fi
	cp $(FONTFILES) $(FONTDIR)/devpcl
	cd $(FONTDIR)/devpcl; \
	rm -f G GI HB HM HK HL HX CB; \
	ln -s H G ; ln -s HI GI; ln -s H  HB; ln -s H  HM; \
	ln -s H HK; ln -s H  HL; ln -s HI HX; ln -s CW CB;
	@for i in $(FONTFILES); do \
	    chmod 644 $(FONTDIR)/devpcl/$$i; \
	    chgrp $(GROUP) $(FONTDIR)/devpcl/$$i; \
	    chown $(OWNER) $(FONTDIR)/devpcl/$$i; \
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

