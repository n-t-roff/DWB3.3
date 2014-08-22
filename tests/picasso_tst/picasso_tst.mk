MAKE=/bin/make
MAKEFILE=picasso_tst.mk

SYSTEM=SYSV

all :
	@for i in picasso??; do \
	    if [ -f "$$i" ]; then \
		echo "picasso $$i >$$i.ps"; \
		picasso $$i >$$i.ps; \
	    fi; \
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

