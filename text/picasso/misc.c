/*	Copyright (c) 1988 AT&T	*/
/*	  All Rights Reserved  	*/

/*	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T	*/
/*	The copyright notice above does not evidence any   	*/
/*	actual or intended publication of such source code.	*/

/*	@(#)picasso:misc.c	1.0	*/
#include        <string.h>
#include	"picasso.h"
#include	"y.tab.h"
#include	"misc.h"
#include	"symtab.h"
#include	"print.h"
#include	"input.h"

extern	obj	*picklist[];
extern	int	pickcount;
extern	int	pic_compat;
extern	int	batch;

static YYSTYPE getblk(obj *, char *);

double
getcomp(obj *p, int t)	/* return component of a position; these must now be */
			/* transformed as there is no later chance to do so. */
{
	float	bnd[4];

	switch (t) {
	case DOTX:	return Xformx(p, 1, p->o_x, p->o_y);
	case DOTY:	return Xformy(p, 1, p->o_x, p->o_y);
	case DOTRAD:
		switch (p->o_type) {
		case SECTOR:
		case ARC:
		case BOX:
		case ARROW:
		case LINE:	return p->o_val[N_VAL].f;
		case CIRCLE:
		case ELLIPSE:	break;	/* fall through to DOTWID case */
		}
	case DOTHT:
	case DOTWID:	if (p->o_type <= TEXT) {
				get_bounds(p, bnd, 1);
				if (t == DOTHT)
					return (bnd[3] - bnd[1]);
				else
					return (bnd[2] - bnd[0]);
			}
	}
	yyerror("can't happen getcomp");
	return 0; /* CK: silence warning */
}

int
exprsave(double f) {
	if (nexpr >= nexprlist)
		exprlist = (float *) grow((char *)exprlist, "exprlist",
					nexprlist += 256, sizeof(float));
	exprlist[nexpr] = f;
	return ++nexpr;
}

char *
sprintgen(char *fmt) {
	char buf[1000];

	sprintf (buf, fmt,  exprlist[0], exprlist[1], exprlist[2],
					 exprlist[3], exprlist[4]);
	nexpr = 0;
	free(fmt);
	return tostring(buf);
}

void
printexpr(double f)	/* print expression for debugging */
{
	fprintf(stderr, "%g\n", f);
}

void
printpos(obj *p)	/* print position for debugging */
{
	double	x, y;

	x = Xformx(p, 1, p->o_x, p->o_y);
	y = Xformy(p, 0, p->o_x, p->o_y);
	fprintf(stderr, "%g, %g\n", x, y);
}

char *
tostring(char *s) {
	register char *p;

	p = malloc(strlen(s)+1);
	if (p == NULL) {
		yyerror("out of space in tostring on %s", s);
		exit(1);
	}
	strcpy(p, s);
	return(p);
}

obj *
makepos(double x, double y, int corner, obj *q)	/* make a position cell */
{
	obj *p;

	p = makenode(PLACE, 1, 0);
	if (q)
		p->o_parent = q;
	p->o_x = x;
	p->o_y = y;
	p->o_val[0].f = corner;
	return(p);
}

obj *
makebetween(double f, obj *p1, obj *p2)	/* make position between p1 and p2   */
			/* again, transforms must be applied */
{
	obj	*p;
	double	x1, y1, x2, y2;

	p = makenode(PLACE, 3, 0);
	x1 = Xformx(p1, 1, p1->o_x, p1->o_y);
	y1 = Xformy(p1, 0, p1->o_x, p1->o_y);
	x2 = Xformx(p2, 1, p2->o_x, p2->o_y);
	y2 = Xformy(p2, 0, p2->o_x, p2->o_y);
	p->o_x = x1 + f * (x2 - x1);
	p->o_y = y1 + f * (y2 - y1);
	p->o_val[0].f = f;
	p->o_val[1].o = p1;
	p->o_val[2].o = p2;
	return(p);
}

int	xdelta[8] = {1,1,1,0,-1,-1,-1,0},
	ydelta[8] = {-1,0,1,1,1,0,-1,-1};

obj *
getnth(obj *p, int nth)	/* find nth point of an object */
{
	float	x, y;
	double  *tbox;
	int	n = nth;

	switch (p->o_type) {
	    default:
		if (n != 1)
			yyerror("object has only 1 point defined");
		return p;
	    case ARC:
		if (n > 2) {
			yyerror("arcs have only 2 points defined");
			return p;
		}
		/* else fall through to SECTOR case */
	    case SECTOR:
		if ((n %= 3) == 0)
			return p;
		else if (n == 1) {
			x = p->o_val[N_VAL+2].f;
			y = p->o_val[N_VAL+3].f;
		}
		else {
			x = p->o_val[N_VAL+4].f;
			y = p->o_val[N_VAL+5].f;
		}
		break;
	    case BLOCK:
		while (n--) {
			p = p->o_next;
			if (p->o_type <= TEXT)
				continue;
			else if (p->o_type == BLOCKEND) {
				yyerror("[] has less than %d objects", nth);
				p = p->o_parent;
			}
		}
		return p;	
	    case BOX:
		n %= 8;
		x = p->o_x + xdelta[n] * p->o_wid / 2;
		y = p->o_y + ydelta[n] * p->o_ht  / 2;
		break;
	    case ARROW:
	    case LINE:
	    case SPLINE:
		if (--n > p->o_val[N_VAL+3].f) {
			yyerror("line has less than %d points", nth);
			return p;
		}
		x = p->o_val[N_VAL + 4 + 2 * n].f;
		y = p->o_val[N_VAL + 5 + 2 * n].f;
		break;
	    case CIRCLE:
	    case ELLIPSE:
		n %= 8;
		x = xdelta[n] * p->o_wid / 2;
		y = ydelta[n] * p->o_ht  / 2;
		if (n % 2 == 0) {
			x *= M_SQRT1_2;
			y *= M_SQRT1_2;
		}
		x += p->o_x;
		y += p->o_y;
		break;
	    case TEXT:
		n %= 8;
		x = p->o_x;
		y = p->o_y;
		tbox = text_bounds(p);
		if (n >= 0 && n <= 2)
			x += tbox[2];
		if (n >= 2 && n <= 4)
			y += tbox[3];
		if (n >= 4 && n <= 6)
			x += tbox[0];
		if (n == 6 || n == 7 || n == 0)
			y += tbox[1];
		if (n == 1 || n == 5)
			x += (tbox[0] + tbox[2]) / 2;
		if (n == 3 || n == 7)
			y += (tbox[1] + tbox[3]) /2;
		break;
	}
	/*  DBK--Here also there is a question of whether x and y should
	    be transformed */
	return makepos(x, y, nth, p);
}

obj *
getpos(obj *p, int corner)	/* find position of point */
{
	float	x, y;

	if (pic_compat && (p->o_type == CIRCLE || p->o_type == ELLIPSE) &&
		(corner == NE || corner == NW || corner == SW || corner == SE))
			return getnth(p, corner == NE ? 2 : corner == NW ? 4 :
							corner == SW ? 6 : 8);
	if (corner == -1 ) {
		if (pic_compat && (p->o_type == LINE || p->o_type == ARROW ||
							p->o_type == SPLINE))
			corner = START;
		else
			return p;
	}
	whatpos(p, corner, &x, &y);
	return makepos(x,y,corner,(corner < EAST || corner > SW)? p: (obj *)0);
}

int
whatpos(obj *p, int corner, float *px, float *py)	/* what is the position (no side effect) */
{
	float	x, y, bnd[4];

	if (corner >= EAST && corner <= SW) {
		get_bounds(p, bnd, 2);	/* 2=>disregard line width */
					/* changed 3/18/91 by DBK  */
		switch (corner) {
	case NE:	x = bnd[2];		y = bnd[3];	break;
	case SW:	x = bnd[0];		y = bnd[1];	break;
	case SE:	x = bnd[2];		y = bnd[1];	break;
	case NW:	x = bnd[0];		y = bnd[3];	break;
	case NORTH:	x = (bnd[0]+bnd[2])/2;	y = bnd[3];	break;
	case SOUTH:	x = (bnd[0]+bnd[2])/2;	y = bnd[1];	break;
	case EAST:	x = bnd[2];	y = (bnd[1]+bnd[3])/2;	break;
	case WEST:	x = bnd[0];	y = (bnd[1]+bnd[3])/2;	break;
		}
	}
	else {	/* DBK--note that get_bounds returns the transformed position,
		   but the following calculations do not!! */
		x = p->o_x;
		y = p->o_y;

/* futz around for special cases: */

		switch (p->o_type) {
	case BLOCK:	if (corner == START)
				whatpos(p->o_next, START, &x, &y);
			else if (corner == END)
				whatpos(p->o_val[N_VAL+1].o->o_prev,END,&x,&y);
			break;
	case ARC:	if (corner == START) {
				x = p->o_val[N_VAL+2].f;
				y = p->o_val[N_VAL+3].f;
			}
			else if (corner == END)	{
				x = p->o_val[N_VAL+4].f;
				y = p->o_val[N_VAL+5].f;
			}
			break;
	case LINE:
	case SPLINE:
	case ARROW:	switch (corner) {
				int	n;
		case START:	x = p->o_val[N_VAL+4].f;
				y = p->o_val[N_VAL+5].f;
				break;
		case END:	n = N_VAL + 4 + 2*p->o_val[N_VAL+3].f;
				x = p->o_val[n].f;
				y = p->o_val[n+1].f;
				break;
			}
			break;
		}
	}
	*px = x;
	*py = y;
	return 1;
}

obj *
gethere(void)	/* make a place for curx,cury */
{
	return(makepos(curx, cury, 0, (obj *)0));
}

obj *
getlast(int n, int t)	/* find n-th previous occurrence of type t */
{
	int k;
	obj *p;

	k = n;
	if (t == TEXTOBJ)	/* for purely syntactical reasons */
		t = TEXT;
	for (p = objtail->o_prev; p != objhead; p = p->o_prev) {
		if (p->o_type == BLOCKEND) {
			p = p->o_parent;
			if (t != BLOCK && t != OBJECT)
				continue;
		}
		if (t == OBJECT && p->o_type > TEXT)
			continue;
		if (t != OBJECT && p->o_type != t)
			continue;
		if (--k > 0)
			continue;	/* not there yet */
		return(p);
	}
	yyerror("there is no %dth last", n);
	return(NULL);
}

obj *
getfirst(int n, int t)	/* find n-th occurrence of type t */
{
	int k;
	obj *p;

	k = n;
	if (t == TEXTOBJ)
		t = TEXT;
	for (p = objhead->o_next; p != objtail; p = p->o_next) {
		if (p->o_type == BLOCK
		&& t != BLOCK && t != OBJECT) {		/* skip block,  */
			if (p->o_val[N_VAL].o != NULL)	/* unless it's  */
				p = p->o_val[N_VAL].o;	/* still active */
			continue;
		}
		if (t == OBJECT && p->o_type > TEXT)
			continue;
		if (t != OBJECT && p->o_type != t)
			continue;
		if (--k > 0)
			continue;	/* not there yet */
		return(p);
	}
	yyerror("there is no %dth", n);
	return(NULL);
}

double
getblkvar(obj *p, char *s)	/* find variable s2 in block p */
{
	YYSTYPE y, getblk();

	y = getblk(p, s);
	free(s);
	return y.f;
}

obj *
getblock(obj *p, char *s)	/* find variable s in block p */
{
	YYSTYPE y, getblk();

	y = getblk(p, s);
	free(s);
	return y.o;
}

static YYSTYPE
getblk(obj *p, char *s)	/* find union type for s in p */
{
	static YYSTYPE bug;
	struct symtab *stp;

	bug.o = NULL;
	if (p == NULL) {	/* There has been a (hopefully reported) */
		p = objhead;	/* error previously, just pick a legal	 */
	}			/* pointer to avoid core dumps.		 */
	if (p->o_type != BLOCK) {
		yyerror(".%s is not in that block", s);
		return(bug);
	}
	for (stp = p->o_val[N_VAL+1].s; stp != NULL; stp = stp->s_next)
		if (strcmp(s, stp->s_name) == 0)
			return(stp->s_val);
	yyerror("there is no .%s in that []", s);
	return(bug);
}

obj *
fixpos(obj *p, double x, double y)	/* this, addpos & subpos SHOULD be altered to give   */
			/* o_x,o_y as offset from position of p, with p as   */
		/* o_parent, but I haven't yet worked out the xform. */
{
#if 1
/* DBK: 3/21/90 -- comment out the following if clause.  It has the effect
   of changing A in the expression A + x,y !!!
	if (p->o_type == PLACE) {
		p->o_x += x;
		p->o_y += y;
		return p;
	}
   end of commented out code *************/
	x += Xformx(p, 1, p->o_x, p->o_y);
	y += Xformy(p, 0, p->o_x, p->o_y);
#else
	if (p->o_type == PLACE) {
		x += p->o_x;
		y += p->o_y;
	}
	else {
		x += Xformx(p, 1, p->o_x, p->o_y);
		y += Xformy(p, 0, p->o_x, p->o_y);
	}
#endif
	return makepos(x, y, 0, (obj *)0);
}

obj *
addpos(obj *p, obj *q) {
	double	x, y;

	x = Xformx(q, 1, q->o_x, q->o_y);
	y = Xformy(q, 0, q->o_x, q->o_y);
/* DBK:  see above
	if (p->o_type == PLACE) {
		p->o_x += x;
		p->o_y += y;
		return p;
	}
 */
	x += Xformx(p, 1, p->o_x, p->o_y);
	y += Xformy(p, 0, p->o_x, p->o_y);
	return makepos(x, y, 0, (obj *)0);
}

obj *
subpos(obj *p, obj *q) {
	double	x, y;

	x = Xformx(q, 1, q->o_x, q->o_y);
	y = Xformy(q, 0, q->o_x, q->o_y);
/* DBK:  see above
	if (p->o_type == PLACE) {
		p->o_x -= x;
		p->o_y -= y;
		return p;
	}
 */
	x -= Xformx(p, 1, p->o_x, p->o_y);
	y -= Xformy(p, 0, p->o_x, p->o_y);
	return makepos(x, y, 0, (obj *)0);
}

obj *
makenode(int type, int n, int layer) {
	obj	*p;

	if (objbuf && batch)
		print_buf();
	p = (obj *) calloc(1, sizeof(obj) + (n-1)*sizeof(YYSTYPE));
	if (p == NULL) {
		yyerror("out of space in makenode");
		exit(1);
	}
	if (n > 65535)
		yyerror("making excessively large object");
	p->o_next = objtail;
	p->o_prev = objtail->o_prev;
	p->o_prev->o_next = objtail->o_prev = p;	
	p->o_parent = cur_block;
	p->o_x = curx;
	p->o_y = cury;
	p->o_nt1 = ntext1;
	p->o_nt2 = ntext;
	p->o_text = -1;
#if 1
	/* force all strings in object to have same justification */
	{
	int	jflags, lastf;
	jflags = RJUST|LJUST|CENTER|ABOVE|BELOW;
	if (ntext)
		lastf = text[ntext-1].t_type & jflags;
	for ( ; ntext1 < ntext; ntext1++)
		text[ntext1].t_type = (text[ntext1].t_type & ~ jflags) | lastf;
	}
#endif
	ntext1 = ntext;	/* ready for next caller */
	if (layer < -128)
		layer = -128;
	else if (layer > 127)
		layer = 127;
	if ((p->o_layer = layer) > 0 && layer > top_layer)
		top_layer = layer;
	if ((p->o_type = type) <= TEXT) {
		p->o_mxx = p->o_myy = 1.0;	/* initialize xform matrix */
		p->o_size = n;			/* keep count, for copies  */
	}
	return(p);
}

void
freenode(obj *p)		/* free space occupied by object p */
{
	obj	*q, *q1;

	if (p->o_type == BLOCK) {			/* I think there's */
		freesymtab(p->o_val[N_VAL+1].s);	/* a bug here, for */
		q = p->o_val[N_VAL].o;			/* nested blocks.  */
		p->o_prev->o_next = q->o_next;
		q->o_next->o_prev = p->o_prev;
		q->o_next = (obj *)NULL;
		for (q = p->o_next; q != NULL; ) {
			if (q->o_type == BLOCK)
				freesymtab(q->o_val[N_VAL+1].s);
			q1 = q;
			q = q->o_next;
			free(q1); 
		}
	}
	else {
		p->o_prev->o_next = p->o_next;
		p->o_next->o_prev = p->o_prev;
	}
	free (p);
	if (!objbuf) redo_gbox = 1;	/* page boundaries are now suspect */
}

void
extreme(double x, double y, float *bbox)	/* record max and min x and y values */
{
	if ((float)x < bbox[0])	bbox[0] = x;
	if ((float)y < bbox[1])	bbox[1] = y;
	if ((float)x > bbox[2])	bbox[2] = x;
	if ((float)y > bbox[3])	bbox[3] = y;
}

void
track_bounds(double x0, double y0, double x1, double y1)	/* insert a bounding box into the global box */
{
	if (x0 < Gbox[0])	Gbox[0] = x0;
	if (y0 < Gbox[1])	Gbox[1] = y0;
	if (x1 > Gbox[2])	Gbox[2] = x1;
	if (y1 > Gbox[3])	Gbox[3] = y1;
}

void
get_bounds(obj *p, float *bbox, int flag) /* reconstruct bounding box from center/basis/xform */
{
static	obj	*lastp = (obj *)0;
static	double	x0, y0, x1, y1;
	double	w, h, wm, hm, x, y;
	double	owid, oht;

	if (flag && p == lastp)
		goto done;
	x = Xformx(p, 1, p->o_x, p->o_y);
	y = Xformy(p, 0, p->o_x, p->o_y);
	if (p->o_type > TEXT) {
		x0 = x1 = x;
		y0 = y1 = y;
	}
	else {
		if (p->o_type == TEXT) {
			x += Linx(p,0,p->o_val[N_VAL-2].f,p->o_val[N_VAL-1].f);
			y += Liny(p,0,p->o_val[N_VAL-2].f,p->o_val[N_VAL-1].f);
		}
		else if (p->o_type == ARC || p->o_type == SECTOR) {
			x -= Linx(p,0,p->o_val[N_VAL+6].f,p->o_val[N_VAL+7].f);
			y -= Liny(p,0,p->o_val[N_VAL+6].f,p->o_val[N_VAL+7].f);
		}
		/* sometimes we ignore line weight */
		owid = p->o_wid + (flag == 2 ? 0.0 : p->o_weight);
		oht =  p->o_ht + (flag == 2 ? 0.0 : p->o_weight);
		if (	 ( p->o_type == ARROW || p->o_type == LINE
			|| p->o_type == SPLINE || p->o_type == ARC)
						&& (p->o_attr & HEAD12)) {
		    w = p->o_val[N_VAL+(p->o_type == ARC ? 8 : 1)].f;
		    owid += w;		/* account for width of arrowheads */
		    oht  += w;
		}
		w = Linx(p, 0, owid, oht) / 2;	/* transform main diagonal */
		h = Liny(p, 0, owid, oht) / 2;
		wm = Linx(p, 0, -owid, oht) / 2; /* transform other diagonal */
		hm = Liny(p, 0, -owid, oht) / 2;
		if (w < 0)	w = -w;
		if (h < 0)	h = -h;
		if (wm < 0)	wm = -wm;
		if (hm < 0)	hm = -hm;
		if (w < wm)	w = wm;
		if (h < hm)	h = hm;
		x0 = x - w;
		x1 = x + w;
		y0 = y - h;
		y1 = y + h;
	}
	lastp = p;
done:	bbox[0] = x0;	bbox[1] = y0;	bbox[2] = x1; bbox[3] = y1;
}

void
get_tot_bounds(obj *o, float *box, int flag) {
    double  *tbox;
    double  xc, yc;

    get_bounds(o, box, flag);
    if (o->o_type == TEXT)	/* Then don't do text_bounds, it ignores */
	return;			/*	transformations. */
    if (o->o_nt1 < o->o_nt2) {	/* some associated strings */
	tbox = text_bounds(o);
	xc = Xformx(o, 0, o->o_x, o->o_y);
	yc = Xformy(o, 0, o->o_x, o->o_y);
	if (tbox[0] + xc < box[0])	box[0] = tbox[0] + xc;
	if (tbox[1] + yc < box[1])	box[1] = tbox[1] + yc;
	if (tbox[2] + xc > box[2])	box[2] = tbox[2] + xc;
	if (tbox[3] + yc > box[3])	box[3] = tbox[3] + yc;
    }
}
/*
 *	Check to see if the object specified has been transformed.
 */
int
transformed(obj *o) {
    if (o->o_mxx != 1 || o->o_mxy || o->o_myx ||
	o->o_myy != 1 || o->o_mxt || o->o_myt)
	return 1;
    return 0;
}

#if 0
static	double	cx, cy;
static	int	close_text;

void
findclosestletter(p, x, y) /* find letter in p closest to x, y */
    obj     *p;
    int     x, y;
{
extern	double	pgscale;
    double  h, v, w, dely, *bnd;
    double  scale = 1.0;	/* If object is scaled. */
    int	    i, j, m, n, t;

    cx = (*storxpos)(x);
    cy = (*storypos)(y);
    close_text = -1;
    closex = closey = 1000.;	/* inches! */
    if (p->o_nt2 <= p->o_nt1)		/* no text */
	return;
    bnd = text_bounds(p);	/* Note that text_bounds has forced a call */
				/* to compose for p.  Also, text_bounds    */
				/* return bounds of NON_TRANSFORMED text!  */
    if (T[1] == 0.0 && T[2] == 0.0)	/* no rotation */
	if (p->o_type == TEXT) {
	    bnd[0] *= T[0];	bnd[2] *= T[0];
	    bnd[1] *= T[3];	bnd[3] *= T[3];
	    scale = sqrt(fabs(T[0]*T[3]));
	}
    v = bnd[3];			/* includes ABOVE/BELOW attributes */
    for (h = w = 0, i = p->o_nt1; i < (int)(p->o_nt2); h = w = 0) {
	j = text[i].t_line;	/* not necessarily consecutive, so
				   set explicitly. */
	/* calculate position of baseline for this line--assumed to be
	   down 3/4 of maximum character height from top of line */
	for (m = 0, n = i; n < (int)(p->o_nt2) && text[n].t_line == j; n++) {
	    w += text[n].t_width*72*scale/pgscale;
	    if (scale*abs(text[n].t_size) > m)
		m = scale*abs(text[n].t_size);
	}
	dely = (double) m / pgscale;		/* max size, in inches */
	t = text[i].t_type;
#if 0
	/* Note the adjustments for ABOVE and BELOW are permanent--affect
	   all subsequent strings in this object */
	if (t & ABOVE)
	    v += dely / 2;
	else if (t & BELOW)
	    v -= dely / 2;
#endif
	dely *= .75;
	if (t & RJUST)
	    h = w;
	else if (t & CENTER)
	    h = w/2;
	firsttext(t, text[i].t_val,abs(text[i].t_font), x-h, y + v - dely,
				abs(text[i].t_size) * scale / pgscale,
				text[i].t_width * 72 * scale / pgscale);
	/* use h temporarily to hold line spacing for this line */
	h = (double) abs(text[i].t_space) * scale / pgscale;
	while (++i < n && cx > lastx)
	    nothertext(text[i].t_type, text[i].t_val, abs(text[i].t_font),
				abs(text[i].t_size) * scale / pgscale,
				text[i].t_width * 72 * scale / pgscale);
	if (y + v < cy)	/* cursor above current line */
	    return;		/* have already found closest letter */
	/*  Adjust top-of-letter position down by line spacing.  */
	v -= h;
    }
}

static	double	lastx, lasty;
extern	double	getstringwidth();
/*
 *	Test to see if any chars in this string closer than previous best.
 *	Since we go from top to bettom, we know y < closey.
 */
static void
firsttext(int type, char *str, int font, double x, double y, double size,
    double w) {
	double z = x;
	static	char	buf[] = " ";

	if (closey < cy)		/* previous best will be closer */
		return;
	if (closey > cy && cy > y)	/* cursor between previous closest */
					/* baseline and this one */
		closey = y;
	else if (closey > y && y > cy)
		closey = y;
	for (; *str != '\0'; str++) {
		buf[0] = *str;
		if (
		ix = xpos(z);
		XDrawString(npdisplay, nppixmap, linegc, ix, iy, buf, 1);
		z += getstringwidth(buf, font, (int) size);
	}
	lastx = x + w;
	lasty = y;
}

static void
nothertext(int type, char *str, int font, double size, double w) {
	if (type & EQNTXT)
		puteqn(lastx, lasty, type, atoi(str));
	else {
		double z = lastx;
		int ix, iy;
		static	char	buf[] = " ";

		iy = ypos(lasty);
		resetfont(font, size);
		size = size * pgscale + 0.5;	/* go back to points */
		for (; *str != '\0'; str++) {
			buf[0] = *str;
			ix = xpos(z);
			XDrawString(npdisplay, nppixmap, linegc, ix, iy, buf, 1);
			z += getstringwidth(buf, font, (int) size);
		}
	}
	lastx += w;
}
#endif

#if 0
static void
oprint(obj *o)
{
    obj     *p;
    int	    t;

    fprintf(stderr, "%p:", o);
    if (o == objhead)
	fprintf(stderr, " (objhead)");
    if (o == objtail)
	fprintf(stderr, " (objtail)");
    fprintf(stderr, "\tprev=");
    p = o->o_prev;
    if (p == objhead)
	fprintf(stderr, "(objhead)");
    else if (p == objtail)
	fprintf(stderr, "(objtail)");
    else
	fprintf(stderr, "%p", p);
    fprintf(stderr, "\tnext=");
    p = o->o_next;
    if (p == objhead)
	fprintf(stderr, "(objhead)");
    else if (p == objtail)
	fprintf(stderr, "(objtail)");
    else
	fprintf(stderr, "%p", p);
    fprintf(stderr, "\tparent=");
    p = o->o_parent;
    if (p == objhead)
	fprintf(stderr, "(objhead)");
    else if (p == objtail)
	fprintf(stderr, "(objtail)");
    else
	fprintf(stderr, "%p", p);
    t = o->o_type;
    fprintf(stderr, "\n\ttype=%s", t == BOX ? "BOX"
				 : t == LINE ? "LINE"
				 : t == ARROW ? "ARROW"
				 : t== CIRCLE ? "CIRCLE"
				 : t== ELLIPSE ? "ELLIPSE"
				 : t== ARC ? "ARC"
				 : t== SECTOR ? "SECTOR"
				 : t== SPLINE ? "SPLINE"
				 : t== BLOCK ? "BLOCK"
				 : t== TEXT ? "TEXT"
				 : t== TROFF ? "TROFF"
				 : t== MOVE ? "MOVE"
				 : t== PLACE ? "PLACE"
				 : t== BLOCKEND ? "BLOCKEND"
				 : t== PSFILE ? "PSFILE"
				 : "UNKNOWN");
    fprintf(stderr, " size=%d layer=%d\n", o->o_size, o->o_layer);
    fprintf(stderr, "\tat %g,%g\n", o->o_x, o->o_y);
    fprintf(stderr, "\ttext %d-%d", o->o_nt1, o->o_nt2);
    if (o->o_nt1 != o->o_nt2)
	fprintf(stderr, " textcolor %g", o->o_text);
    fprintf(stderr, "\n");
    if (t > TEXT)
	return;
    if (transformed(o))
	fprintf(stderr, "\ttranform = [ %g %g %g %g %g %g ]\n", o->o_mxx,
			o->o_myx, o->o_mxy, o->o_myy, o->o_mxt, o->o_myt);
    fprintf(stderr, "\tdimensions %gx%g", o->o_wid, o->o_ht);
    fprintf(stderr, " attr=%lx", o->o_attr);
    if (o->o_attr) {
	fprintf(stderr, " (");
	if (o->o_attr & HEAD1)
	    fprintf(stderr, "HEAD1 ");
	if (o->o_attr & HEAD2)
	    fprintf(stderr, "HEAD2 ");
	if (o->o_attr & HEADFILL)
	    fprintf(stderr, "HEADFILL ");
	if (o->o_attr & CW_ARC)
	    fprintf(stderr, "CW_ARC ");
	if (o->o_attr & DOTDASH)
	    fprintf(stderr, "DOTDASH ");
	if (o->o_attr & EDGED)
	    fprintf(stderr, "EDGED ");
	if (o->o_attr & FILLED)
	    fprintf(stderr, "FILLED ");
	fprintf(stderr, " )");
    }
    if (o->o_attr & DOTDASH) {
	float	*a;
	int	i;

	fprintf(stderr,  " dashpattern=");
	for (a = o->o_ddpat.a, i = 1; i <= a[0]; i++)
	    fprintf(stderr, "%g ", a[i]);
    }
    fprintf(stderr, "\n\tweight=%g, linecolor=%g, fillcolor=%g\n",
				o->o_weight, o->o_color, o->o_fill);
    if (t == BLOCK) {
	fprintf(stderr, "\tmatching BLOCKEND=%p", o->o_val[N_VAL].o);
	fprintf(stderr, " symbol table=%p\n", o->o_val[N_VAL+1].s);
    }
    else if (t == BOX || t == LINE || t == ARROW) {
	if (o->o_val[N_VAL].f != 0.)
	    fprintf(stderr, "\tcorner radius=%g\n", o->o_val[N_VAL].f);
    }
}
#endif

#if 0 /* unused */
oallprint(o)
    obj     *o;
{
    if (o == NULL)
	o = objhead->o_next; 
    for ( ; o != objtail; o = o->o_next)
	oprint(o);
}
#endif
