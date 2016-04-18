/*	Copyright (c) 1988 AT&T	*/
/*	  All Rights Reserved  	*/

/*	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T	*/
/*	The copyright notice above does not evidence any   	*/
/*	actual or intended publication of such source code.	*/

/*	@(#)picasso:plps.c	1.0	*/

#include <string.h>
#include <ctype.h>
#include "font.h"
#include "picasso.h"
#include "ps_include.h"
#include "plps.h"
#include "xstubs.h"
#include "y.tab.h"

#define	max(x,y)	((x)>(y) ? (x) : (y))
#define	min(x,y)	((x)<(y) ? (x) : (y))

#define PROLOGUE	"picasso.ps"
#define	FONTDEFS	"fonts.ps"

extern	char	*gwblib;	/* defined by installer, or set by -I flag */
extern	char	*dwb_devname;
extern	double	pght, pgwid;
extern	int	margin;
extern	float	magnification;
extern	float	miters[];
extern	FILE	*textfp;
extern  int	batch;
extern	int	pic_compat;

FILE	*outfp	 /*= stdout*/;
int	pages	 = 0;
int	pictures = 0;
int	started	 = 0;
int	bboxllx  = 32767;
int	bboxlly  = 32767;
int	bboxurx  = -32767;
int	bboxury  = -32767;
int	psfont	 = -1;
int	Portrait = 1;
double	Bgcolor  = -1;
double	pssize	 =  0;
int	last_cap    = -1;
int	last_join   = -1;
float	last_miter  = -1;
float	last_weight = -1;
float	last_color  = -1;
float	*last_dash  = NULL;

static	int	extra_chars = 0;

static void resetps(void);
static void findfile(char *, char *);
static void beginpl(void);
static void new_weight(float);
static void setattrdefaults(void);
static void new_style(void);
static void fill_or_stroke(void);
static void d_arrow(obj *, double, double, double, double, double, int);
static void octal_char(char);
static void extra_bs(void);
static void escstr(char *);
static int spacecount(char *);
static int catfile(char *s);
static void transparent(FILE *);

static void
resetps(void)	/* these must be reset for each page of a multipage file */
{		/* (so that -mpictures inclusions will work correctly.)  */

	psfont = last_miter = last_cap = last_join = -1;
	last_weight = last_color = -1;
	last_dash = NULL;
	pssize  = 0;
}

static char *nopro = "can't read prologue file ";

static void
findfile(char *path, char *name) {
	char	*msgbuf;

	if (access(strcat(strcat(strcpy(path,gwblib),"/"),name),4) != 0) {
		if (batch)
			fprintf(stderr, "%s%s\n", nopro, path);
		else {
			msgbuf = (char *) malloc(strlen(path)+strlen(nopro)+2);
			if (msgbuf != NULL) {
				sprintf(msgbuf, "%s%s", nopro, path);
				writemessage(msgbuf, 15, 1);
				free(msgbuf);
			}
		}
	}
}

static void
beginpl(void) {
	char	filename[100];
	char	enc[100];

	fputs("%!PS-Adobe-2.0\n", outfp);
	fputs("%%Creator: picasso\n", outfp);
	fputs("%%BoundingBox: (atend)\n", outfp);
	fputs("%%Pages: (atend)\n", outfp);
	fputs("%%EndComments\n", outfp);
	if (!pass_thru) {
		findfile(filename, FONTDEFS);
		catfile(filename);
	}
	findfile(filename, PROLOGUE);
	catfile(filename);
	sprintf(filename, "%s/%s.enc", gwblib, dwb_devname);
	if (catfile(filename) == 0) {			/* no such file, */
		sprintf(filename, "%s/%s.enc", gwblib, "Default");
		catfile(filename);		/*  use default, if any. */
	}
	fputs("%%EndProlog\n", outfp);
	fputs("%%BeginSetup\n", outfp);
	if (magnification != 1.0)
		fprintf(outfp, "/magnification %f def\n", magnification);
	fputs("%%EndSetup\n", outfp);
	pages = 0;
	bboxllx = 32767;
	bboxlly = 32767;
	bboxurx = -32767;
	bboxury = -32767;
	started = 1;
}

void
endpl(void) {
	if (started) {
		fputs("%%Trailer\n", outfp);
		fprintf(outfp, "%%%%BoundingBox: %d %d %d %d\n",
		    (int)(bboxllx*magnification), (int)(bboxlly*magnification),
		    (int)(bboxurx*magnification), (int)(bboxury*magnification));
		fprintf(outfp, "%%%%Pages: %d\n", pages);
	}
}

int	open_done = 0;
double	tx, ty, pgscale = 72;
static double	px, py, sx, sy;
static int	pbnd[4];

void
openpl(char *s)		/* initialize page */
{
	extern	FILE *tmpfile();
	double	deltx, delty, r;

	if (open_done)
		return;
	pgscale = 72;		/* reset for every picture */
	while (isspace(*s))
		s++;
	if (*s == '\0') {
		px = pgwid;
		py = pght;
	}
	else {
		px = py = 0;
		sscanf(s, "%lf %lf", &py, &px);
		if (pic_compat) {
			r = px;
			px = py;
			py = r;
		}
		if (px <= 0)	px = pgwid;
		if (py <= 0)	py = pght;
	}
	if (pass_thru) {
		if ((outfp = tmpfile()) == NULL)
			fatal("can't open internal temporary file");
		started = 0;
	}
	if (!started)
		beginpl();
#if 1	/*  4/23/91--DBK  */
	redogbox();		/* make SURE we compute things right */
#endif
	if (nosqueeze) {
		sx = sy = 72;
		tx = ty = 0;
	}
	else {
		deltx = (Gbox[2]-Gbox[0]);
		delty = (Gbox[3]-Gbox[1]);
		if (cur_xform[0].f != 1) {	/* implicit scaling */
			deltx *= cur_xform[0].f;
			delty *= cur_xform[0].f;
		}
		r = max(deltx/px, delty/py);
		if (r <= 1)
			r = 1;
		else if (verbose || px == pgwid && py == pght) {
			fprintf(stderr, "%s: %g X %g picture shrunk to",
					cmdname, deltx, delty);
			deltx /= r;
			delty /= r;
			fprintf(stderr, " %g X %g\n", deltx, delty);
		}
/*	NOTE: Setting pgscale affects the subsequent ouput of text, so
	that text will come out the same size regardless of the scaling
	of the rest of the drawing.  This is only appropriate when we
	are in pic emulation mode, since pic couldn't scale text.--DBK */
		if (pic_compat)
			pgscale = 72/r;
		sx = sy = 72/r;
		tx = -(Gbox[0]+Gbox[2])/2;
		ty = -(Gbox[1]+Gbox[3])/2;
	}
	pages++;
	fprintf(outfp, "%%%%Page: ? %d\n", pages);
	fprintf(outfp, "%%%%PageBoundingBox: (atend)\n");
	fputs("%%BeginPageSetup\n", outfp);
	if (Portrait == 0) {		/* i.e., landscape mode */
#if 1		/* try different way to get center */
		fprintf(outfp, "%.5g %.5g\n", pgwid * 36, pght * 36);
#else
		fprintf(outfp, "clippath pathbbox newpath exch\n");
		fprintf(outfp, "\t4 -1 roll add 2 div 3 1 roll add 2 div\n");
#endif
		fprintf(outfp, "\tdup neg 3 1 roll 1 index neg 4 1 roll\n");
		fprintf(outfp, "\ttranslate 90 rotate translate\n");
	}
	if (Bgcolor >= 0) {
		new_color(Bgcolor);
		fprintf(outfp, "clippath fill\n");
	}
#if 1		/* try different way to get center */
	fprintf(outfp, "%.5g %.5g translate\n", pgwid * 36, pght * 36);
	fprintf(outfp, "%.5g %.5g %.5g %.5g \n", tx, ty, sx, sy);
	fprintf(outfp, "scale magnification magnification scale translate\n");
#else
	fprintf(outfp, "%.5g %.5g %.5g %.5g PIC\n", tx, ty, sx, sy);
#endif
	fputs("%%EndPageSetup\n", outfp);
	setattrdefaults ();
	open_done = 1;
}

void
closepl(char *s)		/* clean up after finished with one picture */
/* 	char	*s;	residue of .PS invocation line */
{
extern	long	ftell();
extern	int	flyback;
	long	filesize;

	if (open_done) {
		fputs("showpage\n", outfp);
#if 1	/* 4/23/91--DBK */
		redogbox();
#endif
		if (nosqueeze) {
			pbnd[0] = Gbox[0]*72 + px * 72 / 2;
			pbnd[3] = (11+Gbox[3])*72 - py  * 72 / 2;
		}
		else {
			pbnd[0] = pgwid * 72 / 2 + (Gbox[0] - Gbox[2]) * sx / 2;
			pbnd[3] = pght  * 72 / 2 + (Gbox[3] - Gbox[1]) * sy / 2;
		}
		pbnd[1] = pbnd[3] - (Gbox[3] - Gbox[1]) * sy;
		pbnd[2] = pbnd[0] + (Gbox[2] - Gbox[0]) * sx;
		pbnd[0] -= margin;		pbnd[1] -= margin;
		pbnd[2] += margin;		pbnd[3] += margin;
		if (pbnd[0] < 0)		pbnd[0] = margin;
		if (pbnd[1] < 0)		pbnd[1] = margin;
		if (pbnd[2] > pgwid * 72)	pbnd[2] = pgwid * 72 - margin;
		if (pbnd[3] > pght  * 72)	pbnd[3] = pght * 72  - margin;
		fprintf(outfp, "%%%%PageBoundingBox: %d %d %d %d\n",
		    (int)(pbnd[0]*magnification), (int)(pbnd[1]*magnification),
		    (int)(pbnd[2]*magnification), (int)(pbnd[3]*magnification));
		if (bboxllx > pbnd[0])	bboxllx = pbnd[0];
		if (bboxlly > pbnd[1])	bboxlly = pbnd[1];
		if (bboxurx < pbnd[2])	bboxurx = pbnd[2];
		if (bboxury < pbnd[3])	bboxury = pbnd[3];
		if (pass_thru) {
			endpl();
			fflush(outfp);
			filesize = ftell(outfp) - extra_chars;
			rewind(outfp);
			pictures++;
			printf("\\!x X InlinePicture picture%d %ld\n",
				pictures, filesize);
			transparent(outfp);
			fclose(outfp);
			fprintf(textfp, ".BP picture%d ", pictures);
			while (isspace(*s))
				s++;
			if (*s != '\0')
				if (pic_compat) {   /* interchange x and y */
					double	x, y;
					int	i;
					char	r[120];

					i = sscanf(s, "%lf %lf %[^\n]",
								&x, &y, r);
					if (i <= 0)
						x = (bboxurx - bboxllx)/72.0;
					if (i == 1)
						y = x * (bboxury - bboxlly) /
							(bboxurx - bboxllx);
					if (i < 3)
						strcpy(r, "c");
					fprintf(textfp, "%g %g %s\n", y, x, r);
				}
				else
					fputs(s, textfp);
			else
				fprintf(textfp, "%g %g%s\n",
						(bboxury - bboxlly)/72.0,
						(bboxurx - bboxllx)/72.0,
						pic_compat ? " c" : "");
			if (!flyback)
				fputs(".EP\n", textfp);
		}
		extra_chars = 0;
		open_done = 0;
		resetps();
	}
}

/* If not specified with the object, any geometrical primitve is stroked   */
/* in the default linecolor (and at default lineweight) and is not filled. */
/* The most recent settings of color and weight are preserved and used to  */
/* compare with values requested for this object.			   */

#if 0 /* unused */
check_psxform()
{
	if (cur_xform[0].f != 1 || cur_xform[1].f != 0 || cur_xform[2].f != 0
	||  cur_xform[3].f != 1 || cur_xform[4].f != 0 || cur_xform[5].f != 0) {

		fprintf (outfp, "[%.5g %.5g %.5g %.5g %.5g %.5g] concat\n",
			cur_xform[0].f, cur_xform[1].f, cur_xform[2].f,
			cur_xform[3].f, cur_xform[4].f, cur_xform[5].f);

		cur_xform[0].f = cur_xform[3].f = 1;
		cur_xform[1].f = cur_xform[2].f =
		cur_xform[4].f = cur_xform[5].f = 0;
	}
}
#endif

short	have_temp = 0;
extern	double	T[];

void
tmp_xform (obj *p)		/* used only for text */
{
#if 0
	if (p->o_mxx != 1 || p->o_myx != 0 || p->o_mxy != 0 || p->o_myy != 1
	||  p->o_mxt != 0 || p->o_myt != 0) {
		have_temp = 1;
		fprintf (outfp, "\ngs [%.5g %.5g %.5g %.5g %.5g %.5g] concat\n",
					p->o_mxx, p->o_myx, p->o_mxy, p->o_myy,
					p->o_mxt, p->o_myt);
	}
#else
	compose(p);
	if (T[0] != 1 || T[1] != 0 || T[2] != 0 ||
	    T[3] != 1 || T[4] != 0 || T[5] != 0) {
		have_temp = 1;
		fprintf (outfp, "\ngs [%.5g %.5g %.5g %.5g %.5g %.5g] concat\n",
			T[0], T[1], T[2], T[3], T[4], T[5]);
	}
#endif
}

void
undo_tmpx (void) {
	if (have_temp) {
		fputs("gr\n", outfp);
	}
	have_temp = 0;
}

void
reset_line_weight(void) {
	last_weight = -1;
	last_dash = NULL;			/*	this, too.  DBK--6/9/92 */
}

static void
new_weight(float val) {
	if (val < 0.)
		yyerror ("bad value for lineweight");
	else if (val != last_weight)
		fprintf (outfp, " %.5g w\n", last_weight = val);
}

void
new_color(float val) {
	if (val != last_color) {
		if (val <= 1.0)
			fprintf (outfp, " %.5g g\n", val);
		else {
			register int	n = val;

			fprintf (outfp, " %.5g %.5g %.5g rgb\n",
				rgbtable[n].r, rgbtable[n].g, rgbtable[n].b);
		}
		if (!have_temp)
			last_color = val;
	}
}

int	attr_flags;
float	fill_color;
float	line_color;
float	line_weight;
float	*line_dash;

static void
setattrdefaults(void)
{
	float	x;

	if ((x = getfval("flatness")) > 0)
		fprintf(outfp,"%.5g setflat\n", x);
	attr_flags = EDGED;
	new_weight(getfval("lineweight"));
	new_color (getfval("linecolor"));
	new_style();
}

float	solid = 0;

static void
new_style(void)	/* corners, ends, dash pattern */
{
	int	i, n;

	if ((n = attr_flags & (3*LINECAP)) > 0) {
		n /= LINECAP;
		if (--n != last_cap)
			fprintf(outfp,"%d setlinecap\n",last_cap = n);
	}
	if ((n = attr_flags & (3*JOIN)) > 0) {
		n /= JOIN;
		if (--n != last_join)
			fprintf(outfp,"%d setlinecap\n",last_join = n);
		if (n == 0 && (i = attr_flags/MITER) > 0)
			if (miters[i] != last_miter)
				fprintf(outfp,"%.5g setmiterlimit\n",
						last_miter = miters[i]);
	}
	if (attr_flags & DOTDASH) {
		n = *line_dash;
		for (i = 0; i <= n; i++)
			if (last_dash == NULL || line_dash[i] != last_dash[i])
				break;
		if (i < n+1) {
			fprintf(outfp," [%.5g",line_dash[1]);
			for (i = 2; i <= n; i++) {
				fprintf(outfp, " %.5g", line_dash[i]);
			}
			fprintf(outfp, "] 0 d\n");
			last_dash = line_dash;
		}
	}
	else {
		if (last_dash != &solid)
			fprintf(outfp, " [] 0 d\n");
		last_dash = &solid;
	}
}

void
chk_attrs (obj *p) {
	line_weight = p->o_weight;
	/*	It seems as though this should scale with the associated
	 *	object.  I have made it so, 9/20/90.  DBK
	 */
	compose(p);
	line_weight *= sqrt(fabs(T[0] * T[3] - T[1] * T[2]));
	attr_flags  = p->o_attr;
	line_color  = p->o_color;
	fill_color  = p->o_fill;
	line_dash   = p->o_ddpat.a;
}

static void
fill_or_stroke (void)	/* If fill/edge colors differ, need save/restore */
{
	switch (attr_flags & (EDGED | FILLED)) {

	case EDGED:	new_color (line_color);		/* simple stroke */
			new_weight(line_weight);
			new_style();
			fprintf(outfp, " s\n");
			break;
	case FILLED:	new_color(fill_color);		/* simple fill	*/
			fprintf(outfp, " f\n");
			break;
	default:	new_color (line_color);
			new_weight(line_weight);
			new_style();
			if (fill_color <= 1.0)
				fprintf(outfp, " gs %.5g g f gr s\n",
							fill_color);
			else {
				register int	n = fill_color;

				fprintf(outfp," gs %.5g %.5g %.5g rgb f gr s\n",
						rgbtable[n].r,
						rgbtable[n].g,
						rgbtable[n].b);
			}
			break;
	}
}

void
line(double x0, double y0, double x1, double y1)	/* draw line from x0,y0 to x1,y1 */
{
	fprintf(outfp, "%.5g %.5g 1 %.5g %.5g L", x1, y1, x0, y0);
	fill_or_stroke ();
}

int
box(double x0, double y0, double x1, double y1, double r) {
	if (r < MINRAD)
		fprintf(outfp, "%.5g %.5g %.5g %.5g Q", x0,y0, x1,y1);
	else
		fprintf(outfp, "%.5g %.5g %.5g %.5g %.5g rQ", x0,y0, x1,y1, r);
	fill_or_stroke ();
}

/* draw arrowhead (w/o shaft) */

void
arrow(double x0, double y0, double x1, double y1, double w, double h,
    double ang, int attr)
/* 	double x0, y0, x1, y1, w, h, ang;	wid w, len h, rotated ang  */
/* 	int attr;				and drawn filled or open.  */
{
	double alpha, rot, hyp;
	float dx0, dy0, dx1, dy1;
    int	savattrflags;

	rot = atan2(w/2, h);
	hyp = hypot(w/2, h);
	alpha = atan2(y1-y0, x1-x0) + ang;
	dx0 = hyp * cos(alpha + M_PI - rot);
	dy0 = hyp * sin(alpha + M_PI - rot);
	dx1 = hyp * cos(alpha + M_PI + rot);
	dy1 = hyp * sin(alpha + M_PI + rot);
    savattrflags = attr_flags;
    attr_flags &= ~DOTDASH;	/* arrows always drawn w/ solid lines */
    attr_flags &= ~(3 * JOIN);	/* arrows always drawn w/ points */
    new_weight(line_weight);
    new_style();
    attr_flags = savattrflags;
	fprintf(outfp, "%.5g %.5g %.5g %.5g 2 %.5g %.5g L ",
			x1+dx1, y1+dy1, x1, y1, x1+dx0, y1+dy0);
	if (attr & HEADFILL)
		fprintf(outfp, "c gs s gr f\n");
	else
		fprintf(outfp, "s\n");
}

void
arc_arrow(obj *o) {
    double  hyp;		/* side of naked arrowhead */
    double  l;			/* actual length of arrowhead */
    double  theta;		/* half angle at arrow point */
    double  phi;		/* half angle subtended by (wide) arrowhead */
    double  len, wid;		/* of naked arrowhead */
    double  wt = o->o_weight;	/* line thickness */
    int	savattrflags;

    wid = o->o_val[N_VAL+8].f;
    len = o->o_val[N_VAL+9].f;
    theta = atan2(wid / 2, len);
    hyp = len / cos(theta);
    l = len + wt / 2 * (1 + 1 / sin(theta));
    phi = atan2(l / 2, o->o_val[N_VAL].f);	/* o_val[N_VAL] = radius */
    savattrflags = attr_flags;
    attr_flags &= ~DOTDASH;	/* arrows always drawn w/ solid lines */
    attr_flags &= ~(3 * JOIN);	/* arrows always drawn w/ points */
    new_weight(line_weight);
    new_style();
    attr_flags = savattrflags;
    compose(o);
    if (o->o_attr & HEAD1) 
	d_arrow(o, theta, phi + M_PI / 2, hyp,
		o->o_val[N_VAL+2].f, o->o_val[N_VAL+3].f, (int)o->o_attr);
    if (o->o_attr & HEAD2)
	d_arrow(o, theta, -phi - M_PI / 2, hyp,
		o->o_val[N_VAL+4].f, o->o_val[N_VAL+5].f, (int)o->o_attr);
}

static void
d_arrow(obj *o, double theta, double phi, double hyp, double x1, double y1,
    int attr)
/*  double  theta,		   arrowhead point half-angle */
/*   phi,		   +- half-angle subtended by arrowhead 
						+- pi */
/*   hyp,		   length of side of arrow */
/*   x1, y1;		   end of arc */
{
    double  alpha,		/* radius angle */
	    rho,		/* angle counter to arrow direction */
	    x0, y0, x2, y2,	/* end points of rear of arrow */
	    wt = o->o_weight;	/* line thickness */
    double  tmp;

    alpha = atan2(y1 - o->o_y, x1 - o->o_x);
    rho = alpha + phi;
    /* reset end point to account for thickness of line */
    x1 += wt * cos(rho) / sin(theta) / 2;
    y1 += wt * sin(rho) / sin(theta) / 2;
    x0 = x1 + hyp * cos(rho + theta);
    y0 = y1 + hyp * sin(rho + theta);
    x2 = x1 + hyp * cos(rho - theta);
    y2 = y1 + hyp * sin(rho - theta);
#if 0
    tmp = Xformx(o, 0, x0, y0);
    y0 = Xformy(o, 0, x0, y0);
    x0 = tmp;
    tmp = Xformx(o, 0, x1, y1);
    y1 = Xformy(o, 0, x1, y1);
    x1 = tmp;
    tmp = Xformx(o, 0, x2, y2);
    y2 = Xformy(o, 0, x2, y2);
    x2 = tmp;
#else
    tmp_xform(o);
#endif
    fprintf(outfp, "%.5g %.5g %.5g %.5g 2 %.5g %.5g L ",
			x0, y0, x1, y1, x2, y2);
    if (attr & HEADFILL)
	fprintf(outfp, "c gs s gr f\n");
    else
	fprintf(outfp, "s\n");
#if 1
    undo_tmpx();
#endif
}

void
spline(int n, int close, valtype *p) {
	int i;

	for (i = 2*n; i > 2; i -= 2)
		fprintf(outfp,"%.5g %.5g%c",p[i].f,p[i+1].f,i%10==9 ?'\n':' ');
	fprintf(outfp, "%d   %.5g %.5g %.5g %.5g Sp %c",
			n-1, p[2].f,p[3].f,p[0].f,p[1].f, close? 'c' : ' ');
	fill_or_stroke ();
}

void
pline(int n, int close, valtype *p, double r)
/* 	double	r;	"corner" radius */
{
	int	i;
	float	x, y;

	if (close && r > MINRAD) {
		fprintf(outfp, "%.5g %.5g\n",
				x=(p[0].f+p[2].f)/2, y=(p[1].f+p[3].f)/2);
		for (i = 2*n; i > 0; i -= 2)
			fprintf(outfp, "%.5g %.5g%c",
					p[i].f, p[i+1].f, i%8==6 ?'\n':' ');
		fprintf(outfp, "%.5g %d %.5g %.5g rL", r, n+1, x, y);
	}
	else {
		n -= close;
		for (i = 2*n; i > 0; i -= 2)
			fprintf(outfp, "%.5g %.5g%c",
					p[i].f, p[i+1].f, i%8==6 ?'\n':' ');
		if (r > MINRAD)
			fprintf(outfp, "%.5g %d %.5g %.5g rL",
					r, n, p[0].f, p[1].f);
		else
			fprintf(outfp, "%d %.5g %.5g L", n, p[0].f, p[1].f);
		if (close)
			fprintf(outfp, " c");
	}
	fill_or_stroke ();
}

/* general elliptical arc/sector routine */

void
ellipse(double xc, double yc, double x0, double y0, double x1, double y1,
    double ang1, double ang2, int type) {
	double	c, s, phi, r1, r2;
	int	iang1, iang2;

	iang1 = (int)(180 * (ang1 * M_1_PI) + (ang1 > 0. ? 0.5 : -0.5));
	iang2 = (int)(180 * (ang2 * M_1_PI) + (ang2 > 0. ? 0.5 : -0.5));
	if (iang2 == iang1)
		iang2 += 360;

/* This finds the angle at which the ellipse is inclined to the axes; the */
/* most common case will have phi==0 or pi/2, and it seems worthwhile to  */
/* check for that case without doing all the trigonometric stuff below.   */

	if (y0 == 0 && x1 == 0 || x0 == 0 && y1 == 0) {
		phi = 0;
		r1 = fabs(x0);
		r2 = fabs(y1);
	}
	else {
		phi = atan2(x0*x0 + y0*y0 - x1*x1 - y1*y1, 2*(x0*x1 + y0*y1))/2;
		c = cos(phi);
		s = sin(phi);
		r1 = hypot(c*x0 + s*x1, c*y0 + s*y1);
		r2 = hypot(c*x1 - s*x0, c*y1 - s*y0);
	}
/* MS: The following piece of code was taken out, because */
/* transformed ellipses would print as circles. 6/1/92 */

/*	if (fabs(r1-r2) < MINRAD)
		fprintf(outfp, "n %.5g %.5g %.5g %d %d arc",
				xc, yc, (r1+r2)/2, iang1, iang2);
	else {
*/
		/* note: if phi != 0, non-postScript displays need to call a */
		/*	 special elliptical arc generation routine here:     */
		/*							     */
		/*	 	gen_ellipse(xc,yc,x0,y0,x1,y1,ang1,ang2)     */

		fprintf(outfp,"0 0 1 %d %d [%.5g %.5g %.5g %.5g %.5g %.5g] E",
				  iang1, iang2, x0, y0, x1, y1,   xc, yc);
/*	}  */
	if (type == SECTOR)
		fprintf(outfp, " %.5g %.5g l c", xc, yc);
	fill_or_stroke();
}

static void
extra_bs(void) {
	fputc('\\', outfp);
	extra_chars++;
}

static void
octal_char(char c) {
	if (pass_thru)
		extra_bs();
	fprintf(outfp,"\\%o", (int) c & 0xff);
}

char	escapes[] = "()\\";	/* chars needing to be escaped in PostScript */

static void
escstr(char *s) {
	char	*ptr;

	fputc('(', outfp);
	while ((ptr = strpbrk(s,escapes)) != NULL) {
		while (s < ptr)
			if (*s >= ' ' && *s <= '~')
				fputc(*s++, outfp);
			else
				octal_char(*s++);
		if (pass_thru) {	/* troff changes \\ to \ */
			extra_bs();
			if (*s == '\\')		/* for a total of 3 extras! */
				extra_bs();
		}
		fputc('\\', outfp);
		fputc(*s++, outfp);
	}
	while (*s)
		if (*s >= ' ' && *s <= '~')
			fputc(*s++, outfp);
		else
			octal_char(*s++);
	fputc(')', outfp);
}

static int
spacecount(char *s) {
	int	count = 0;

	while (*s)
		if (*s++ == ' ') count++;
	
	return(count);
}

double	lastx, lasty;

void
newlabel(int type, char *str, int font, double x, double y, double size,
    double w) {
	if (type & EQNTXT)
		puteqn(x, y, type, atoi(str));
	else {
		resetfont(font, size);
		escstr(str);
		fprintf(outfp," %d %.5g %.5g %.5g T\n",spacecount(str),w,x,y);
	}
	lastx = x+w;
	lasty = y;
}

void
addlabel(int type, char *str, int font, double size, double w) {
	if (type & EQNTXT)
		puteqn(lastx, lasty, type, atoi(str));
	else {
		resetfont(font, size);
		escstr(str);
		fprintf(outfp, " %d %.5g AT\n", spacecount(str), w);
	}
	lastx += w;
}

void
resetfont(int font, double size) {
	if (font < 0) font = -font;
	if (size < 0) size = -size;
	if (font != psfont || size != pssize) {
		fprintf(outfp, "%s findfont %.5g scalefont setfont\n",
					dwb_mount[font]->name, size);
		if (!have_temp) {
			psfont = font; pssize = size;
		}
	}
}

static int
catfile(char *s) {
	FILE *fp, *fopen();
	char buf[BUFSIZ];
	int count;

	if ((fp = fopen(s, "r")) == NULL) return(0);
	while ((count = fread(buf, sizeof(*buf), BUFSIZ, fp)) > 0)
		fwrite(buf, sizeof(*buf), count, outfp);
	fclose(fp);
	return(1);
}

static void
transparent(FILE *fp) {
	char buf[BUFSIZ];

	while (fgets(buf, BUFSIZ, fp) != NULL) {
		putchar('\\'); putchar('!');
		fputs(buf, stdout);
	}
}

/*
 *	include an encapsulated postscript file.  Apply any scaling and
 *	transformation specified by p.
 */

void
puteps(obj *o)
{
	FILE	*fp;

	if ((fp = fopen(o->o_val[N_VAL-1].p, "r")) == NULL) {
		yyerror("can't open EPS file %s", o->o_val[N_VAL-1].p);
		return;
	}
	pic_include(fp, outfp, 1, o);
	fclose(fp);
}
