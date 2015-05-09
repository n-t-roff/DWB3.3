# include "e.h"
# include "y.tab.h"

#ifndef UNANSI
int move(int dir, int amt, int p)
#else /* UNANSI */
void move(dir, amt, p)
	int dir; int amt; int p;
#endif /* UNANSI */
{
	double a;
	int yyval;

	yyval = p;
	a = EM(amt/100.0, ps);
	printf(".ds %d ", yyval);
	if (dir == FWD || dir == BACK)
		printf("\\h'%s%gm'\\*(%d\n", (dir==BACK) ? "-" : "", a, p);
	else if (dir == UP)
		printf("\\v'-%gm'\\*(%d\\v'%gm'\n", a, p, a);
	else if (dir == DOWN)
		printf("\\v'%gm'\\*(%d\\v'-%gm'\n", a, p, a);
	dprintf(".\tmove %d dir %d amt %g; h=%g b=%g\n", 
		p, dir, a, eht[yyval], ebase[yyval]);
	return yyval;
}
