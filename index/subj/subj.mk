MAKE=/bin/make
MAKEFILE=subj.mk

SYSTEM=SYSV
VERSION=3.3

GROUP=bin
OWNER=bin

BINDIR=/usr/bin
LIBDIR=/usr/lib/dwb
MAN1DIR=/usr/man/u_man/man1

CFLGS=-O
LDFLGS=-s

CFLAGS=$(CFLGS)
LDFLAGS=$(LDFLGS)

all : subj parts sbj1 sbj2 sbj3 style1 style2 style3

install : all
	@if [ ! -d $(LIBDIR) ]; then \
	    mkdir $(LIBDIR); \
	    chmod 755 $(LIBDIR); \
	    chgrp $(GROUP) $(LIBDIR); \
	    chown $(OWNER) $(LIBDIR); \
	fi
	cp subj $(BINDIR)/subj
	@chmod 755 $(BINDIR)/subj
	@chgrp $(GROUP) $(BINDIR)/subj
	@chown $(OWNER) $(BINDIR)/subj
	cp parts $(LIBDIR)/parts
	@chmod 755 $(LIBDIR)/parts
	@chgrp $(GROUP) $(LIBDIR)/parts
	@chown $(OWNER) $(LIBDIR)/parts
	cp sbj1 $(LIBDIR)/sbj1
	@chmod 755 $(LIBDIR)/sbj1
	@chgrp $(GROUP) $(LIBDIR)/sbj1
	@chown $(OWNER) $(LIBDIR)/sbj1
	cp sbj2 $(LIBDIR)/sbj2
	@chmod 755 $(LIBDIR)/sbj2
	@chgrp $(GROUP) $(LIBDIR)/sbj2
	@chown $(OWNER) $(LIBDIR)/sbj2
	cp sbj3 $(LIBDIR)/sbj3
	@chmod 755 $(LIBDIR)/sbj3
	@chgrp $(GROUP) $(LIBDIR)/sbj3
	@chown $(OWNER) $(LIBDIR)/sbj3
	cp style1 $(LIBDIR)/style1
	@chmod 755 $(LIBDIR)/style1
	@chgrp $(GROUP) $(LIBDIR)/style1
	@chown $(OWNER) $(LIBDIR)/style1
	cp style2 $(LIBDIR)/style2
	@chmod 755 $(LIBDIR)/style2
	@chgrp $(GROUP) $(LIBDIR)/style2
	@chown $(OWNER) $(LIBDIR)/style2
	cp style3 $(LIBDIR)/style3
	@chmod 755 $(LIBDIR)/style3
	@chgrp $(GROUP) $(LIBDIR)/style3
	@chown $(OWNER) $(LIBDIR)/style3
	cp subj.1 $(MAN1DIR)/subj.1
	@chmod 644 $(MAN1DIR)/subj.1
	@chgrp $(GROUP) $(MAN1DIR)/subj.1
	@chown $(OWNER) $(MAN1DIR)/subj.1

clean :
	rm -f *.o

clobber : clean
	rm -f subj parts sbj1 sbj2 sbj3 style1 style2 style3

subj : subj.sh
	cp subj.sh subj; chmod 755 subj

parts : parts.sh
	cp parts.sh parts; chmod 755 parts

sbj1 : sbj1.o
	$(CC) $(CFLAGS) $(LDFLAGS) sbj1.o -o sbj1 -lfl

sbj2 : sbj2.o case.o
	$(CC) $(CFLAGS) $(LDFLAGS) sbj2.o case.o -o sbj2 -lfl

sbj3 : sbj3.o case.o omit.o
	$(CC) $(CFLAGS) $(LDFLAGS) sbj3.o case.o omit.o -o sbj3 -lfl

style1 : nwords.o
	$(CC) $(CFLAGS) $(LDFLAGS) nwords.o -o style1 -lfl

style2 : end.o
	$(CC) $(CFLAGS) $(LDFLAGS) end.o -o style2 -lfl

style3 : part.o pscan.o outp.o extern.o
	$(CC) $(CFLAGS) $(LDFLAGS) part.o pscan.o outp.o extern.o -o style3 -lfl

end.o : edict.h ehash.h names.h
nwords.o : abbrev.h dict.h names.h nhash.h ydict.h
omit.o : cnst.h
outp.o : cnst.h conp.h names.h style.h
part.o : conp.h names.h style.h
pscan.o : conp.h names.h
sbj1 : cnst.h
sbj2 : cnst.h
sbj3 : cnst.h

changes :
	@trap "" 1 2 3 15; \
	sed \
	    -e "s'^SYSTEM=.*'SYSTEM=$(SYSTEM)'" \
	    -e "s'^VERSION=.*'VERSION=$(VERSION)'" \
	    -e "s'^GROUP=.*'GROUP=$(GROUP)'" \
	    -e "s'^OWNER=.*'OWNER=$(OWNER)'" \
	    -e "s'^BINDIR=.*'BINDIR=$(BINDIR)'" \
	    -e "s'^LIBDIR=.*'LIBDIR=$(LIBDIR)'" \
	    -e "s'^MAN1DIR=.*'MAN1DIR=$(MAN1DIR)'" \
	$(MAKEFILE) >X$(MAKEFILE); \
	mv X$(MAKEFILE) $(MAKEFILE); \
	sed \
	    -e "s'^UL=.*'UL=$(LIBDIR)'" \
	subj.sh >Xsubj.sh; \
	mv Xsubj.sh subj.sh; \
	sed \
	    -e "s'^L=.*'L=$(LIBDIR)'" \
	parts.sh >Xparts.sh; \
	mv Xparts.sh parts.sh

