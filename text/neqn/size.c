# include "e.h"
#include "y.tab.h"
#include <stdlib.h>

extern YYSTYPE yyval;

void
setsize(char *p)	/* set size as found in p */
{
	if (*p == '+')
		ps += atoi(p+1);
	else if (*p == '-')
		ps -= atoi(p+1);
	else
		ps = atoi(p);
	if(dbg)printf(".\tsetsize %s; ps = %d\n", p, ps);
}

void
size(int p1, int p2) {
		/* old size in p1, new in ps */
	int effps, effp1;

	yyval.token = p2;
	if(dbg)printf(".\tb:sb: S%d <- \\s%d S%d \\s%d; b=%d, h=%d\n", 
		yyval.token, ps, p2, p1, ebase[yyval.token], eht[yyval.token]);
	effps = EFFPS(ps);
	effp1 = EFFPS(p1);
	printf(".ds %d \\s%d\\*(%d\\s%d\n", 
		yyval.token, effps, p2, effp1);
	ps = p1;
}

void
globsize(void) {
	char temp[20];

	getstr(temp, 20);
	if (temp[0] == '+')
		gsize += atoi(temp+1);
	else if (temp[0] == '-')
		gsize -= atoi(temp+1);
	else
		gsize = atoi(temp);
	yyval.token = eqnreg = 0;
	setps(gsize);
	ps = gsize;
	if (gsize >= 12)	/* sub and sup size change */
		deltaps = gsize / 4;
	else
		deltaps = gsize / 3;
}
