#include "e.h"

#define abs(x) ((x) > 0 ? (x) : (-(x)))

#ifndef UNANSI
extern void brack(int, char *, char *, char *);
#else /* UNANSI */
extern void brack();
#endif /* UNANSI */

#ifndef UNANSI
int paren(int leftc, int p1, int rightc)
#else /* UNANSI */
void paren(leftc, p1, rightc)
	int leftc; int p1; int rightc;
#endif /* UNANSI */
{
	int n, m, j;
	double h1, b1;
	double v, bv;	/* v = shift of inside, bv = shift of brackets */
	extern double Parenbase, Parenshift, Parenheight;
	int yyval;

	bv = ttype == DEVPOST ? Parenshift : 0;	/* move brackets down this much */
	h1 = eht[p1];
	b1 = ebase[p1];
	yyval = p1;
	lfont[yyval] = rfont[yyval] = 0;
	n = REL(h1,ps) + 0.99;	/* ceiling */
	if (n < 2)
		n = 1;
	m = n - 2;
	if (leftc == '{' || rightc == '}') {
		if (!(n % 2))
			n++;
		if (n < 3)
			n = 3;
		m = n-3;
	}
	eht[yyval] = EM((double) n + Parenheight, ps);
	ebase[yyval] = eht[yyval]/2 - EM(Parenbase, ps);

	/* try to cope with things that are badly centered */
	/* (top heavy or bottom heavy) */
	if (abs(h1/2 - b1) >= EM(0.5, ps))
		v = REL(-ebase[yyval] + (eht[yyval]-h1)/2 + b1, ps);
	else
		v = 0;	/* don't shift it at all */

	printf(".ds %d \\^", yyval);	/* was \| */
	if (bv)
		printf("\\v'%gm'", bv);
	switch (leftc) {
	case 'n':	/* nothing */
	case '\0':
		break;
	case 'f':	/* floor */
		if (n <= 1)
			printf("\\(lf");
		else
			brack(m, "\\(bv", "\\(bv", "\\(lf");
		break;
	case 'c':	/* ceiling */
		if (n <= 1)
			printf("\\(lc");
		else
			brack(m, "\\(lc", "\\(bv", "\\(bv");
		break;
	case '{':
		printf("\\b'\\(lt");
		for(j = 0; j < m; j += 2) printf("\\(bv");
		printf("\\(lk");
		for(j = 0; j < m; j += 2) printf("\\(bv");
		printf("\\(lb'");
		break;
	case '(':
		brack(m, "\\(lt", "\\(bv", "\\(lb");
		break;
	case '[':
		brack(m, "\\(lc", "\\(bv", "\\(lf");
		break;
	case '|':
		brack(m, "|", "|", "|");
		break;
	default:
		brack(m, (char *) &leftc, (char *) &leftc, (char *) &leftc);
		break;
	}
	if (bv)
		printf("\\v'%gm'", -bv);
	if (v)
		printf("\\v'%gm'\\*(%d\\v'%gm'", -v, p1, v);
	else
		printf("\\*(%d", p1);
	if (rightc) {
		if (bv)
			printf("\\v'%gm'", bv);
		switch (rightc) {
		case 'f':	/* floor */
			if (n <= 1)
				printf("\\(rf");
			else
				brack(m, "\\(bv", "\\(bv", "\\(rf");
			break;
		case 'c':	/* ceiling */
			if (n <= 1)
				printf("\\(rc");
			else
				brack(m, "\\(rc", "\\(bv", "\\(bv");
			break;
		case '}':
			printf("\\b'\\(rt");
			for(j = 0; j < m; j += 2) printf("\\(bv");
			printf("\\(rk");
			for(j = 0; j < m; j += 2) printf("\\(bv");
			printf("\\(rb'");
			break;
		case ']':
			brack(m, "\\(rc", "\\(bv", "\\(rf");
			break;
		case ')':
			brack(m, "\\(rt", "\\(bv", "\\(rb");
			break;
		case '|':
			brack(m, "|", "|", "|");
			break;
		default:
			brack(m, (char *) &rightc, (char *) &rightc, (char *) &rightc);
			break;
		}
		if (bv)
			printf("\\v'%gm'", -bv);
	}
	printf("\n");
	dprintf(".\tcurly: h=%g b=%g n=%d v=%g l=%c, r=%c\n", 
		eht[yyval], ebase[yyval], n, v, leftc, rightc);
	return yyval;
}

#ifndef UNANSI
void brack(int m, char *t, char *c, char *b)
#else /* UNANSI */
void brack(m, t, c, b)
	int m; char *t; char *c; char *b;
#endif /* UNANSI */
{
	int j;
	printf("\\b'%s", t);
	for( j=0; j < m; j++)
		printf("%s", c);
	printf("%s'", b);
}
