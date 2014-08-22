#include "e.h"

int mark(int p1)
{
	markline = 1;
	printf(".ds %d \\k(09\\*(%d\n", p1, p1);
	dwb_yyval = p1;
	dprintf(".\tmark %d\n", p1);
	return dwb_yyval;
}

int lineup(int p1)
{
	markline = 2;
	if (p1 == 0) {
		dwb_yyval = salloc();
		printf(".ds %d \\h'|\\n(09u'\n", dwb_yyval);
	}
	dprintf(".\tlineup %d\n", p1);
	return dwb_yyval;
}
