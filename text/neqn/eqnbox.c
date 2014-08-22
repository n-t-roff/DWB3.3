# include "e.h"
#include "y.tab.h"

extern YYSTYPE yyval;

eqnbox(p1, p2, lu) {
	int b, h;
	char *sh;

	yyval.token = p1;
	b = max(ebase[p1], ebase[p2]);
	eht[yyval.token] = h = b + max(eht[p1]-ebase[p1], 
		eht[p2]-ebase[p2]);
	ebase[yyval.token] = b;
	if(dbg)printf(".\te:eb: S%d <- S%d S%d; b=%d, h=%d\n", 
		yyval.token, p1, p2, b, h);
	if (rfont[p1] == ITAL && lfont[p2] == ROM)
		sh = "\\|";
	else
		sh = "";
	if (lu) {
		printf(".nr %d \\w'\\s%d\\*(%d%s'\n", p1, ps, p1, sh);
		printf(".ds %d \\h'|\\n(97u-\\n(%du'\\*(%d\n", p1, p1, p1);
	}
	printf(".as %d \"%s\\*(%d\n", yyval.token, sh, p2);
	rfont[p1] = rfont[p2];
	ofree(p2);
}
