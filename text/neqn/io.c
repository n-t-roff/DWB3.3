#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include "e.h"
#include "y.tab.h"
#define	MAXLINE	2048	/* maximum input line */

char	in[MAXLINE];	/* input buffer */
int	eqnexit(int);
int noeqn;

extern int yyparse(void);
int dwb_getline(register char *s);
void dwb_inline(void);

int
main(int argc, char **argv) {
	eqnexit(eqn(argc, argv));
	return 0;
}

int
eqnexit(int n) {
#ifdef gcos
	if (n)
		fprintf(stderr, "run terminated due to eqn error\n");
	exit(0);
#endif
	exit(n);
}

int
eqn(int argc, char **argv) {
	int i, type;

	setfile(argc,argv);
	init_tbl();	/* install keywords in tables */
	while ((type=dwb_getline(in)) != EOF) {
		eqline = linect;
		if (in[0]=='.' && in[1]=='E' && in[2]=='Q') {
			for (i=11; i<100; used[i++]=0);
			printf("%s",in);
			printf(".nr 99 \\n(.s\n.nr 98 \\n(.f\n");
			markline = 0;
			init();
			yyparse();
			if (eqnreg>0) {
				printf(".nr %d \\w'\\*(%d'\n", eqnreg, eqnreg);
				/* printf(".if \\n(%d>\\n(.l .tm too-long eqn, file %s, between lines %d-%d\n",	*/
				/*	eqnreg, svargv[ifile], eqline, linect);	*/
				printf(".nr MK %d\n", markline);	/* for -ms macros */
				printf(".if %d>\\n(.v .ne %du\n", eqnht, eqnht);
				printf(".rn %d 10\n", eqnreg);
				if(!noeqn)printf("\\*(10\n");
			}
			printf(".ps \\n(99\n.ft \\n(98\n");
			printf(".EN");
			if (lastchar == EOF) {
				putchar('\n');
				break;
			}
			if (putchar(lastchar) != '\n')
				while (putchar(gtc()) != '\n');
		}
		else if (type == lefteq)
			dwb_inline();
		else
			printf("%s",in);
	}
	return(0);
}

int
dwb_getline(char *s) {
	int c;
	while((*s++=c=gtc())!='\n' && c!=EOF && c!=lefteq)
		if (s >= in + MAXLINE) {
			error( !FATAL, "input line too long: %.20s\n", in);
			in[MAXLINE - 1] = '\0';
			break;
		}
	if (c==lefteq)
		s--;
	*s++ = '\0';
	return(c);
}

void
dwb_inline(void) {
	int ds;

	printf(".nr 99 \\n(.s\n.nr 98 \\n(.f\n");
	ds = oalloc();
	printf(".rm %d \n", ds);
	do{
		if (*in)
			printf(".as %d \"%s\n", ds, in);
		init();
		yyparse();
		if (eqnreg > 0) {
			printf(".as %d \\*(%d\n", ds, eqnreg);
			ofree(eqnreg);
		}
		printf(".ps \\n(99\n.ft \\n(98\n");
	} while (dwb_getline(in) == lefteq);
	if (*in)
		printf(".as %d \"%s", ds, in);
	printf(".ps \\n(99\n.ft \\n(98\n");
	printf("\\*(%d\n", ds);
	ofree(ds);
}

void
putout(int p1) {
	extern int gsize, gfont;
	int before, after;
	if(dbg)printf(".\tanswer <- S%d, h=%d,b=%d\n",p1, eht[p1], ebase[p1]);
	eqnht = eht[p1];
	printf(".ds %d \\x'0'", p1);
	/* suppposed to leave room for a subscript or superscript */
	before = eht[p1] - ebase[p1] - VERT(3);	/* 3 = 1.5 lines */
	if (before > 0)
		printf("\\x'0-%du'", before);
	printf("\\f%c\\s%d\\*(%d%s\\s\\n(99\\f\\n(98",
		gfont, gsize, p1, rfont[p1] == ITAL ? "\\|" : "");
	after = ebase[p1] - VERT(1);
	if (after > 0)
		printf("\\x'%du'", after);
	putchar('\n');
	eqnreg = p1;
}

int
max(int i, int j) {
	return (i>j ? i : j);
}

int
oalloc(void) {
	int i;
	for (i = 11; i < 100; i++)
		if (!used[i]++)
			return i;
	error(FATAL, "no eqn strings left", i);
	return 0;
}

void
ofree(int n) {
	used[n] = 0;
}

void
setps(int p) {
	printf(".ps %d\n", EFFPS(p));
}

void
nrwid(int n1, int p, int n2) {
	printf(".nr %d \\w'\\s%d\\*(%d'\n", n1, EFFPS(p), n2);
}

void
setfile(int argc, char **argv) {
	static char *nullstr = "-";

	svargc = --argc;
	svargv = argv;
	while (svargc > 0 && svargv[1][0] == '-') {
		switch (svargv[1][1]) {

		case 'd': lefteq=svargv[1][2]; righteq=svargv[1][3]; break;
		case 's': gsize = atoi(&svargv[1][2]); break;
		case 'p': deltaps = atoi(&svargv[1][2]); break;
		case 'f': gfont = svargv[1][2]; break;
		case 'e': noeqn++; break;
		default: dbg = 1;
		}
		svargc--;
		svargv++;
	}
	ifile = 1;
	linect = 1;
	if (svargc <= 0 || strcmp(svargv[1], "-") == 0) {
		curfile = stdin;
		svargv[1] = nullstr;
	}
	else if ((curfile = fopen(svargv[1], "r")) == NULL)
		error( FATAL,"can't open file %s", svargv[1]);
}

void
yyerror(char *s) {}

void
init(void) {
	ct = 0;
	ps = gsize;
	ft = gfont;
	setps(ps);
	printf(".ft %c\n", ft);
}

void
error(int fatal, const char *fmt, ...) {
	va_list argp;
	fprintf(stderr, "eqn: ");
	if (fatal)
		fprintf(stderr, "fatal error: ");
	va_start(argp, fmt);
	vfprintf(stderr, fmt, argp);
	va_end(argp);
	fprintf(stderr, "\nfile %s, between lines %d and %d\n",
		svargv[ifile], eqline, linect);
	if (fatal)
		eqnexit(1);
}
