#include <stdio.h>
#include <math.h>
#include "pic.h"
extern int dbg;

#define	abs(n)	(n >= 0 ? n : -(n))
#define	max(x,y)	((x)>(y) ? (x) : (y))

char	*textshift = "\\v'.2m'";	/* move text this far down */

/* scaling stuff defined by s command as X0,Y0 to X1,Y1 */
/* output dimensions set by -l,-w options to 0,0 to hmax, vmax */
/* default output is 6x6 inches */

static void space(double, double, double, double);
static double xconv(double);
static double xsc(double);
static double yconv(double);
static double ysc(double);
static void movehv(double, double);
static void hgoto(double);
static void vgoto(double);
static double dwb_fabs(double);
static void hvflush(void);
static void flyback(void);
static void cont(double, double);

double	xscale;
double	yscale;

double	hpos	= 0;	/* current horizontal position in output coordinate system */
double	vpos	= 0;	/* current vertical position; 0 is top of page */

double	htrue	= 0;	/* where we really are */
double	vtrue	= 0;

double	X0, Y0;		/* left bottom of input */
double	X1, Y1;		/* right top of input */

double	hmax;		/* right end of output */
double	vmax;		/* top of output (down is positive) */

extern	double	deltx;
extern	double	delty;
extern	double	xmin, ymin, xmax, ymax;

void
openpl(char *s)	/* initialize device */
	/* char *s;	/ * residue of .PS invocation line */
{
	double maxw, maxh, ratio = 1;
	double odeltx = deltx, odelty = delty;

	hpos = vpos = 0;
	maxw = getfval("maxpswid");
	maxh = getfval("maxpsht");
/*	if (deltx > getfval("maxpswid") || delty > getfval("maxpsht")) {	/ * 8.5x11 inches max * /
 *		fprintf(stderr, "pic: %g X %g picture shrunk to", deltx, delty);
 *		maxdelt = max(deltx, delty);
 *		deltx *= 7/maxdelt;	/ * screwed up anyway; * /
 *		delty *= 7/maxdelt;	/ * make it 7x7 so someone can see it * /
 *		fprintf(stderr, " %g X %g\n", deltx, delty);
 *	}
 */
	if (deltx > maxw) {	/* shrink horizontal */
		ratio = maxw / deltx;
		deltx *= ratio;
		delty *= ratio;
	}
	if (delty > maxh) {	/* shrink vertical */
		ratio = maxh / delty;
		deltx *= ratio;
		delty *= ratio;
	}
	if (ratio != 1) {
		fprintf(stderr, "pic: %g X %g picture shrunk to", odeltx, odelty);
		fprintf(stderr, " %g X %g\n", deltx, delty);
	}
	space(xmin, ymin, xmax, ymax);
	printf("... %g %g %g %g\n", xmin, ymin, xmax, ymax);
	printf("... %.3fi %.3fi %.3fi %.3fi\n",
		xconv(xmin), yconv(ymin), xconv(xmax), yconv(ymax));
	printf(".nr 00 \\n(.u\n");
	printf(".nf\n");
	printf(".PS %.3fi %.3fi %s", yconv(ymin), xconv(xmax), s);
		/* assumes \n comes as part of s */
}

static void
space(double x0, double y0, double x1, double y1)	/* set limits of page */
{
	X0 = x0;
	Y0 = y0;
	X1 = x1;
	Y1 = y1;
	xscale = deltx == 0.0 ? 1.0 : deltx / (X1-X0);
	yscale = delty == 0.0 ? 1.0 : delty / (Y1-Y0);
}

static double
xconv(double x)	/* convert x from external to internal form */
{
	return (x-X0) * xscale;
}

static double
xsc(double x)	/* convert x from external to internal form, scaling only */
{

	return (x) * xscale;
}

static double
yconv(double y)	/* convert y from external to internal form */
{
	return (Y1-y) * yscale;
}

static double
ysc(double y)	/* convert y from external to internal form, scaling only */
{
	return (y) * yscale;
}

void
closepl(int type)	/* clean up after finished */
{
	movehv(0.0, 0.0);	/* get back to where we started */
	if (type == 'F')
		printf(".PF\n");
	else {
		printf(".sp 1+%.3fi\n", yconv(ymin));
		printf(".PE\n");
	}
	printf(".if \\n(00 .fi\n");
}

void
move(double x, double y)	/* go to position x, y in external coords */
{
	hgoto(xconv(x));
	vgoto(yconv(y));
}

static void
movehv(double h, double v)	/* go to internal position h, v */
{
	hgoto(h);
	vgoto(v);
}

#if 0
hmot(double n)	/* generate n units of horizontal motion */
{
	hpos += n;
}

vmot(n)	/* generate n units of vertical motion */
	double n;
{
	vpos += n;
}
#endif

static void
hgoto(double n)
{
	hpos = n;
}

static void
vgoto(double n)
{
	vpos = n;
}

static double
dwb_fabs(double x)
{
	return x < 0 ? -x : x;
}

static void
hvflush(void)	/* get to proper point for output */
{
	if (dwb_fabs(hpos-htrue) >= 0.0005) {
		printf("\\h'%.3fi'", hpos - htrue);
		htrue = hpos;
	}
	if (dwb_fabs(vpos-vtrue) >= 0.0005) {
		printf("\\v'%.3fi'", vpos - vtrue);
		vtrue = vpos;
	}
}

static void
flyback(void)	/* return to upper left corner (entry point) */
{
	printf(".sp -1\n");
	htrue = vtrue = 0;
}

void
printlf(int n, char *f)
{
	if (f)
		printf(".lf %d %s\n", n, f);
	else
		printf(".lf %d\n", n);
}

void
troff(char *s)	/* output troff right here */
{
	printf("%s\n", s);
}

void
label(char *s, int t, int nh)	/* text s of type t nh half-lines up */
{
	int q;
	char *p;

	if (!s)
		return;
	hvflush();
	dprintf("label: %s %o %d\n", s, t, nh);
	printf("%s", textshift);	/* shift down and left */
	if (t & ABOVE)
		nh++;
	else if (t & BELOW)
		nh--;
	if (nh)
		printf("\\v'%du*\\n(.vu/2u'", -nh);
	/* just in case the text contains a quote: */
	q = 0;
	for (p = s; *p; p++)
		if (*p == '\'') {
			q = 1;
			break;
		}
	t &= ~(ABOVE|BELOW);
	if (t & LJUST) {
		printf("%s", s);
	} else if (t & RJUST) {
		if (q)
			printf("\\h\\(ts-\\w\\(ts%s\\(tsu\\(ts%s", s, s);
		else
			printf("\\h'-\\w'%s'u'%s", s, s);
	} else {	/* CENTER */
		if (q)
			printf("\\h\\(ts-\\w\\(ts%s\\(tsu/2u\\(ts%s", s, s);
		else
			printf("\\h'-\\w'%s'u/2u'%s", s, s);
	}
	printf("\n");
	flyback();
}

void
line(double x0, double y0, double x1, double y1)	/* draw line from x0,y0 to x1,y1 */
{
	move(x0, y0);
	cont(x1, y1);
}

void
arrow(double x0, double y0, double x1, double y1, double w, double h, double ang, int nhead) 	/* draw arrow (without shaft) */
	/* double x0, y0, x1, y1, w, h, ang;	/ * head wid w, len h, rotated ang */
	/* int nhead;				/ * and drawn with nhead lines */
{
	double alpha, rot, drot, hyp;
	double dx, dy;
	int i;

	rot = atan2(w / 2, h);
	hyp = sqrt(w/2 * w/2 + h * h);
	alpha = atan2(y1-y0, x1-x0) + ang;
	if (nhead < 2)
		nhead = 2;
	dprintf("rot=%g, hyp=%g, alpha=%g\n", rot, hyp, alpha);
	for (i = nhead-1; i >= 0; i--) {
		drot = 2 * rot / (double) (nhead-1) * (double) i;
		dx = hyp * cos(alpha + PI - rot + drot);
		dy = hyp * sin(alpha + PI - rot + drot);
		dprintf("dx,dy = %g,%g\n", dx, dy);
		line(x1+dx, y1+dy, x1, y1);
	}
}

void
fillstart(double v)	/* this works only for postscript, obviously */
{
	hvflush();
	printf("\\X'BeginObject %g setgray'\n", v);
	flyback();
}

void
fillend(void)
{
	hvflush();
	printf("\\X'EndObject gsave eofill grestore 0 setgray stroke'\n");
	flyback();
}

void
box(double x0, double y0, double x1, double y1)
{
	move(x0, y0);
	cont(x0, y1);
	cont(x1, y1);
	cont(x1, y0);
	cont(x0, y0);
}

static void
cont(double x, double y)	/* continue line from here to x,y */
{
	double h1, v1;
	double dh, dv;

	h1 = xconv(x);
	v1 = yconv(y);
	dh = h1 - hpos;
	dv = v1 - vpos;
	hvflush();
	printf("\\D'l%.3fi %.3fi'\n", dh, dv);
	flyback();	/* expensive */
	hpos = h1;
	vpos = v1;
}

void
circle(double x, double y, double r)
{
	move(x-r, y);
	hvflush();
	printf("\\D'c%.3fi'\n", xsc(2 * r));
	flyback();
}

void
spline(double x, double y, double n, ofloat *p, int dashed, double ddval)
	/* double n;	/ * sic */
{
	int i;
	double dx, dy;
	double xerr, yerr;

	if (dashed && ddval)
		printf(".nr 99 %.3fi\n", ddval);
	move(x, y);
	hvflush();
	xerr = yerr = 0.0;
	if (dashed) {
		if (ddval)
			printf("\\X'Pd \\n(99'\\D'q 0 0");
		else
			printf("\\X'Pd'\\D'q 0 0");
	} else
		printf("\\D'~");
	for (i = 0; i < 2 * n; i += 2) {
		dx = xsc(xerr += p[i]);
		xerr -= dx/xscale;
		dy = ysc(yerr += p[i+1]);
		yerr -= dy/yscale;
		printf(" %.3fi %.3fi", dx, -dy);	/* WATCH SIGN */
	}
	if (dashed)
		printf(" 0 0'\\X'Ps'\n");
	else
		printf("'\n");
	flyback();
}

void
ellipse(double x, double y, double r1, double r2)
{
	double ir1, ir2;

	move(x-r1, y);
	hvflush();
	ir1 = xsc(r1);
	ir2 = ysc(r2);
	printf("\\D'e%.3fi %.3fi'\n", 2 * ir1, 2 * abs(ir2));
	flyback();
}

void
arc(double x, double y, double x0, double y0, double x1, double y1)	/* draw arc with center x,y */
{

	move(x0, y0);
	hvflush();
	printf("\\D'a%.3fi %.3fi %.3fi %.3fi'\n",
		xsc(x-x0), -ysc(y-y0), xsc(x1-x), -ysc(y1-y));	/* WATCH SIGNS */
	flyback();
}

void
dot(void) {
	hvflush();
	/* what character to draw here depends on what's available. */
	/* on the 202, l. is good but small. */
	/* in general, use a smaller, shifted period and hope */

	printf("\\&\\f1\\h'-.1m'\\v'.03m'\\s-3.\\s+3\\fP\n");
	flyback();
}
