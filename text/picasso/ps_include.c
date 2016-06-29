/*	Copyright (c) 1989 AT&T	*/
/*	  All Rights Reserved  	*/

/*	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T	*/
/*	The copyright notice above does not evidence any   	*/
/*	actual or intended publication of such source code.	*/

/*	@(#)picasso:ps_include.c	1.0	*/

/*
 *
 * Picture inclusion code for PostScript printers, taken from Rich Drechsler
 *
 */

#include <string.h>
#include "picasso.h"
#include "xform.h"
#include "misc.h"

/* in SVR4, the C-preprocessor will not accept the tricky definitions of lq
   and rq.  However, we should be able to do it using the following

   define var(x) 	fprintf(fout, "/%s %g def\n", #x, x)
 */
/*#define lq(x)		"x
#define rq(x)		x"
#define quote(x)	rq(lq(x))
#define var(x)		fprintf(fout, "/%s %g def\n", quote(x), x)*/
#define has(word)	(strncmp(buf, word, strlen(word)) == 0)
#define grab(n)		((Section *)(nglobal \
			? realloc((char *)global, n*sizeof(Section)) \
			: calloc(n, sizeof(Section))))

typedef struct { long start, end; } Section;

static void ps_include(FILE *, FILE *, int, double, double, double, double,
    double, double);
static void ps_print(FILE *, char **);
static void ps_copy(FILE *, FILE *, Section *);

char	buf[512];

static char *PS_head[] = {
	"%ps_include: begin",
	"save",
	"/ed {exch def} def",
	"{} /showpage ed",
	"{} /copypage ed",
	"{} /erasepage ed",
	"{} /letter ed",
	"36 dict dup /PS-include-dict-dw ed begin",
	"/context ed",
	"count array astore /o-stack ed",
	"%ps_include: variables begin",
	0
};

static char *PS_setup[] = {
	"%ps_include: variables end",
	"{dup mul exch dup mul add sqrt} /len ed",
	"{2 copy gt {exch} if pop} /min ed",
	"{2 copy lt {exch} if pop} /max ed",
	"{6 array} /n ed",
	"n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed",
	"urx llx sub 0 A dtransform len /Sx ed",
	"0 ury lly sub A dtransform len /Sy ed",
	"llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed",
/*	"rot dup sin abs /S ed cos abs /C ed",
 *	"Sx S mul Sy C mul add /H ed",
 *	"Sx C mul Sy S mul add /W ed",
 *	"sy H div /Scaley ed",
 *	"sx W div /Scalex ed",
 *	"s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if",
 *	"sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed",
 *	"sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed",
 *	"urx llx sub 0 A dtransform exch atan rot exch sub /rot ed",
 *	"n currentmatrix initgraphics setmatrix",
 */	"sx Sx div /Scalex ed",
	"sy Sy div /Scaley ed",
	"cx cy translate",
	"Scalex Scaley scale",
/*	"rot rotate",
*/	"Cx neg Cy neg translate",
	"A concat",
	"newpath",
	"end",
	"%ps_include: inclusion begin",
	0
};

static char *PS_tail[] = {
	"%ps_include: inclusion end",
	"PS-include-dict-dw begin",
	"clear o-stack aload pop",
	"context end restore",
	"%ps_include: end",
	0
};

static char *Pic_setup[] = {
	"%ps_include: variables end",
	"{dup mul exch dup mul add sqrt} /len ed",
	"{2 copy gt {exch} if pop} /min ed",
	"{2 copy lt {exch} if pop} /max ed",
	"{6 array} /n ed",
	"n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed",
	"urx llx sub 0 A dtransform len /Sx ed",
	"0 ury lly sub A dtransform len /Sy ed",
	"llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed",
/*	"rot dup sin abs /S ed cos abs /C ed",
 *	"Sx S mul Sy C mul add /H ed",
 *	"Sx C mul Sy S mul add /W ed",
 *	"sy H div /Scaley ed",
 *	"sx W div /Scalex ed",
 *	"s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if",
 *	"sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed",
 *	"sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed",
 *	"urx llx sub 0 A dtransform exch atan rot exch sub /rot ed",
 *	"n currentmatrix initgraphics setmatrix",
 */	"sx Sx div /Scalex ed",
	"sy Sy div /Scaley ed",
	"BoB concat",
	"cx cy translate",
	"newpath sx 2 div sy 2 div moveto sx neg 0 rlineto",
	"0 sy neg rlineto sx 0 rlineto closepath clip",
	"Scalex Scaley scale",
/*	"rot rotate",
*/	"Cx neg Cy neg translate",
	"A concat",
	"newpath",
	"end",
	"%ps_include: inclusion begin",
	0
};

static void
ps_print(FILE *fout, char **s) {
	while (*s)
		fprintf(fout, "%s\n", *s++);
}

static void
ps_copy(FILE *fin, FILE *fout, Section *s)
{
	if (s->end <= s->start)
		return;
	fseek(fin, s->start, 0);
	while (ftell(fin) < s->end && fgets(buf, sizeof(buf), fin) != NULL)
		if (buf[0] != '%')
			fprintf(fout, "%s", buf);
}

void
puteqn(double x, double y, int type, int neqn) {
	extern	FILE	*eqnfp;
	extern	float	eqn_move;
	double	ax, ay;

	ax = 0;
	ay = 0;
	if (type & (LJUST|RJUST|ABOVE|BELOW)) {
		/* modify ax,ay if text_bounds can get the bounding box */
	}
	if (eqnfp != NULL)
	ps_include(eqnfp, outfp, neqn, x, y + eqn_move, 0., 0., ax, ay/*,0.*/);
}

static void
ps_include(FILE *fin, FILE *fout, int page_no, double cx, double cy, double sx,
    double sy, double ax, double ay /*, rot */)

/*	FILE	*fin, *fout;		input and output files */
/*	int	page_no;		physical page number from *fin */
/*	double	cx, cy;			center of the picture and */
/*	double	sx, sy;			its size - in current coordinates */
/*	double	ax, ay;			left-right, up-down adjustment */
/*	double	rot;			rotation - in clockwise degrees */
{
	int	foundpage = 0;		/* found the page when non zero */
	int	foundpbox = 0;		/* found the page bounding box  */
	int	nglobal   = 0;		/* number of global defs so far */
	int	maxglobal = 0;		/* and the number we've got room for */
	Section	prolog, setup,		/* major divisions in document	*/
		page, trailer;
	Section	*global;		/* offsets for all global definitions */
	double	llx, lly;		/* lower left and upper right corners */
	double	urx, ury;		/* (default -- printer pt -- coords)  */
	int	i = 0;			/* found page number */
/*
 *
 * Reads a PostScript file (*fin), and uses structuring comments to locate the
 * prologue, trailer, global definitions, and the requested page.  After the
 * file is scanned, the  special ps_include PostScript definitions are copied to
 * *fout, followed by the prologue, global definitions, the requested page, and
 * the trailer. Before returning the initial environment (saved in PS_head) is
 * restored.
 *
 * By default we assume the picture is 8.5 by 11 inches, but the BoundingBox
 * comment, if found, takes precedence.
 *
 */

	llx = lly = 0;		/* default BoundingBox - 8.5x11 inches */
	urx = 72 * 8.5;
	ury = 72 * 11.0;

	/* section boundaries and bounding box */

	prolog.start = prolog.end = 0;
	setup.start  = setup.end  = 0;
	page.start   = page.end   = 0;
	trailer.start = 0;
	fseek(fin, 0L, 0);

	while ( fgets(buf, sizeof(buf), fin) != NULL ) {
		if (!has("%%"))
			continue;
		else if (has("%%PageBoundingBox: (atend)")
		     ||  has("%%BoundingBox: (atend)"))
			continue;
		else if (has("%%Page: ")) {
			if (!foundpage)
				page.start = ftell(fin);
			sscanf(buf, "%*s %*s %d", &i);
			if (i == page_no)
				foundpage = 1;
			else if (foundpage && page.end <= page.start)
				page.end = ftell(fin);
		} else if (has("%%EndPage: ")) {
			sscanf(buf, "%*s %*s %d", &i);
			if (i == page_no) {
				foundpage = 1;
				page.end = ftell(fin);
			}
			if (!foundpage)
				page.start = ftell(fin);
		} else if (has("%%PageBoundingBox:")) {
			if (i > page_no && !foundpbox) {
				foundpbox = 1;
				llx = lly = urx = ury = 0;
			} else if (i == page_no) {
			    sscanf(buf, "%%%%PageBoundingBox:%lf %lf %lf %lf",
						&llx, &lly, &urx, &ury);
				foundpbox = 1;
			}
		} else if (has("%%BoundingBox:")) {
			if (!foundpbox)
				sscanf(buf,"%%%%BoundingBox:%lf %lf %lf %lf",
						&llx, &lly, &urx, &ury);
		} else if (has("%%EndProlog"))
			prolog.end = setup.start = page.start = ftell(fin);
		else if (has("%%BeginSetup")
		     ||  has("%%BeginDocumentSetup")) {

			if (!setup.start) setup.start = ftell(fin);
		} else if (has("%%EndSetup")
		       ||  has("%%EndDocumentSetup"))
			setup.end = page.start = ftell(fin);
		else if (has("%%Trailer"))
			trailer.start = ftell(fin);
		else if (has("%%BeginGlobal")) {
			if (page.end <= page.start) {
				if (nglobal >= maxglobal) {
					maxglobal += 20;
					global = grab(maxglobal);
				}
				global[nglobal].start = ftell(fin);
			}
		} else if (has("%%EndGlobal"))
			if (page.end <= page.start)
				global[nglobal++].end = ftell(fin);
	}
	if (urx == llx && ury == lly)
		return;
	fseek(fin, 0L, 2);
	if (trailer.start == 0)
		trailer.start = ftell(fin);
	trailer.end = ftell(fin);

	if (page.end <= page.start)
		page.end = trailer.start;

	ps_print(fout, PS_head);
	if (sx == 0)
		sx = (urx-llx)/pgscale;
	if (sy == 0)
		sy = (ury-lly)/pgscale;
	track_bounds(cx-sx/2, cy-sy/2, cx+sy/2, cy+sy/2);

	fprintf(fout, "/llx %g def\n", llx);
	fprintf(fout, "/lly %g def\n", lly);
	fprintf(fout, "/urx %g def\n", urx);
	fprintf(fout, "/ury %g def\n", ury);
	fprintf(fout, "/cx %g def\n", cx);
	fprintf(fout, "/cy %g def\n", cy);
	fprintf(fout, "/sx %g def\n", sx);
	fprintf(fout, "/sy %g def\n", sy);
	fprintf(fout, "/ax %g def\n", ax);
	fprintf(fout, "/ay %g def\n", ay);

	ps_print(fout, PS_setup);
	ps_copy(fin, fout, &prolog);
	fprintf(fout,"/useclippath false def\n");
	ps_copy(fin, fout, &setup);
	for(i = 0; i < nglobal; i++)
		ps_copy(fin, fout, &global[i]);
	ps_copy(fin, fout, &page);
	ps_copy(fin, fout, &trailer);
	ps_print(fout, PS_tail);
	if(nglobal)
		free(global);
}

void
pic_include(FILE *fin, FILE *fout, int page_no, obj *o)
/*	FILE	*fin, *fout;		input and output files */
/*	int	page_no;		physical page number from *fin */
/*	obj	*o;			has bounds and transformation */
{
	extern	double	T[6];
	int	foundpage = 0;		/* found the page when non zero */
	int	foundpbox = 0;		/* found the page bounding box  */
	int	nglobal   = 0;		/* number of global defs so far */
	int	maxglobal = 0;		/* and the number we've got room for */
	Section	prolog, setup,		/* major divisions in document	*/
		page, trailer;
	Section	*global;		/* offsets for all global definitions */
	double	cx, cy;
	double  sx, sy;
	double	llx, lly;		/* lower left and upper right corners */
	double	urx, ury;		/* (default -- printer pt -- coords)  */
	int	i = 0;			/* found page number */
/*
 *
 * Reads a PostScript file (*fin), and uses structuring comments to locate the
 * prologue, trailer, global definitions, and the requested page.  After the
 * file is scanned, the  special ps_include PostScript definitions are copied to
 * *fout, followed by the prologue, global definitions, the requested page, and
 * the trailer. Before returning the initial environment (saved in PS_head) is
 * restored.
 *
 * By default we assume the picture is 8.5 by 11 inches, but the BoundingBox
 * comment, if found, takes precedence.
 *
 */

	llx = lly = 0;		/* default BoundingBox - 8.5x11 inches */
	urx = 72 * 8.5;
	ury = 72 * 11.0;
	cx = o->o_x;
	cy = o->o_y;
	sx = o->o_wid;
	sy = o->o_ht;

	/* section boundaries and bounding box */

	prolog.start = prolog.end = 0;
	setup.start  = setup.end  = 0;
	page.start   = page.end   = 0;
	trailer.start = 0;
	fseek(fin, 0L, 0);

	while ( fgets(buf, sizeof(buf), fin) != NULL ) {
		if (!has("%%"))
			continue;
		else if (has("%%PageBoundingBox: (atend)")
		     ||  has("%%BoundingBox: (atend)"))
			continue;
		else if (has("%%Page: ")) {
			if (!foundpage)
				page.start = ftell(fin);
			sscanf(buf, "%*s %*s %d", &i);
			if (i == page_no)
				foundpage = 1;
			else if (foundpage && page.end <= page.start)
				page.end = ftell(fin);
		} else if (has("%%EndPage: ")) {
			sscanf(buf, "%*s %*s %d", &i);
			if (i == page_no) {
				foundpage = 1;
				page.end = ftell(fin);
			}
			if (!foundpage)
				page.start = ftell(fin);
		} else if (has("%%PageBoundingBox: ")) {
			if (i > page_no && !foundpbox) {
				foundpbox = 1;
				llx = lly = urx = ury = 0;
			} else if (i == page_no) {
				sscanf(buf, "%*s %lf %lf %lf %lf",
						&llx, &lly, &urx, &ury);
				foundpbox = 1;
			}
		} else if (has("%%BoundingBox: ")) {
			if (!foundpbox)
				sscanf(buf,"%*s %lf %lf %lf %lf",
						&llx, &lly, &urx, &ury);
		} else if (has("%%EndProlog"))
			prolog.end = setup.start = page.start = ftell(fin);
		else if (has("%%BeginSetup")
		     ||  has("%%BeginDocumentSetup")) {

			if (!setup.start) setup.start = ftell(fin);
		} else if (has("%%EndSetup")
		       ||  has("%%EndDocumentSetup"))
			setup.end = page.start = ftell(fin);
		else if (has("%%Trailer"))
			trailer.start = ftell(fin);
		else if (has("%%BeginGlobal")) {
			if (page.end <= page.start) {
				if (nglobal >= maxglobal) {
					maxglobal += 20;
					global = grab(maxglobal);
				}
				global[nglobal].start = ftell(fin);
			}
		} else if (has("%%EndGlobal"))
			if (page.end <= page.start)
				global[nglobal++].end = ftell(fin);
	}
	if (urx == llx && ury == lly)
		return;
	fseek(fin, 0L, 2);
	if (trailer.start == 0)
		trailer.start = ftell(fin);
	trailer.end = ftell(fin);

	if (page.end <= page.start)
		page.end = trailer.start;

	ps_print(fout, PS_head);
	if (sx == 0)
		sx = (urx-llx)/pgscale;
	if (sy == 0)
		sy = (ury-lly)/pgscale;
	track_bounds(cx-sx/2, cy-sy/2, cx+sy/2, cy+sy/2);

	fprintf(fout, "/llx %g def\n", llx);
	fprintf(fout, "/lly %g def\n", lly);
	fprintf(fout, "/urx %g def\n", urx);
	fprintf(fout, "/ury %g def\n", ury);
	fprintf(fout, "/cx %g def\n", cx);
	fprintf(fout, "/cy %g def\n", cy);
	fprintf(fout, "/sx %g def\n", sx);
	fprintf(fout, "/sy %g def\n", sy);

	compose(o);
	fprintf(fout, "/BoB [ %g %g %g %g %g %g ] def\n", T[0], T[1], T[2],
							T[3], T[4], T[5]);
	ps_print(fout, Pic_setup);
	ps_copy(fin, fout, &prolog);
	fprintf(fout,"/useclippath false def\n");
	ps_copy(fin, fout, &setup);
	for(i = 0; i < nglobal; i++)
		ps_copy(fin, fout, &global[i]);
	ps_copy(fin, fout, &page);
	ps_copy(fin, fout, &trailer);
	ps_print(fout, PS_tail);
	if(nglobal)
		free(global);
}
