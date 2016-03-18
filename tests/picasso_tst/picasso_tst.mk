MAKE=/bin/make
MAKEFILE=picasso_tst.mk

SYSTEM=SYSV

all :
	for i in picasso??; do \
		mv $$i.ps $$i.ps.orig; \
		picasso $$i >$$i.ps; \
		diff $$i.ps $$i.ps.orig; \
		rm $$i.ps; \
		mv $$i.ps.orig $$i.ps; \
	done

install : all
	@if [ ! -d ../$(SYSTEM) ]; then \
	    mkdir ../$(SYSTEM); \
	    chmod 755 ../$(SYSTEM); \
	fi
	cp *.ps ../$(SYSTEM)
	@chmod 644 ../$(SYSTEM)/*.ps

clean :
	rm -f *.ps

clobber : clean

changes :

