#include "e.h"
#include "y.tab.h"

extern int Intps;
extern double Intht, Intbase, Int1h, Int1v, Int2h, Int2v;

int integral(int p, int p1, int p2)
{
	dwb_yyval = p;
	if (p1 != 0)
		printf(".ds %d \\h'%gm'\\v'%gm'\\*(%d\\v'%gm'\n", p1, -Int1h, Int1v, p1, -Int1v);
	if (p2 != 0)
		printf(".ds %d \\v'%gm'\\h'%gm'\\*(%d\\v'%gm'\n", p2, -Int2v, Int2h, p2, Int2v);
	if (p1 != 0 && p2 != 0)
		dwb_yyval = shift2(p, p1, p2);
	else if (p1 != 0)
		dwb_yyval = bshiftb(p, SUB, p1);
	else if (p2 != 0)
		dwb_yyval = bshiftb(p, SUP, p2);
	dprintf(".\tintegral: S%d; h=%g b=%g\n", p, eht[p], ebase[p]);
	lfont[p] = ROM;
	return dwb_yyval;
}

int setintegral(void)
{
	dwb_yyval = salloc();
	printf(".ds %d %s\n", dwb_yyval, lookup(deftbl, "int_def")->cval);
	eht[dwb_yyval] = EM(Intht, ps+Intps);
	ebase[dwb_yyval] = EM(Intbase, ps);
	lfont[dwb_yyval] = rfont[dwb_yyval] = ROM;
	return dwb_yyval;
}
