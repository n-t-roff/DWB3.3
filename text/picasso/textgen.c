/*	Copyright (c) 1988 AT&T	*/
/*	  All Rights Reserved  	*/

/*	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T	*/
/*	The copyright notice above does not evidence any   	*/
/*	actual or intended publication of such source code.	*/

/*	@(#)picasso:textgen.c	1.0	*/

#include <string.h>
#include <ctype.h>
#include "picasso.h"
#include "y.tab.h"

extern int	pic_compat;

obj *textgen()
{
static	double	prevh = 0;
static	double	prevw = 0;

struct	objattr	obat;
	int	i, sub, at, with, saw_with = 0;
	double	*bnd, savGbox[4], xwith, ywith;
	double	savcurx, savcury;
	obj	*p, *ppos;
	Attr	*ap;

	if (pic_compat) {	/* in pic, bounding box has size zero */
		savcurx = curx;
		savcury = cury;
	}
	obat.a_weight = obat.a_pcolor = obat.a_lcolor = obat.a_tcolor = -1;
	obat.a_ht = obat.a_wid = 0;
	obat.a_dashpat.a = (float *)0;
	obat.a_layer = (int)getfval("curlayer");
	sub = CENTER;
	at = with = 0;
	set_text();
	for (i = 0; i < nattr; i++) {
		ap = &attr[i];
		switch (ap->a_type) {
		default:
			miscattrs(ap, &obat);
			break;
		case WITH:
			with = ap->a_val.i;
			saw_with++;
			break;
		case AT:
			ppos = ap->a_val.o;
			curx = Xformx(ppos, 1, ppos->o_x, ppos->o_y);
			cury = Xformy(ppos, 0, ppos->o_x, ppos->o_y);
			at++;
			break;
		}
	}
	p = makenode(TEXT, N_VAL, obat.a_layer);
	/* NOTE: the three color attributes reduce to one here; their obj.val
	 * slots are used to record bounding box center.  If outline fonts are
	 * implemented, o_fill will be needed, and some adjustments made below
	 */
	if (obat.a_tcolor == -1)
		if ((obat.a_tcolor = obat.a_pcolor) == -1)
			obat.a_tcolor = obat.a_lcolor;
	p->o_text = obat.a_tcolor;
	checktextcolor(p);
	p->o_attr |= EDGED;
	/* need to save and restore the global bounding box, since text_bounds
	   sets it based on o_x and o_y, which are not properly set yet!  */
	for (i = 0; i < 4; i++)
		savGbox[i] = Gbox[i];
	bnd = text_bounds(p);
	for (i = 0; i < 4; i++)
		Gbox[i] = savGbox[i];
	p->o_val[N_VAL-2].f = (bnd[0] + bnd[2]) / 2;
	p->o_val[N_VAL-1].f = (bnd[1] + bnd[3]) / 2;
	prevw = p->o_wid = (obat.a_wid > 0 ? obat.a_wid : bnd[2]-bnd[0]);
	prevh = p->o_ht  = (obat.a_ht  > 0 ? obat.a_ht  : bnd[3]-bnd[1]);

    if (pic_compat) {	/* Here unchanged, or changed to at */
	if (!saw_with) {	/* adjustment w.r.t. Here */
	    p->o_x = curx;
	    p->o_y = cury;
	}
	else {			/* forces text center to Here, since all corners
				   are at center (size is zero) */
	    p->o_x = curx - p->o_val[N_VAL-2].f;
	    p->o_y = cury - p->o_val[N_VAL-1].f;
	}
    }
    else {
	if (at == 0 && saw_with == 0)
		with = isright(hvmode) ? WEST :	/* the default for with */
			isleft(hvmode) ? EAST :	/* butts the text box a- */
			isup(hvmode)   ? SOUTH :/* gainst the current point */
				 	NORTH;	/* in the current direction */
	/* position of center relative to current point */
	xwith = ywith = 0.0;
	switch (with) {
	    case NORTH:	ywith = -prevh/2;			break;
	    case SOUTH:	ywith =  prevh/2;			break;
	    case EAST:	xwith = -prevw/2;			break;
	    case WEST:	xwith =  prevw/2;			break;
	    case NE:	xwith = -prevw/2;   ywith = -prevh/2;	break;
	    case SE:	xwith = -prevw/2;   ywith =  prevh/2;	break;
	    case NW:	xwith =  prevw/2;   ywith = -prevh/2;	break;
	    case SW:	xwith =  prevw/2;   ywith =  prevh/2;	break;
	}
	curx += xwith;		/* position of center, temporarily */
	cury += ywith;
	/* calculate PLACE for this object based on center */
	p->o_x = curx - p->o_val[N_VAL-2].f;
	p->o_y = cury - p->o_val[N_VAL-1].f;

	/* calculate new postion for Here */
	if (isright(hvmode))
		curx += prevw/2;
	else if (isleft(hvmode))
		curx -= prevw/2;
	else if (isup(hvmode))
		cury += prevh/2;
	else
		cury -= prevh/2;
    }

	track_bounds (bnd[0]+p->o_x, bnd[1]+p->o_y,
				bnd[2]+p->o_x, bnd[3]+p->o_y);
	return(p);
}

int	def_font, def_size, def_space;
int	cur_font, cur_size, cur_space;
int	ft_mark, sz_mark, sp_mark, col_mark, adj_mark, ab_mark;

set_text()	/* called at beginning of each object generator */
		/* and each time a line to insert is typed at the terminal */
{
	cur_font =  def_font  = (int)getfval("textfont");
	cur_size =  def_size  = (int)getfval("textsize");
	cur_space = def_space = (int)getfval("textspace");
	ft_mark  = sz_mark  = sp_mark =
	col_mark = adj_mark = ab_mark = ntext;
}

reset_font(val)		/* user supplied font attribute on object  */
	double	val;	/* (stored as negative, to distinguish it  */
{			/* from troff escape embedded in a string) */
	int	i;

	cur_font = -val;
	for (i = ft_mark; i < ntext; i++)
		text[i].t_font = cur_font;
	ft_mark = ntext;
}

reset_size (op, val)
	int	op;
	double	val;
{
	int	i;

	if (cur_size == 0)
		cur_size = -def_size;
	switch (op) {
		default:	cur_size = -val;	break;
		case '+':	cur_size = -(abs(cur_size) + val);	break;
		case '-':	cur_size = -(abs(cur_size) - val);	break;
		case '*':	cur_size *= val;	break;
		case '/':	if (val != 0)
					cur_size /= val;
	}
	cur_space = cur_size * 6 / 5;
	for (i = sz_mark; i < ntext; i++) {
		text[i].t_size = cur_size;
		text[i].t_space = cur_space;
	}
	sz_mark = ntext;	/* NOTE sp_mark not updated */
}

reset_space (op, val)
	int	op;
	double	val;
{
	int	i;

	if (cur_space == 0)
		cur_space = -def_space;
	switch (op) {
		default:	cur_space = -val;	break;
		case '+':	cur_space = -(abs(cur_space) + val);	break;
		case '-':	cur_space = -(abs(cur_space) - val);	break;
		case '*':	cur_space *= val;	break;
		case '/':	if (val != 0)
					cur_space /= val;
	}
	for (i = sp_mark; i < ntext; i++)
		text[i].t_space = cur_space;
	sp_mark = ntext;
}

fix_text(n1, n2)		/* fill in default font/size/space values */
	int	n1, n2;		/* if space unspecified, set from size.   */
{
	if (cur_font == 0)
		cur_font  = -def_font;
	if (cur_size == 0)
		cur_size  = -def_size;
	if (cur_space == 0)
		cur_space  = (cur_size==0 ? -def_space : (double)cur_size
							* def_space/def_size);
	while (n1 < n2) {
		if (text[n1].t_font == 0)
			text[n1].t_font = cur_font;
		if (text[n1].t_size == 0)
			text[n1].t_size = cur_size;
		if (text[n1].t_space == 0)
			text[n1].t_space = text[n1].t_size == 0 ? cur_space :
					   (short)(text[n1].t_size
						* (double)def_space/def_size);
		++n1;
	}
}

troffesc(buf)		/* maintain up-to-date values in cur_font, cur_size */
	char	*buf;
{
	while (parse_text(buf, &cur_font, &cur_size))
					;
}

int	ntextlines = 0;

savetext(type, s)	/* record text elements for current object */
	int type;	/* breaking up into homogeneous font/size. */
	char *s;
{
extern	char	eqn_delim;
extern	int	eqn_count;
	int	start = ntext,
		tmp_font = cur_font,
		tmp_size = cur_size,
		max_size = 0;
	char	*str;

	++ntextlines;
	if ((type & (CENTER|LJUST|RJUST)) == 0)
		type |= CENTER;
	if (*s == '\0')		/* then save a blank (KLUDGE!!) */
		save_one(type, cur_font, cur_size, ntextlines, " ");
	else while (str = parse_text(s, &cur_font, &cur_size))
		if (*str) {
			if (abs(cur_size) > max_size)
				max_size = abs(cur_size);
			save_one(type, cur_font, cur_size, ntextlines, str);
		}
	free(s);
	while (start < ntext)
		text[start++].t_space = max_size * 6 / 5;
	if (cur_font != tmp_font)
		setfval("textfont",(double)cur_font);
	if (cur_size != tmp_size) {
		setfval("textsize",(double)cur_size);
		cur_space = cur_size * 6 / 5;
		setfval("textspace", (double) cur_space);
	}
}

save_one(type, font, size, n, str)
	int type, font, n, size;
	char *str;
{
	if (ntext >= ntextlist)
		text = (Text *) grow((char *) text, "text",
				ntextlist += 200, sizeof(Text));
	text[ntext].t_type  = type;
	text[ntext].t_font  = font;
	text[ntext].t_size  = size;
	text[ntext].t_space = cur_space;
	text[ntext].t_line = n;
	text[ntext].t_val = tostring(str);
	ntext++;
}

int
copytext(start, end)
    int     start, end;
{
/* DBK--3/23/90: This is called from copyone(); if copyone is called during
   the process of assembling a new obj, the calculation of o_nt2 could
   possibly be upset (too many people updating ntext).  However, I don't
   believe this occurs.
*/
    int     i;
    int	    linediff;

    linediff = ntextlines - text[start].t_line + 1;
    for (i = start; i < end; i++, ntext++) {
	if (ntext >= ntextlist)
	    text = (Text *) grow((char *) text, "text", ntextlist += 200,
								sizeof(Text));
	text[ntext] = text[i];
	text[ntext].t_val = tostring(text[i].t_val);
	text[ntext].t_line = ntextlines = text[i].t_line + linediff;
    }
    return ntext1 = ntext;
}

double	*text_bounds(p)		/* returns relative bounding box */
	obj	*p;		/* if possible, EQN type text should be sized */
{				/* by looking for bounding box in dpost file. */
static	double	bnd[4];
	double	ext[4];
	double	w0, w1, v, dely;
	double	ox, oy;
	int	n1, n2, seq, type;
	int	n, t;

	if ((n1=p->o_nt1) >= (n2=p->o_nt2))
		return bnd;
	/* Should not need to do anything here.  The only way size could
	   be 0 is for TROFF type objects.
	fix_text(n1, n2); */
	n = text[n2-1].t_line;		/* sequence number of last line */
	/* find total height = sum of space for all lines except last plus
	   maximum size in last line -- assumes leading is beneath letters */
	for (v = 0; text[n1].t_line < n; ) {
		v += abs(text[n1].t_space);
		t = text[n1].t_line;
		while (text[++n1].t_line == t)
			;
	}
	for (t = 0; n1 < n2; n1++)
		if (abs(text[n1].t_size) > t)
			t = abs(text[n1].t_size);
	v += t;
	v /= 2 * pgscale;	/* convert to half-height, in inches */
	n1 = p->o_nt1;
	dely = abs(text[n1].t_space) / (2 * pgscale);
	bnd[1] = 0;
	switch (text[n1].t_type & (ABOVE | BELOW)) {
		case ABOVE:	bnd[1] += dely;	break;
		case BELOW:	bnd[1] -= dely;	break;
	}
	bnd[3] = bnd[1] + v;
	bnd[1] -= v;
	bnd[0] = bnd[2] = 0;
	while (n1 < n2) {
		seq = text[n1].t_line;
		type = text[n1].t_type;
		for (w0 = w1 = 0; n1 < n2 && text[n1].t_line == seq; ++n1) {
			w1 += (text[n1].t_width = getstringwidth(text[n1].t_val,
					      text[n1].t_font,text[n1].t_size));
		}
		switch (type & (CENTER | LJUST | RJUST)) {
			case CENTER:	w1 /= 2;	w0 = -w1;	break;
			case RJUST:	w0 = -w1;	w1 = 0;		break;
		}
		if (w0 < bnd[0])
			bnd[0] = w0;
		if (w1 > bnd[2])
			bnd[2] = w1;
	}
	for (n1 = 0; n1 < 4; n1++)
		ext[n1] = bnd[n1];
	if (p->o_type != TEXT)	/* text is horizontally centered on o_x,o_y */
		ext[0] = - (ext[2] = (bnd[2] - bnd[0]) / 2);

	ox = Xformx(p, 1, p->o_x, p->o_y);
	oy = Xformy(p, 0, p->o_x, p->o_y);
	track_bounds(ox + ext[0], oy + ext[1], ox + ext[2], oy + ext[3]);
	return bnd;
}
