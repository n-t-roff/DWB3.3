# include "e.h"
# include "y.tab.h"

extern YYSTYPE yyval;

void
move(int dir, int amt, int p) {
	int a;

	yyval.token = p;
	a = VERT( (amt+49)/50 );	/* nearest number of half-lines */
	printf(".ds %d ", yyval.token);
	if( dir == FWD || dir == BACK )	/* fwd, back */
		printf("\\h'%s%du'\\*(%d\n", (dir==BACK) ? "-" : "", a, p);
	else if (dir == UP)
		printf("\\v'-%du'\\*(%d\\v'%du'\n", a, p, a);
	else if (dir == DOWN)
		printf("\\v'%du'\\*(%d\\v'-%du'\n", a, p, a);
	if(dbg)printf(".\tmove %d dir %d amt %d; h=%d b=%d\n", 
		p, dir, a, eht[yyval.token], ebase[yyval.token]);
}
