/*	Copyright (c) 1988 AT&T	*/
/*	  All Rights Reserved  	*/

/*	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T	*/
/*	The copyright notice above does not evidence any   	*/
/*	actual or intended publication of such source code.	*/

/*	@(#)picasso:print.c	1.0	*/

#include	<assert.h>
#include	<ctype.h>
#include	<string.h>
#include	"picasso.h"
#include	"y.tab.h"

extern int  eqn_count;
extern float line_weight;
int	flyback;
int	redo_gbox = 0;
int	objcount  = 0;

void
print_buf(void)
{
	int	n;
	obj	*p;

	if (++objcount > objbuf) {
		p = objhead->o_next;
		if (p->o_type != BLOCK)
			print_obj(p->o_layer, p);
		else if (p->o_val[N_VAL].o == (obj *)0)
			return;
		else for (n = draftlayer; n <= top_layer; n++)
			print_obj(n,p);
		freenode(p);
	}
}

extern	FILE	*pipefp, *eqnfp;
extern	char	psfname[];

print(c)		/* show everything (above draft layers) */
	int	c;
{
	int	n;

#ifndef NOWRITE
#if 0		/* 4/23/91--DBK */
	/* Added 10/15/90--DBK.  Is there any reason NOT to do this? */
	redo_gbox = 1;
#else
	redogbox();		/* just do it here */
#endif
	if (pipefp) {
		pclose(pipefp);
		pipefp = NULL;
		if ((eqnfp = fopen(psfname,"r")) == NULL)
			fatal("cannot read eqn output");
	}
	flyback = (c == 'F');
	if (c != 'N')
		for (n = draftlayer; n <= top_layer; ++n)
			print_layer(n);
	if (eqnfp) {
		fclose(eqnfp);
		eqnfp = NULL;
		eqn_count = 0;
		unlink(psfname);
	}
#else
	fprintf(stderr,
		"This version of picasso is for on-screen previewing only.\n");
	exit(1);
#endif
}

print_layer(n)	/* show contents of a single layer (maybe a draft layer) */
	int	n;
{
	obj	*p;

	for (p = objhead->o_next; p!= objtail; p = p->o_next)
		p = print_obj(n, p);
}

print_bnd(p, q)	/* show everything (non-draft) between given bounds */
	obj	*p, *q;
{
	int	n;

	for (n = draftlayer; n <= top_layer; ++n)
		print_layer_bnd(n, p, q);
}

print_layer_bnd(n, p, q)	/* show objects in layer n from p to q */
	int	n;
	obj	*p, *q;
{
	obj	*r;
	float	x0, y0, x1, y1, bnd[4];

	if (p->o_x < q->o_x)
		{ x0 = p->o_x;	x1 = q->o_x; }
	else
		{ x0 = q->o_x;	x1 = p->o_x; }
	if (p->o_y < q->o_y)
		{ y0 = p->o_y;	y1 = q->o_y; }
	else
		{ y0 = q->o_y;	y1 = p->o_y; }

	for (r = objhead->o_next; r!= objtail; r = r->o_next)
		if (r->o_x >= x0 && r->o_x <= x1
		&&  r->o_y >= y0 && r->o_y <= y1)
			r = print_obj(n, r);
}

obj	*print_obj(layer, p)
	int	layer;
	obj	*p;
{
	double	r, dx, dy, ox, oy, x0, y0, x1, y1;
	obj	*op, *q;
	int	n;

	op = p;
#if 0
/*  4/23/91 -- trying to understand BoundingBox problems */
	if (redo_gbox) {
		float	bnd[4];
		Gbox[2] = Gbox[3] = -(Gbox[0] = Gbox[1] = 32767);
		for (q = objhead->o_next; q != objtail; q = q->o_next) {
			if (q->o_type > TEXT)
				continue;
			get_tot_bounds(q, bnd, 1);
/*			get_bounds(q, bnd, 1);		*/
			track_bounds (bnd[0], bnd[1], bnd[2], bnd[3]);
			if (q->o_type == BLOCK)
				q = q->o_val[N_VAL].o;
		}
		redo_gbox = 0;
	}
#endif
	openpl("");
	if (p->o_type != BLOCK && p->o_layer != layer)
		return p;
	if (p->o_type <= TEXT && (p->o_mxx!=1 || p->o_myy!=1 || p->o_mxy!=0 ||
				  p->o_myx!=0 || p->o_mxt!=0 || p->o_myt!=0))
		return print_xform(layer,p);

	ox = p->o_x;
	oy = p->o_y;
	if (p->o_type < TEXT && (p->o_attr & (FILLED | EDGED)))
		chk_attrs (p);
	switch (p->o_type) {

	case TROFF:
		n = p->o_nt1;
		if (text[n].t_type & EQNTXT)
			puteqn(ox, oy, text[n].t_type, atoi(text[n].t_val));
		else
			troff(text[n].t_val);
		return p;
	case BLOCK:
		for (q = p->o_next; q != p->o_val[N_VAL].o; q = q->o_next)
			if (q->o_type <= TEXT || q->o_nt2 > q->o_nt1)
				q = print_obj(layer,q);
		p = q;
		break;
	case PSFILE:
		puteps(p);
		/* CAREFUL!! THIS FLOWS THROUGH INTO BOX!! */
	case BOX:
		if (p->o_attr & (FILLED|EDGED)) {
			x0 = ox - p->o_wid/2;	x1 = ox + p->o_wid/2;
			y0 = oy - p->o_ht/2;	y1 = oy + p->o_ht/2;
			r  = p->o_val[N_VAL].f;
			box(x0, y0, x1, y1, r);
		}
		break;
	case CIRCLE:
	case ELLIPSE:
		if (p->o_attr & (FILLED|EDGED))
			ellipse(ox,oy,p->o_wid/2,0.,0.,p->o_ht/2,0.,2*M_PI,0);
		break;
	case SECTOR:
	case ARC:
		if (p->o_attr & (FILLED|EDGED)) {
			register double ang1, ang2;

			if (p->o_attr & HEAD12) {
				print_xform(layer, p);
				break;
			}
			r  = p->o_val[N_VAL+0].f;
			x0 = p->o_val[N_VAL+2].f;	/* starting point */
			y0 = p->o_val[N_VAL+3].f;
			x1 = p->o_val[N_VAL+4].f;	/* ending point   */
			y1 = p->o_val[N_VAL+5].f;
			ang1 = atan2(y0-oy, x0-ox);
			ang2 = atan2(y1-oy, x1-ox);
			ellipse(ox, oy, r, 0., 0., r, ang1, ang2, p->o_type);
		}
		break;
	case LINE:
	case ARROW:
	case SPLINE:
		if (p->o_attr & (FILLED|EDGED)) {
			int	c, nxy;

			if (p->o_attr & HEAD12) {
				print_xform(layer, p);
				break;
			}
			r   = p->o_val[N_VAL+0].f;
			nxy = p->o_val[N_VAL+3].f;	    /* segment count */
			x0  = p->o_val[N_VAL+4].f;	    /* first point   */
			y0  = p->o_val[N_VAL+5].f;
			x1  = p->o_val[N_VAL+4+2*nxy].f;    /* last point    */
			y1  = p->o_val[N_VAL+5+2*nxy].f;
			c = (x0 == x1 && y0 == y1);	    /* flags closure */
			if (nxy == 1)
				line(x0, y0, x1, y1);
			else if (p->o_type == SPLINE)
				spline(nxy, c, &p->o_val[N_VAL+4]);
			else
				pline (nxy, c, &p->o_val[N_VAL+4], r);
		}
		break;
	}
	if (op->o_nt1 < op->o_nt2)
		objtext(ox, oy, op);
	return p;
}

obj	*print_xform (layer,p)
	int	layer;
	obj	*p;
{
	double	r, ox, oy, dx, dy, x0, y0, x1, y1, M[4];
	double	b, tx0, ty0, tx1, ty1;
	valtype	*X;
	obj	*op, *q;
	int	n;

	op = p;
	if (p->o_layer != layer && p->o_type != BLOCK)
		return p;
#if 0
	if (p->o_type == TEXT) {
		ox = Xformx(p->o_parent, 1, p->o_x, p->o_y);
		oy = Xformy(p->o_parent, 0, p->o_x, p->o_y);
	}
	else {
#endif
		ox = Xformx(p, 1, p->o_x, p->o_y);
		oy = Xformy(p, 0, p->o_x, p->o_y);
#if 0
	}
#endif
	X = (valtype *)0;	
	if (p->o_type < TEXT && (p->o_attr & (FILLED | EDGED)))
		chk_attrs (p);

	switch (p->o_type) {

	case TROFF:
		n = p->o_nt1;
		if (text[n].t_type & EQNTXT)
			puteqn(ox, oy, text[n].t_type, atoi(text[n].t_val));
		else
			troff(text[n].t_val);
		return p;
	case BLOCK:
		for (q = p->o_next; q != p->o_val[N_VAL].o; q = q->o_next)
			if (q->o_type <= TEXT || q->o_nt2 > q->o_nt1)
				q = print_xform(layer,q);
		p = q;
		break;
	case PSFILE:
		puteps(p);
		/* CAREFUL!! THIS FLOWS THROUGH INTO BOX!! */
	case BOX:
		if (p->o_attr & (FILLED|EDGED)) {
			if ((X = (valtype *)malloc(10*sizeof(valtype))) == NULL)
				yyerror("out of room in print_xform");
			r = p->o_val[N_VAL].f;
			X[6].f = X[0].f = -(X[2].f = X[4].f = p->o_wid/2);
			X[1].f = X[3].f = -(X[5].f = X[7].f = p->o_ht/2);
			for (n = 0; n < 8; n += 2) {
				x1	 = ox + Linx(p, 0, X[n].f, X[n+1].f);
		  		X[n+1].f = oy + Liny(p, 0, X[n].f, X[n+1].f);
				X[n].f	 = x1;
			}
			X[n] = X[0];	X[++n] = X[1];
			x1 = Linx(p, 0, r, 0.);
			r =  Liny(p, 0, r, 0.);
			r = sqrt(x1 * x1 + r * r);
			pline(4, 1, X, r);
		}
		break;
	case CIRCLE:
	case ELLIPSE:
		if (p->o_attr & (FILLED|EDGED)) {
			get_matrix(&x0, &y0, &x1, &y1);
			x0 *= p->o_wid/2;
			y0 *= p->o_wid/2;
			x1 *= p->o_ht/2;
			y1 *= p->o_ht/2;
			ellipse(ox, oy, x0, y0, x1, y1, 0., 2*M_PI, 0);
		}
		break;
	case SECTOR:
	case ARC:
		if (p->o_attr & (FILLED|EDGED)) {
		    register double ang1, ang2;

		    r  = p->o_val[N_VAL+0].f;
		    x0 = p->o_val[N_VAL+2].f;	/* starting point */
		    y0 = p->o_val[N_VAL+3].f;
		    x1 = p->o_val[N_VAL+4].f;	/* ending point   */
		    y1 = p->o_val[N_VAL+5].f;
                    ang1 = atan2(y0 - p->o_y, x0 - p->o_x);
                    ang2 = atan2(y1 - p->o_y, x1 - p->o_x);
	/*
	 *	If there are arrowheads and non-zero line thickness, we
	 *	adjust the end points so the thick lines do not go all the
	 *	way to the end of the arrows, obliterating the points.
	 */
		    if (p->o_attr & HEAD12) {
			dx = p->o_val[N_VAL+8].f;
			dy = p->o_val[N_VAL+9].f;
			if (p->o_weight > 0.) {
			    b = p->o_weight / 2 / dx;
			    b *= sqrt(dx*dx + 4*dy*dy);
			    b = 2. * atan2(b, r);
			    if (p->o_attr & HEAD1)
				ang1 += b;
			    if (p->o_attr & HEAD2)
				ang2 -= b;
			}
		    }
		    tmp_xform(p);
		    line_weight = p->o_weight;	/* use REAL weight here */
		    ellipse(p->o_x, p->o_y, r, 0., 0., r,
					ang1, ang2, (int)p->o_type);
		    undo_tmpx();
	/* This is a kludge.  Because tmp_xform and undo_tmpx put the
	 * ellipse stuff (including a new_weight()) inside a gs/gr pair,
	 * the postscript line-weight is unchanged, but new_weight thinks
	 * it is set to line_weight.  To get around this, we call a sub-
	 * that just resets the last_weight variable in plps.c.
	 */
		    reset_line_weight();

		    if (p->o_attr & (HEAD1 | HEAD2))
			arc_arrow(p);
		}
		break;
	case LINE:
	case ARROW:
	case SPLINE:
		if (p->o_attr & (FILLED|EDGED)) {
			int	c, i, nxy;

			r   = p->o_val[N_VAL+0].f;
			x1 = Linx(p, 0, r, 0.);
			r =  Liny(p, 0, r, 0.);
			r = sqrt(x1 * x1 + r * r);
			nxy = p->o_val[N_VAL+3].f;	/* segment count */
			X = (valtype *)malloc((2*nxy+2)*sizeof(valtype));
			if (X == NULL)
				yyerror("out of room in print_xform");
			for (i = 0, n = N_VAL+4; i <= 2 * nxy; ) {
				register double	xx = p->o_val[n++].f,
						yy = p->o_val[n++].f;
				X[i++].f = Xformx(p, 0, xx, yy);
				X[i++].f = Xformy(p, 0, xx, yy);
			}
			x0 = X[0].f;
			y0 = X[1].f;
			x1 = X[i-2].f;
			y1 = X[i-1].f;
			tx0 = ty0 = tx1 = ty1 = 0.;
			n = 2 * nxy - 2;
			if (p->o_attr & HEAD12) {
			    get_matrix(M, M+1, M+2, M+3);
		/*  DBK: I added the fabs to eliminate sqrt errors
		 *  and make it same as xprint.c.  9/20/90	*/
			    dy = dx = sqrt(fabs(M[0]*M[3] - M[1]*M[2]));
			    dx *= p->o_val[N_VAL+1].f;
			    dy *= p->o_val[N_VAL+2].f;
			    if (p->o_weight > 0.) {
				double	linex, liney, a;

				b = p->o_weight / 2 / p->o_val[N_VAL+1].f;
				b *= sqrt(dx*dx + 4*dy*dy);
				if (p->o_attr & HEAD2) {
				    linex = x1 - X[n].f;
				    liney = y1 - X[n+1].f;
				    a = b / sqrt(linex*linex + liney*liney);
				    tx1 = -a * linex;
				    ty1 = -a * liney;
				    x1 = X[n+2].f += tx1;
				    y1 = X[n+3].f += ty1;
				}
				if (p->o_attr & HEAD1) {
				    linex = x0 - X[2].f;
				    liney = y0 - X[3].f;
				    a = b / sqrt(linex*linex + liney*liney);
				    tx0 = -a * linex;
				    ty0 = -a * liney;
				    x0 = X[0].f += tx0;
				    y0 = X[1].f += ty0;
				}
			    }
			}
                /*      The first two args are just to give a direction to
                 *      the second two.  To make sure that the direction
                 *      isn't reversed, adjust the first two by the same
                 *      amount as we adjusted x1 and y1 above.
                 */
			c = (x0 == x1 && y0 == y1);	    /* flags closure */
			if (nxy == 1)
				line(X[0].f, X[1].f, X[2].f, X[3].f);
			else if (p->o_type == SPLINE)
				spline(nxy, c, X);
			else
				pline (nxy, c, X, r);
                        if (p->o_attr & HEAD2) {
                            tx1 += X[n].f;
                            ty1 += X[n+1].f;
                            arrow(tx1, ty1, x1, y1, dx, dy, 0.0, p->o_attr);
                        }
                        if (p->o_attr & HEAD1) {
                            tx0 += X[2].f;
                            ty0 += X[3].f;
                            arrow(tx0, ty0, x0, y0, dx, dy, 0.0, p->o_attr);
                        }
		}
		break;
	case TEXT:
		tmp_xform(p);
#if 0
		dotext(ox, oy, p);
#else
		dotext(p->o_x, p->o_y, p);
#endif
		undo_tmpx();
		return p;
	}
	if (X)
		free(X);
	if (op->o_nt1 < op->o_nt2)
		objtext(ox, oy, op);
	return p;
}

objtext(x, y, p)
	double x, y;
	obj    *p;
{
	double  *bnd;
	int     i, nt2 = (unsigned int) p->o_nt2, t;

	t = text[p->o_nt1].t_type;
	for (i = p->o_nt1; i < nt2; i++)
		if (text[i].t_type != t)
			break;
	if (i = nt2 && p->o_type != TEXT) {  /* all strings same type */
		bnd = text_bounds(p);
		if (t & RJUST)
			x += (bnd[2] - bnd[0]) / 2;
		if (t & LJUST)
			x -= (bnd[2] - bnd[0]) / 2;
	}
	dotext(x, y, p);
}

dotext(x, y, p)	/* print text strings of p in proper vertical spacing   */
	double x, y;
	obj *p;
{
    double  h, v, w, dely, *bnd;
    int	    i, j, m, n, t;
    int     nt2 = p->o_nt2;

    bnd = text_bounds(p);
    v = bnd[3];			/* includes ABOVE/BELOW attributes */
    j = text[p->o_nt1].t_line;
    new_color(p->o_text);
    for (h = w = 0, i = p->o_nt1; i < nt2; h = w = 0) {
	/* calculate position of baseline for this line--assumed to be
	   down 3/4 of maximum character height from top of line */
	for (m = 0, n = i; n < nt2 && text[n].t_line == j; n++) {
	    w += text[n].t_width*72/pgscale;
	    if (abs(text[n].t_size) > m)
		m = abs(text[n].t_size);
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
	newlabel(t, text[i].t_val, abs(text[i].t_font), x-h, y + v - dely,
						text[i].t_size / pgscale,
						text[i].t_width * 72 / pgscale);
	v -= (double) abs(text[i].t_space) / pgscale;
	while (++i < n)
	    addlabel(text[i].t_type, text[i].t_val,
				 text[i].t_font, text[i].t_size / pgscale,
					    text[i].t_width * 72 / pgscale);
	j = text[i].t_line;	/* line numbers not necessarily consecutive! */
    }
}

redogbox()
{
	float	bnd[4];
	obj	*o;

	Gbox[2] = Gbox[3] = -(Gbox[0] = Gbox[1] = 32767);
	for (o = objhead->o_next; o != objtail; o = o->o_next) {
		if (o->o_type > TEXT)
			continue;
		get_tot_bounds(o, bnd, 1);
/*		get_bounds(o, bnd, 1);		*/
		track_bounds (bnd[0], bnd[1], bnd[2], bnd[3]);
		if (o->o_type == BLOCK)
			o = o->o_val[N_VAL].o;
	}
	redo_gbox = 0;
}
