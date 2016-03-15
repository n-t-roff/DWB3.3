#include "e.h"

#ifndef UNANSI
int mark(int p1)
#else /* UNANSI */
void mark(p1)
	int p1;
#endif /* UNANSI */
{
	int yyval;

	markline = 1;
	printf(".ds %d \\k(09\\*(%d\n", p1, p1);
	yyval = p1;
	dprintf(".\tmark %d\n", p1);
	return yyval;
}

#ifndef UNANSI
int lineup(int p1)
#else /* UNANSI */
void lineup(p1)
	int p1;
#endif /* UNANSI */
{
	int yyval;

	markline = 2;
	if (p1)
		yyval = p1;
	else {
		yyval = salloc();
		printf(".ds %d \\h'|\\n(09u'\n", yyval);
	}
	dprintf(".\tlineup %d\n", p1);
	return yyval;
}
