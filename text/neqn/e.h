#include <stdio.h>

#define	FATAL	1
#define	ROM	'1'
#define	ITAL	'1'
#define	BLD	'1'

#define	VERT(n)	(20 * (n))
#define	EFFPS(p)	((p) >= 6 ? (p) : 6)

extern int	dbg;
extern int	ct;
extern int	lp[];
extern int	used[];	/* available registers */
extern int	ps;	/* dflt init pt size */
extern int	deltaps;	/* default change in ps */
extern int	gsize;	/* global size */
extern int	gfont;	/* global font */
extern int	ft;	/* dflt font */
extern FILE	*curfile;	/* current input file */
extern int	ifile;	/* input file number */
extern int	linect;	/* line number in current file */
extern int	eqline;	/* line where eqn started */
extern int	svargc;
extern char	**svargv;
extern int	eht[];
extern int	ebase[];
extern int	lfont[];
extern int	rfont[];
extern int	eqnreg, eqnht;
extern int	lefteq, righteq;
extern int	lastchar;	/* last character read by lex */
extern int	markline;	/* 1 if this EQ/EN contains mark or lineup */

typedef struct s_tbl {
	char	*name;
	char	*defn;
	struct s_tbl *next;
} tbl;
tbl *lookup(tbl **tblp, char *name, char *defn);	/* find name in tbl. if defn non-null, install */
int dwb_sqrt(int);
void error(int, const char *, ...);
int text(int, char *);
void name4(int, int);
void roman(int);
void shim(void);
int oalloc(void);
int trans(int, char *);
void nrwid(int, int, int);
int globsize(void);
int size(int, int);
void setsize(char *);
void setps(int);
void init(void);
void getstr(char *, int);
int shift2(int, int, int);
int shift(int);
int bshiftb(int, int, int);
void ofree(int);
int max(int, int);
int lpile(int, int, int);
void brack(int, char *, char *, char *);
int paren(int, int, int);
int boverb(int, int);
int move(int, int, int);
void column(int, int);
int matrix(int);
int mark(int);
int lineup(int);
void init_tbl(void);
int gtc(void);
void pbstr(char *);
int cstr(char *, int, int);
void define(int);
char *strsave(char *);
void include(void);
int delim(void);
int globfont(void);
int yylex(void);
void yyerror(char *);
void setfile(int, char **);
void putout(int);
int eqn(int, char **);
int setintegral(void);
int integral(int, int, int);
int funny(int);
int fromto(int, int, int);
int setfont(char);
int font(int, int);
int fatbox(int);
int eqnbox(int, int, int);
void diacrit(int, int);
