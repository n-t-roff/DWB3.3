# include "e.h"
# include "y.tab.h"

int move(int dir, int amt, int p)
{
	double a;

	dwb_yyval = p;
	a = EM(amt/100.0, ps);
	printf(".ds %d ", dwb_yyval);
	if (dir == FWD || dir == BACK)
		printf("\\h'%s%gm'\\*(%d\n", (dir==BACK) ? "-" : "", a, p);
	else if (dir == UP)
		printf("\\v'-%gm'\\*(%d\\v'%gm'\n", a, p, a);
	else if (dir == DOWN)
		printf("\\v'%gm'\\*(%d\\v'-%gm'\n", a, p, a);
	dprintf(".\tmove %d dir %d amt %g; h=%g b=%g\n", 
		p, dir, a, eht[dwb_yyval], ebase[dwb_yyval]);
	return dwb_yyval;
}
