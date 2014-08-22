#include "e.h"
#include "y.tab.h"

extern int Funnyps;
extern double Funnyht, Funnybase;

int funny(int n)
{
	char *f;

	dwb_yyval = salloc();
	switch (n) {
	case SUM:
		f = lookup(deftbl, "sum_def")->cval; break;
	case UNION:
		f = lookup(deftbl, "union_def")->cval; break;
	case INTER:	/* intersection */
		f = lookup(deftbl, "inter_def")->cval; break;
	case PROD:
		f = lookup(deftbl, "prod_def")->cval; break;
	default:
		ERROR "funny type %d in funny", n FATAL;
	}
	printf(".ds %d %s\n", dwb_yyval, f);
	eht[dwb_yyval] = EM(1.0, ps+Funnyps) - EM(Funnyht, ps);
	ebase[dwb_yyval] = EM(Funnybase, ps);
	dprintf(".\tS%d <- %s; h=%g b=%g\n", 
		dwb_yyval, f, eht[dwb_yyval], ebase[dwb_yyval]);
	lfont[dwb_yyval] = rfont[dwb_yyval] = ROM;
	return dwb_yyval;
}
