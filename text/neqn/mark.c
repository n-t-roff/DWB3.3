#include "e.h"
#include "y.tab.h"

int
mark(int p1) {
	int yyval;
	markline = 1;
	printf(".ds %d \\k(97\\*(%d\n", p1, p1);
	yyval = p1;
	if(dbg)printf(".\tmark %d\n", p1);
	return yyval;
}

int
lineup(int p1) {
	int yyval;
	markline = 1;
	if (p1)
		yyval = p1;
	else {
		yyval = oalloc();
		printf(".ds %d \\h'|\\n(97u'\n", yyval);
	}
	if (dbg)
		printf(".\tlineup %d\n", p1);
	return yyval;
}
