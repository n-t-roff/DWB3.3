# include "e.h"
# include "y.tab.h"

int
funny(int n) {
	char *f;
	int yyval;

	yyval = oalloc();
	switch(n) {
	case SUM:
		f = "\\(*S"; break;
	case UNION:
		f = "\\(cu"; break;
	case INTER:	/* intersection */
		f = "\\(ca"; break;
	case PROD:
		f = "\\(*P"; break;
	default:
		error(FATAL, "funny type %d in funny", n);
		f = ""; /* silence warning */
	}
	printf(".ds %d %s\n", yyval, f);
	eht[yyval] = VERT(2);
	ebase[yyval] = 0;
	if (dbg)
		printf(".\tfunny: S%d <- %s; h=%d b=%d\n",
		    yyval, f, eht[yyval], ebase[yyval]);
	lfont[yyval] = rfont[yyval] = ROM;
	return yyval;
}
