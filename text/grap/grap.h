#include <stdlib.h>
extern	char	errbuf[200];
#define	ERROR	sprintf(errbuf,
#define	FATAL	), yyerror(errbuf), exit(1)
#define	WARNING	), yyerror(errbuf)

#define	dprintf	if(dbg)printf

#define	String	01
#define	Macro	02
#define	File	04
#define	Char	010
#define	Thru	020
#define	Free	040

#define	MARGIN	0.07	/* default margin around data */
#define	SLOP	1.001	/* slop for limits of for loops */
#define	FRAMEWID 3	/* default width for boxes and ellipses */
#define	FRAMEHT	2	/* default height and line length */
#define	TICKLEN	0.1

#define	MAXNUM	200

#define	XFLAG	01
#define	YFLAG	02

#define	INTICK	01
#define	OUTICK	02

#define	BOT	01
#define	TOP	02
#define	RIGHT	04
#define	LEFT	010

#define	RJUST	01
#define	LJUST	02
#define	ABOVE	04
#define	BELOW	010

typedef struct infile {
	FILE	*fin;
	char	*fname;
	int	lineno;
} Infile;

typedef struct {	/* input source */
	int	type;	/* Macro, String, File */
	char	*sp;	/* if String or Macro */
} Src;

extern	Src	src[], *srcp;	/* input source stack */

#define	MAXARGS	100
typedef struct {	/* argument stack */
	char	*argstk[MAXARGS];	/* pointers to args */
	char	*argval;	/* points to space containing args */
} Arg;

extern	Infile	infile[10];
extern	Infile	*curfile;

typedef struct {
	struct obj *obj;
	double	x, y;
} Point;

typedef struct attr {	/* e.g., DASH 1.1 or "..." rjust size *.5 */
	short	type;
	double	fval;
	char	*sval;
	short	just;	/* justification, for STRING type */
	short	op;	/* optional operator, ditto */
	struct attr *next;
} Attr;

typedef struct obj {	/* a name and its properties */
	char	*name;
	char	*val;	/* body of define, etc. */
	double	fval;	/* if a numeric variable */
	Point	pt;	/* usually for max and min */
	Point	pt1;
	short	type;	/* NAME, DEFNAME, ... */
	short	first;	/* 1 after 1st item seen */
	short	coord;	/* 1 if coord system specified for this name */
	short	log;	/* x, y, or z (= x+y) */
	Attr	*attr;	/* DASH, etc., for now */
	struct obj *next;
} Obj;

typedef union {		/* the yacc stack type */
	int	i;
	char	*p;
	double	f;
	Point	pt;
	Obj	*op;
	Attr	*ap;
} YYSTYPE;

extern	YYSTYPE	yylval, yyval;

extern	int	dbg;

extern	int	ntext;
extern	double	num[MAXNUM];
extern	int	nnum;
extern	int	ntick, tside;

extern	Obj	*objlist;

extern	int	lineno;
extern	int	synerr;
extern	int	codegen;
extern	char	tempfile[];
extern	FILE	*tfd;

extern	Point	ptmin, ptmax;

extern	char	*dflt_coord;
extern	char	*curr_coord;
extern	int	ncoord;
extern	int	auto_x;
extern	double	margin;
extern	int	autoticks;
extern	int	pointsize, ps_set;

extern	double	log10(), log(), exp(), sin(), cos(), sqrt(), atof();
extern	double	fabs(), floor(), ceil(), moddouble();
char *tostring(register char *s);
Obj *lookup(char *s, int inst);	/* find s in objlist, install if inst */
char *delimstr(char *s);	/* get body of X ... X */
Obj *copythru(char *s);	/* collect the macro name or body for thru */
char *sizeit(Attr *ap);		/* add \s..\s to ap->sval */
Attr *makeattr(int type, double fval, char *sval, int just, int op);
char *slprint(Attr *stringlist);	/* print strings from stringlist */
char *desc_str(Attr *a);	/* convert DOT to "dotted", etc. */
Attr *makesattr(char *s);		/* make an Attr cell containing s */
char *xyname(Point pt);	/* generate xy name macro for point p */
double setvar(Obj *p, double f);	/* set value of variable to f */
double getvar(Obj *p);	/* return value of variable */
char *grow(char *ptr, char *name, int num, int size);	/* make array bigger */
double errcheck(double x, char *s);
Point makepoint(Obj *s, double x, double y);	/* make a Point */
char *ifstat(double expr, char *thenpart, char *elsepart);
Attr *addattr(Attr *a1, Attr *ap);	/* add attr ap to end of list a1 */
Attr *makefattr(int type, double fval);	/* set double in attribute */
char *sprntf(char *s, Attr *ap);	/* sprintf(s, attrlist ap) */
void yyerror(char *s);
int dwb_input(void);
int dwb_unput(int c);
void savenum(int, double);
void setjust(int);
void setsize(int, double);
void range(Point);
void halfrange(Obj *, int, double);
void freeattr(Attr *);
void pushsrc(int, char *);
void definition(char *);
void dodef(Obj *);
void pbstr(char *);
void copyfile(char *);
void copydef(Obj *);
void copyuntil(char *);
void copy(void);
void shell_init(void);
void shell_text(char *);
void shell_exec(void);
void forloop(Obj *, double, double, int, double, char *);
void endfor(void);
void labelwid(double);
void labelmove(int, double);
void label(int, Attr *);
void lab_adjust(void);
void line(int, Point, Point, Attr *);
void circle(double, Point);
void pic(char *);
void numlist(void);
void plot(Attr *, Point);
void plotnum(double, char *, Point);
void drawdesc(int, Obj *, Attr *, char *);
void next(Obj *, Point, Attr *);
void savetick(double, char *);
void tickside(int);
void tickoff(int);
void gridtickoff(void);
void setlist(void);
void tickdir(int, double, int);
void ticks(void);
void do_autoticks(Obj *);
Obj *setauto(void);
void iterator(double, double, int, double, char *);
void ticklist(Obj *, int);
void griddesc(Attr *);
void gridlist(Obj *);
void coord_x(Point);
void coord_y(Point);
void coordlog(int);
void coord(Obj *);
void resetcoord(Obj *);
void frame(void);
void frameht(double);
void framewid(double);
void frameside(int, Attr *);
void endstat(void);
void graph(char *);
void setup(void);

#define	logit(x) (x) = log10(x)
#define	Log10(x) errcheck(log10(x), "log")
#define	Exp(x)	errcheck(exp(x), "exp")
#define	Sqrt(x)	errcheck(sqrt(x), "sqrt")

#define	min(x,y)	(((x) <= (y)) ? (x) : (y))
#define	max(x,y)	(((x) >= (y)) ? (x) : (y))
