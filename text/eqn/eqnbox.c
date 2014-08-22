#include "e.h"

int eqnbox(int p1, int p2, int lu)
{
	double b, h;
	char *sh;
	extern char *IRspace;

	dwb_yyval = p1;
	b = max(ebase[p1], ebase[p2]);
	eht[dwb_yyval] = h = b + max(eht[p1]-ebase[p1], 
		eht[p2]-ebase[p2]);
	ebase[dwb_yyval] = b;
	dprintf(".\tS%d <- %d %d; b=%g, h=%g\n", dwb_yyval, p1, p2, b, h);
	sh = pad(class[rclass[p1]][lclass[p2]]);
	if (lu) {
		printf(".nr %d \\w'\\*(%d%s'\n", p1, p1, sh);
		printf(".ds %d \\h'|\\n(09u-\\n(%du'\\*(%d\n", p1, p1, p1);
	}
	printf(".as %d \"%s\\*(%d\n", dwb_yyval, sh, p2);
	rfont[p1] = rfont[p2];
	rclass[p1] = rclass[p2];
	sfree(p2);
	return dwb_yyval;
}
