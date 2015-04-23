MAKE=/bin/make
MAKEFILE=troff.mk

SYSTEM=BSD4_2
VERSION=3.3

GROUP=bin
OWNER=bin

HYPHALG=0
NDEVNAME=37
TDEVNAME=post

BINDIR=/usr/bin
FONTDIR=/usr/lib/font
MACRODIR=/usr/lib/macros
MAN1DIR=/usr/man/u_man/man1
MAN5DIR=/usr/man/p_man/man5
NTERMDIR=/usr/lib/nterm
PUBDIR=/usr/pub
TMACDIR=/usr/lib/tmac

CFLGS=-O
LDFLGS=-s

CFLAGS=$(CFLGS) -D$(SYSTEM) -DDWBVERSION='"${VERSION}"'
LDFLAGS=$(LDFLGS)

OFILES=n1.o\
       n2.o\
       n3.o\
       n4.o\
       n5.o\
       t6.o\
       n6.o\
       n7.o\
       n8.o\
       n9.o\
       n10.o\
       t10.o\
       t11.o\
       ni.o\
       hytab.o\
       suftab.o\
       dwbinit.o

all : troff

install : all
	@if [ ! -d $(TMACDIR) ]; then \
	    mkdir $(TMACDIR); \
	    chmod 755 $(TMACDIR); \
	    chgrp $(GROUP) $(TMACDIR); \
	    chown $(OWNER) $(TMACDIR); \
	fi
	cp troff $(BINDIR)/troff
	@chmod 755 $(BINDIR)/troff
	@chgrp $(GROUP) $(BINDIR)/troff
	@chown $(OWNER) $(BINDIR)/troff
	cp troff $(BINDIR)/nroff
	@chmod 755 $(BINDIR)/nroff
	@chgrp $(GROUP) $(BINDIR)/nroff
	@chown $(OWNER) $(BINDIR)/nroff
	cp hyphen.tex $(TMACDIR)/hyphen.tex
	@chmod 644 $(TMACDIR)/hyphen.tex
	@chgrp $(GROUP) $(TMACDIR)/hyphen.tex
	@chown $(OWNER) $(TMACDIR)/hyphen.tex
	for i in *.1; do \
		sed -e 's" /usr/lib/font$$" $(FONTDIR)"' \
		    -e 's" /usr/lib/macros$$" $(MACRODIR)"' \
		    -e 's" /usr/pub$$" $(PUBDIR)"' \
		    -e 's" /usr/lib/tmac$$" $(TMACDIR)"' \
		    -e 's" /usr/lib/nterm$$" $(NTERMDIR)"' \
		    $$i > $(MAN1DIR)/$$i; \
	done
	for i in *.5; do \
		sed -e 's" /usr/lib/font$$" $(FONTDIR)"' \
		    $$i > $(MAN5DIR)/$$i; \
	done
	@chmod 644 $(MAN1DIR)/troff.1
	@chgrp $(GROUP) $(MAN1DIR)/troff.1
	@chown $(OWNER) $(MAN1DIR)/troff.1
	@chmod 644 $(MAN1DIR)/nroff.1
	@chgrp $(GROUP) $(MAN1DIR)/nroff.1
	@chown $(OWNER) $(MAN1DIR)/nroff.1
	@chmod 644 $(MAN5DIR)/troff.5
	@chgrp $(GROUP) $(MAN5DIR)/troff.5
	@chown $(OWNER) $(MAN5DIR)/troff.5
	@chmod 644 $(MAN5DIR)/font.5
	@chgrp $(GROUP) $(MAN5DIR)/font.5
	@chown $(OWNER) $(MAN5DIR)/font.5

clean :
	rm -f *.o

clobber : clean
	rm -f troff

troff : $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o troff $(OFILES)

n1.o : tdef.h fns.h ext.h
n2.o : tdef.h fns.h ext.h
n3.o : tdef.h fns.h ext.h
n4.o : tdef.h fns.h ext.h
n5.o : tdef.h fns.h ext.h
t6.o : tdef.h fns.h ext.h
n6.o : tdef.h fns.h ext.h
n7.o : tdef.h fns.h ext.h
n8.o : tdef.h fns.h ext.h
n9.o : tdef.h fns.h ext.h
t10.o : tdef.h fns.h ext.h
n10.o : tdef.h fns.h ext.h
t11.o : tdef.h fns.h ext.h
ni.o : tdef.h fns.h ext.h

hytab.o : hytab.c
suftab.o : suftab.c

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^HYPHALG=.*'HYPHALG=$(HYPHALG)'" \
	    -e "s'^NDEVNAME=.*'NDEVNAME=$(NDEVNAME)'" \
	    -e "s'^TDEVNAME=.*'TDEVNAME=$(TDEVNAME)'" \
	    -e "s'^BINDIR=.*'BINDIR=$(BINDIR)'" \
	    -e "s'^FONTDIR=.*'FONTDIR=$(FONTDIR)'" \
	    -e "s'^MACRODIR=.*'MACRODIR=$(MACRODIR)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	    -e "s'^MAN5DIR=.*'MAN5DIR=$(MAN5DIR)'" \
	    -e "s'^NTERMDIR=.*'NTERMDIR=$(NTERMDIR)'" \
	    -e "s'^PUBDIR=.*'PUBDIR=$(PUBDIR)'" \
	    -e "s'^TMACDIR=.*'TMACDIR=$(TMACDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'define HYPHALG.*'define HYPHALG	$(HYPHALG)'" \
	    -e "s'define NDEVNAME.*'define NDEVNAME	\"$(NDEVNAME)\"'" \
	    -e "s'define TDEVNAME.*'define TDEVNAME	\"$(TDEVNAME)\"'" \
	    -e "s'define FONTDIR.*'define FONTDIR	\"$(FONTDIR)\"'" \
	    -e "s'define NTERMDIR.*'define NTERMDIR	\"$(NTERMDIR)/tab.\"'" \
	    -e "s'define TMACDIR.*'define TMACDIR	\"$(TMACDIR)/tmac.\"'" \
	    -e "s'define ALTHYPHENS.*'define ALTHYPHENS	\"$(TMACDIR)/hyphen.tex\"'" \
	tdef.h >Xtdef.h; \
	mv Xtdef.h tdef.h; \
	sed \
	    -e "s'^.ds dF.*'.ds dF $(FONTDIR)'" \
	    -e "s'^.ds dM.*'.ds dM $(MACRODIR)'" \
	    -e "s'^.ds dP.*'.ds dP $(PUBDIR)'" \
	    -e "s'^.ds dT.*'.ds dT $(TMACDIR)'" \
	troff.1 >Xtroff.1; \
	mv Xtroff.1 troff.1; \
	sed \
	    -e "s'^.ds dM.*'.ds dM $(MACRODIR)'" \
	    -e "s'^.ds dN.*'.ds dN $(NTERMDIR)'" \
	    -e "s'^.ds dP.*'.ds dP $(PUBDIR)'" \
	    -e "s'^.ds dT.*'.ds dT $(TMACDIR)'" \
	nroff.1 >Xnroff.1; \
	mv Xnroff.1 nroff.1; \
	sed \
	    -e "s'^.ds dF.*'.ds dF $(FONTDIR)'" \
	troff.5 >Xtroff.5; \
	mv Xtroff.5 troff.5; \
	sed \
	    -e "s'^.ds dF.*'.ds dF $(FONTDIR)'" \
	font.5 >Xfont.5; \
	mv Xfont.5 font.5

