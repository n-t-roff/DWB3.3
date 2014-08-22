MAKE=/bin/make
MAKEFILE=onroff.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

NDEVNAME=37
TDEVNAME=post

BINDIR=/usr/bin
FONTDIR=/usr/lib/font
MACRODIR=/usr/lib/macros
MAN1DIR=/usr/man/man1
NTERMDIR=/usr/lib/nterm
PUBDIR=/usr/pub
TMACDIR=/usr/lib/tmac

CFLGS=-O
LDFLGS=-s

CFLAGS=$(CFLGS) -DNROFF -DINCORE -D$(SYSTEM)
#CFLAGS=$(CFLGS) -DNROFF -DSMALLER -DINCORE -D$(SYSTEM)
LDFLAGS=$(LDFLGS)

OFILES=n1.o\
       n2.o\
       n3.o\
       n4.o\
       n5.o\
       n6.o\
       n7.o\
       n8.o\
       n9.o\
       n10.o\
       ni.o\
       nii.o\
       hytab.o\
       suftab.o

all : onroff

install : all
	cp onroff $(BINDIR)/onroff
	@chmod 755 $(BINDIR)/onroff
	@chgrp $(GROUP) $(BINDIR)/onroff
	@chown $(OWNER) $(BINDIR)/onroff

clean :
	rm -f *.o

clobber : clean
	rm -f onroff

onroff : $(OFILES)
	$(CC) -n $(CFLAGS) $(LDFLAGS) -o onroff $(OFILES)

n1.o : tdef.h ext.h tw.h
n2.o : tdef.h ext.h tw.h
n3.o : tdef.h ext.h tw.h
n4.o : tdef.h ext.h tw.h
n5.o : tdef.h ext.h tw.h
n6.o : tdef.h ext.h tw.h
n7.o : tdef.h ext.h tw.h
n8.o : tdef.h ext.h
n9.o : tdef.h ext.h tw.h
n10.o : tdef.h ext.h tw.h
ni.o : tdef.h
nii.o : tdef.h ext.h tw.h

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^NDEVNAME=.*'NDEVNAME=$(NDEVNAME)'" \
	    -e "s'^TDEVNAME=.*'TDEVNAME=$(TDEVNAME)'" \
	    -e "s'^BINDIR=.*'BINDIR=$(BINDIR)'" \
	    -e "s'^FONTDIR=.*'FONTDIR=$(FONTDIR)'" \
	    -e "s'^MACRODIR=.*'MACRODIR=$(MACRODIR)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	    -e "s'^NTERMDIR=.*'NTERMDIR=$(NTERMDIR)'" \
	    -e "s'^PUBDIR=.*'PUBDIR=$(PUBDIR)'" \
	    -e "s'^TMACDIR=.*'TMACDIR=$(TMACDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'NDEVNAME.*'NDEVNAME	\"$(NDEVNAME)\"'" \
	    -e "s'TDEVNAME.*'TDEVNAME	\"$(TDEVNAME)\"'" \
	    -e "s'FONTDIR.*'FONTDIR	\"$(FONTDIR)\"'" \
	    -e "s'NTERMDIR.*'NTERMDIR	\"$(NTERMDIR)/tab.\"'" \
	    -e "s'TMACDIR.*'TMACDIR	\"$(TMACDIR)/tmac.\"'" \
	tdef.h >Xtdef.h; \
	mv Xtdef.h tdef.h

