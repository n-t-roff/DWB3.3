# include "e.h"
# include "y.tab.h"

extern YYSTYPE yyval;

void
integral(int p, int p1, int p2) {
#ifndef	NEQN
	if (p1 != 0)
		printf(".ds %d \\h'-0.4m'\\v'0.4m'\\*(%d\\v'-0.4m'\n", p1, p1);
	if (p2 != 0)
		printf(".ds %d \\v'-0.3m'\\*(%d\\v'0.3m'\n", p2, p2);
#endif
	if (p1 != 0 && p2 != 0)
		shift2(p, p1, p2);
	else if (p1 != 0)
		bshiftb(p, SUB, p1);
	else if (p2 != 0)
		bshiftb(p, SUP, p2);
	if(dbg)printf(".\tintegral: S%d; h=%d b=%d\n", 
		p, eht[p], ebase[p]);
	lfont[p] = ROM;
}

void
setintegral(void) {
	char *f;

	yyval.token = oalloc();
	f = "\\(is";
	printf(".ds %d %s\n", yyval.token, f);
	eht[yyval.token] = VERT(2);
	ebase[yyval.token] = 0;
	lfont[yyval.token] = rfont[yyval.token] = ROM;
}
