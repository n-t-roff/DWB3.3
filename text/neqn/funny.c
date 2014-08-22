# include "e.h"
# include "y.tab.h"

extern YYSTYPE yyval;

funny(n) int n; {
	char *f;

	yyval.token = oalloc();
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
	}
	printf(".ds %d %s\n", yyval.token, f);
	eht[yyval.token] = VERT(2);
	ebase[yyval.token] = 0;
	if(dbg)printf(".\tfunny: S%d <- %s; h=%d b=%d\n", 
		yyval.token, f, eht[yyval.token], ebase[yyval.token]);
	lfont[yyval.token] = rfont[yyval.token] = ROM;
}
