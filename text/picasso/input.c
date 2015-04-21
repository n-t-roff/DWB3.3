/*	Copyright (c) 1988 AT&T	*/
/*	  All Rights Reserved  	*/

/*	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T	*/
/*	The copyright notice above does not evidence any   	*/
/*	actual or intended publication of such source code.	*/

/*	@(#)picasso:input.c	1.0	*/

#include <stdlib.h>
#include <ctype.h>
#include <errno.h>
#include <setjmp.h>
#include <string.h>
#include "picasso.h"
#include "y.tab.h"

void do_thru(void);

extern int	batch;
extern	jmp_buf	pic_env;
extern	int	parsing;

Infile	infile[10];
Infile	*curfile = infile;

#define	MAXSRC	50
Src	src[MAXSRC];	/* input source stack */
Src	*srcp	= src;

pushsrc(type, ptr)	/* new input source */
	int type;
	char *ptr;
{
	if (++srcp >= src + MAXSRC)
		fatal("inputs nested too deep");
	srcp->type = type;
	srcp->sp = ptr;
}

popsrc()	/* restore an old one */
{
	if (srcp <= src)
		fatal("too many inputs popped");
	srcp--;
}

void
definition(char *s)	/* collect definition for s and install */
/*	char *s;	definitions picked up lexically */
{
	char *p;
	struct symtab *stp;

	p = delimstr("definition");
	stp = lookup(s);
	if (stp == NULL)	/* it's not there already */
		stp = newvar(tostring(s), DEFNAME);
	else {
		if (stp->s_type != DEFNAME) {
			yyerror("%s used as variable and definition", s);
			return;
		}
		free(stp->s_val.p);
	}
	stp->s_val.p = p;
}

char *delimstr(s)	/* get body of X ... X */
	char *s;		/* message if too big */
{
	int c, delim, rdelim, n, deep;
	static char *buf = NULL;
	static int nbuf = 0;
	char *p;

	if (buf == NULL)
		buf = grow(buf, "buf", nbuf += 1000, sizeof(buf[0]));
	while ((delim = dwb_input()) == ' ' || delim == '\t' || delim == '\n')
		;
	rdelim = baldelim(delim, "{}()");	/* could be "(){}[]`'" */
	deep = 1;
	for (p = buf; ; ) {
		c = dwb_input();
		if (c == rdelim)
			if (--deep == 0)
				break;
		if (c == delim)
			deep++;
		if (p >= buf + nbuf) {
			n = p - buf;
			buf = grow(buf, "buf", nbuf += 1000, sizeof(buf[0]));
			p = buf + n;
		}
		if (c == EOF)
			fatal("end of file in %s %c %.20s... %c",
						s, delim, buf, delim);
		*p++ = c;
	}
	*p = '\0';
	return tostring(buf);
}

baldelim(c, s)	/* replace c by balancing entry in s */
	int c;
	char *s;
{
	for ( ; *s; s += 2)
		if (*s == c)
			return s[1];
	return c;
}

undefine(s)	/* undefine macro */
	char *s;
{
	while (*s != ' ' && *s != '\t')		/* skip "undef..." */
		s++;
	while (*s == ' ' || *s == '\t')
		s++;
	freedef(s);
}

pArg	args[10];	/* argument frames */
pArg	*argfp = args;	/* frame pointer */
int	argcnt;		/* number of arguments seen so far */

dodef(stp)	/* collect args and switch input to defn */
	struct symtab *stp;
{
	int i, len;
	char *p;
	pArg *ap;

	ap = argfp+1;
	if (ap >= args+10)
		fatal("arguments too deep");
	argcnt = 0;
	if (dwb_input() != '(')
		fatal("disaster in dodef\n");
	if (ap->argval == 0)
		ap->argval = malloc(1000);
	for (p = ap->argval; (len = getarg(p)) != -1; p += len) {
		ap->argstk[argcnt++] = p;
		if (dwb_input() == ')')
			break;
	}
	for (i = argcnt; i < MAXARGS; i++)
		ap->argstk[i] = "";
	argfp = ap;
	pushsrc(Macro, stp->s_val.p);
}

getarg(p)	/* pick up single argument, store in p, return length */
	char *p;
{
	int n, c, npar;

	n = npar = 0;
	for ( ;; ) {
		c = dwb_input();
		if (c == EOF)
			fatal("end of file in getarg!\n");
		if (npar == 0 && (c == ',' || c == ')'))
			break;
		if (c == '"')	/* copy quoted stuff intact */
			do {
				*p++ = c;
				n++;
			} while ((c = dwb_input()) != '"' && c != EOF);
		else if (c == '(')
			npar++;
		else if (c == ')')
			npar--;
		n++;
		*p++ = c;
	}
	*p = 0;
	unput(c);
	return(n + 1);
}

#define	PBSIZE	2000
char	pbuf[PBSIZE];		/* pushback buffer */
char	*pb	= pbuf-1;	/* next pushed back character */

char	ebuf[200];		/* collect input here for error reporting */
char	*ep	= ebuf;

int	begin	= 0;
extern	int	thru;
extern	struct symtab	*thrudef;
extern	char	*untilstr;

int dwb_input(void) {
	register int c;

	if (thru && begin) {
		do_thru();
		begin = 0;
	}
	c = nextchar();
	if (ep >= ebuf + sizeof ebuf)
		ep = ebuf;
	return *ep++ = c;
}

nextchar()
{
	register int c;

  loop:
	switch (srcp->type) {
	case Free:	/* free string */
		free(srcp->sp);
		popsrc();
		goto loop;
	case Thru:	/* end of pushed back line */
		begin = 1;
		popsrc();
		c = '\n';
		break;
	case Char:
		if (pb >= pbuf) {
			c = *pb--;
			popsrc();
			break;
		} else {	/* can't happen? */
			popsrc();
			goto loop;
		}
	case pString:
		c = *srcp->sp++;
		if (c == '\0') {
			popsrc();
			goto loop;
		} else {
			if (*srcp->sp == '\0')	/* empty, so pop */
				popsrc();
			break;
		}
	case Macro:
		c = *srcp->sp++;
		if (c == '\0') {
			if (--argfp < args)
				fatal("argfp underflow");
			popsrc();
			goto loop;
		} else if (c == '$' && isdigit(*srcp->sp)) {
			int n = 0;
			while (isdigit(*srcp->sp))
				n = 10 * n + *srcp->sp++ - '0';
			if (n > 0 && n <= MAXARGS)
				pushsrc(pString, argfp->argstk[n-1]);
			goto loop;
		}
		break;
	case File:
		c = getc(curfile->fin);
		if (c == EOF) {
			if (curfile == infile)	/* ??  && pass_thru) */
				fatal("end of file inside .PS/.PE");
			if (curfile->fin != stdin) {
				fclose(curfile->fin);
				free(curfile->fname);	/* assumes allocated */
			}
			curfile--;
			popsrc();
		/* ??	pushsrc(pString, ".PE\n");	*/
			thru = 0;	/* chicken out */
			thrudef = 0;
			if (untilstr) {
				free(untilstr);
				untilstr = 0;
			}
			goto loop;
		}
		if (c == '\n')
			curfile->lineno++;
		break;
	}
	return c;
}

void
do_thru(void)	/* read one line, make into a macro expansion */
{
	int c, i;
	char *p;
	pArg *ap;

	ap = argfp+1;
	if (ap >= args+10)
		fatal("arguments too deep");
	if (ap->argval == NULL)
		ap->argval = malloc(1000);
	p = ap->argval;
	argcnt = 0;
	c = nextchar();
	if (thru == 0) {	/* end of file was seen, so thru is done */
		unput(c);
		return;
	}
	for ( ; c != '\n' && c != EOF; ) {
		if (c == ' ' || c == '\t') {
			c = nextchar();
			continue;
		}
		ap->argstk[argcnt++] = p;
		if (c == '"') {
			do {
				*p++ = c;
				if ((c = nextchar()) == '\\') {
					*p++ = c;
					*p++ = nextchar();
					c = nextchar();
				}
			} while (c != '"' && c != '\n' && c != EOF);
			*p++ = '"';
			if (c == '"')
				c = nextchar();
		} else {
			do {
				*p++ = c;
			} while ((c = nextchar())!=' '  && c!='\t' && c!='\n'
							&& c!=','  && c!=EOF);
			if (c == ',')
				c = nextchar();
		}
		*p++ = '\0';
	}
	if (c == EOF)
		fatal("unexpected end of file in do_thru");
	if (argcnt == 0) {	/* ignore blank line */
		pushsrc(Thru, (char *) 0);
		return;
	}
	for (i = argcnt; i < MAXARGS; i++)
		ap->argstk[i] = "";
	if (strcmp(ap->argstk[0], ".PE") == 0) {
		thru = 0;
		thrudef = 0;
		pushsrc(pString, "\n.PE\n");
		return;
	}
	if (untilstr && strcmp(ap->argstk[0], untilstr) == 0) {
		thru = 0;
		thrudef = 0;
		free(untilstr);
		untilstr = 0;
		return;
	}
	pushsrc(Thru, (char *) 0);
	argfp = ap;
	pushsrc(Macro, thrudef->s_val.p);
}

int unput(int c) {
	if (++pb >= pbuf + sizeof pbuf)
		fatal("pushback overflow\n");
	if (--ep < ebuf)
		ep = ebuf + sizeof(ebuf) - 1;
	*pb = c;
	pushsrc(Char, pb);
	return c;
}

pbstr(s)
	char *s;
{
	pushsrc(pString, s);
}

double errcheck(x, s)
	double x;
	char *s;
{
	if (errno == EDOM) {
		errno = 0;
		yyerror("%s argument out of domain", s);
	} else if (errno == ERANGE) {
		errno = 0;
		yyerror("%s result out of range", s);
	}
	return x;
}

fatal(s, s1, s2, s3, s4)	/* should be a flag on yyerror */
	char *s, *s1, *s2, *s3, *s4;
{
	yyerror(s, s1, s2, s3, s4);
	if (batch)
		exit(1);
	else if (parsing)
		longjmp(pic_env, 1);
	else
		exit(1);
}

yyerror(s, s1, s2, s3, s4)
	char *s, *s1, *s2, *s3, *s4;
{
extern	char	*cmdname;
	char	msgbuf[1024];

/*	if (synerr)
		return;	*/
	sprintf(msgbuf, s, s1, s2, s3, s4);	/* for debugging */
	if (!batch)
		writemessage(msgbuf, 12, 1);
	fprintf(stderr, "%s: %s\n", cmdname, msgbuf);
	
	if (curfile->fin != NULL) {
		fprintf(stderr, " near line %d, file %s\n",
			curfile->lineno, curfile->fname);
		eprint();
		synerr = 1;
#if 0
		while (srcp > src)  /* If not at level of original input, */
			nextchar(); /* skip until we are.  This is an attempt */
				    /* to clean up the buffers. -- DBK */
#endif
	}
#if 1
	if (curfile->fin == NULL) {	/* see if this works */
		eprint();
		synerr = 1;
	}
#endif
	errno = 0;
}

eprint()	/* try to print context around error */
{
	char *p, *q;

	p = ep - 1;
	if (p > ebuf && *p == '\n')
		p--;
	for ( ; p >= ebuf && *p != '\n'; p--)
		;
	while (*p == '\n')
		p++;
	fprintf(stderr, " context is\n\t");
	for (q=ep-1; q>=p && *q!=' ' && *q!='\t' && *q!='\n'; q--)
		;
	while (p < q)
		putc(*p++, stderr);
	fprintf(stderr, " >>> ");
	while (p < ep)
		putc(*p++, stderr);
	fprintf(stderr, " <<< ");
	while (pb >= pbuf)
		putc(*pb--, stderr);
	if (curfile->fin != NULL) {
		fgets(ebuf, sizeof ebuf, curfile->fin);
		fprintf(stderr, "%s", ebuf);
	}
/*	pbstr("\n.PE\n");	/* safety first */
	ep = ebuf;
}

yywrap() {;}

char	*newfile = 0;		/* filename for file copy */
char	*untilstr = 0;		/* string that terminates a thru */
int	thru	= 0;		/* 1 if copying thru macro */
struct symtab	*thrudef = 0;		/* macro being used */

copyfile(s)	/* remember file to start reading from */
	char *s;
{
	newfile = s;
}

copydef(p)	/* remember macro symtab ptr */
	struct symtab *p;
{
	thrudef = p;
}

struct symtab *copythru(s)	/* collect the macro name or body for thru */
	char *s;
{
	struct symtab *p;
	char *q, *addnewline();

	p = lookup(s);
	if (p != NULL) {
		if (p->s_type == DEFNAME) {
			p->s_val.p = addnewline(p->s_val.p);
			return p;
		} else
			fatal("%s used as define and name", s);
	}
	/* have to collect the definition */
	pbstr(s);	/* first char is the delimiter */
	q = delimstr("thru body");
	s = "nameless";
	p = lookup(s);
	if (p != NULL) {
		if (p->s_val.p)
			free(p->s_val.p);
		p->s_val.p = q;
	} else {
		YYSTYPE u;
		u.p = q;
		p = makevar(tostring(s), DEFNAME, u);
	}
	p->s_val.p = addnewline(p->s_val.p);
	return p;
}

char *addnewline(p)	/* add newline to end of p */
	char *p;
{
	int n;

	n = strlen(p);
	if (p[n-1] != '\n') {
		p = realloc(p, n+2);
		p[n] = '\n';
		p[n+1] = '\0';
	}
	return p;
}

copyuntil(s)	/* string that terminates a thru */
	char *s;
{
	untilstr = s;
}

copy()	/* begin input from file, etc. */
{
	FILE *fin;

	if (newfile) {
		if ((fin = fopen(newfile, "r")) == NULL)
			fatal("can't open file %s", newfile);
		curfile++;
		curfile->fin = fin;
		curfile->fname = newfile;
		curfile->lineno = 0;
		pushsrc(File, curfile);
		newfile = 0;
	}
	if (thrudef) {
		thru = 1;
		begin = 1;	/* wrong place */
	}
}

char	shellbuf[1000], *shellp;

shell_init()	/* set up to interpret a shell command */
{
	sprintf(shellbuf, "sh -c '");
	shellp = shellbuf + strlen(shellbuf);
}

shell_text(s)	/* add string to command being collected */
	char *s;
{
	while (*shellp++ = *s++)
		;
	shellp--;
}

shell_exec()	/* do it */
{
	shell_text("' >&2");
	system(shellbuf);
}
