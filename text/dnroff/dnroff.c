/*
 *	drive nroff devices
 */

/*
output language from troff:
all numbers are character strings

sn	size in points
fn	font as number from 1-n
cx	ascii character x
Cxyz	funny char xyz. terminated by white space
Nn	absolute character number n on this font.  ditto
Hn	go to absolute horizontal position n
Vn	go to absolute vertical position n (down is positive)
hn	go n units horizontally (relative)
vn	ditto vertically
nnc	move right nn, then print c (exactly 2 digits!)
		(this wart is an optimization that shrinks output file size
		 about 35% and run-time about 15% while preserving ascii-ness)
Dt ...\n	draw operation 't':
	Dl x y		line from here by x,y
	Dc d		circle of diameter d with left side here
	De x y		ellipse of axes x,y with left side here
	Da dx dy dx dy	arc counter-clockwise, center at dx,dx, end at dx,dy
	D~ x y x y ...	wiggly line by x,y then x,y ...
nb a	end of line (information only -- no action needed)
w	paddable word space -- no action needed
	b = space before line, a = after
p	new page begins -- set v to 0
#...\n	comment
x ...\n	device control functions:
	x i	init
	x T s	name of device is s
	x r n h v	resolution is n/inch
		h = min horizontal motion, v = min vert
	x p	pause (can restart)
	x s	stop -- done for ever
	x t	generate trailer
	x f n s	font position n contains font s
	x H n	set character height to n
	x S n	set slant to N

	Subcommands like "i" are often spelled out like "init".
*/

#include	<stdio.h>
#include	<ctype.h>
#include	<signal.h>
#include        <stdlib.h>
#include        <string.h>

#ifndef NDEVNAME
#define NDEVNAME	"37"
#endif

#ifndef NTERMDIR
#define NTERMDIR	"/usr/lib/nterm"
#endif

#define	oput(c)		putchar(c)
#define	oputs(s)	fputs(s, stdout)

#define	FATAL	1

#define	NCHARS	500
#include	"tw.h"

struct	t	t;	/* general parameters */

int	output	= 0;	/* do we do output at all? */
int	nolist	= 0;	/* output page list if > 0 */
#define	N_OLIST	100
int	olist[N_OLIST];	/* pairs of page numbers */
int	spage	= 9999;	/* stop every spage pages */
int	scount	= 0;
int	xoffset	= 0;	/* units are typesetter goobies! */

char	xchname[4 * (NROFFCHARS-128)];	/* hy, em, etc. */
short	xchtab[NROFFCHARS-128];		/* indexes into chname[] */
char	*codestr;
char	*chname = xchname;
short	*chtab = xchtab;
int	nchtab;

#define	FATAL	1
#define	BYTEMASK	0377
int	dbg	= 0;
int	res;		/* input assumed computed according to this resolution */

char	dwb_devname[50]	= NDEVNAME;
char	*fontdir	= NTERMDIR;

#define	RES	240
#define	hmot(n)		hpos += scale(n)
#define	hgoto(n)	hpos = scale(n)
#define	vmot(n)		vpos += scale(n)
#define	vgoto(n)	vpos = scale(n)
#define	scale(n)	(int)( (n) * (RES / (double) res) + 0.5 )

int	size	= -1;	/* this is invalid */
int	font	= -1;	/* current font */

int	hpos;		/* horizontal position where we are supposed to be next (left = 0) */
int	vpos;		/* vertical position (down positive) ditto */
int	htrue;		/* where we really are */
int	vtrue;

main(argc, argv)
char *argv[];
{
	FILE *fp;
	int done();
	char *p, *getenv();

	if ((p = getenv("NROFFTERM")) != 0)
		strcpy(dwb_devname, p);
	while (argc > 1 && argv[1][0] == '-') {
		switch (argv[1][1]) {
		case 'T':
			strcpy(dwb_devname, &argv[1][2]);
			break;
		case 'f':
		case 'F':
			fontdir = argv[2];
			argv++;
			argc--;
			break;
		case 'o':
			outlist(&argv[1][2]);
			break;
		case 'd':
			dbg = atoi(&argv[1][2]);
			if (dbg == 0) dbg = 1;
			break;
		case 's':
			spage = atoi(&argv[1][2]);
			if (spage <= 0)
				spage = 9999;
			break;
		case 'x':	/* x offset */
			xoffset = atoi(&argv[1][2]);
			break;
		}
		argc--;
		argv++;
	}

	if (argc <= 1)
		conv(stdin);
	else
		while (--argc > 0) {
			if (strcmp(*++argv, "-") == 0)
				fp = stdin;
			else if ((fp = fopen(*argv, "r")) == NULL)
				error(FATAL, "can't open %s", *argv);
			conv(fp);
			fclose(fp);
		}
	done();
}

int	maxolist = 9999;	/* largest page number in -o */

outlist(s)	/* process list of page numbers to be printed */
char *s;
{
	int n1, n2, i;

	nolist = 0;
	while (*s) {
		n1 = 0;
		if (isdigit(*s))
			do
				n1 = 10 * n1 + *s++ - '0';
			while (isdigit(*s));
		else
			n1 = -9999;
		n2 = n1;
		if (*s == '-') {
			s++;
			n2 = 0;
			if (isdigit(*s))
				do
					n2 = 10 * n2 + *s++ - '0';
				while (isdigit(*s));
			else
				n2 = 9999;
		}
		if (nolist > N_OLIST-2)
			error(FATAL, "too many items in -o");
		olist[nolist++] = n1;
		olist[nolist++] = n2;
		if (n2 > maxolist)
			maxolist = n2;
		if (*s != '\0')
			s++;
	}
	olist[nolist] = 0;
	if (dbg)
		for (i=0; i<nolist; i += 2)
			printf("%3d %3d\n", olist[i], olist[i+1]);
}

conv(fp)
register FILE *fp;
{
	register int c, k, sign;
	int m, n, i, n1, m1;
	char str[100], buf[300];

	while ((c = getc(fp)) != EOF) {
		switch (c) {
		case '\n':	/* when input is text */
		case ' ':
		case 0:		/* occasional noise creeps in */
			break;
		case '0': case '1': case '2': case '3': case '4':
		case '5': case '6': case '7': case '8': case '9':
			/* two motion digits plus a character */
			hmot((c-'0')*10 + fgetc(fp)-'0');
			put1(getc(fp));
			break;
		case 'c':	/* single ascii character */
			put1(getc(fp));
			break;
		case 'C':
			fscanf(fp, "%s", str);
			put1s(str);
			break;
		case 'N':	/* absolute character number */
			fscanf(fp, "%d", &n);
			put1a(n);
			break;
		case 'D':	/* draw function */
			fgets(buf, sizeof(buf), fp);
			switch (buf[0]) {
			case 'l':	/* draw a line */
				sscanf(buf+1, "%d %d", &n, &m);
				drawline(n, m, ".");
				break;
			case 'c':	/* circle */
				sscanf(buf+1, "%d", &n);
				drawcirc(n);
				break;
			case 'e':	/* ellipse */
				sscanf(buf+1, "%d %d", &m, &n);
				drawellip(m, n);
				break;
			case 'a':	/* arc */
				sscanf(buf+1, "%d %d %d %d", &n, &m, &n1, &m1);
				drawarc(n, m, n1, m1);
				break;
			case '~':	/* wiggly line */
				drawwig(buf+1);
				break;
			default:
				error(FATAL, "unknown drawing function %s\n", buf);
				break;
			}
			break;
		case 's':
			fscanf(fp, "%d", &n);	/* ignore fractional sizes */
			setsize(t_size(n));
			break;
		case 'f':
			fscanf(fp, "%s", str);
			setfont(t_font(str));
			break;
		case 'H':	/* absolute horizontal motion */
			/* fscanf(fp, "%d", &n); */
			while ((c = getc(fp)) == ' ')
				;
			k = 0;
			do {
				k = 10 * k + c - '0';
			} while (isdigit(c = getc(fp)));
			ungetc(c, fp);
			hgoto(k);
			break;
		case 'h':	/* relative horizontal motion */
			/* fscanf(fp, "%d", &n); */
			while ((c = getc(fp)) == ' ')
				;
			k = 0;
			sign = 1;
			if (c == '-') {
				sign = -1;
				c = getc(fp);
			}
			do {
				k = 10 * k + c - '0';
			} while (isdigit(c = getc(fp)));
			ungetc(c, fp);
			hmot(sign * k);
			break;
		case 'w':	/* word space */
			break;
		case 'V':
			fscanf(fp, "%d", &n);
			vgoto(n);
			break;
		case 'v':
			fscanf(fp, "%d", &n);
			vmot(n);
			break;
		case 'p':	/* new page */
			fscanf(fp, "%d", &n);
			t_page(n);
			break;
		case 'n':	/* end of line */
			while (getc(fp) != '\n')
				;
			t_newline();
			break;
		case '#':	/* comment */
			while (getc(fp) != '\n')
				;
			break;
		case 'x':	/* device control */
			devcntrl(fp);
			break;
		default:
			error(!FATAL, "unknown input character %o %c\n", c, c);
			fprintf(stderr, "input context is:\n%c", c);
			for (i = 0; i < 10; i++) {
				if (fgets(buf, sizeof(buf), fp) == NULL)
					break;
				fprintf(stderr, "%s", buf);
			}
			done();
		}
	}
}

devcntrl(fp)	/* interpret device control functions */
FILE *fp;
{
        char str[20], buf[100];
	int c, n;

	fscanf(fp, "%s", str);
	switch (str[0]) {	/* crude for now */
	case 'i':	/* initialize */
		fileinit();
		t_init(0);
		break;
	case 'T':	/* device name */
		fscanf(fp, "%s", buf);
		if (strcmp(buf, "nroff") != 0) {
			error(!FATAL, "WARNING\007: input file for %s, not nroff", buf);
		}
		break;
	case 't':	/* trailer */
		t_trailer();
		break;
	case 'p':	/* pause -- can restart */
		t_reset('p');
		break;
	case 's':	/* stop */
		t_reset('s');
		break;
	case 'r':	/* resolution assumed when prepared */
		fscanf(fp, "%d", &res);
		break;
	case 'f':	/* font used */
		fscanf(fp, "%d %s", &n, str);
		fgets(buf, sizeof buf, fp);	/* in case there's a filename */
		ungetc('\n', fp);	/* fgets goes too far */
		break;
	case 'H':	/* char height */
		fscanf(fp, "%d", &n);
		break;
	case 'S':	/* slant */
		fscanf(fp, "%d", &n);
		break;
	}
	while ((c = getc(fp)) != '\n')	/* skip rest of input line */
		if (c == EOF)
			break;
}

#define	skip(fp)	fscanf(fp, "%*s")

fileinit()	/* read in font and code files, etc. */
{
	/* open table for device,
	/* read in resolution, size info, font info, etc.
	/* and set params
	*/
	char name[50], *cp;
	FILE *fp;
	int i, wid;

	sprintf(name, "%s/tab.%s", fontdir, dwb_devname);
	if ((fp = fopen(name, "r")) == NULL)
		error(FATAL, "can't open %s\n", name);
	
	fscanf(fp, "%s", name);		/* skip over type, could check */
	skip(fp); getint(fp, &t.bset);	skip(fp); /* these are assumed in order for now */
	skip(fp); getint(fp, &t.breset);
	skip(fp); getint(fp, &t.Hor);
	skip(fp); getint(fp, &t.Vert);
	skip(fp); getint(fp, &t.Newline);
	skip(fp); getint(fp, &t.Char);
	skip(fp); getint(fp, &t.Em);
	skip(fp); getint(fp, &t.Halfline);
	skip(fp); getint(fp, &t.Adj);
	skip(fp); getstr(fp, &t.twinit);
	skip(fp); getstr(fp, &t.twrest);
	skip(fp); getstr(fp, &t.twnl);
	skip(fp); getstr(fp, &t.hlr);
	skip(fp); getstr(fp, &t.hlf);
	skip(fp); getstr(fp, &t.flr);
	skip(fp); getstr(fp, &t.bdon);
	skip(fp); getstr(fp, &t.bdoff);
	skip(fp); getstr(fp, &t.iton);
	skip(fp); getstr(fp, &t.itoff);
	skip(fp); getstr(fp, &t.ploton);
	skip(fp); getstr(fp, &t.plotoff);
	skip(fp); getstr(fp, &t.up);
	skip(fp); getstr(fp, &t.down);
	skip(fp); getstr(fp, &t.right);
	skip(fp); getstr(fp, &t.left);

	fscanf(fp, "%s", name);
	if (strcmp(name, "charset"))
		error(FATAL, "sync error on %s\n", dwb_devname);

	/* now read the characters themselves */
	/* god help us if these are not perfect */

	for (i = 0; i < 128; i++)
		t.width[i] = 1;	/* default ascii widths */
	i = 0;
/* this ought to be a pointer array and in place in codestr */
	cp = chname + 1;	/* bug if starts at 0, in setch */
	while (fscanf(fp, "%s %d", name, &wid) != EOF) {
		chtab[i] = cp - chname;	/* index, not pointer */
		*cp++ = name[0];	/* 2-char names */
		*cp++ = name[1];
		*cp++ = '\0';
		t.width[i+128] = wid;
		getstr(fp, &t.codetab[i]);	/* compress string */
		nchtab++;
		i++;
	}


}

getint(fp, pn)	/* find integer at s */
	FILE *fp;
	int *pn;
{
	int base, c;

	while ((c = getc(fp)) == ' ' || c == '\t' || c == '\n')
		;
	base = (c == '0') ? 8 : 10;
	for (*pn = 0; isdigit(c); c = getc(fp))
		*pn = base * *pn + c - '0';
}

char *dwb_strdup(s)
	char *s;
{
	char *p = malloc(strlen(s) + 1);
	strcpy(p, s);
	return p;
}

getstr(fp, strp)	/* find next string, copy to str */
	FILE *fp;
	char **strp;
{
	int quote = 0;
	char buf[100], *s = buf;
	char target[100], *t = target;

	fscanf(fp, "%s", buf);	
	if (*s == '"') {
		s++;
		quote = 1;
	}
	for ( ; *s; ) {
		if (quote && *s == '"') {
			s++;
			break;
		}
		if (!quote && *s == 0)
			break;
		if (*s != '\\')
			*t++ = *s++;
		else {
			s++;	/* skip \\ */
			if (isdigit(s[0]) && isdigit(s[1]) && isdigit(s[2])) {
				*t++ = (s[0]-'0')<<6 | (s[1]-'0')<<3 | s[2]-'0';
				s += 2;
			} else if (isdigit(s[0])) {
				*t++ = *s - '0';
			} else if (*s == 'b') {
				*t++ = '\b';
			} else if (*s == 'n') {
				*t++ = '\n';
			} else if (*s == 'r') {
				*t++ = '\r';
			} else if (*s == 't') {
				*t++ = '\t';
			} else {
				*t++ = *s;
			}
			s++;
		}
	}
	*t = '\0';
	*strp = dwb_strdup(target);
}

done()
{
	t_reset('s');
	oputs(t.twrest);	/* should be in t_reset */
	restore_tty();
	exit(0);
}

error(f, s, a1, a2, a3, a4, a5, a6, a7)
	char	*s;
{
	fprintf(stderr, "dnroff: ");
	fprintf(stderr, s, a1, a2, a3, a4, a5, a6, a7);
	fprintf(stderr, "\n");
	if (f)
		done();
}


/*
	Here beginneth all the stuff that really depends
	on nroff (we hope).
*/

	extern int esct;

t_init(reinit)	/* initialize device */
int reinit;
{
	if (reinit == 0) {
		save_tty();
		oputs(t.twinit);
	}
	vpos = hpos = vtrue = htrue = 0;
	vtrue = t.Newline;	/* because we are already one line down the page */
}

t_page(n)	/* do whatever new page functions */
{
	int i;

	if (output) {
		if (++scount >= spage) {
			/* t_reset('p'); */
			scount = 0;
		}
	}
	htrue = hpos = esct = 0;
	while (vtrue <= vpos) {
		oputs(t.twnl);
		vtrue += t.Newline;
	}
	vpos = 0;
	vtrue = t.Newline;
	output = 1;

	/* do we have to do anything here? */

	if (nolist == 0)
		return;	/* no -o specified */
	if (n > maxolist)	/* we've gone past the end */
		done();
	output = 0;
	for (i = 0; i < nolist; i += 2)
		if (n >= olist[i] && n <= olist[i+1]) {
			output = 1;
			break;
		}
}

t_newline()	/* do whatever for the end of a line */
{
	esct = 0;
	htrue = hpos;
	move();
	oputs(t.twnl);	/* start a new line */
	hpos = htrue = 0;
	vtrue += t.Newline;
}

t_size(n)	/* convert integer to internal size number*/
int n;
{	n;
}

t_font(s)	/* convert string to internal font number */
char *s;
{
	/* assumes comes in as f1, f2, etc.   probably rash. */
	return atoi(s);
}

t_reset(c)
{	c;
	output = 1;	/* by God */
	move();
	fflush(stdout);
}

t_trailer()
{
	oputs(t.twnl);
}


put1s(s)	/* s is a funny char name */
	char *s;
{
	/* look it up, get an index > 128, put1(whatever it was) */
	int i;

	for (i = 0; chtab[i] != 0; i++)
		if (strcmp(s, &chname[chtab[i]]) == 0) {
			put1(i + 128);
			break;
		}
}

put1a(n)	/* put single char by absolute number */
	int n;
{n;
}

setsize(n)	/* set point size to n (internal) */
int n;
{n;
}

t_fp(n, s, si)	/* font position n now contains font s, intname si */
int n;
char *s, *si;
{n,s,si;
}

drawline(n, m, s) int m, n; char *s; {}
drawcirc(n) int n; {}
drawellip(m, n) int m,n; {}
drawarc(n, m, n1, m1) int m,n,m1,n1; {}
drawwig(buf) char *buf; {}


/*

Device interface

*/

#include <ctype.h>
#include <sys/types.h>
#include <sys/stat.h>

int	plotmode;
int	esct;
int	esc;	/* accumulated horizontal since last char */
int	lead;	/* accumulated vertical */

enum { RFONT = 1, ULFONT, BDFONT, BIFONT };	/* assumes the normal layout */

int	xfont	= RFONT;	/* current font */
int	ulfont	= ULFONT;	/* underline font */

setfont(n)	/* set font to n */
{
	xfont = n;
}

put1(k)	/* output char k */
	int k;
{
	char *codep;
	extern char *plot();
	int w, j, phyw;
	static int oxfont = RFONT;	/* start off in roman */

	if (k <= 040) {
		switch (k) {
		case ' ': /*space*/
			break;
		case '\033':
		case '\007':
		case '\016':
		case '\017':
			oput(k);
			break;
		}
		return;
	}
	phyw = w = t.Char * t.width[k];

	esc = hpos - htrue;
	lead = vpos - vtrue;
	if (esc || lead)
		move();
	esct += w;
	htrue += w;	/* is this the right/only place? */

	if (xfont != oxfont) {
		switch (oxfont) {
		case ULFONT:	oputs(t.itoff); break;
		case BDFONT:	oputs(t.bdoff); break;
		case BIFONT:	oputs(t.itoff); oputs(t.bdoff); break;
		}
		switch (xfont) {
		case ULFONT:
			if (*t.iton & 0377) oputs(t.iton); break;
		case BDFONT:
			if (*t.bdon & 0377) oputs(t.bdon); break;
		case BIFONT:
			if (*t.bdon & 0377) oputs(t.bdon);
			if (*t.iton & 0377) oputs(t.iton);
			break;
		}
		oxfont = xfont;
	}
	if ((xfont == ulfont || xfont == BIFONT) && !(*t.iton & 0377) &&
	    k < 128 && isalnum(k)) {
		for (j = w / t.Char; j > 0; j--)
			oput('_');
		for (j = w / t.Char; j > 0; j--)
			oput('\b');
	}
	if (!(*t.bdon & 0377) && (xfont == BDFONT || xfont == BIFONT))
		j = 2;
	else
		j = 1;	/* number of overstrikes for bold */
	if (k < 128) {	/* ordinary ascii */
		oput(k);
		while (--j > 0) {
			oput('\b');
			oput(k);
		}
	} else if (k >= nchtab + 128) {
		oput(k - nchtab - 128);
	} else {
		int oj = j;
		codep = t.codetab[k-128];
		while (*codep != 0) {
			if (*codep & 0200) {
				codep = plot(codep);
				oput(' ');
			} else {
				if (*codep == '%')	/* escape */
					codep++;
				oput(*codep);
				if (*codep == '\033')
					oput(*++codep);
				else if (*codep != '\b')
					for (j = oj; --j > 0; ) {
						oput('\b');
						oput(*codep);
					}
				codep++;
			}
		}
	}
	if (!w)
		for (j = phyw / t.Char; j > 0; j--)
			oput('\b');
}


char	*plot(x)
char	*x;
{
	register int	i;
	register char	*j, *k;

	oputs(t.ploton);
	k = x;
	if ((*k & 0377) == 0200)
		k++;
	for (; *k; k++) {
		if (*k == '%') {	/* quote char within plot mode */
			oput(*++k);
		} else if (*k & 0200) {
			if (*k & 0100) {
				if (*k & 040)
					j = t.up; 
				else 
					j = t.down;
			} else {
				if (*k & 040)
					j = t.left; 
				else 
					j = t.right;
			}
			if ((i = *k & 037) == 0) {	/* 2nd 0200 turns it off */
				++k;
				break;
			}
			while (i--)
				oputs(j);
		} else 
			oput(*k);
	}
	oputs(t.plotoff);
	return(k);
}


move()
{
	register k;
	register char	*i, *j;
	char	*p, *q;

	esc = hpos - htrue;
	lead = vpos - vtrue;

	if (esct += esc)
		i = "\0"; 
	else 
		i = "\n\0";
	if (htrue == 0)
		i = "\n";
	j = t.hlf;
	p = t.right;
	q = t.down;
	if (lead) {
		if (lead < 0) {
			lead = -lead;
			i = t.flr;
			/*	if(!esct)i = t.flr; else i = "\0";*/
			j = t.hlr;
			q = t.up;
		}
		if (*i & 0377) {
			k = lead / t.Newline;
			lead = lead % t.Newline;
			while (k--)
				oputs(i);
		}
		if (*j & 0377) {
			k = lead / t.Halfline;
			lead = lead % t.Halfline;
			while (k--)
				oputs(j);
		} else { /* no half-line forward, not at line begining */
			k = lead / t.Newline;
			lead = lead % t.Newline;
			if (k > 0) 
				esc = esct;
			i = "\n";
			while (k--) 
				oputs(i);
		}
	}
	if (esc) {
		if (esc < 0) {
			esc = -esc;
			j = "\b";
			p = t.left;
		} else {
			j = " ";
		}
		k = esc / t.Em;
		esc = esc % t.Em;
		while (k--)
			oputs(j);
	}
	if ((*t.ploton & 0377) && (esc || lead)) {
		oputs(t.ploton);
		esc /= t.Hor;
		lead /= t.Vert;
		while (esc--)
			oputs(p);
		while (lead--)
			oputs(q);
		oputs(t.plotoff);
	}
	esc = lead = 0;
	htrue = hpos;
	vtrue = vpos;
}


/*
 * The following routines are concerned with setting terminal options.
 *	The manner of doing this differs between research/Berkeley systems
 *	and UNIX System V systems (i.e. DOCUMENTER'S WORKBENCH)
 *	The distinction is controlled by the #define'd variable SYSV,
 *	which must be set by System V users.
 */


#ifdef	SYSV
#include <termio.h>

#define CRMOD_SYSV (ONLCR | OCRNL | ONLRET)
#define	ECHO_SYSV (ECHO | ECHOE | ECHOK | ECHONL)
struct termio	ttys[2];
#endif

#ifdef BSD4_2
/*#include <sys/ttyio.h>*/
#include "4.3BSD/ioctl.h"
struct	sgttyb	ttys[2];
#define	stty(f, a)	ioctl(f, TIOCSETP, a)
#define	gtty(f, a)	ioctl(f, TIOCGETP, a)
#endif

#ifdef V9
#include <sys/ttyio.h>
/* #include <sgtty.h> */
struct	sgttyb	ttys[2];

#define	stty(f, a)	ioctl(f, TIOCSETP, a)
#define	gtty(f, a)	ioctl(f, TIOCGETP, a)
#endif

int	ttysave[2] = {-1, -1};

save_tty()			/*save any tty settings that may be changed*/
{

#ifdef	SYSV
	if (ioctl(0, TCGETA, &ttys[0]) >= 0)
		ttysave[0] = ttys[0].c_lflag;
	if (ioctl(1, TCGETA, &ttys[1]) >= 0)
		ttysave[1] = ttys[1].c_oflag;
#else
	if (gtty(0, &ttys[0]) >= 0)
		ttysave[0] = ttys[0].sg_flags;
	if (gtty(1, &ttys[1]) >= 0)
		ttysave[1] = ttys[1].sg_flags;
#endif	/* SYSV */

}


restore_tty()			/*restore tty settings from beginning*/
{

	if (ttysave[0] != -1) {
#ifdef	SYSV
		ttys[0].c_lflag = ttysave[0];
		ioctl(0, TCSETAW, &ttys[0]);
#else
		ttys[0].sg_flags = ttysave[0];
		stty(0, &ttys[0]);
#endif	/* SYSV */
	}
	if (ttysave[1] != -1) {
#ifdef	SYSV
		ttys[1].c_oflag = ttysave[1];
		ioctl(1, TCSETAW, &ttys[1]);
#else
		ttys[1].sg_flags = ttysave[1];
		stty(1, &ttys[1]);
#endif	/* SYSV */
	}
}


set_tty()
{

	if (t.bset || t.breset) {
		if (ttysave[1] == -1)
			save_tty();
		if (ttysave[1] != -1) {
#ifdef SYSV			/* seems to be necessary for -T450 */
			ttys[1].c_oflag &= ~CRMOD_SYSV;
			ioctl(1, TCSETAW, &ttys[1]);
#else
			ttys[1].sg_flags &= ~t.breset;
			ttys[1].sg_flags |= t.bset;
			stty(1, &ttys[1]);
#endif /* SYSV */
		}
	}

}
