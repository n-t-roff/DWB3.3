# CC = cc

# CC = lcc -N -I/usr/include/lcc -A -b
# CC = lcc -N -I/usr/include/lcc -A
# CC = PTCC -I/usr/include/lcc

# CC = lcc -A
# CC = acc -sys5
# CC = /v/bin/lcc -A

CFLAGS = -g -p
CFLAGS = -g -DDWBENV=\""DWBHOME\"" -DDWBHOME=\""/usr\""
CFLAGS = -DDWBENV=\""DWBHOME\"" -DDWBHOME=\""/usr\""
# DWB test for now is: /s2/dwb3.3

CFILES=n1.c n2.c n3.c n4.c n5.c t6.c n6.c n7.c n8.c n9.c t10.c n10.c t11.c ni.c hytab.c suftab.c dwbinit.c
NCFILES = tab.37 tab.450 tab.lp
HFILES=tdef.h ext.h fns.h dwbinit.h
TFILES=n1.o n2.o n3.o n4.o n5.o t6.o n6.o n7.o n8.o n9.o t10.o n10.o t11.o ni.o hytab.o suftab.o dwbinit.o
NTHFILES=ntdef.h ext.h fns.h dwbinit.h
NTFILES=nt1.o n2.o n3.o n4.o n5.o t6.o n6.o n7.o nt8.o n9.o t10.o n10.o t11.o nti.o hytab.o suftab.o dwbinit.o
DFILES=dev202/DESC dev202/R dev202/I dev202/B dev202/S dev202/CW
SHAR=/v/bin/bundle

a.out:	$(TFILES)
	$(CC) $(CFLAGS) $(TFILES)

$(TFILES):	tdef.h fns.h ext.h 

hytab.o:	hytab.c
suftab.o:	suftab.c
n1.o:	dwbinit.h

clean:
	rm -f a.out  *.o core foo* temp* ntroff ntdef.h nt1.c nti.c nt8.c troff

dcat:	dcat.o draw.o dev.h
	${CC} -o dcat dcat.o draw.o -lm

d202:	d202.o draw.o dev.h
	${CC} $(CFLAGS) -O -o d202 d202.o draw.o -lm

dsort:	dsort.o dev.h
	${CC} -O -o dsort dsort.o

daps:	daps.o draw.o aps.h dev.h
	${CC} $(CFLAGS) -o daps daps.o draw.o -lm

dnroff:	dnroff.o
	${CC} -g -o dnroff dnroff.o

tc:	tc.o draw.o dev.h
	${CC} $(CFLAGS) -O -o tc tc.o draw.o -lm

hc:	hc.o draw.o dev.h
	${CC} $(CFLAGS) -O -o hc hc.o draw.o -lm

ta:	ta.o draw.o dev.h
	${CC} $(CFLAGS) -O -o ta ta.o draw.o -lm

bowell:	$(CFILES) $(HFILES) $(NCFILES) makefile ta.c hc.c tc.c d202.c draw.c FIXES README cvt unansi
	push bowell $? /usr/src/cmd/troff
	touch bowell

bundle:
	@${SHAR} README FIXES cvt unansi $(HFILES) $(CFILES) makefile 

bigbundle:
	@bundle README FIXES cvt unansi $(HFILES) tw.h dev.h  $(CFILES) $(NCFILES) makefile ta.c hc.c tc.c draw.c d202.c $(DFILES)

install:
	cp a.out /usr/bin/troff
	# ln /usr/bin/troff /usr/bin/nroff

tst: mee a.out
	@tbl mee | ./a.out -N
