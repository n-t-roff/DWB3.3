/*	Copyright (c) 1988 AT&T	*/
/*	  All Rights Reserved  	*/

/*	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T	*/
/*	The copyright notice above does not evidence any   	*/
/*	actual or intended publication of such source code.	*/

/*	@(#)picasso:symtab.c	1.0	*/
#include	<ctype.h>
#include        <string.h>
#include	"picasso.h"
#include	"y.tab.h"
#include	"input.h"

YYSTYPE
getvar(char *s)	/* return value of variable s (usually pointer) */
{
	struct symtab *p;
	static YYSTYPE bug;

	p = lookup(s);
	if (p == NULL) {
		if (islower(s[0])) {
			yyerror("no such variable as %s", s);
			return lookup("curlayer")->s_val;	/* arbitrary */
		}
		else {
			yyerror("no such place as %s", s);
			return lookup("O")->s_val;
		}
		/* return(bug);	NOTREACHED */
	}
	if (s != p->s_name) free(s);
	return(p->s_val);
}

double
getsub(char *s, int n) {
	struct	symtab	*p;

	p = lookup(s);
	if (p == NULL)
		yyerror("array %s not declared", s);
	else if (n > (int)(p->s_dim))
		yyerror("variable %s has dimension %d < %d", s, p->s_dim, n);
	else if (p->s_dim == 0)
		return p->s_val.f;
	else
		return p->s_val.a[n-1];
	return 0.0;
}

double
setvar(char *s, int n, double v) {
	struct	symtab	*p;

	p = lookup(s);
	if (p == NULL) {
		fatal("array %s not declared", s);
		return v;
	}
	else if (n > (int)(p->s_dim)) {
		fatal("variable %s has dimension %d < %d", s, p->s_dim, n);
		return v;
	}
	else if (p->s_dim == 0)
		p->s_val.f = v;
	else
		p->s_val.a[n-1] = v;
	if (s != p->s_name) free(s);
	return v;
}

double
setsize(char *s, double v)	/* kludge: textsize = v implies textspace = v * r */
{
	double	r;
	struct	symtab	*p, *q;

	p = lookup(s);
	q = lookup("textspace");
	r = q->s_val.f/p->s_val.f;
	q->s_val.f = v * r;
	p->s_val.f = v;
	return v;
}

struct symtab *
newvar(char *s, int t)	/* allocate variable with name s, type t */
			/* assumes s derives from a tostring	 */ 
{
	struct symtab *p;

	p = (struct symtab *) malloc(sizeof(struct symtab));
	if (p == NULL) {
		yyerror("out of symtab space with %s", s);
		exit(1);
	}
	p->s_name = s;
	p->s_type = t;
	p->s_dim  = 0;
	p->s_next = stack[nstack].p_symtab;
	stack[nstack].p_symtab = p;		/* stick it at front */
	return(p);
}

struct symtab *
findvar(char *s, int t)	/* make variable named s in table	*/
			/* will reuse local or global symbol	*/
{
	struct symtab *p;

	if ((p = lookup(s)) == NULL)
		p = newvar(s, t);
	if (s != p->s_name) free(s);
	return(p);
}

double
setarray(char *s) {
	struct	symtab	*p;

	p = findvar (s, VARNAME);
	if ((int)(p->s_dim) < nexpr-1) {     /* existing array is too short */
		if (p->s_dim > 0)
			free (p->s_val.a);
	}
	if ((p->s_dim = nexpr-1) > 0) {
		p->s_val.a = (float *)malloc((unsigned)nexpr * sizeof(float));
		if (p->s_val.a == NULL)
			fatal("out of array space with %s", p->s_name);
	}
	if (p->s_dim == 0)
		p->s_val.f = exprlist[0];
	else
		memcpy ((char *)p->s_val.a, (char *)exprlist,
						nexpr * sizeof(float));
	nexpr = 0;
	return exprlist[0];
}

double
getfval(char *s)	/* return float value of variable s */
{
	struct	symtab	*p;

	if ((p = lookup(s)) == NULL) {
		yyerror("%s undefined", s);
		return 0.;
	}
	else if (p->s_dim == 0)
		return p->s_val.f;
	else					/* should probably place all */
		return (double)*p->s_val.a;	/* array values in exprlist. */
}

void
setfval(char *s, double f)	/* set variable s to f */
{
	struct symtab *p;

	if ((p = lookup(s)) == NULL)
		p = newvar(s, VARNAME);
	if (p->s_dim == 0)
		p->s_val.f = f;
	else
		*p->s_val.a = f;
}

struct symtab *
makevar(char *s, int t, valtype v)	/* make variable named s in table	*/
			/* assumes s is static or from tostring	*/
			/* if s is already defined as an array,	*/
			/* only its first element is set.	*/
{
	struct symtab *p;
	obj *o;

	for (p = stack[nstack].p_symtab; p != NULL; p = p->s_next)
		if (strcmp(s, p->s_name) == 0)
			break;
	if (p == NULL)
		p = newvar(s, t);
#if 1
	/* seems like a PLACENAME should always point to an object */
	if (t == PLACENAME) {
		for (o = objhead; o->o_next != objtail; o = o->o_next)
			if (o == v.o)
				break;
		v.o = o;
	}
#endif
	if (p->s_dim == 0)
		p->s_val  = v;
	else
		*p->s_val.a = v.f;
	if (s != p->s_name) free(s);
	return(p);
}

struct symtab *
lookup(char *s)	/* find s in symtab */
{
	int i;
	struct symtab *p;

	for (i = nstack; i >= 0; i--)	/* look in each active symtab */
		for (p = stack[i].p_symtab; p != NULL; p = p->s_next)
			if (strcmp(s, p->s_name) == 0)
				return(p);
	return(NULL);
}

void
freesymtab(struct symtab *p)	/* free space used by symtab at p */
{
	struct symtab *q;

	for ( ; p != NULL; p = q) {
		q = p->s_next;
		free(p->s_name);	/* assumes done with tostring */
		if (p->s_dim)
			free(p->s_val.a);
		free(p);
	}
}

void
freedef(char *s)	/* free definition for string s */
{
	struct symtab *p, *q, *op;

	for (p = op = q = stack[nstack].p_symtab; p != NULL; p = p->s_next) {
		if (strcmp(s, p->s_name) == 0) { 	/* got it */
			if (p->s_type != DEFNAME)
				break;
			if (p == op)	/* 1st elem */
				stack[nstack].p_symtab = p->s_next;
			else
				q->s_next = p->s_next;
			free(p->s_name);
			free(p->s_val.p);
			free(p);
			return;
		}
		q = p;
	}
	yyerror("%s is not defined at this point", s);
}

static	int	i, M;

void
first_xy(struct symtab *xsym, struct symtab *ysym, double *xp, double *yp) {
	if ((M = xsym->s_dim) == 0)
		*xp = xsym->s_val.f;
	else
		*xp = xsym->s_val.a[0];
	if (ysym->s_dim == 0)
		*yp = ysym->s_val.f;
	else
		*yp = ysym->s_val.a[0];
	if ((int)(ysym->s_dim) > M)
		M = ysym->s_dim;
	i = 0;
}

int
next_xy (struct symtab *xsym, struct symtab *ysym, double *xp, double *yp) {
	if (++i > M)
		return 0;
	if (xsym->s_dim == 0)
		*xp = xsym->s_val.f;
	else
		*xp = xsym->s_val.a[i % ((int)(xsym->s_dim)+1)];
	if (ysym->s_dim == 0)
		*yp = ysym->s_val.f;
	else
		*yp = ysym->s_val.a[i % ((int)(ysym->s_dim)+1)];
	return 1;
}
