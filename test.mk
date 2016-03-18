TESTS=	eqn_tests grap_tests mm_tests mview_tests mv_tests pic_tests tbl_tests
DOC=	eqn grap misc mm mpictures mv mview pic picasso post tbl \
	troff.man troff.tut

test:
	for i in $(TESTS); do \
		(cd tests/$$i; \
		$(MAKE) -f $$i.mk); \
	done
	for i in $(DOC); do \
		(cd doc/$$i; \
		for j in PS.*; do \
			mv $$j $$j.orig; \
		done; \
		for j in ps.* *.ps; do \
			[ -e $$j ] || continue; \
			mv $$j $$j.orig; \
			cp $$j.orig $$j; \
		done; \
		./Run; \
		for j in *.orig; do \
			k=`echo $$j|sed 's/.orig$$//'`; \
			diff -d $$j $$k || echo "$$i/$$k"; \
			rm $$k; \
			mv $$j $$k; \
		done); \
	done
