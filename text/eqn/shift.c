#include "e.h"
#include "y.tab.h"

int subsup(int p1, int p2, int p3)
{
	if (p2 != 0 && p3 != 0)
		return shift2(p1, p2, p3);
	else if (p2 != 0)
		return bshiftb(p1, SUB, p2);
	else if (p3 != 0)
		return bshiftb(p1, SUP, p3);
}

extern double Subbase, Supshift;
extern char *Sub1space, *Sup1space, *Sub2space;
extern char *SS1space, *SS2space;

int bshiftb(int p1, int dir, int p2)
{
	int subps, n;
	double shval, d1, h1, b1, h2, b2;
	char *sh1, *sh2;

	dwb_yyval = p1;
	h1 = eht[p1];
	b1 = ebase[p1];
	h2 = eht[p2];
	b2 = ebase[p2];
	subps = ps;
	ps += deltaps;
	sh1 = "";
	if (dir == SUB) {
		/* base .2m below bottom of main box */
		shval = b1 + EM(Subbase, ps);
		ebase[dwb_yyval] = shval + b2;
		eht[dwb_yyval] = max(h1-b1+shval+b2, h2);
		if (rfont[p1] == ITAL && lfont[p2] == ROM)
			n = 2;		/* Sub1space */
		else
			n = max(2, class[rclass[p1]][lclass[p2]]);
		sh1 = pad(n);
		rclass[p1] = OTHER;	/* OTHER leaves too much after sup */
	} else {	/* superscript */
		/* 4/10 up main box */
		d1 = EM(Subbase, subps);
		ebase[dwb_yyval] = b1;
		shval = -(Supshift * (h1-b1)) - b2;
		if (Supshift*(h1-b1) + h2 < h1-b1)	/* raise little super */
			shval = -(h1-b1) + h2-b2 - d1;
		eht[dwb_yyval] = h1 + max(0, h2 - (1-Supshift)*(h1-b1));
		if (rclass[p1] == ILETF)
			n = 4;
		else if (rfont[p1] == ITAL)
			n = 2;		/* Sup1space */
		else
			n = max(1, class[rclass[p1]][lclass[p2]]);
		sh1 = pad(n);
		rclass[p1] = rclass[p2];	/* OTHER leaves too much after sup */
	}
	dprintf(".\tS%d <- %d shift %g %d; b=%g, h=%g, ps=%d, subps=%d\n", 
		dwb_yyval, p1, shval, p2, ebase[dwb_yyval], eht[dwb_yyval], ps, subps);
	sh2 = Sub2space;	/* was Sub2space; */
	printf(".as %d \\v'%gm'%s%s\\*(%d%s%s\\v'%gm'\n", 
		dwb_yyval, REL(shval,ps), DPS(ps,subps), sh1, p2,
		DPS(subps,ps), sh2, REL(-shval,ps));
	rfont[p1] = 0;
	sfree(p2);
	return dwb_yyval;
}

int shift2(int p1, int p2, int p3)
{
	int subps;
	double h1, h2, h3, b1, b2, b3, subsh, d2, supsh, dh;
	int treg;
	char *sh2;

	treg = salloc();
	dwb_yyval = p1;
	subps = ps;	/* sub and sup at this size */
	ps += deltaps;	/* outer size */
	h1 = eht[p1]; b1 = ebase[p1];
	h2 = eht[p2]; b2 = ebase[p2];
	h3 = eht[p3]; b3 = ebase[p3];
	subsh = EM(Subbase, ps);
	if (b1 > b2 + subsh) {	/* move little sub down */
		subsh += b1;
		ebase[dwb_yyval] = subsh + b2;	/* XXX */
	} else {
		ebase[dwb_yyval] = subsh + b2 - b1;	/* XXX */
	}
		
	supsh = -Supshift*(h1-b1) - b3;
	eht[dwb_yyval] = h1 + subsh+b2-b1 + max(0, h3-(1-Supshift)*(h1-b1));
	if (h3 < (1-Supshift)*(h1-b1)) {
		supsh = -(h1-b1) + (h3-b3) - EM(Subbase, subps);
		eht[dwb_yyval] = h1 + subsh+b2-b1 + supsh+h3-b3;
	}
	dprintf(".\tS%d <- %d sub %d sup %d, ps=%d, subps=%d, h=%g, b=%g\n",
		dwb_yyval, p1, p2, p3, ps, subps, eht[dwb_yyval], ebase[dwb_yyval]);
	if (rclass[p1] == ILETF)
		sh2 = "\\|\\|";
	else
		sh2 = SS2space;

	printf(".ds %d %s\\*(%d\n", p2, SS1space, p2);
	nrwid(p2, subps, p2);
	printf(".ds %d %s\\*(%d\n", p3, sh2, p3);
	nrwid(p3, subps, p3);
	printf(".nr %d \\n(%d\n", treg, p3);
	printf(".if \\n(%d>\\n(%d .nr %d \\n(%d\n", p2, treg, treg, p2);
	printf(".as %d %s\\v'%gm'\\*(%d\\v'%gm'\\h'-\\n(%du'\\\n", 
		p1, DPS(ps,subps), REL(subsh,subps), p2, REL(-subsh,subps), p2);
	printf("\\v'%gm'\\*(%d\\v'%gm'\\h'-\\n(%du+\\n(%du'%s%s\n", 
		REL(supsh,subps), p3, REL(-supsh,subps), p3, treg, DPS(subps,ps), Sub2space);
	if (rfont[p2] == ITAL)
		rfont[dwb_yyval] = 0;	/* lie */
	rclass[dwb_yyval] = rclass[p3];	/* was OTHER */
	sfree(p2); sfree(p3); sfree(treg);
	return dwb_yyval;
}