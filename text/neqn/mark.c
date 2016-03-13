#include "e.h"
#include "y.tab.h"

extern YYSTYPE yyval;

void
mark(int p1) {
	markline = 1;
	printf(".ds %d \\k(97\\*(%d\n", p1, p1);
	yyval.token = p1;
	if(dbg)printf(".\tmark %d\n", p1);
}

void
lineup(int p1) {
	markline = 1;
	if (p1 == 0) {
		yyval.token = oalloc();
		printf(".ds %d \\h'|\\n(97u'\n", yyval.token);
	}
	if(dbg)printf(".\tlineup %d\n", p1);
}
