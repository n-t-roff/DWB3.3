#
# Won't compile without a good C++ compiler.
#

CC=CC

MAKE=/bin/make
MAKEFILE=pm.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

MAN5DIR=/usr/man/p_man/man5
TMACDIR=/usr/lib/tmac

CFLGS=-O
LDFLGS=-s

CFLAGS=$(CFLGS) -D$(SYSTEM)
LDFLAGS=$(LDFLGS)

OFILES=misc.o\
       slug.o\
       range.o\
       queue.o\
       page.o

all : pm tmac.pm tmac.spe

install : all
	cp pm $(TMACDIR)/pm
	@chmod 755 $(TMACDIR)/pm
	@chgrp $(GROUP) $(TMACDIR)/pm
	@chown $(OWNER) $(TMACDIR)/pm
	cp tmac.pm $(TMACDIR)/tmac.pm
	@chmod 644 $(TMACDIR)/tmac.pm
	@chgrp $(GROUP) $(TMACDIR)/tmac.pm
	@chown $(OWNER) $(TMACDIR)/tmac.pm
	cp tmac.spe $(TMACDIR)/tmac.spe
	@chmod 644 $(TMACDIR)/tmac.spe
	@chgrp $(GROUP) $(TMACDIR)/tmac.spe
	@chown $(OWNER) $(TMACDIR)/tmac.spe
	sed -e 's" /usr/lib/tmac$$" $(TMACDIR)"' \
	    mpm.5 > $(MAN5DIR)/mpm.5
	@chmod 644 $(MAN5DIR)/mpm.5
	@chgrp $(GROUP) $(MAN5DIR)/mpm.5
	@chown $(OWNER) $(MAN5DIR)/mpm.5

clean :
	rm -f *.o

clobber : clean
	rm -f pm tmac.pm tmac.spe

tmac.pm : tmac.pm.sr
	@sed \
	    -e "s:TMACDIR:$(TMACDIR):" \
	tmac.pm.sr >tmac.pm

tmac.spe : tmac.spe.sr
	@sed \
	    -e "s:TMACDIR:$(TMACDIR):" \
	tmac.spe.sr >tmac.spe

pm : $(OFILES)
	$(CXX) $(CFLAGS) -o pm $(OFILES) -lm

.c.o:
	$(CXX) $(CFLAGS) -c $<

misc.o : misc.h
slug.o : slug.h misc.h
range.o : range.h slug.h misc.h
queue.o : page.h range.h slug.h misc.h
page.o : page.h range.h slug.h misc.h

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^MAN5DIR=.*'MAN5DIR=$(MAN5DIR)'" \
	    -e "s'^TMACDIR=.*'TMACDIR=$(TMACDIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^.ds dT.*'.ds dT $(TMACDIR)'" \
	mpm.5 >Xmpm.5; \
	mv Xmpm.5 mpm.5


