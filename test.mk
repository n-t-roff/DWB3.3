DOC=	eqn grap misc mm mpictures mv mview pic picasso post tbl \
	troff.man troff.tut

test:
	for i in $(DOC); do \
		(cd doc/$$i; \
		for j in PS.*; do \
			mv $$j $$j.orig; \
		done; \
		./Run; \
		for j in PS.*.orig; do \
			k=`echo $$j|sed 's/.orig$$//'`; \
			diff -d $$j $$k || echo "$$i/$$k"; \
			rm $$k; \
			mv $$j $$k; \
		done); \
	done
