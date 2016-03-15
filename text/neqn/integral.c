# include "e.h"
# include "y.tab.h"

int
integral(int p, int p1, int p2) {
	int yyval;
#ifndef	NEQN
	if (p1 != 0)
		printf(".ds %d \\h'-0.4m'\\v'0.4m'\\*(%d\\v'-0.4m'\n", p1, p1);
	if (p2 != 0)
		printf(".ds %d \\v'-0.3m'\\*(%d\\v'0.3m'\n", p2, p2);
#endif
	if (p1 != 0 && p2 != 0)
		yyval = shift2(p, p1, p2);
	else if (p1 != 0)
		yyval = bshiftb(p, SUB, p1);
	else if (p2 != 0)
		yyval = bshiftb(p, SUP, p2);
	else
		yyval = p; /* default: $$ = $1 */
	if(dbg)printf(".\tintegral: S%d; h=%d b=%d\n", 
		p, eht[p], ebase[p]);
	lfont[p] = ROM;
	return yyval;
}

int
setintegral(void) {
	char *f;
	int yyval;

	yyval = oalloc();
	f = "\\(is";
	printf(".ds %d %s\n", yyval, f);
	eht[yyval] = VERT(2);
	ebase[yyval] = 0;
	lfont[yyval] = rfont[yyval] = ROM;
	return yyval;
}
