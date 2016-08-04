#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "ps_include.h"

#define has(word)	(strncmp(buf, word, strlen(word)) == 0)
#define grab(n)		((Section *)(nglobal \
			? realloc((char *)global, n*sizeof(Section)) \
			: calloc(n, sizeof(Section))))

char	buf[512];
typedef struct {long start, end;} Section;
static void print(FILE *, char **);
static void copy(FILE *fin, FILE *fout, Section *s);

static char *PS_head[] = {
	"%ps_include: begin",
	"save",
	"/ed {exch def} def",
	"{} /showpage ed",
	"{} /copypage ed",
	"{} /erasepage ed",
	"{} /letter ed",
	"currentdict /findfont known systemdict /findfont known and {",
	"	/findfont systemdict /findfont get def",
	"} if",
	"36 dict dup /PS-include-dict-dw ed begin",
	"/context ed",
	"count array astore /o-stack ed",
	"%ps_include: variables begin",
	0
};

static char *PS_setup[] = {
	"%ps_include: variables end",
	"{llx lly urx ury} /bbox ed",
	"{newpath 2 index exch 2 index exch dup 6 index exch",
	" moveto 3 {lineto} repeat closepath} /boxpath ed",
	"{dup mul exch dup mul add sqrt} /len ed",
	"{2 copy gt {exch} if pop} /min ed",
	"{2 copy lt {exch} if pop} /max ed",
	"{transform round exch round exch A itransform} /nice ed",
	"{6 array} /n ed",
	"n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed",
	"urx llx sub 0 A dtransform len /Sx ed",
	"0 ury lly sub A dtransform len /Sy ed",
	"llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed",
	"rot dup sin abs /S ed cos abs /C ed",
	"Sx S mul Sy C mul add /H ed",
	"Sx C mul Sy S mul add /W ed",
	"sy H div /Scaley ed",
	"sx W div /Scalex ed",
	"s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if",
	"sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed",
	"sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed",
	"urx llx sub 0 A dtransform exch atan rot exch sub /rot ed",
	"n currentmatrix initgraphics setmatrix",
	"cx cy translate",
	"Scalex Scaley scale",
	"rot rotate",
	"Cx neg Cy neg translate",
	"A concat",
	"bbox boxpath clip newpath",
	"w 0 ne {gsave bbox boxpath 1 setgray fill grestore} if",
	"end",
	"gsave",
	"%ps_include: inclusion begin",
	0
};

static char *PS_tail[] = {
	"%ps_include: inclusion end",
	"grestore",
	"PS-include-dict-dw begin",
	"o 0 ne {gsave A defaultmatrix /A ed llx lly nice urx ury nice",
	"	initgraphics 0.1 setlinewidth boxpath stroke grestore} if",
	"clear o-stack aload pop",
	"context end restore",
	"%ps_include: end",
	0
};

void
ps_include(FILE *fin, FILE *fout, int page_no, int whiteout, int outline,
    int scaleboth, double cx, double cy, double sx, double sy, double ax,
    double ay, double rot)


    /* FILE	*fin, *fout;		/ * input and output files */
    /* int		page_no;		/ * physical page number from *fin */
    /* int		whiteout;		/ * erase picture area */
    /* int		outline;		/ * draw a box around it and */
    /* int		scaleboth;		/ * scale both dimensions - if not zero */
    /* double	cx, cy;			/ * center of the picture and */
    /* double	sx, sy;			/ * its size - in current coordinates */
    /* double	ax, ay;			/ * left-right, up-down adjustment */
    /* double	rot;			/ * rotation - in clockwise degrees */


{


    int		foundpage = 0;		/* found the page when non zero */
    int		foundpbox = 0;		/* found the page bounding box */
    int		nglobal = 0;		/* number of global defs so far */
    int		maxglobal = 0;		/* and the number we've got room for */
    Section	prolog, page, trailer;	/* prologue, page, and trailer offsets */
    Section	*global;		/* offsets for all global definitions */
    double	llx, lly;		/* lower left and */
    double	urx, ury;		/* upper right corners - default coords */
    double	w = whiteout != 0;	/* mostly for the var() macro */
    double	o = outline != 0;
    double	s = scaleboth != 0;
    int		i;			/* loop index */


/*
 *
 * Reads a PostScript file (*fin), and uses structuring comments to locate the
 * prologue, trailer, global definitions, and the requested page. After the whole
 * file is scanned, the  special ps_include PostScript definitions are copied to
 * *fout, followed by the prologue, global definitions, the requested page, and
 * the trailer. Before returning the initial environment (saved in PS_head) is
 * restored.
 *
 * By default we assume the picture is 8.5 by 11 inches, but the BoundingBox
 * comment, if found, takes precedence.
 *
 */


	llx = lly = 0;			/* default BoundingBox - 8.5x11 inches */
	urx = 72 * 8.5;
	ury = 72 * 11.0;

	/* section boundaries and bounding box */

	prolog.start = prolog.end = 0;
	page.start = page.end = 0;
	trailer.start = 0;
	fseek(fin, 0L, 0);

	while ( fgets(buf, sizeof(buf), fin) != NULL )
		if (!has("%%"))
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
			if (i == page_no) {
				foundpbox = 1;
				sscanf(buf, "%*s %lf %lf %lf %lf",
						&llx, &lly, &urx, &ury);
			}
		} else if (has("%%BoundingBox: ")) {
			if (!foundpbox)
				sscanf(buf,"%*s %lf %lf %lf %lf",
						&llx, &lly, &urx, &ury);
		} else if (has("%%EndProlog") || has("%%EndSetup") || has("%%EndDocumentSetup"))
			prolog.end = page.start = ftell(fin);
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

	fseek(fin, 0L, 2);
	if (trailer.start == 0)
		trailer.start = ftell(fin);
	trailer.end = ftell(fin);

	if (page.end <= page.start)
		page.end = trailer.start;

/*
fprintf(stderr, "prolog=(%d,%d)\n", prolog.start, prolog.end);
fprintf(stderr, "page=(%d,%d)\n", page.start, page.end);
for(i = 0; i < nglobal; i++)
	fprintf(stderr, "global[%d]=(%d,%d)\n", i, global[i].start, global[i].end);
fprintf(stderr, "trailer=(%d,%d)\n", trailer.start, trailer.end);
*/

	/* all output here */
	print(fout, PS_head);
/*
 * Unix 4.0 didn't like the var macro.
 *
	var(llx); var(lly); var(urx); var(ury); var(w); var(o); var(s);
	var(cx); var(cy); var(sx); var(sy); var(ax); var(ay); var(rot);
 *
 */

	fprintf(fout, "/llx %g def\n", llx);
	fprintf(fout, "/lly %g def\n", lly);
	fprintf(fout, "/urx %g def\n", urx);
	fprintf(fout, "/ury %g def\n", ury);
	fprintf(fout, "/w %g def\n", w);
	fprintf(fout, "/o %g def\n", o);
	fprintf(fout, "/s %g def\n", s);
	fprintf(fout, "/cx %g def\n", cx);
	fprintf(fout, "/cy %g def\n", cy);
	fprintf(fout, "/sx %g def\n", sx);
	fprintf(fout, "/sy %g def\n", sy);
	fprintf(fout, "/ax %g def\n", ax);
	fprintf(fout, "/ay %g def\n", ay);
	fprintf(fout, "/rot %g def\n", rot);

	print(fout, PS_setup);
	copy(fin, fout, &prolog);
	for(i = 0; i < nglobal; i++)
		copy(fin, fout, &global[i]);
	copy(fin, fout, &page);
	copy(fin, fout, &trailer);
	print(fout, PS_tail);

	if(nglobal)
		free(global);

}

static void
print(FILE *fout, char **s)
{
	while (*s)
		fprintf(fout, "%s\n", *s++);
}

static void
copy(FILE *fin, FILE *fout, Section *s)
{
	if (s->end <= s->start)
		return;
	fseek(fin, s->start, 0);
	while (ftell(fin) < s->end && fgets(buf, sizeof(buf), fin) != NULL)
		if (buf[0] != '%')
			fprintf(fout, "%s", buf);
}

