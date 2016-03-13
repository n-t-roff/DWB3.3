# include "e.h"
#include "y.tab.h"

extern YYSTYPE yyval;

void
setfont(char ch1) {
	/* use number '1', '2', '3' for roman, italic, bold */
	yyval.token = ft;
	if (ch1 == 'r' || ch1 == 'R')
		ft = ROM;
	else if (ch1 == 'i' || ch1 == 'I')
		ft = ITAL;
	else if (ch1 == 'b' || ch1 == 'B')
		ft = BLD;
	else
		ft = ch1;
	printf(".ft %c\n", ft);
	if (dbg)
		printf(".\tsetfont %c\n", ft);
}

void
font(int p1, int p2) {
		/* old font in p1, new in ft */
	yyval.token = p2;
	lfont[yyval.token] = rfont[yyval.token] = ft==ITAL ? ITAL : ROM;
	if (dbg)
		printf(".\tb:fb: S%d <- \\f%c S%d \\f%c b=%d,h=%d,lf=%c,rf=%c\n",
		    yyval.token, ft, p2, p1, ebase[yyval.token],
		    eht[yyval.token], lfont[yyval.token], rfont[yyval.token]);
	printf(".ds %d \\f%c\\*(%d\\f%c\n", yyval.token, ft, p2, p1);
	ft = p1;
	printf(".ft %c\n", ft);
}

void
fatbox(int p) {
	int sh;

	yyval.token = p;
	sh = ps / 4;
	nrwid(p, ps, p);
	printf(".ds %d \\*(%d\\h'-\\n(%du+%du'\\*(%d\n", p, p, p, sh, p);
	if (dbg)
		printf(".\tfat %d, sh=%d\n", p, sh);
}

void
globfont(void) {
	char temp[20];

	getstr(temp, 20);
	yyval.token = eqnreg = 0;
	gfont = temp[0];
	switch (gfont) {
	case 'r': case 'R':
		gfont = '1';
		break;
	case 'i': case 'I':
		gfont = '2';
		break;
	case 'b': case 'B':
		gfont = '3';
		break;
	}
	printf(".ft %c\n", gfont);
	ft = gfont;
}
