/*	Copyright (c) 1992 AT&T	*/
/*	  All Rights Reserved  	*/

/*	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T	*/
/*	The copyright notice above does not evidence any   	*/
/*	actual or intended publication of such source code.	*/

/* tbl.c */

#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <signal.h>
#include <string.h>

#define	MAX_INPUT_CHARS 1024 /* Maximum length of an input line */
#define	MAXLIN	   250	/* Maximum number of data lines given full treatment */
#define	MAXHEAD	    44	/* Maximum number of format rows */
#define	MAXCOL	    36	/* Maximum number of columns (see warning) */
/* Warning:  Do not make MAXCOL bigger without adjusting nregs[]! */
#define	MAXCHS	  2000	/* Chunk size for getting more string storage */
#define	MAX_FILES   10	/* Maximum depth of nested file references */
#define	CLLEN	    10	/* Maximum length of a column-width modifier */
#define	SHORTLINE    4	/* Not used */
#define	MAX_ERR1   100	/* Maximum number of errors per invocation */
#define	MAX_ERR2    10	/* Maximum number of errors per table */

/* Used to calculate offsets into nregs[] */
#define	CLEFT	0	/* Left edge of specified column */
#define	CMID	1	/* Midpoint of specified column */
#define	CRIGHT	2	/* Right edge of specified column */
/* Note: reg(icol,CRIGHT) is meaningful only if the column is 'a' or 'n' type*/

/* troff number registers */
#define	S1	31
#define	S2	32
#define	LSIZE	33	/* Holds point size for lines and rules */
#define	SL	34	/* Used to save current line length */
#define	SVS	36	/* Used to save current vertical line spacing */
#define	SIND	37	/* Used to save current indentation */
#define	TMP	38
#define	S9	39	/* Scratch */

/* troff macro names */
#define	SF	35	/* Used to restore context saved at table start. */

/* This refers to the relative position of lines */
#define	LEFT	1
#define	RIGHT	2
#define	THRU	3
#define	TOP	1
#define	BOTTOM	2

/* Flag bits for the 'flags' array */
#define	ZEROW	001	/* Zero-width entry */
#define	HALFUP	002	/* Move this entry up one-half line */
#define	CTOP	004	/* Put this entry at the top of its range */
#define	CDOWN	010	/* Put this entry at the bottom of its range */

/* Macros for accessing data structures */
#define TABLE(i,c) (table[(i)])[(c)]
#define	FLGS(i,c) (flags[c][stynum[i]])
#define	FN(i,c)   (font[c][stynum[i]])
#define	SZ(i,c)   (csize[c][stynum[i]])
#define	VS(i,c)   (vsize[c][stynum[i]])

/* General-purpose macros */
#define	max(a,b) ((a)>(b) ? (a) : (b))
#define	min(a,b) ((a)<(b) ? (a) : (b))
#define	streql(s,t) (strcmp((char *)(s),(char *)(t)) == 0)

/* Error-message macros */
#define	error(s) {error1(s);return 1;}
#define	error2(fmt,a) {sprintf(errbuf,(char *)(fmt),(a));error(errbuf);}

/* Warning-message macros */
#define	warning(s) {warning1(s);}
#define	warning2(fmt,a) {sprintf(errbuf,(char *)(fmt),(a));warning1(errbuf);}

/* The following macros insert a troff comment into the output of tbl */
/* (used for debugging). */
#define comment(X) {comment1((char *)(X));}
#define comment2(X,Y) {sprintf(errbuf,(char *)(X),(Y));comment1(errbuf);}

/* The following macros insert text into the output stream of tbl */
/* while printing an additional copy on stderr.  (used for debugging). */
#define output(X) {sprintf(errbuf,(char *)(X));output1(errbuf);}
#define output2(X,Y) {sprintf(errbuf,(char *)(X),(Y));output1(errbuf);}
#define output3(X,Y,Z) {sprintf(errbuf,(char *)(X),(Y),(Z));output1(errbuf);}

struct colstr /* Holds pointers to character data for one table entry */
{
	char *col, *rcol;
};

extern char *chspace(), *gets1(), *maknew(), *reg(), *strsave();

struct colstr *alocv();
long int dwb_gettext(char **sp, int ilin, int icol); /* Read in a text block */
int dwb_getline(char *s, int nmax);

int Vopt = 0;
int Hflag = 0;		/* Set iff first argument to .TS is "H" */
int in_header1 = 0;	/* Set iff within table header */
int in_header2 = 0;	/* Set iff within table header */
int have_header = 0;	/* Set iff this table has a table header */
int Ropt = 0;		/* Controls undocumented compatibility mode */
int Xcol = -1;		/* Index of first column with 'x' modifier */
int Maxlin = MAXLIN;	/* Maximum number of lines given full treatment */
int errterm = 1;	/* Controls error recovery */
int errcnt1 = 0;	/* Number of errors on this execution */
int errcnt2;		/* Number of errors in current table */
int expflg;		/* Expand the table to fill the current line length */
int ctrflg;		/* Center the table horizontally */
int boxflg;		/* Enclose the table in a box */
int dboxflg;		/* Enclose the table in a double box */
int allflg;		/* Enclose each entry of the table in a box */
int tab;		/* Column separator for data lines */
int linsize;		/* Point size for lines and rules */
int pr1403 = 0;		/* Use full-line vertical motions only */
int F1;			/* troff field delimiter */
int F2;			/* troff pad character */
int delim1, delim2;	/* Delimiters for in-line equations */
int nclin;		/* Number of lines in the format array */
int nlin;		/* Number of lines in the data array */
int iline = 0;		/* Current line number in current input file */
int linstart = 0;	/* Nonzero iff within a table */
int texct;		/* Index into 'texstr' array */
int ncol;		/* Number of columns in table */
int oncol;
int evenflg;
int textflg;
int left1flg;
int rightl;
int qcol;
int in_overflow;
int pflag;   /* Nonzero iff previous data line was a horizontal line request */
char inbuf[MAX_INPUT_CHARS];	/* Input line buffer */
char savebuf[MAX_INPUT_CHARS];	/* Saved input line */
char errbuf[MAX_INPUT_CHARS];	/* Error message buffer */
int have_buffer = 0;	/* Nonzero iff there is a saved input line */
char texstr[] =
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWYXZ0123456789";
char id_line[] = "DWB 3.3 tbl";
char *Maxleft = "0i";	/* Limit on unused space at bottom of page */
char *last;
char *leftover = NULL;
FILE *tabin /*= stdin*/;	/* Current input stream */
int  nfd = 0;		/* Number of open files - 1 */
typedef	char FILENAME[256];

struct file_item {
	FILE *fileptr;
	int line_nr;
	FILENAME filename;
} file_stack[MAX_FILES];

char *ifile = "";	/* Pointer to current input file name */
FILENAME current_name;	/* Buffer to hold current input file name */

/* The following arrays are allocated dynamically */
int *stynum;
short *fullbot;
short *linestop;
char **instead;
struct colstr **table;
short (*style)[MAXHEAD];
short (*lefline)[MAXHEAD];
short (*flags)[MAXHEAD];
char (*font)[MAXHEAD][2];
char (*csize)[MAXHEAD][4];
char (*vsize)[MAXHEAD][4];
char (*cll)[CLLEN];
int *evenup;
int *sep, *sep1;
int *used, *lused, *rused;
int *doubled, *acase, *topat;

comment1(s) /* Insert a comment into the troff output (for debugging) */
char *s;
{
	/* Invoked via macros 'comment', 'comment2', etc. */
	printf(".\\\" *** %s ***\n", s);
}

output1(s) /* Insert some text into the output of tbl, while making a copy
	      on stderr (used for debugging) */
char *s;
{
	/* Invoked via macros 'output', 'output2', etc. */
	printf("%s", s);
}

/* t1.c: main control and input switching */

int errflg = 0;
int sargc;
char **sargv;
extern void	badsig();

main(argc, argv)
char *argv[];
{
	int c;
	char *line;
	extern char *optarg; /* Set by getopt() */

	tabin = stdin;	/* for linux stdin is not const */
	signal(SIGPIPE, badsig);
	while ((c = getopt(argc, argv, "cVRT:")) != EOF)
	{
		switch (c)
		{
		case 'V': /* Undocumented option--for debugging only */
			Vopt = 1;
			break;
		case 'R': /* Undocumented option--for debugging only */
			Ropt = 1;
			break;
		case 'c': /* Continue processing if there are errors */
			errterm = 0;
			break;
		case 'T':
			if (streql(optarg, "X"))
				pr1403 = 1;
			else
			{
				fprintf(stderr,
				    "%s: Invalid argument to T option--X expected.\n", argv[0]);
				errflg++;
			}
			break;
		case '?':
			errflg++;
		}
	}
	if (errflg)
	{
		fprintf(stderr, "Usage: %s [-c] [-T X] [--] [file] ... [-]\n", argv[0]);
		exit(2);
	}
	if (Ropt) Maxleft = "9i";
	if (Vopt) fprintf(stderr, "%s\n", id_line);
	comment(id_line);
	sargc = argc;
	sargv = argv;
	if (swapin())
	{
		tabin = stdin;
		ifile = "-";
		print_file_info();
	}
	while ((line = gets1(inbuf, sizeof(inbuf))) != NULL)
	{
		puts(line);
		if (is_table_start(line))
			do_table(); /* Process one table */
	}
	if (errcnt1)
	{
		fprintf(stderr, "tbl: Input contains errors.\n");
		exit(1);
	}
	return(0);
}

swapin() /* Switch to next input file */
{
	/* Returns 0 for success, 1 for failure (no more input files) */
	extern int optind; /* Set by getopt() */

	if (tabin != stdin)
		fclose(tabin);
	if (popfd() == 0)
	{
		/* Resumed previous source of input */
		print_file_info();
		return 0;
	}
	if (optind >= sargc)
		return(1);	/* No more files to be processed */
	if (streql(sargv[optind], "-"))
	{
		ifile = "-";
		tabin = stdin;
		print_file_info();
	}
	else if (open_for_input(sargv[optind]))
	{
		fprintf(stderr, "tbl: Can't open file %s\n", sargv[optind]);
		bailout();
	}
	optind++;
	return(0);
}

void
badsig() /* Catch broken-pipe signal */
{
	signal(SIGPIPE, SIG_IGN);
	exit(0);
}

do_table() /* Subroutine sequencing for one table */
{
	errflg = errcnt2 = in_overflow = 0;
	in_header1 = in_header2 = Hflag; /* Set iff table begins with .TS H */
	have_header = 0; /* Assume no table header */
	saveline();	/* Save input line number */
	savefill();	/* Save context at beginning of table. */
	ifdivert();	/* Generate code to define string #d */
	cleanfc();	/* Turn off field delimiter and pad char mechanism */
	if (do_table1()) /* Compile the table */
		skip_input();
	release();	/* Make character buffers available for reuse */
	rstofill();	/* Restore saved context */
	endoff();	/* Clean up after one table */
	freearr();	/* Release storage obtained for arrays */
	restline();	/* Restore input line number */
}

do_table1() /* Compile one table */
{
	if (getspec())	/* Read format lines */
		error("Errors in format section.");
	if (gettbl())	/* Read data lines */
		error("Errors in data section.");
	getstop();	/* Set the linestop array */
	checkuse();	/* Mark columns with real data */
	choochar();	/* Choose delimiter characters */
	multipg(); /* Initialize stuff for multi-page tables */
	maktab();	/* Generate code to calculate column widths */
	runout();	/* Generate code to draw the table */
	return 0;
}

skip_input()	/* Skip remainder of current table */
{
	fprintf(stderr, "tbl: Skipping to the end of this table\n");
	while (dwb_getline(inbuf, sizeof(inbuf)))
	{
		if (is_table_end(inbuf))
		{
			if (nfd > 0)
				continue;
			last = inbuf;
			return;
		}
	}
	fatal_error("Missing table-end request");
}

/* t3.c: interpret commands affecting the whole table */


struct optstr {
	char *optnam;
	int *optadd;
} options[] = {
	"allbox", &allflg,	/* Draw a box around each entry */
	"ALLBOX", &allflg,
	"box", &boxflg,		/* Draw a box around the table */
	"BOX", &boxflg,
	"center", &ctrflg,	/* Center the table horizontally */
	"CENTER", &ctrflg,
	"centre", &ctrflg,	/* Alternative spelling */
	"CENTRE", &ctrflg,
	"delim", &delim1,	/* Delimiters for in-line equations */
	"DELIM", &delim1,
	"doublebox", &dboxflg,	/* Draw a double box around the table */
	"DOUBLEBOX", &dboxflg,
	"expand", &expflg,	/* Expand table to fill page width */
	"EXPAND", &expflg,
	"frame", &boxflg,	/* Obsolete synonym for "box" */
	"FRAME", &boxflg,
	"doubleframe", &dboxflg, /* Obsolete synonym for "doublebox" */
	"DOUBLEFRAME", &dboxflg,
	"linesize", &linsize,	/* Point size for rules */
	"LINESIZE", &linsize,
	"maxlines", &Maxlin,	/* Maximum lines to be given full treatment */
	"MAXLINES", &Maxlin,
	"maxline", &Maxlin,	/* Synonym for "maxlines" */
	"MAXLINE", &Maxlin,
	"tab", &tab,		/* Column separator for data */
	"TAB", &tab,
	NULL, NULL};

#define	syntax_error() error("Syntax error processing global options")
#define	getcomm_err() error2("Error processing global option %s", lp->optnam)
#define	maxlin_errmsg "Out-of-range value %ld for global option maxline"

getcomm(line) /* Get global options */
char *line;
{
	char *cp, *nb, *p, tbuf[9];
	struct optstr *lp;
	int c, ci, i;
	long maxline;

	for (lp = options; lp->optnam; lp++)
		*(lp->optadd) = 0;
	texct = 0;	/* Set number of text blocks = 0 */
	Maxlin = MAXLIN;
	tab = '\t';	/* Default column separator in data lines */
	delim1 = delim2 = 0;
	printf(".nr %d \\n(.s\n", LSIZE); /* Save current point size */

	if (strchr(line, ';') == NULL)
		return 0;	/* No options for this table */

	for (cp = line; (c = *cp) != ';'; cp++)
	{
		if (c == ' ' || c == '\t' || c == ',') continue;
		if ( ! isalpha(c)) syntax_error();
		for (lp = options; lp->optadd != NULL; lp++)
		{
			if (prefix(lp->optnam, cp))
			{
				cp += strlen(lp->optnam);
				if (isalpha(*cp))
					error("Misspelled global option");
				while (*cp == ' ') /* Skip blanks */
					cp++;

				/* Get stuff between parens, if any */
				if (*cp == '(')
				{
					nb = tbuf;
					i = 0;
					while ((ci = *++cp) != ')')
					{
						if (i < sizeof(tbuf))
							nb[i++] = ci;
						if (ci == '\0')
							break;
					}
					if (ci != ')')
						syntax_error();
					if (i >= sizeof(tbuf))
						error("option string is too long");
					nb[i] = 0;
				}
				else
				{
					cp--;	/* Put back unused char */
					nb = "";
				}
				if (lp->optadd == &tab)
				{
					if (strlen(nb) != 1)
						getcomm_err();
					tab = nb[0];
				}
				else if (lp->optadd == &linsize)
				{
					if ((int)strlen(nb) < 1)
						getcomm_err();
					printf(".nr %d %s\n", LSIZE, nb);
					linsize = 1;
				}
				else if (lp->optadd == &Maxlin)
				{
					if ((int)strlen(nb) < 1)
						getcomm_err();
					maxline = strtol(nb, &p, 10);
					if (*p)
						getcomm_err();
					if (maxline >= 16384 || maxline < 2*MAXHEAD)
						error2(maxlin_errmsg, maxline);
					Maxlin = maxline;
				}
				else if (lp->optadd == &delim1)
				{
					if ((int)strlen(nb) < 2)
						getcomm_err();
					delim1 = nb[0];
					delim2 = nb[1];
				}
				else
					*(lp->optadd) = 1;
				break;
			}
		}
		if (lp->optadd == NULL)
			error("Illegal option");
	}
	return 0;
}

/* t4.c: read table specification */

getspec() /* Allocate data structures and read format lines */
{
	int i, c, icol, nch;
	char *line, *p;


	oncol = ncol = nclin = left1flg = rightl = 0;

	for (;;) /* Get an input line */
	{
		nch = dwb_getline(line = inbuf, sizeof(inbuf));
		if (nch == 0)
			fatal_error("Unexpected end-of-file");
		if (is_table_start(line))
		{
			if (nfd > 0)
				continue;
			ungetline(inbuf);
			error("Missing table-end (.TE) request");
		}
		if (is_table_end(line))
		{
			if (nfd > 0)
				continue;
			ungetline(inbuf);
			error("Unexpected table-end request");
		}
		errflg = 0;
		if (is_include(line))
		{
			if (errflg)
				return 1; /* Syntax or file access error */
			continue;
		}
		break;
	}
	/* Initialize and then process global options, if any */
	if (getcomm(line))
		warning("Error in table options");
	p = strrchr(line, ';');
	if (p != NULL)
		line = p+1;
	/* Skip leading blanks, tabs, and newlines */
	for (;;)
	{
		while ((c = *line) == ' ' || c == '\t')
			line++;
		if (c != '\n')
			break;
getspec2: /* Come back to here after file inclusion request has been processed */
		nch = dwb_getline(line = inbuf, sizeof(inbuf));
		if (nch == 0)
			fatal_error("Unexpected end-of-file");
		if (is_table_start(line))
		{
			if (nfd > 0)
				goto getspec2;
			ungetline(inbuf);
			error("Missing table-end (.TE) request");
		}
		if (is_table_end(line))
		{
			if (nfd > 0)
				continue;
			ungetline(inbuf);
			error("Unexpected table-end request");
		}
		errflg = 0;
		if (is_include(line))
		{
			if (errflg)
				return 1; /* Syntax or file access error */
			goto getspec2;
		}
	}
	errflg = 0;
	qcol = findcol(line)+1;	/* Must allow one extra for line at right */
	if (errflg)
		error("Error in format for first row");
	garray();	/* Allocate storage for dynamic arrays */
	sep[-1] = -1;
	for (icol = 0; icol < qcol; icol++)
	{
		sep[icol] = -1;
		evenup[icol] = 0;
		cll[icol][0] = 0;
		for (i = 0; i < MAXHEAD; i++)
		{
			csize[icol][i][0] = 0;
			vsize[icol][i][0] = 0;
			font[icol][i][0] = 0;
			flags[icol][i] = 0;
			lefline[icol][i] = 0;
			style[icol][i] = 'l';
		}
	}
	for (i = 0; i < Maxlin; i++)
		linestop[i] = 0;
	/* Process format lines */
	for (; nch > 0; nch = dwb_getline(line = inbuf, sizeof(inbuf)))
	{
		if (is_table_start(line))
		{
			if (nfd > 0)
				continue;
			ungetline(inbuf);
			error("Missing table-end (.TE) request");
		}
		if (is_table_end(line))
		{
			if (nfd > 0)
				continue;
			ungetline(inbuf);
			error("Unexpected table-end request");
		}
		errflg = 0;
		if (is_include(line))
		{
			if (errflg)
				return 1; /* Syntax or file access error */
			continue;
		}
		if (readspec(line)) {
			if (errflg)
				return 1;
			break;
		}
	}
	printf(".rm"); /* Clear macros used to record and define text blocks */
	for (i = 0; i < ncol; i++)
		printf(" %2s", reg(i,CRIGHT));
	printf("\n");
	return 0;
}

getchange() /* Process a table-change (.T&) request */
{
	int c, i, nch;
	char linbuf[MAX_INPUT_CHARS];
	char *line, *p;

	/*
	 * The reason for using a temp array here is to avoid overwriting
	 * the contents of inbuf, which still contains the .T& request.
	 * gettbl() will treat the request as if it were troff, by
	 * saving it to be emitted later.
	 */
	for (;;)
	{
		nch = dwb_getline(line = linbuf, sizeof(linbuf));
		if (nch == 0)
			fatal_error("Unexpected end-of-information");
		if (is_table_start(line))
		{
			if (nfd == 0)
			{
				ungetline(inbuf);
				error("Missing table-end (.TE) request");
			}
			continue;
		}
		if (is_table_end(line))
		{
			if (nfd > 0)
				continue;
			ungetline(inbuf);
			error("Unexpected table-end request");
		}
		errflg = 0;
		if (is_include(line))
		{
			if (errflg)
				return 1; /* Syntax or file access error */
			continue;
		}
		break;
	}
	p = strrchr(line, ';');
	if (p != NULL)
	{
		warning("Global options not allowed following .T&!");
		line = p+1;
	}
	/* Skip leading blanks, tabs, and newlines */
	for (;;)
	{
		while ((c = *line) == ' ' || c == '\t')
			line++;
		if (c != '\n')
			break;
getchange2: /* Come back to here after file inclusion request has been processed */
		nch = dwb_getline(line = inbuf, sizeof(inbuf));
		if (nch == 0)
			fatal_error("Unexpected end-of-file");
		if (is_table_start(line))
		{
			if (nfd > 0)
				goto getchange2;
			ungetline(inbuf);
			error("Missing table-end (.TE) request");
		}
		if (is_table_end(line))
		{
			if (nfd > 0)
				goto getchange2;
			ungetline(inbuf);
			error("Unexpected table-end request");
		}
		errflg = 0;
		if (is_include(line))
		{
			if (errflg)
				return 1; /* Syntax or file access error */
			goto getchange2;
		}
		continue;
	}
	errflg = 0;
	i = findcol(line);
	if (errflg)
		return 1;
	if (i >= qcol)
		error("Tried to widen table in T&, not allowed");
	/* Process format lines */
	for (; nch > 0; nch = dwb_getline(line = linbuf, sizeof(linbuf)))
	{
		if (is_table_start(line))
		{
			if (nfd > 0)
				continue;
			ungetline(inbuf);
			error("Missing table-end (.TE) request");
		}
		if (is_table_end(line))
		{
			if (nfd > 0)
				continue;
			ungetline(inbuf);
			error("Unexpected table-end request");
		}
		errflg = 0;
		if (is_include(line))
		{
			if (errflg)
				return 1; /* Syntax or file access error */
			continue;
		}
		if (readspec(line)) {
			if (errflg)
				return 1;
			break;
		}
	}
	return 0;
}

#define get1char()	(*next++)
#define	un1getc(c)	(next--)
#define	key_error()	error(missing_key_msg)

char missing_key_msg[] = "Missing key letter";

readspec(next) /* Process a format line */
char *next;
{
	char *snp, *temp;
	int c, stopc, i, k;
	int sawchar = 0; /* Nonzero iff current row contains a key letter */
	int icol = 0;	 /* Index of current column */

	/* Returns nonzero for end of format section or error, otherwise zero */
	while (c = get1char())
	{
		switch (c)
		{
		default:
			error2("Bad table specification character '%c'", c);
		case ' ':
		case '\t':
			continue; /* Ignore white space */
		case '\n':
			if (sawchar == 0) return 0; /* Ignore blank lines */
		case ',':
		case '.':
			/* End of format for one row */
			if (lefline[icol][nclin] > 0) /* Virtual column on right */
			{
				icol++;
				rightl++;
			}
			if (ncol < icol)
				ncol = icol;
			if (ncol > qcol)
				fatal_error("Internal error--get help");
			if (sawchar)
				nclin++;
			if (nclin >= MAXHEAD)
				error("Too many lines in specification");
			if (ncol == 0 || nclin == 0)
				error("No specification");
			if (c == '.') /* End of format lines */
			{
				while ((c = get1char()) && c != '\n')
					if (c != ' ' && c != '\t')
						error("Dot not last character on format line");
				/* fix up sep - default is 3 except at edge */
				for (icol = 0; icol < ncol; icol++)
					if (sep[icol] < 0)
						sep[icol] = icol+1 < ncol ? 3 : 2;
				if (oncol == 0)
					oncol = ncol;
				else if (ncol > oncol+1)
					error("Tried to widen table in T&, not allowed");
				return 1;
			}
			icol = sawchar = 0;	/* Get ready for next row */
			if (c == '\n')
				return 0;
			continue;
		case 'L':
		case 'R':
		case 'C':
		case 'N':
		case 'A':
		case 'S':
			c = tolower(c);
		case 'l':
		case 'r':
		case 'c':
		case 'n':
		case 'a':
		case 's':
		case '^':
		case '-':
		case '_':
		case '=':
			sawchar = 1; /* Found a key letter */
			if (c == '_') c = '-';
			style[icol][nclin] = c;
			if (c == 's' && icol < 1)
				error("First column cannot be S-type");
			if (c == 's' && style[icol-1][nclin] == 'a')
			{
				warning("Can't span a-type cols, changed to l");
				style[icol-1][nclin] = 'l';
			}
			if (c == 's' && style[icol-1][nclin] == 'n')
			{
				warning("Can't span n-type cols, changed to c");
				style[icol-1][nclin] = 'c';
			}
			if (c == '^' && nclin <= 0)
				error("First row cannot contain vertical span");
			/* Must have icol+1 < qcol */
			if (++icol >= qcol)
				error("Tried to widen table after first row");
			continue;
		case 'b':
		case 'i':
			c = toupper(c);
		case 'B':
		case 'I':
			/* font request */
			if (icol < 1) key_error();
			snp = font[icol-1][nclin];
			snp[0] = (c == 'I' ? '2' : '3');
			snp[1] = 0;
			continue;
		case 't':
		case 'T':
			/* Put this item at the top of its cell */
			if (icol < 1) key_error();
			flags[icol-1][nclin] |= CTOP;
			continue;
		case 'd':
		case 'D':
			/* Put this item at the bottom of its cell */
			if (icol < 1) key_error();
			flags[icol-1][nclin] |= CDOWN;
			continue;
		case 'f':
		case 'F':
			/* font request */
			/* Note: this allows undocumented format f(n) */
			if (icol < 1) key_error();
			snp = font[icol-1][nclin];
			snp[0] = snp[1] = stopc = 0;
			for (i = 0; i < 2; i++)
			{
				c = get1char();
				if (i == 0 && c == '(')
				{
					stopc = ')';
					c = get1char();
				}
				if (c == 0) break;
				if (c == stopc)
				{
					stopc = 0;
					break;
				}
				if (stopc == 0)
				{
					if (c == ' ' || c == '\t')
						break;
				}
				if (c == '\n' || c == '|')
				{
					un1getc(c);
					break;
				}
				snp[i] = c;
				if (isdigit(c)) break;
			}
			if (stopc && get1char() != stopc)
				error("Nonterminated font name");
			continue;
		case 'P':
		case 'p':
			/* point size specification */
			if (icol < 1) key_error();
			temp = snp = csize[icol-1][nclin];
			while (c = get1char())
			{
				if (c == ' ' || c == '\t' || c == '\n') break;
				if (c == '-' || c == '+')
				{
					if (snp > temp)
						break;
					else
						*snp++ = c;
				}
				else
				{
					if (isdigit(c))
						*snp++ = c;
					else
						break;
				}
				if (snp-temp > 4)
					error("Point size too large");
			}
			*snp = 0;
			if (atoi(temp) > 36)
				error("Point size unreasonable");
			un1getc(c);
			continue;
		case 'V':
		case 'v':
			/* vertical spacing (for text blocks only) */
			if (icol < 1) key_error();
			temp = snp = vsize[icol-1][nclin];
			while (c = get1char())
			{
				if (c == ' ' || c == '\t' || c == '\n') break;
				if (c == '-' || c == '+')
				{
					if (snp > temp)
						break;
					else
						*snp++ = c;
				}
				else
				{
					if (isdigit(c))
						*snp++ = c;
					else
						break;
				}
				if (snp-temp > 4)
					error("Vertical spacing value too large");
			}
			*snp = 0;
			un1getc(c);
			continue;
		case 'w':
		case 'W':
			/* column width */
			if (icol < 1) key_error();
			snp = cll[icol-1];
			stopc = 0;
			while (c = get1char())
			{
				if (snp == cll[icol-1] && c == '(')
				{
					stopc = ')';
					continue;
				}
				if (stopc)
				{
					if (c == stopc) break;
				}
				else
				{
					if ( ! isdigit(c)) break;
				}
				if (snp-cll[icol-1] >= CLLEN-2)
					error("Column width too long");
				*snp++ = c;
			}
			if (isdigit(*(snp-1)))
				*snp++ = 'n';	/* default units are ens */
			*snp = 0;
			if ( ! stopc)
				un1getc(c);
			continue;
		case 'e':
		case 'E':
			/* equal-width column */
			if (icol < 1) key_error();
			evenup[icol-1] = 1;
			evenflg = 1;
			continue;
		case 'x':
		case 'X':
			/* Make this column as wide as possible */
			if (icol < 1) key_error();
			if (Xcol < 0)
				Xcol = icol - 1;
			if (Xcol != (icol - 1))
				warning("Too many columns with 'x' modifier.");
			continue;
		case 'z':
		case 'Z':
			/* zero width--ignore width of this item */
			if (icol < 1) key_error();
			flags[icol-1][nclin] |= ZEROW;
			continue;
		case 'u':
		case 'U':
			/* half line up */
			if (icol < 1) key_error();
			flags[icol-1][nclin] |= HALFUP;
			continue;
		case '0':
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			/* separation between this column and the next one */
			k = c - '0';
			while (isdigit(c=get1char()))
				k = k*10 + c - '0';
			un1getc(c);
			sep[icol-1] = max(sep[icol-1], k);
			/* Note that sep[-1] is legal */
			continue;
		case '|':
			/* put a vertical line here */
			lefline[icol][nclin]++;
			if (icol == 0) left1flg = 1;
			continue;
		} /* End of switch */
	} /* End of loop */
	fatal_error("End-of-file encountered while reading table specification");
	return 1;
}

#define	format_error()	{ \
	    error2("Unexpected character '%c' in format specification", c); \
	}

#define	FLNLIM 200

findcol(line) /* This counts the number of columns */
char *line;
{
	char *p;
	int nc = 0;
	int i, c, stopc = 0;

	if (strchr("LlRrCcNnAaSs|^-_=", *line) == NULL)
		error("Format does not begin with a key letter");

	/* Scan the specification looking for a key letter, '^', '-', or '=' */
	for (p = line; (c = *p++) != '\0';)
	{
		switch (c)
		{
		default:
			error2("Unexpected character '%c' in format specification", c);
		case ' ':
		case '\t':
			continue;
		case ',':
		case '.':
		case '\n':
			break;
		case 'L':
		case 'l':
		case 'R':
		case 'r':
		case 'C':
		case 'c':
		case 'N':
		case 'n':
		case 'A':
		case 'a':
		case 'S':
		case 's':
		case '^':
		case '-':
		case '_':
		case '=':
			/* Found a key letter: increment column count */
			if (++nc > MAXCOL)
				error("Too many columns");
			break;
		case 'B':
		case 'b':
		case 'I':
		case 'i':
		case 'T':
		case 't':
		case 'E':
		case 'e':
		case 'X':
		case 'x':
		case 'Z':
		case 'z':
		case 'U':
		case 'u':
		case 'D':
		case 'd':
			/* Eat up modifier */
			continue;
		case 'F':
		case 'f':
			/*
			 * Eat up a font name or number
			 *
			 * The purpose is to avoid possible confusion
			 * between keyletters and troff width indicators.
			 * This allows undocumented format f(n).
			 */
			c = *p++;
			if (c == '(')
			{
				for (i = 0; (c = *p++) != '\0' && i < 2; i++)
				{
					if ( ! (isdigit(c) || isalpha(c)))
						break;
				}
				if (i == 0 || c != ')')
					format_error();
			}
			else if (isalpha(c))
			{
				if (isalpha(*p))
					p++;
			}
			else if ( ! isdigit(c))
				format_error();
			break;
		case 'W':
		case 'w':
			/*
			 * Eat up a column-width specification
			 *
			 * The purpose is to avoid possible confusion
			 * between keyletters and troff width indicators
			 */
			stopc = 0;
			for (i = 0; c = *p++; i++)
			{
				if (i == 0 && c == '(')
				{
					stopc = ')';
					continue;
				}
				if (stopc)
				{
					if (c == stopc) break;
				}
				else
				{
					if ( ! isdigit(c)) break;
				}
			}
			if ( ! stopc)
				p--;
			break;
		case 'P':
		case 'p':
		case 'V':
		case 'v':
			/*
			 * Eat up a point-size or vertical-spacing change
			 *
			 * The purpose is to avoid possible confusion
			 * between the use of '-' to indicate a negative
			 * integer and the use of '-' to indicate a
			 * horizontal line
			 */
			for (i = 0; c = *p++; i++)
			{
				if ((c == '-' || c == '+') && i == 0)
					continue;
				if ( ! isdigit(c))
					break;
			}
			p--;
			break;
		case '0':
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
		case '|':
			break;
		}
		if (strchr(",.\n", c) != NULL)
			break;
	}
	return(nc); /* Return the column count */
}

warning1(s)	/* Display a warning or error message */
char *s;
{
	/* Assumes errflg has already been set if appropriate */
	fprintf(stderr, "tbl: File %s, line %d: Warning: %s\n",
	    ifile, iline, s);
}

long Gdbytes = 0; /* Number of bytes allocated for dynamic arrays */

garray() /* Allocate storage for dynamic arrays */
{
	char *getcore();

	Gdbytes = 0;
	table = (struct colstr **) getcore(MAXHEAD+Maxlin, sizeof(struct colstr *));
	stynum = (int *) getcore(MAXHEAD+Maxlin, sizeof(int));
	fullbot = (short *) getcore(MAXHEAD+Maxlin, sizeof(short));
	linestop = (short *) getcore(MAXHEAD+Maxlin, sizeof(short));
	instead = (char **) getcore(MAXHEAD+Maxlin, sizeof(char *));
	style = (short (*)[]) getcore(MAXHEAD*qcol, sizeof(short));
	lefline = (short (*)[]) getcore(MAXHEAD*qcol, sizeof(short));
	flags = (short (*)[]) getcore(MAXHEAD*qcol, sizeof(short));
	csize = (char (*)[MAXHEAD][4]) getcore(MAXHEAD*qcol, 4);
	vsize = (char (*)[MAXHEAD][4]) getcore(MAXHEAD*qcol, 4);
	font = (char (*)[][2]) getcore(MAXHEAD*qcol, 2);
	cll = (char (*)[]) getcore(qcol, CLLEN);
	sep1 = (int *) getcore(qcol+2, sizeof(int));
	sep = sep1 + 1; /* sep[-1] must be legal */
	evenup = (int *) getcore(qcol+1, sizeof(int));
	used = (int *) getcore(qcol+1, sizeof(int));
	lused = (int *) getcore(qcol+1, sizeof(int));
	rused = (int *) getcore(qcol+1, sizeof(int));
	doubled = (int *) getcore(qcol+1, sizeof(int));
	acase = (int *) getcore(qcol+1, sizeof(int));
	topat = (int *) getcore(qcol+1, sizeof(int));
}

char *
getcore(a, b) /* Allocate storage for one array */
int a, b;
{
	char *x;

	x = calloc((unsigned)a, (unsigned)b);
	if (x == NULL)
		fatal_error("Couldn't get memory");
	Gdbytes += (long)a*b;
	return(x);
}

freearr() /* Release storage obtained by garray() */
{
	if (Gdbytes > 0) {
		free((char *)style);
		free((char *)evenup);
		free((char *)lefline);
		free((char *)flags);
		free((char *)font);
		free((char *)csize);
		free((char *)vsize);
		free((char *)cll);
		free((char *)(sep1));
		free((char *)used);
		free((char *)lused);
		free((char *)rused);
		free((char *)doubled);
		free((char *)acase);
		free((char *)topat);
	}
	Gdbytes = 0;
}

/* t5.c: read data for table */

gettbl() /* Read in the first Maxlin lines of data */
{
	int icol, ch;
	char *cp, *cstore;
	int nslin = 0; /* Index of format row */


	textflg = 0;
	for (nlin = 0; (cstore = gets1(inbuf, sizeof(inbuf))) != NULL; nlin++)
	{
		stynum[nlin] = nslin;
		if (prefix(".TH", cstore))
		{
			if (in_header1)
				in_header1 = 0;
			else
				warning("Unmatched table-header end (.TH)");
		}
		if (is_table_start(cstore))
		{
			if (nfd > 0) {
				nlin--;
				continue;
			}
			/* This should be an error, but for now */
			/* just reproduce the DWB 3.1 behavior */
		}
		if (is_table_end(cstore))
		{
			if (nfd > 0) {
				nlin--;
				continue;
			}
			leftover = NULL;
			break;
		}
		errflg = 0;
		if (is_include(cstore))
		{
			if (errflg)
				return 1; /* Syntax or file access error */
			nlin--;
			continue;
		}
		if (prefix(".T&", cstore))
		{
			nslin = nclin; /* Advance to first row of new section */
			if (getchange())    /* Get additional format lines */
				error("Error processing new format section.");
			if (nslin >= nclin) /* Might be a null format section */
				nslin = nclin - 1;
		}
		if (nlin >= Maxlin)
		{
			leftover = cstore;
			break;
		}
		fullbot[nlin] = 0;
		instead[nlin] = NULL;
		if (istroff(cstore)) /* troff request or macro call */
		{
			if (is_table_start(cstore))
				warning("Unexpected table-start (.TS) request.");
			instead[nlin] = strsave(cstore);
			continue;
		}
		/* If there are no data fields in the format for this row,
		 * insert a fake data row ahead of this data row and advance
		 * to the next format row with real data fields, if any.
		 */
		if (nodata(nslin))
		{
			fullbot[nlin] = oneh(nslin); /* '-', '=', '^', or 0 */
			table[nlin] = alocv(ncol+2);
			for (icol=0; icol<ncol; icol++)
			{
				TABLE(nlin,icol).rcol = "";
				TABLE(nlin,icol).col = "";
			}
			nlin++;
			nslin++;
			fullbot[nlin] = 0;
			instead[nlin] = NULL;
		}
		table[nlin] = alocv(ncol+2); /* Allocate data structures for this row */
		if (cstore[0] != 0 && cstore[1] == 0)
		{
			switch (cstore[0])
			{
			case '_':
				fullbot[nlin] = '-';
				continue;
			case '=':
				fullbot[nlin] = '=';
				continue;
			}
		}
		stynum[nlin] = nslin;
		if (++nslin >= nclin) nslin--;
		for (icol = 0; icol < ncol; icol++)
		{
			struct colstr *p = &TABLE(nlin,icol);

			p->rcol = NULL;
			ch = 1;
			if (streql(cstore, "T{")) /* Text block follows */
			{
				p->col = (char *)dwb_gettext(&cstore, nlin, icol);
			}
			else
			{
				for (cp = cstore; (ch = *cp) != '\0'; cp++)
				{
					if (ch == tab)
					{
						*cp++ = '\0';
						break;
					}
				}
				p->col = strsave(cstore);
				cstore = cp;
				/* Fix up numeric or alpha subcolumn */
				switch (ctype(nlin, icol))
				{
				case 'n':
					/* split numeric field into two parts */
					p->rcol = maknew(p->col);
					break;
				case 'a':
					/* move text pointer */
					p->rcol = p->col;
					p->col = "";
					break;
				}
			}
			/*
			 * BUG--If the user has provided gratuitous data,
			 * such as a text block, for the spanned columns,
			 * we should eat up the data and issue a warning
			 * message.
			 */
			while (ctype(nlin, icol+1) == 's') /* spanning */
			{
				TABLE(nlin,++icol).col = "";
			}
			if (ch == '\0') break; /* end of line */
		}
		while (++icol < ncol+2)
		{
			TABLE(nlin,icol).col = "";
			TABLE(nlin,icol).rcol = NULL;
		}
	}
	if (cstore == NULL)
		fatal_error("Missing .TE");/*TEMP--shouldn't be fatal */
	last = cstore;
	permute(); /* Fix up vertically spanned items */
	if (textflg)
		untext(); /* Restore line length saved in gettext() */
	return 0;
}

nodata(ilin) /* Returns 1 if there are no data fields in this format
	        row, otherwise 0 */
{
	int icol;

	for (icol = 0; icol < ncol; icol++)
	{
		switch (style[icol][ilin])
		{
		case 'c':
		case 'n':
		case 'r':
		case 'l':
		case 's':
		case 'a':
			return(0);
		}
	}
	return(1);
}

oneh(ilin) /* If all columns for this format row have the same keyletter,
	     the return value is that keyletter, otherwise 0 */
{
	int k, icol;

	k = style[0][ilin];
	for (icol = 1; icol < ncol; icol++)
	{
		if (k != style[icol][ilin])
			return(0);
	}
	return(k);
}

#define	SPAN "\\^"

permute() /* Check for vertically spanned entries and fix up the 'table' array
	     accordingly */
{
	int irow, jcol, is;

	for (jcol = 0; jcol < ncol; jcol++)
	{
		for (irow = 1; irow < nlin; irow++)
		{
			if (vspand(irow, jcol, 0)) /* vertically spanned */
			{
				is = prev(irow);
				if (is < 0)
					fatal_error("Vertical spanning in first row not allowed");
				while (irow+1 < nlin && vspand(irow+1, jcol, 0))
					irow++;
				TABLE(irow,jcol).col = TABLE(is,jcol).col;
				TABLE(irow,jcol).rcol = TABLE(is,jcol).rcol;
				while (is < irow)
				{
					TABLE(is,jcol).rcol = NULL;
					TABLE(is,jcol).col = SPAN;
					is = next(is);
				}
			}
		}
	}
}

vspand(irow, icol, ignore) /* Check for vertical spanning */
{
	/*
	 * Returns 1 if this entry is vertically spanned from the previous
	 * row, otherwise 0.
	 *
	 * If the 'ignore' argument is non-zero, the keyletter information
	 * from the format section is not considered.
	 */
	if (irow < 0 || irow >= nlin) return(0);
	if (instead[irow] != NULL) return(0);
	if ( ! ignore && ctype(irow, icol) == '^') return(1);
	if (fullbot[irow]) return(0);
	if (TABLE(irow,icol).rcol != NULL) return(0);
	return(vspen(TABLE(irow,icol).col));
}

vspen(s) /* Returns 1 if s is a pointer to "\\^", otherwise 0 */
char *s;
{
	return(point(s) && streql(s, SPAN));
}


/* t6.c: compute tab stops */

maktab() /* Generate code to perform column width calculations */
{
	int icol, tsep;

	for (icol = 0; icol < ncol; icol++) /* Calculate column widths */
		getcolwidth(icol);

	if (textflg)
		untext(); /* Restore line length saved in gettext() */

	if (evenflg) /* If even requested, make all columns widest width */
	{
		printf(".nr %d 0\n", TMP);
		for (icol = 0; icol < ncol; icol++)
		{
			if ( ! evenup[icol]) continue;
			printf(".if \\n(%2s>\\n(%d .nr %d \\n(%2s\n",
			    reg(icol,CRIGHT), TMP, TMP, reg(icol,CRIGHT));
		}
		for (icol = 0; icol < ncol; icol++)
		{
			/* if column not evened just retain old interval */
			if ( ! evenup[icol])
				continue;
			if (doubled[icol])
				printf(".nr %2s (100*\\n(%2s/\\n(%2s)*\\n(%d/100\n",
				    reg(icol,CMID), reg(icol,CMID), reg(icol,CRIGHT), TMP);
			/*
			 * That nonsense with the 100's and parens tries
			 * to avoid overflow while proportionally shifting
			 * the middle of the number
			 */
			printf(".nr %2s \\n(%d\n", reg(icol,CRIGHT), TMP);
		}
	}

	/* Now adjust for total table width */
	for (tsep = icol = 0; icol < ncol; icol++)
		tsep += sep[icol];


	/* Process 'x' modifier, if any */
	if (Xcol >= 0)
	{
		printf(".nr %d 0", TMP);
		for (icol = 0; icol < ncol; icol++)
			printf("+\\n(%2s", reg(icol,CRIGHT));
		printf("\n");
		printf(".nr %d \\n(.l-%dn-\\n(%2d\n", TMP, tsep, TMP);
		printf(".if \\n(%d>0 .nr %s +\\n(%2d\n", TMP, reg(Xcol,CRIGHT), TMP);
		printf(".%2s\n", reg(Xcol,CRIGHT)); /* Remake text blocks */
		printf(".rm %2s\n", reg(Xcol,CRIGHT)); /* Release space */
		if (textflg)
			untext(); /* Restore line length saved in gettext() */
	}

	if (expflg) /* Process global 'expand' option */
	{
		printf(".nr %d 0", TMP);
		for (icol = 0; icol < ncol; icol++)
			printf("+\\n(%2s", reg(icol,CRIGHT));
		printf("\n");
		printf(".nr %d \\n(.l-\\n(%d\n", TMP, TMP);
		if (boxflg || dboxflg || allflg)
			/* tsep += 1; */ ;	/* STRANGE CODE */
		else
			tsep -= sep[ncol-1];
		/* a .nr request with a dividend equal to zero is not generated */
		/* the following check (one line) is the fix for mr bl83-05311 */
		if (tsep)
			printf(".nr %d \\n(%d/%d\n", TMP, TMP, tsep);
		printf(".if \\n(%d<0 .nr %d 0\n", TMP, TMP);
	}
	else
		printf(".nr %d 1n\n", TMP);
	printf(".nr %2s 0\n", reg(-1,CRIGHT)); /* KLUDGE--see reg() */
	tsep = (boxflg || allflg || dboxflg || left1flg) ? 2 : 0;
	if (sep[-1] >= 0)
		tsep = sep[-1];
	for (icol = 0; icol < ncol; icol++)
	{
		printf(".nr %2s \\n(%2s+((%d*\\n(%d)/2)\n",
		    reg(icol,CLEFT), reg(icol-1,CRIGHT), tsep, TMP);
		printf(".nr %2s +\\n(%2s\n", reg(icol,CRIGHT), reg(icol,CLEFT));
		if (doubled[icol])
		{
			/* the next line is last-ditch effort to avoid zero field width */
			/*printf(".if \\n(%2s=0 .nr %2s 1\n", reg(icol,CMID), reg(icol,CMID));*/
			printf(".nr %2s +\\n(%2s\n", reg(icol,CMID), reg(icol,CLEFT));
			/*  printf(".if n .if \\n(%s%%24>0 .nr %s +12u\n", reg(icol,CMID), reg(icol,CMID)); */
		}
		tsep = sep[icol]*2;
	}
	if (rightl) {
		printf(".nr %s (\\n(%s+\\n(%s)/2\n",
		    reg(ncol-1,CRIGHT), reg(ncol-1,CLEFT), reg(ncol-2,CRIGHT));
	}
	printf(".nr TW \\n(%2s\n", reg(ncol-1,CRIGHT));
	tsep = sep[ncol-1];
	if (boxflg || allflg || dboxflg)
		printf(".nr TW +((%d*\\n(%d)/2)\n", tsep, TMP);
	/* The following three lines calculate the table width in inches */
	printf(".nr %d (\\n(TW*10u+0.5i)/1i\n", TMP);
	printf(".nr %d \\n(%d%%10u\n", S9, TMP); /* Fraction part in S9 */
	printf(".nr %d \\n(%d/10u\n", TMP, TMP); /* Integer part in TMP */
	printf(".if t .if (\\n(TW+\\n(.o)>7.65i");/*Beginning of long request*/
	printf(" .tm Warning: table at line %d of file %s is too wide - \\n(TW units", linstart, ifile);
	printf(" (\\n(%d.\\n(%d inches)\n", TMP, S9);/*End of long request*/
}

getcolwidth(icol) /* Generate code to calculate width for one column */
{
	/* This code used to be part of maktab(). */
	int ilin, k, ik, vforml, il, pass;
	char *s, *t;

	doubled[icol] = acase[icol] = 0;
	printf(".nr %2s 0\n", reg(icol,CRIGHT));
	for (pass = 0; pass < 2; pass++)
	{
		if (pass != 0)
		{
			printf(".%2s\n", reg(icol,CRIGHT));
			if (icol != Xcol)
				printf(".rm %2s\n", reg(icol,CRIGHT));
		}
		for (ilin = 0; ilin < nlin; ilin++)
		{
			if (instead[ilin] != NULL || fullbot[ilin]) continue;
			vforml = ilin;
			for (il = prev(ilin); il >= 0; il = prev(il))
			{
				if ( ! vspen(TABLE(il,icol).col))
					break;
				vforml = il;
			}
			if (fspan(vforml, icol)) continue;
			s = TABLE(ilin,icol).col;
			t = TABLE(ilin,icol).rcol;
			if (filler(s)) continue;
			if ((FLGS(ilin, icol) & ZEROW) != 0) continue;
			switch (ctype(vforml, icol))
			{
			case 'a': /* alphabetic field */
				acase[icol] = 1;
				if (pass != 0 && ischar(s))
				{
					if (doubled[icol] == 0)
						printf(".nr %d 0\n.nr %d 0\n",
						    S1, S2);
					doubled[icol] = 1;
					printf(".if \\n(%c->\\n(%d .nr %d \\n(%c-\n",
					    s, S2, S2, s);
				}
				/* fall through to next case */
			case 'n': /* numeric field */
				if (t != NULL)
				{
					if (pass == 0 && ! doubled[icol])
						printf(".nr %d 0\n.nr %d 0\n", S1, S2);
					doubled[icol] = 1;
					if (real(s) && ! vspen(s))
					{
						if (ischar(s) != pass) continue;
						printf(".nr %d ", TMP);
						wide(s, FN(vforml,icol), SZ(vforml,icol));
						printf("\n");
						printf(".if \\n(%d<\\n(%d .nr %d \\n(%d\n",
						    S1, TMP, S1, TMP);
					}
					if (pass==0 && real(t) && ! vspen(t) && ! barent(t))
					{
						printf(".nr %d \\w%c%s%c\n",
						    TMP, F1, t, F1);
						printf(".if \\n(%d<\\n(%d .nr %d \\n(%d\n",
						    S2, TMP, S2, TMP);
					}
					continue;
				}
				/* fall through to next case */
			case 'r':
			case 'c':
			case 'l': /* other real data field */
				if (real(s) && ! vspen(s))
				{
					if (ischar(s) != pass) continue;
					printf(".nr %d ", TMP);
					wide(s, FN(vforml,icol), SZ(vforml,icol));
					printf("\n");
					printf(".if \\n(%2s<\\n(%d .nr %2s \\n(%d\n",
					    reg(icol,CRIGHT), TMP, reg(icol,CRIGHT), TMP);
				}
			}
		}
	}
	if (acase[icol])
	{
		printf(".if \\n(%d>=\\n(%2s .nr %2s \\n(%du+2n\n",
		    S2, reg(icol,CRIGHT), reg(icol,CRIGHT), S2);
	}
	if (doubled[icol])
	{
		printf(".nr %2s \\n(%d\n", reg(icol,CMID), S1);
		printf(".nr %d \\n(%2s+\\n(%d\n",
		    TMP, reg(icol,CMID), S2);
		printf(".if \\n(%d>\\n(%2s .nr %2s \\n(%d\n",
		    TMP, reg(icol,CRIGHT), reg(icol,CRIGHT), TMP);
		printf(".if \\n(%d<\\n(%2s .nr %2s +(\\n(%2s-\\n(%d)/2\n",
		    TMP, reg(icol,CRIGHT), reg(icol,CMID),
		    reg(icol,CRIGHT), TMP);
	}
	if (cll[icol][0]) /* User-specified column width */
	{
		printf(".nr %d %s\n", TMP, cll[icol]);
		printf(".if \\n(%2s<\\n(%d .nr %2s \\n(%d\n",
		    reg(icol,CRIGHT), TMP, reg(icol,CRIGHT), TMP);
	}
	for (ilin = 0; ilin < nlin; ilin++)
	{
		if (k = lspan(ilin, icol))
		{
			s = TABLE(ilin,icol-k).col;
			if ( ! real(s) || barent(s) || vspen(s) ) continue;
			printf(".nr %d ", TMP);
			wide(TABLE(ilin,icol-k).col, FN(ilin,icol-k), SZ(ilin,icol-k));
			for (ik = k; ik >= 0; ik--)
			{
				printf("-\\n(%2s", reg(icol-ik,CRIGHT));
				if ( ! expflg && ik > 0)
					printf("-%dn", sep[icol-ik]);
			}
			printf("\n");
			printf(".if \\n(%d>0 .nr %d \\n(%d/%d\n",
			    TMP, TMP, TMP, k);
			printf(".if \\n(%d<0 .nr %d 0\n", TMP, TMP);
			for (ik = 1; ik <= k; ik++)
			{
				if (doubled[icol-k+ik])
					printf(".nr %2s +\\n(%d/2\n",
					    reg(icol-k+ik,CMID), TMP);
				printf(".nr %2s +\\n(%d\n",
				    reg(icol-k+ik,CRIGHT), TMP);
			}
		}
	}
}

wide(s, fn, size) /* Generate code to calculate the width of string <s> */
char *s, *size, *fn;
{
	if (point(s))
	{
		printf("\\w%c", F1);
		if (*fn) putfont(fn);
		if (*size) putsize(size);
		printf("%s", s);
		if (*fn) putfont("P");
		if (*size) putsize("0");
		printf("%c", F1);
	}
	else
		printf("\\n(%c-", s);
}

filler(s) /* Returns 1 if s is a field-fill request (\Rx), otherwise 0 */
char *s;
{
	return(point(s) && s[0] == '\\' && s[1] == 'R');
}


/* t7.c: control to write table entries */


runout() /* Generate code to format the table */
{
	int i;

	pflag = 0;
	printf(".nr #I \\n(.i\n");
	if (ctrflg)
	{
		printf(".in +(\\n(.lu-\\n(TWu-\\n(.iu)/2u\n");
	}
	setfc();		/* Set field delimiter and pad character */
	printf(".nr #T 0-1\n");
	deftail();		/* Define macros for bottom-of-box processing*/
	for (i=0; i<nlin; i++)	/* Generate code for first Maxlin data lines */
	{
		putline(i, i);
	}
	if (leftover != NULL)	/* Process remaining data, if any */
		yetmore();
	cleanfc(); /* Turn off the field delimiter and pad character mechanism */
	if ( ! (boxflg || allflg || dboxflg) )
		check_prev();	/* Check for a deferred horizontal-line request */
	printf(".ch #f\n");	/* Remove bottom-of-page trap */
	printf(".nr T. 1\n");
	printf(".T# 1\n");
	printf(".in \\n(#Iu\n");
}

runtabs(lform, ldata) /* Set tab stops */
/* lform = index of format line */
/* ldata = index of data line */
{
	int c, ct, vforml, lf;

	printf(".ta ");
	for (c=0; c<ncol; c++)
	{
		vforml=lform;
		for (lf=prev(lform); lf>=0; lf=prev(lf))
		{
			if ( ! vspen(TABLE(lf,c).col))
				break;
			vforml = lf;
		}
		if (fspan(vforml,c))
			continue;
		ct=ctype(vforml,c);
		switch (ct)
		{
		case 'n':
		case 'a':
			if (TABLE(ldata,c).rcol)
				if (lused[c]) /*Zero field width*/
					printf("\\n(%2su ",reg(c,CMID));
			/* Fall through to next case */
		case 'c':
		case 'l':
		case 'r':
# define realsplit1 ((ct=='a'||ct=='n') && TABLE(ldata,c).rcol)
			if (realsplit1 ? rused[c] : (used[c]+lused[c]))
				printf("\\n(%2su ",reg(c,CRIGHT));
			continue;
		case 's':
			if (lspan(lform, c))
				printf("\\n(%2su ", reg(c,CRIGHT));
			continue;
		}
	}
	printf("\n");
}

ifline(s) /* Test for horizontal line through entry */
char *s;
{
	/* Returns '-' if s is a pointer to "-" or "\\-" */
	/* Returns '=' if s is a pointer to "=" or "\\=" */
	/* Returns 0 otherwise */
	if ( ! point(s)) return(0);
	if (s[0] == '\\') s++;
	if (s[1] ) return(0);
	if (s[0] == '_') return('-');
	if (s[0] == '=') return('=');
	return(0);
}

deftail() /* Generate code to define the bottom-of-page macro */
{
	int i, c, lf, lwid;

	/*
	 * This routine defines the 'tail' macro T#, which is used to
	 * draw the horizontal line for the bottom of the box and the
	 * vertical lines that separate columns and form the sides of
	 * the box.
	 *
	 * T# is called with T.==0 from TH; called with T.==1 from the
	 * page footer macro FO in -ms; called with T.==1 at the end
	 * of the table.
	 */
	for (i = 0; i < MAXHEAD; i++) /* Set linestop registers = -1 */
	{
		if (linestop[i])
			printf(".nr #%c 0-1\n", linestop[i]+'a'-1);
	}
	printf(".nr #a 0-1\n"); /* Make sure register #a = -1 */
	printf(".eo\n");	/* Turn off the escape mechanism */
	printf(".de T#\n");	/* Begin definition of macro T# */
	printf(".nr 35 1m\n");
	ifdivert();		/* Define string #d */
	printf(".mk ##\n");	/* Save current vertical position */
	printf(".nr ## -1v\n");
	printf(".ls 1\n");	/* Set line spacing to 1 */
	for (i = 0; i < MAXHEAD; i++) /* Set origin for vertical lines */
	{
		if (linestop[i])
			printf(".if \\n(#T>=0 .nr #%c \\n(#T\n", linestop[i]+'a'-1);
	}
	if (boxflg || allflg || dboxflg) /* Bottom of table line */
	{
		printf(".if \\n(T. .#h\n");
		/* Note:  T. is really an argument to a macro but because of
		   eqn can't reference by $1 */
	}
	for (c = 0; c < ncol; c++)
	{
		if ((lf=left(nlin-1,c,&lwid)) >= 0)
		{
			printf(".if \\n(#%c>=0 .sp -1\n", linestop[lf]+'a'-1);
			printf(".if \\n(#%c>=0 ", linestop[lf]+'a'-1);
			tohcol(c); /* Move to left edge of this column */
			drawvert(lf, nlin-1, c, lwid); /* Draw vertical line */
			printf("\\h'|\\n(TWu'\n"); /* Move to right edge of table */
		}
	}
	if (boxflg || allflg || dboxflg) /* right hand line */
	{
		printf(".if \\n(#a>=0 .sp -1\n");
		printf(".if \\n(#a>=0 \\h'|\\n(TWu'");
		drawvert(0, nlin-1, ncol, dboxflg ? 2 : 1);
		printf("\n");
	}
	printf(".ls\n"); /* Restore previous line spacing */
	printf("..\n");	/* End definition of macro T# */
	printf(".de #h\n"); /* Begin definition of macro #h */
	if ( ! pr1403)
		printf(".vs \\n(.vu-\\n(.sp\n");
	drawline(nlin, 0, ncol, dboxflg ? '=' : '-', 1, 0);
	printf("\n");
	if ( ! pr1403)
		printf(".vs\n");
	printf("..\n");	/* End definition of macro #h */
	printf(".ec\n"); /* Reenable the escape-character mechanism */
}


/* *** BEGIN t8.c *** */

/* t8.c: Generate code to format one row of the output table */

int nlsave, ctsave;

check_prev()
{
	if (pflag)
	{
		fullwide(nlsave, ctsave);
		pflag = 0;
	}
}

putline(i, nl) /* Process one line of input data */
/* i is the line number for selecting the format */
/* nl is the line number for finding the data (usually identical) */
{
	static int once;
	int cmidx = 0, watchout = 0, vspf = 0, exvspen = 0;
	int c, lf, ct, form, lwid, ip, vforml, vct, chfont, uphalf;
	char *s, *size, *fn;


	if (i==0)
	{
		once = 0; /* No previous line with real data */
		/* If this is a boxed table, draw line for top of box */
		if (allflg || boxflg || dboxflg)
			fullwide(0,   dboxflg? '=' : '-');
	}
	printf(".if \\n(#| .#f\n");

	if (instead[nl]==NULL && fullbot[nl]==0)
	{
		/*
		 * We now have a row with real data.  Calculate the amount
		 * of vertical space needed for this row and the deferred
		 * horizontal line, if any, that precedes it.
		 */
		/*
		 * The following code sets S1 to the text height without
		 * text blocks and sets S2 to the text height including
		 * text blocks.
		 */
		printf(".nr %2d 1v\n", S1); /* Set S1 = text height w/o text blocks */
		printf(".nr %2d \\n(%2d\n", S2, S1); /* Set S2 = S1 */
		/* Now set S2 to the height of the longest text block */
		for (c=0; c<ncol; c++)
		{
			s = TABLE(nl,c).col;
			if (s==0)
				continue;
			if (vspen(s))
			{
				for (ip=nl; ip<nlin; ip=next(ip))
					if ( ! vspen(s=TABLE(ip,c).col))
						break;
				if ((long int)s>0 && (long int)s<128)
				{
					printf(".nr %2d \\n(%c|u\n",TMP,s);
					printf(".if \\n(%2d>\\n(%2d .nr %2d \\n(%2du\n",
					    TMP, S2, S2, TMP);
				}
				continue;
			}
			if (point(s))
				continue;
			printf(".nr %2d \\n(%c|u\n", TMP, s);
			printf(".if \\n(%2d>\\n(%2d .nr %2d \\n(%2du\n",
			    TMP, S2, S2, TMP);
			watchout=1;
		}

		if (pflag)
		{
			printf(".nr %2d +(\\n(.vu-\\n(.sp)\n", S1);
			printf(".nr %2d +(\\n(.vu-\\n(.sp)\n", S2);
		}

		if (allflg || boxflg || dboxflg)
			printf(".nr %2d \\n(.tu-\\n(.vu+\\n(.sp\n", S9);
		else
			printf(".nr %2d \\n(.tu\n", S9);

		/* Registers S1, S2, and S9 now contain the following: */
		/* S1 = height of this row without text blocks */
		/* S2 = height of this row including text blocks */
		/* S9 = distance to bottom of box (bottom of page if no box) */
		printf(".nr %2d \\n(%2d\n", TMP, S2); /* Set TMP = S2 */
		/* If (S2>=S9 && S1<S9 && S9>Maxleft) then set TMP = S1 */
		printf(".if \\n(%2d>=\\n(%2d ", S2, S9);
		printf(".if \\n(%2d<\\n(%2d ", S1, S9);
		printf(".if \\n(%2du>%2s ", S9, Maxleft);
		printf(".nr %2d \\n(%2d\n", TMP, S1);
		printf(".if \\n(32>\\n(31 .nr %2d +\\n(.Vu\n", TMP);
		printf(".ne \\n(%2du\n", TMP);
	}

	if (instead[nl] != NULL)
	{
		/* This line of data is a troff request or macro call */
		check_prev();
		if (linestop[nl])
			printf(".mk #%c\n", linestop[nl]+'a'-1);
		puts(instead[nl]);
		if (in_header2 && prefix(".TH", instead[nl]))
		{
			in_header2 = 0;
			have_header = 1; /* This table has a header */
		}
		pflag = 0;
		return;
	}

	if (fullbot[nl])
	{
		/* Request for a full-width horizontal line or all entries vertically spanned */
		check_prev();
		if (linestop[nl])
			printf(".mk #%c\n", linestop[nl]+'a'-1);
		switch (ct = fullbot[nl])
		{
		case '=':
		case '-':
			nlsave = nl;
			ctsave = ct;
			pflag = 1;
			break;
		}
		return;
	}

	check_prev();
	if (linestop[nl])
	{
		/* Record current vertical position */
		printf(".mk #%c\n", linestop[nl]+'a'-1);
	}

	lf = prev(nl);
	if ( ! pr1403)
		printf(".nr %d \\n(%du+\\n(.du+0p\n", S2, S2);
	else
		printf(".nr %d \\n(%du+\\n(.du\n", S2, S2);

	for (c=0; c<ncol; c++)
	{
		if (instead[nl]==NULL && fullbot[nl]==0)
			if (vspen(TABLE(nl,c).col)) vspf=1;
		if (lf>=0)
			if (vspen(TABLE(lf,c).col)) vspf=1;
	}

	if (vspf)
	{
		printf(".nr #^ \\n(\\*(#du\n");
		printf(".nr #- \\n(#^\n"); /* Current line position relative to bottom */
	}
	vspf = 0;
	chfont = 0;
	for (c=0; c<ncol; c++)
	{
		s = TABLE(nl,c).col;
		if (s==NULL) continue;
		chfont |= (FN(nl,c) != NULL);
		if (point(s) ) continue;
		lf=prev(nl);
		if (lf>=0 && vspen(TABLE(lf,c).col))
			printf(".if (\\n(%c|+\\n(^%c-1v)>\\n(#- .nr #- +(\\n(%c|+\\n(^%c-\\n(#--1v)\n",
			    s, 'a'+c, s, 'a'+c);
		else
			printf(".if (\\n(%c|+\\n(#^-1v)>\\n(#- .nr #- +(\\n(%c|+\\n(#^-\\n(#--1v)\n",s,s);
	}
	if (allflg && once>0)
	{
		fullwide(i,'-');
	}
	once=1;

	runtabs(i, nl);     /* Set tab stops */
	printf(".mk ##\n"); /* Save current vertical position */
	if (allh(i) && ! pr1403)
	{
		printf(".nr %d \\n(.v\n", SVS);
		printf(".vs \\n(.vu-\\n(.sp\n");
		printf(".nr 35 \\n(.vu\n");
	}
	else
		printf(".nr 35 1m\n");
	if (chfont)
	{
		printf(".nr %2d \\n(.f\n", S1);
		printf(".ie \\n(%2d>9 .ds #e (\\n(%2d\n", S1, S1);
		printf(".el .ds #e \\n(%2d\n", S1);
	}
	output("\\&");
	vct = 0;
	for (c=0; c<ncol; c++)
	{
		uphalf = 0;
		if ( ! watchout && i+1<nlin && (lf=left(i,c,&lwid))>=0)
		{
			tohcol(c);
			drawvert(lf, i, c, lwid);
			vct += 2;
		}
		if (rightl && c+1==ncol) continue;
		vforml = i;
		for (lf=prev(nl); lf>=0 && vspen(TABLE(lf,c).col); lf=prev(lf))
			vforml = lf;
		form = ctype(vforml,c);
		if (form != 's')
		{
			char *cct;

			if (form=='a')
				cct = reg(c,CMID);
			else if (form=='n' && TABLE(nl,c).rcol && lused[c]==0)
				cct = reg(c,CMID);
			else
				cct = reg(c,CLEFT);
			output2("\\h'|\\n(%2su'", cct);
		}
		s = TABLE(nl,c).col;
		fn = FN(vforml,c);
		size = SZ(vforml,c);
		if (*size==0) size = 0;
		if ((FLGS(nl,c)&HALFUP) && ! pr1403)
			uphalf=1;
		switch (ct=ctype(vforml, c))
		{
		case 'n':
		case 'a':
			if (TABLE(nl,c).rcol != NULL)
			{
				if (lused[c]) /* Zero field width */
				{
					ip = prev(nl);
					if (ip>=0)
					{
						if (vspen(TABLE(ip,c).col))
						{
							if (exvspen==0)
							{
								output2("\\v'-(\\n(\\*(#du-\\n(^%cu", c+'a');
								if (cmidx)
/* code folded from here */
	output2("-((\\n(#-u-\\n(^%cu)/2u)", c+'a');
/* unfolding */
								vct++;
								if (pr1403) /* must round to whole lines */
/* code folded from here */
	output("/1v*1v");
/* unfolding */
								output("'");
								exvspen=1;
							}
						}
					}
					output3("%c%c", F1, F2);
					if (uphalf) output("\\u");
					puttext(s, fn, size);
					if (uphalf) output("\\d");
					output2("%c", F1);
				}
				s = TABLE(nl,c).rcol;
				form=1;
				break;
			}
			/* Fall through to next case */
		case 'c':
			form=3;
			break;
		case 'r':
			form=2;
			break;
		case 'l':
			form=1;
			break;
		case '-':
		case '=':
			if (real(TABLE(nl,c).col))
				fprintf(stderr,
				    "File %s, line %d: Warning: Data ignored on table line %d\n",
				    ifile, iline-1, i+1);
			makeline(i, c, ct); /* Draw a horizontal line */
			continue;
		default:
			continue;
		}
#define realsplit2 ((ct=='a'||ct=='n') && TABLE(nl,c).rcol)
		if (realsplit2 ? rused[c]: used[c]) /* Zero field width */
		{
			int k;

			/* form: 1 left, 2 right, 3 center adjust */
			if (k=ifline(s)) /* Horizontal line through entry */
			{
				makeline(i,c,k); /* Draw a horizontal line */
				continue;
			}
			if (filler(s)) /* Field-fill request */
			{
				output3("\\l'|\\n(%2su\\&%s'", reg(c,CRIGHT), s+2);
				continue;
			}
			ip = prev(nl);
			cmidx = (FLGS(nl,c) & (CTOP|CDOWN))==0;
			if (ip>=0 && vspen(TABLE(ip,c).col))
			{
				if (exvspen==0)
				{
					output2("\\v'-(\\n(\\*(#du-\\n(^%cu", c+'a');
					if (cmidx)
						output2("-((\\n(#-u-\\n(^%cu)/2u)", c+'a');
					vct++;
					if (pr1403) /* Round to whole lines */
						output("/1v*1v");
					output("'");
				}
			}
			output2("%c", F1);
			if (form != 1)
				output2("%c", F2);
			if (vspen(s))
				vspf = 1;
			else
			{
				if (uphalf) output("\\u");
				puttext(s, fn, size);
				if (uphalf) output("\\d");
			}
			if (form != 2)
				output2("%c", F2);
			output2("%c", F1);
		}
		ip = prev(nl);
		if (ip>=0)
		{
			if (vspen(TABLE(ip,c).col))
			{
				exvspen = (c+1 < ncol) &&
				    vspen(TABLE(ip,c+1).col) &&
				    (topat[c] == topat[c+1]) &&
				    (cmidx == (FLGS(nl,c+1)&(CTOP|CDOWN)==0)) &&
				    (left(i,c+1,&lwid)<0); /*TEMP--DUBIOUS CODE*/
				if (exvspen==0)
				{
					output2("\\v'(\\n(\\*(#du-\\n(^%cu", c+'a');
					if (cmidx)
						output2("-((\\n(#-u-\\n(^%cu)/2u)", c+'a');
					vct++;
					if (pr1403) /* round to whole lines */
						output("/1v*1v");
					output("'");
				}
			}
			else
				exvspen=0;
		}
		/* If long requests need to be split, here is the place for a backslash */
		if (vct > 7 && c < ncol)
		{
			output("\n.sp-1\n\\&");
			vct=0;
		}
	}
	output("\n");
	if (allh(i) && ! pr1403) printf(".vs \\n(%du\n", SVS);
	if (watchout)
		funnies(i, nl); /* Write out text blocks */
	if (vspf)
	{
		for (c=0; c<ncol; c++)
		{
			if (vspen(TABLE(nl,c).col) &&
			    (nl==0 || (lf=prev(nl))<0 || !vspen(TABLE(lf,c).col)))
			{
				printf(".nr ^%c \\n(#^u\n", 'a'+c);
				topat[c]=nl;
			}
		}
	}
}

puttext(s, fn, size) /* Generate code to output some text */
char *s, *size, *fn;
{
	if (point(s))
	{
		putfont(fn);
		putsize(size);
		printf("%s", s);
		if (*fn)
			printf("\\f\\*(#e");
		if (size != NULL)
			putsize("0");
	}
}

funnies(stl, lin) /* Write out funny diverted things */
/* stl is the line number for selecting the format */
/* lin is the line number for finding the data (usually identical) */
{
	int c, pl, lwid, dv, lf, ct;
	char *fn, *s;

	printf(".mk %d\n", S1); /* Set S1 = current vertical position */
	for (c=0; c<ncol; c++)
	{
		s = TABLE(lin,c).col;
		if (s==NULL || point(s)) continue; /* Not a text block */
		printf(".sp |\\n(##u\n");
		printf(".nr %d ", SIND);
		ct = 'l'; /* Just in case */
		for (pl=stl; pl>=0; pl=prev(pl))
		{
			if (isalpha(ct=ctype(pl,c)))
				break;
		}
		switch (ct)
		{
		case 'n':
		case 'c':
			printf("(\\n(%2su+\\n(%2su-\\n(%c-u)/2u\n",
			    reg(c,CLEFT), reg(c-1+ctspan(lin,c),CRIGHT), (long int)s);
			break;
		case 'l':
			printf("\\n(%2su\n", reg(c,CLEFT));
			break;
		case 'a':
			printf("\\n(%2su\n", reg(c,CMID));
			break;
		case 'r':
			printf("\\n(%2su-\\n(%c-u\n", reg(c,CRIGHT), s);
			break;
		}
		printf(".in +\\n(%du\n", SIND); /* Set left margin for this column */
		pl = prev(stl);
		if (stl>0 && pl>=0 && vspen(TABLE(pl,c).col))
		{
			printf(".sp |\\n(^%cu\n", 'a'+c);
			if ((FLGS(stl,c)&(CTOP|CDOWN))==0)
			{
				printf(".nr %d \\n(#-u-\\n(^%c-\\n(%c|+1v\n",
				    TMP, 'a'+c, s);
				printf(".if \\n(%d>0 .sp \\n(%du/2u", TMP, TMP);
				if (pr1403) /* round */
					printf("/1v*1v");
				printf("\n");
			}
		}
		printf(".ie \\n(%c|>=\\n(.t .nr #& 1\n", s);
		printf(".el .nr #& 0\n");
		fn = FN(stl,c);
		putfont(fn);
		printf(".%c+\n",s); /* Output saved text block */
		printf(".#%%\n");
		printf(".in -\\n(%du\n", SIND); /* Restore previous margin */
		if (*fn) putfont("P"); /* Restore previous font */
		printf(".mk %d\n", TMP); /* Save current vertical position */
		printf(".if \\n(%d>\\n(%d .nr %d \\n(%d\n", TMP, S1, S1, TMP);
	}
	printf(".if \\n(#| .if \\n(dn>0 .#f\n");
	printf(".sp |\\n(%du\n", S1); /* Restore previous vertical position */
	for (c=dv=0; c<ncol; c++)
	{
		if ((stl+1)<nlin && (lf=left(stl,c,&lwid))>=0)
		{
			if (dv++ == 0)
				printf(".sp -1\n");
			tohcol(c); /* Move to left edge of column */
			drawvert(lf, stl, c, lwid); /* Draw a vertical line */
		}
	}
	if (dv)
		printf("\n");
} /* End funnies() */

putfont(fn) /* Generate an in-line font-change request */
char *fn;
{
	if (fn != NULL && *fn)
		printf( fn[1] ? "\\f(%.2s" : "\\f%.2s", fn);
}

putsize(s) /* Generate an in-line point-size change request */
char *s;
{
	if (s != NULL && *s)
		printf("\\s%s", s);
}

multipg() /* Initialize stuff for multi-page boxed tables */
{
	int c;

	if (Ropt) return;
	printf(".if \\(ts\\n(.z\\(ts\\(ts .wh \\n(nlu+\\n(.tu-2v #f\n");
	printf(".nr #| 0\n");
	printf(".de #f\n"); /* Begin definition of macro #f */
	printf(".ie \\\\n(#& \\{ \\\n");
	printf(".\tnr #& 0\n");
	printf(".\tnr #| 1\n");
	printf(".\tdi #o \\}\n");
	printf(".el \\{ \\\n");
	printf(".\tch #f\n");
	printf(".\tnr T. 1\n");
	printf(".\tT#\n");
	printf(".\tsp \\\\n(.tu\n");
	printf(".\tmk #T\n");
	for (c = 0; c < ncol; c++)
	{
		printf(".\tnr ^%c \\\\n(#T\n", 'a'+c);
	}
	printf(".\tif \\\\n(#| \\{ \\\n");
	printf(".\t\tin 0\n");
	printf(".\t\t#+\n"); /* Write out diversion */
	printf(".\t\trm #+\n");
	printf(".\t\tmk %d\n", S2);
	printf(".\t\tnr %d \\\\n(%d\n", S1, S2);
	printf(".\t\tnr #| 0\n");
	printf(".\t\tin \\}\n");
	printf(".\tif \\\\(ts\\\\n(.z\\\\(ts\\\\(ts .wh \\\\n(nlu+\\\\n(.tu-2v #f \\}\n");
	printf("..\n"); /* End definition of macro #f */
	printf(".de #%%\n"); /* Begin definition of macro #% */
	printf(".if \\\\(ts\\\\n(.z\\\\(ts#o\\\\(ts \\{ \\\n");
	printf(".\tsp |0u\n");
	printf(".\tin 0\n");
	printf(".\t#+\n");
	printf(".\tin\n");
	printf(".\tsp |\\\\n(.hu\n");
	printf(".\tdi\n");
	printf(".\trn #o #+ \\}\n");
	printf("..\n");	/* End definition of macro #% */
}

/* *** END t8.c *** */

/* t9.c: Generate code for rows after the first Maxlin rows */

static useln;

yetmore() /* Process the rest of the input data */
{
	/* Called from runout() when there are more than Maxlin lines */
	/* of input data */
	char *cstore;

	for (useln = 0; useln < Maxlin; useln++)
	{
		if (table[useln] != NULL)
			break;
	}
	if (useln >= Maxlin)
		fatal_error("Weird--no data in table.");
	table[0] = table[useln]; /* ? */
	for (useln = nlin-1; useln >= 0; useln--)
	{
		if (fullbot[useln] == 0 && instead[useln] == NULL) /* data */
			break;
	}
	if (useln < 0)
		fatal_error("Weird--no real lines in table.");
	in_overflow = 1; /* Indicates beyond first Maxlin rows */
	domore(leftover);
	while ((cstore = gets1(inbuf, sizeof(inbuf))) != NULL)
		if ( ! domore(cstore))
			break;
	last = cstore;
}

domore(dataln) /* Process one line of data */
char *dataln;
/* This routine is called to process each data line after the first 200 or so */
{
	int icol, ch;
	char *cp;

	if (is_table_end(dataln))
		return(0);
	if (prefix(".T&", dataln))
	{
		warning("Too much data preceding table-change (.T&) request--request ignored.");
		return 1;
	}
	if (istroff(dataln)) /* troff request or macro call */
	{
		puts(dataln);
		return(1);
	}
	fullbot[0] = 0;
	instead[0] = NULL;
	if (dataln[1] == 0)
	{
		switch (dataln[0])
		{
		case '_':
			fullbot[0] = '-';
			putline(useln, 0);
			return(1);
		case '=':
			fullbot[0] = '=';
			putline(useln, 0);
			return(1);
		}
	}

	/*
	 * The following code allows an unlimited number of text blocks
	 * after the first Maxlin lines of input data.
	 */
	/*
	 * First get rid of previous text blocks, if any, and clear the
	 * macros used to record and define text blocks
	 */
	cleartext();
	printf(".rm");
	for (icol = 0; icol < ncol; icol++)
		printf(" %2s", reg(icol,CRIGHT));
	printf("\n");
	/* Now get the data for this row */
	textflg = 0;
	for (icol = 0; icol < ncol; icol++)
	{
		struct colstr *p = &TABLE(0,icol);

		p->rcol = NULL;
		ch = 1;
		if (streql(dataln, "T{")) /* Text block follows */
		{
			p->col = (char *)dwb_gettext(&dataln, useln, icol);
			printf(".%2s\n.rm %2s\n",
			    reg(icol,CRIGHT), reg(icol,CRIGHT));
		}
		else
		{
			for (cp = dataln; (ch = *cp) != '\0'; cp++)
			{
				if (ch == tab)
				{
					*cp++ = '\0';
					break;
				}
			}
			p->col = strsave(dataln);
			dataln = cp;
			/* Fix up numeric or alpha subcolumn */
			switch (ctype(useln, icol))
			{
			case 'n':
				/* split numeric field into two parts */
				p->rcol = maknew(p->col);
				break;
			case 'a':
				/* move text pointer */
				p->rcol = p->col;
				p->col = "";
				break;
			}
		}
		while (ctype(useln, icol+1) == 's') /* spanning */
			TABLE(0,++icol).col = "";
		if (ch == '\0') break; /* end of line */
	}
	if (textflg)
		untext(); /* Restore line length saved in gettext() */
	while (++icol < ncol)
	{
		TABLE(0,icol).col = "";
		TABLE(0,icol).rcol = NULL;
	}
	putline(useln, 0); /* Generate code to format this row */
	ch_release(); /* Release string-storage space */
	return(1);
}

/* tb.c: check which entries exist, also storage allocation */


checkuse() /* Flag columns with real data */
{
	int i, c, k;


	for (c = 0; c < ncol; c++)
	{
		used[c] = lused[c] = rused[c] = 0;
		for (i = 0; i < nlin; i++)
		{
			if (instead[i] != NULL || fullbot[i]) continue;
			switch (ctype(i,c))
			{
			case '-':
			case '=':
				continue;
			case 'n':
			case 'a':
				k = real(TABLE(i,c).rcol);
				rused[c] |= k;
				if ( ! k)
					used[c] |= real(TABLE(i,c).col);
				if (TABLE(i,c).rcol != NULL)
					lused[c] |= real(TABLE(i,c).col);
				break;
			default:
				used[c] |= real(TABLE(i,c).col);
			}
		}
	}
}

/*
 * Returns 1 if s is an ASCII character or a pointer to a non-null string,
 * otherwise 0
 */
real(s)
char *s;
{
	if (s == NULL) return(0); /* Null pointer */
	if (ischar(s)) return(1); /* ASCII character (text block) */
	if (*s == 0) return(0); /* Pointer to non-null string */
	return(1);
}

#define	MAXVEC 20
char *spvecs[MAXVEC];
int spcount = 0; /* Number of non-null pointers in spvecs */

char *
chspace() /* Allocate a character buffer--reuse previous if available */
{
	char *pp;

	if (spvecs[spcount])
		return(spvecs[spcount++]);
	if (spcount >= MAXVEC)
		fatal_error("Too many characters in table");
	spvecs[spcount++] = pp = calloc(MAXCHS+200, 1);
	if (pp == (char *)-1 || pp == NULL)
		fatal_error("No space for characters");
	return(pp);
}

char *saveptr = NULL, *savelim;

char *
strsave(s) /* Create a copy of string s */
char *s;
{
	int i;
	char *t;

	i = strlen(s) + 1;
	if (saveptr==NULL || saveptr+i>=savelim)
	{
		saveptr = chspace();
		savelim = saveptr + MAXCHS - 1;
	}
	t = saveptr;
	saveptr += i;
	strcpy(t, s);
	return(t);
}

#define	MAXPC 50
char *thisvec, *tpvecs[MAXPC];
int tpcount = -1;

struct colstr *
alocv(n) /* Allocate one row of 'table' structures */
int n;	/* Number of structures needed */
{
	int *tp, *q;

	n *= sizeof(struct colstr);
	if (tpcount < 0 || thisvec+n > tpvecs[tpcount]+MAXCHS)
	{
		tpcount++;
		if (tpvecs[tpcount] == 0)
		{
			tpvecs[tpcount] = calloc(MAXCHS, 1);
		}
		thisvec = tpvecs[tpcount];
		if (thisvec == NULL)
			fatal_error("No space for vectors");
	}
	tp = (int *)thisvec;
	thisvec += n;
	for (q = tp; q < (int *)thisvec; q++)
		*q = 0;
	return((struct colstr *)tp);
}

release() /* Make available for reuse the space obtained via chspace()
	     and alocv() */
{

	ch_release(); /* Release space used to save strings */
	tpcount = -1; /* Release space used for 'table' structures */
}

ch_release() /* Make available for reuse the space obtained via chspace() */
{
	spcount = 0;
	saveptr = NULL;
}

/* tc.c: find character not in table to delimit fields */

choochar() /* Choose troff pad character and field delimiter character */
{
	int had[128], ilin, icol, k;
	char *s;


	for (icol = 0; icol < 128; icol++)
		had[icol] = 0;
	F1 = F2 = 0;
	for (ilin = 0;ilin < nlin;ilin++)
	{
		if (fullbot[ilin] || instead[ilin] != NULL) continue;
		for (icol = 0; icol < ncol; icol++)
		{
			k = ctype(ilin, icol);
			if (k == 0 || k == '-' || k == '=')
				continue;
			s = TABLE(ilin,icol).col;
			if (point(s))
				while (*s)
					had[*s++] = 1;
			s = TABLE(ilin,icol).rcol;
			if (point(s))
				while (*s)
					had[*s++] = 1;
		}
	}
	/* Choose field delimiter character */
	for (s = "\002\003\005\006\007!%&#/?,:;<=>@`^~_{}+-*ABCDEFGHIJKMNOPQRSTUVWXYZabcdefgjkoqrstwxyz";
	    *s; s++)
	{
		if (had[*s] == 0)
		{
			F1 = *s;
			had[F1] = 1;
			break;
		}
	}
	/* Choose pad character */
	for (s = "\002\003\005\006\007:_~^`@;,<=>#%&!/?{}+-*ABCDEFGHIJKMNOPQRSTUVWXZabcdefgjkoqrstuwxyz";
	    *s; s++)
	{
		if (had[*s] == 0)
		{
			F2 = *s;
			break;
		}
	}
	if (F1 == 0 || F2 == 0)
		fatal_error("Couldn't find characters to use for delimiters");
}

point(s) /* Returns 1 if s is a non-null pointer, otherwise 0 */
char *s;
{
	return((long)s >= 128 || (long)s < 0);
}

ischar(s) /* Returns 1 if s is really an ASCII character (not a pointer), */
/* otherwise 0 */
char *s;
{
	return((long)s > 0 && (long)s < 128);
}

istroff(s) /* Returns 1 if s is a troff request or a macro call, otherwise 0 */
char *s;
{
	return (*s == '.' && ! isdigit(*(s+1)));
}

is_table_start(s) /* Returns 1 if s is a table-start request, otherwise 0 */
char *s;
{
	char c;

	Hflag = 0;
	if ( ! prefix(".TS", s))
		return 0;
	for (s += strlen(".TS"); ((c=*s++)==' ' || c=='\t'); )
		;
	if (c == 'H' && *s=='\0' || *s==' ' || *s=='\t')
		Hflag = 1;
	return 1;
}

is_table_end(s) /* Returns 1 if s is a table-end request, otherwise 0 */
char *s;
{
	if ( ! prefix(".TE", s))
		return 0;
	return 1;
}

is_include(s) /* Returns 1 if s is a file-inclusion request, otherwise 0 */
char *s;
{
	FILENAME namebuf;
	int c, n;
	int delim = 0;
	char *p;

	if ( ! prefix(".T&", s))
		return 0;
	s += strlen(".T&");
	while (*s == ' ' || *s == '\t')
		s++;
	if (*s == '\0')
		return 0;
	if (*s++ != '<')
	{
		warning("Non-blank characters following .T&--ignored.");
		return 0;
	}
	while (*s == ' ' || *s == '\t')
		s++;
	if (*s == '\"')
	{
		delim = '\"';
		s++;
	}
	n = 0;
	for (p = s; (c = *p) != '\0'; p++)
	{
		if (c == ' ' || c == '\t' || c == '\n' || c == delim)
			break;
		if (n < sizeof(namebuf))
			namebuf[n++] = c;
	}
	if (n >= sizeof(namebuf))
		error("File name exceeds maximum length.");
	namebuf[n++] = '\0';
	if (delim)
	{
		if (*p != delim)
			error("Syntax error in file-inclusion request.");
		p++;
	}
	if (*p != '\0')
	{
		/* Make sure remainder of line is blank */
		while (*p == ' ' || *p == '\t')
			p++;
		if (*p != '\0' && *p != '\n')
			error("Syntax error in file-inclusion request.");
	}
	if (pushfd())
		error("Too many nested file references.");
	if (open_for_input(namebuf))
	{
		popfd();
		error2("Can't access file %s.", namebuf);
	}
	return 1;
}

open_for_input(s)	/* Divert input to a specified file */
char *s;
{
	tabin = fopen(s, "r");
	if (tabin == NULL)
		return 3;
	ifile = strcpy(current_name, s);
	iline = 0;
	print_file_info();
	return 0;
}

pushfd()	/* Push current input file */
{
	struct file_item *p;

	if (nfd >= MAX_FILES)
		return 1;
	p = &file_stack[nfd++];
	strcpy(p->filename, current_name);
	p->fileptr = tabin;
	p->line_nr = iline;
	return 0;
}

popfd()		/* Restore (pop) previous input file */
{
	struct file_item *p;

	if (nfd <= 0)
		return 1;
	fclose(tabin);
	p = &file_stack[--nfd];
	tabin = p->fileptr;
	ifile = strcpy(current_name, p->filename);
	iline = p->line_nr;
	return 0;
}

print_file_info()
{
	printf(".ds f. %s\n", ifile);
	printf(".lf %d %s\n", iline+1, ifile);
}

/* te.c: error message control, input line count */

error1(s) /* Display error message and set error flag */
char *s;
{
	fprintf(stderr, "File %s, line %d: %s\n", ifile, iline, s);
	errflg = 1;
	if (errterm)
		bailout();
	if (++errcnt1 >= MAX_ERR1)
	{
		fprintf(stderr, "Too many errors!\n");
		bailout();
	}
	if (++errcnt2 >= MAX_ERR2)
	{
		fprintf(stderr, "Too many errors in this table.\n");
		skip_input();
		ungetline(inbuf);
	}
}

fatal_error(s) /* Display an error message and exit */
char *s;
{
	fprintf(stderr, "\n%s: line %d: %s\n", ifile, iline, s);
	bailout();
}

bailout()
{
	fprintf(stderr, "tbl quits\n");
	exit(1);
}

int
dwb_getline(char *s, int nmax)
/* char *s;  input buffer */
/* int nmax;  size of input buffer */
/*
 * Get an input line, keeping track of the input line number
 * and switching from one input source to another as necessary.
 * Returns 0 if no more input is available, otherwise the number
 * of characters read, including the trailing newline.
 */
{
	int i, c;

	if (have_buffer)
	{
		strcpy(s, savebuf);
		have_buffer = 0;
		return strlen(s);
	}
	while (fgets(s, nmax, tabin) == NULL)
	{
		if (swapin())
			return 0;
	}
	iline++;
	for (i = 0; i < nmax; i++)
	{
		c = s[i];
		if (c == '\n' || c == '\0')
			break;
	}
	if (i >= nmax-1)
		fatal_error("Input line too long");
	else if (s[i] != '\n')
		fatal_error("Truncated input line");
	return(i+1);
}

ungetline(s)	/* Put back an input line */
char *s;
{
	if (have_buffer)
		fatal_error("Too much backup!");
	strcpy(savebuf, s);
	have_buffer = 1;
}

char *
gets1(s, nmax) /* Get an input line */
char *s;
/* Get an input line, concatenating continuation lines, if any */
{
	char *p = s;
	int i, nbl;

	i = dwb_getline(s, nmax);
	if (i == 0)
		return NULL;
	s += i - 1;
	*s-- = 0; /* Get rid of trailing newline */

	/* Check for escaped newline */
	for (nbl = 0; *s == '\\' && s > p; s--)
		nbl++;
	s++;
	if (linstart && nbl % 2) /* fold escaped nl if in table */
		if (gets1(s, p+nmax-s) == NULL) /* recursive */
			fatal_error("Unexpected end-of-file");
	return(p);
}

/* tf.c: save and restore fill mode around table */

savefill() /* Save context */
{
	/* Remembers various things--fill mode, vs, ps--in macro SF (35) */
	printf(".de %d\n", SF);	/* Begin definition of macro 35 */
	printf(".ta \\n(.S\n");
	printf(".ps \\n(.s\n");
	printf(".vs \\n(.vu\n");
	printf(".in \\n(.iu\n");
	printf(".if \\n(.u .fi\n");
	printf(".if \\n(.j .ad\n");
	printf(".if \\n(.j=0 .na\n");
	printf("..\n");	/* End definition of macro 35 */
	printf(".nf\n");
	printf(".nr #~ 0\n");
	printf(".if \\n(.T .if n .nr #~ 0.6n\n"); /* Set box offset if useful */
}

rstofill() /* Restore the context saved by savefill() */
{
	printf(".%d\n", SF);
}

endoff() /* Clean up after one table */
{
	int i;


	if (Gdbytes) {	/* Do this only if linestop has been allocated */
		for (i = 0; i < MAXHEAD; i++)
			if (linestop[i])
				printf(".nr #%c 0\n", linestop[i]+'a'-1);
	}
	cleartext();
	printf("%s\n", last);	/* Copy .TE to output */
}

ifdivert() /* Generate code to define string #d */
{
	/* Set #d = ".d" if currently in a diversion */
	/* Set #d = "nl" if no current diversion */
	printf(".ds #d .d\n");
	printf(".if \\(ts\\n(.z\\(ts\\(ts .ds #d nl\n");
}

cleartext()
{
	int i;

	for (i = 0; i < texct; i++) /* Get rid of text blocks */
		printf(".rm %c+\n", texstr[i]);
	texct = 0;	/* Set number of text blocks = 0 */
}

saveline() /* Save input line number */
{
	printf(".if \\n+(b.=1 .nr d. \\n(.c-\\n(c.-1\n");
	linstart = iline;
}

restline() /* Restore input line number */
{
	printf(".if \\n-(b.=0 .nr c. \\n(.c-\\n(d.-%d\n", iline-linstart);
	linstart = 0;
}

setfc() /* Turn on the field delimiter and pad character mechanism */
{
	printf(".fc %c %c\n", F1, F2); /* Set field delimiter and pad character */
}

cleanfc() /* Turn off the field delimiter and pad character mechanism */
{
	printf(".fc\n");
}

/* tg.c: process included text blocks */

long int
dwb_gettext(char **sp, int ilin, int icol) /* Read in a text block */
/* char **sp;  Address of pointer into input line buffer */
{
	long int texname;
	char line[4096];
	char *fn = FN(ilin, icol);
	char *sz = SZ(ilin, icol);
	char *vs = VS(ilin, icol);

	texname = texstr[texct++]; /* Allocate a name for this text block */
	if (texname == 0) /* Null byte at end of string */
		fatal_error("Too many text block diversions");
	if (textflg == 0) /* Remember old line length if not already done */
	{
		printf(".nr %d \\n(.lu\n", SL);
		textflg = 1;
	}
	printf(".eo\n"); /* Turn off the escape character mechanism */
	printf(".am %s %c+\n", reg(icol,CRIGHT), texname);/* Begin macro append */
	printf(".br\n");
	printf(".di %c+\n", texname); /* Begin output diversion */
	rstofill(); /* Output code to restore beginning-of-table context */
	if (fn != NULL && *fn)
		printf(".nr %d \\n(.f\n.ft %s\n", S1, fn);
	printf(".ft \\n(.f\n"); /* protect font */
	if ((sz != NULL && *sz) || (vs != NULL && *vs))
	{
		printf(".nr %d \\n(.v\n", S9);
		if (vs == NULL || *vs == 0) vs = "\\n(.s+2";
		if (sz != NULL && *sz)
			printf(".ps %s\n", sz);
		printf(".vs %s\n", vs);
		printf(".if \\n(%du>\\n(.vu .sp \\n(%du-\\n(.vu\n", S9, S9);
	}
	if (cll[icol][0])
		printf(".ll %s\n", cll[icol]); /* Set user-specified line length */
	else
		printf(".ll \\n(%du*%du/%du\n", SL, ctspan(ilin,icol), ncol+1);
	if (in_overflow)
		printf(".nr %2d \\n(%s-\\n(%2s\n",
		    TMP, reg(icol,CRIGHT), reg(icol,CLEFT));
	else
		printf(".nr %2d \\n(%s\n", TMP, reg(icol,CRIGHT));
	printf(".if \\n(.l<\\n(%2d .ll \\n(%2du\n", TMP, TMP);
	if (ctype(ilin,icol) == 'a')
		printf(".ll -2n\n");
	printf(".in 0\n");
	while (gets1(line, sizeof(line)) != NULL)
	{
		if (line[0] == 'T' && line[1] == '}' && line[2] == tab) break;
		if (streql("T}", line)) break;
		printf("%s\n", line);
	}
	if (fn != NULL && *fn) printf(".ft \\n(%d\n", S1);
	if (sz != NULL && *sz) printf(".br\n.ps\n.vs\n");
	printf(".br\n");
	printf(".di\n"); /* Terminate output diversion */
	printf(".nr %c| \\n(dn\n", texname);/* Save height of this text block*/
	printf(".nr %c- \\n(dl\n", texname); /* Save width of this text block*/
	printf(".%c+\n", texname);/* Terminate macro append */
	printf(".ec \\\n"); /* Reenable the escape-character mechanism */
	if (line[2]) /* Text following T} */
		strcpy(*sp, line+3); /* Append remainder of input line to original input */
	else
		**sp = 0;
	return(texname);
}

untext() /* Restore line length saved in gettext() */
{
	rstofill();
	printf(".nf\n");
	printf(".ll \\n(%du\n", SL);
}

/* ti.c: classify line intersections */

interv(i, c) /* Determine local environment for intersections */
{
	/* Returns TOP if a line extends upward from this entry */
	/* Returns BOTTOM if a line extends downward from this entry */
	/* Returns THRU if a vertical line goes through this entry */
	/* Returns 0 otherwise */
	int ku, kl;

	if (c >= ncol || c == 0)
	{
		if (dboxflg)
		{
			if (i == 0) return(BOTTOM);
			if (i >= nlin) return(TOP);
			return(THRU);
		}
		if (c >= ncol)
			return(0);
	}
	ku = i > 0 ? lefdata(i-1,c) : 0; /* type of line extending upward */
	kl = (i+1>=nlin && allh(i)) ? 0 :
	    lefdata(allh(i) ? i+1 : i, c); /* type of line extending downward */
	if (ku == 2 && kl == 2) return(THRU);
	if (ku == 2) return(TOP);
	if (kl == BOTTOM) return(2);
	return(0);
}

interh(i, c) /* Determine local environment for intersections */
/* i = row, c = column */
{
	/* Returns LEFT if line extends to the left of this column */
	/* Returns RIGHT if line extends to the right of this column */
	/* Returns THRU if line extends through this column */
	/* Returns 0 otherwise */
	int kl, kr;

	if (fullbot[i] == '=' || (dboxflg && (i == 0 || i >= nlin-1)))
	{
		if (c == ncol)
			return(LEFT);
		if (c == 0)
			return(RIGHT);
		return(THRU);
	}
	if (i >= nlin) return(0);
	kl = c > 0 ? thish(i,c-1) : 0; /* kl = type of line to left */
	if (kl <= 1 && i > 0 && allh(up1(i)))
		kl = c > 0 ? thish(up1(i),c-1) : 0;
	kr = thish(i, c); /* kr = type of line to right */
	if (kr <= 1 && i > 0 && allh(up1(i)))
		kr = c > 0 ? thish(up1(i), c) : 0;
	if (kl == '=' && kr == '=') return(THRU);
	if (kl == '=') return(LEFT);
	if (kr == '=') return(RIGHT);
	return(0);
}

up1(i) /* Find previous row with horizontal line or data */
{
	/* returns row number if one found, otherwise 0 */
	while (--i > 0)
		if (instead[i] == NULL)
			break;
	return(i);
}

/* tm.c: split numerical fields */

char *
maknew(str) /* Split a numeric field into two parts */
char *str;
{
	int c;
	int ineqn = 0;
	char *p, *q;
	char *ba = NULL, *dpoint = NULL, *lastdigit = NULL;

	/* First look for \&; it overrides decimal point */
	for (p = str; c = *p; p++)
	{
		if (c == '\\' && p[1] == '&')
			ba = p;
	}

	if (ba == NULL) /* Didn't find \& */
	{
		/* Look for rightmost dot with adjacent digit */
		for (p = str; c = *p; p++)
		{
			if (ineqn)
			{
				if (c == delim2)
					ineqn = 0;
			}
			else
			{
				if (c == delim1)
					ineqn = 1;
				else if (c == '.')
				{
					if (isdigit(p[1]) ||
					    (p>str && isdigit(p[-1])))
						dpoint = p;
				}
				else if (isdigit(c))
					lastdigit = p;
			}
		}
	}
	if (ba != NULL)
		p = ba;
	else if (dpoint != NULL)
		p = dpoint;
	else if (lastdigit != NULL)
		p = lastdigit + 1;
	else
		return(NULL); /* Not numeric, so don't split */
	q = strsave(p);	/* Make a copy of text after units position */
	*p = 0;		/* Truncate input string after units position */
	return(q);	/* Return pointer to saved text */
}

/* tr.c: number register allocation */

char *nregs[] = {
	/* This array must have at least 3*qcol entries
	   or illegal register names will result */
	"40", "41", "42", "43", "44", "45", "46", "47", "48", "49",
	"50", "51", "52", "53", "54", "55", "56", "57", "58", "59",
	"60", "61", "62", "63", "64", "65", "66", "67", "68", "69",
	"70", "71", "72", "73", "74", "75", "76", "77", "78", "79",
	"80", "81", "82", "83", "84", "85", "86", "87", "88", "89",
	"90", "91", "92", "93", "94", "95", "96", "97", "4q", "4r",
	"4s", "4t", "4u", "4v", "4w", "4x", "4y", "4z", "4;", "4.",
	"4a", "4b", "4c", "4d", "4e", "4f", "4g", "4h", "4i", "4j",
	"4k", "4l", "4m", "4n", "4o", "4p", "5a", "5b", "5c", "5d",
	"5e", "5f", "5g", "5h", "5i", "5j", "5k", "5l", "5m", "5n",
	"5o", "5p", "5q", "5r", "5s", "5t", "5u", "5v", "5w", "5x",
	"5y"
};

static int Nregs = sizeof(nregs)/sizeof(char *);

char *
reg(col, place) /* Allocate a number register */
/* col = column number */
/* place = CRIGHT (2), CLEFT (0), or CMID (1) */
/* reg(col,CRIGHT) holds the location of the right edge of the column */
/* reg(col,CLEFT) holds the location of the left edge of the column */
/* reg(col,CMID) holds the location of the middle of the column */
{
	int i;

	if (Nregs < 3*qcol)
		fatal_error("Too many columns for registers");
	i = qcol*place+col;
	if (i < 0 || i >= Nregs) {
		return "5z"; /* KLUDGE--see maktab() */
	}
	return (nregs[i]);
}

/* ts.c: minor string processing subroutines */

prefix(small, big)
char *small, *big;
{
	int c;

	/* Returns 1 if the first string is an initial segment of the
	 * second string, otherwise 0 */
	while ((c = *small++) == *big++)
		if (c == 0) return(1);
	return(c == 0);
}

/* tt.c: subroutines for drawing horizontal lines */

ctype(il, ic) /* Returns key letter for this row and column */
int il; /* row index */
int ic; /* column index */
{
	if (fullbot[il] || instead[il] != NULL) return(0); /* Not real data */
	return(style[ic][stynum[il]]);
}

fspan(i, c) /* Returns 1 if the entry to the right of this one is
	      horizontally spanned, otherwise 0 */
int i;	/* row index */
int c;	/* column index */
{
	c++;
	return(c < ncol && ctype(i,c) == 's');
}

lspan(i, c) /* Checks whether or not this entry is the last in a horizontal
	       sequence of horizontally spanned entries.  If so, the return
	       value is the length of the sequence; if not, the return value
	       is 0 */
int i;	/* row index */
int c;	/* column index */
{
	int k;

	if (ctype(i,c) != 's') return(0);
	if (c+1 < ncol && ctype(i,c+1) == 's')
		return(0);
	for (k = 1; c>k && ctype(i,c-k) == 's'; k++);
	return(k);
}

ctspan(i, c) /* The return value is 1 plus the number of consecutive
		horizontally spanned entries starting with the entry
		to the right of this one */
int i;	/* row index */
int c;	/* column index */
{
	int k;

	for (k = c+1; k<ncol && ctype(i,k) == 's'; k++);
	return(k-c);
}



/* tu.c: draws horizontal lines */

makeline(i, c, lintype) /* Draw a less-than-full-width horizontal line */
int i;	/* row index */
int c;	/* column index */
{
	int cr, type, shortl;

	type = thish(i, c); /* '-', '=', 1, or 0 */
	if (type == 0) return; /* No horizontal line through this entry */
	shortl = (TABLE(i,c).col[0] == '\\');
	if (shortl == 0)
	{
		if (c > 0 && thish(i,c-1) == type) return; /* already drawn */
		for (cr = c; cr < ncol; cr++)
			if (ctype(i,cr) != 's' && thish(i,cr) != type)
				break;
	}
	else
	{
		for (cr = c+1; cr < ncol; cr++)
			if (ctype(i,cr) != 's')
				break;
	}
	drawline(i, c, cr-1, lintype, 0, shortl);
}

fullwide(i, lintype) /* Draw a full-width horizontal line */
{
	int cr, cl;

	if ( ! pr1403)
		printf(".nr %d \\n(.v\n.vs \\n(.vu-\\n(.sp\n", SVS);
	cr = 0;
	while (cr < ncol)
	{
		cl = cr;
		while (i > 0 && vspand(prev(i),cl,1))
			cl++;
		for (cr = cl; cr < ncol; cr++)
			if (i > 0 && vspand(prev(i),cr,1))
				break;
		if (cl < ncol)
			drawline(i, cl, (cr<ncol ? cr-1 : cr), lintype, 1, 0);
	}
	printf("\n");
	if ( ! pr1403)
		printf(".vs \\n(%du\n", SVS);
}

drawline(i, cl, cr, lintype, noheight, shortl) /* Draw a horizontal line */
/* i = row number */
/* cl = beginning column number */
/* cr = ending column number */
/* lintype = type of line ('-' if single, '=' if double) */
/* noheight is nonzero iff the line is not through the middle of an entry */
/* shortl is nonzero iff the line is not full column width */
{
	char *exhr, *exhl, *lnch;
	int lcount, ln, linpos, oldpos, nnodata;

	exhr = exhl = "";
	lcount = oldpos = 0;
	switch (lintype)
	{
	case '-':
		lcount = 1;
		break;
	case '=':
		lcount = pr1403 ? 1 : 2;
		break;
	case SHORTLINE:	/* NOT USED */
		lcount = 1;
		break;
	}
	if (lcount <= 0) return; /* Invalid call */
	nnodata = cr-cl >= ncol || noheight || allh(i); /* not through middle */
	if ( ! nnodata)
		printf("\\v'-.5m'"); /* Move up half an em */
	for (ln = 0; ln < lcount; ln++) /* One line for each iteration */
	{
		linpos = 2*ln - lcount +1; /* Displacement for double lines */
		/* If lcount == 2 then linpos = +1 or -1; otherwise linpos = 0 */
		if (linpos != oldpos)
			printf("\\v'%dp'", linpos-oldpos);
		oldpos = linpos;
		if (shortl) /* Not full width of column */
		{
			printf("\\h'|\\n(%2su'", reg(cl,CLEFT));
		}
		else	/* Full width of column */
		{
			tohcol(cl); /* Move to left edge of entry */
			if (lcount > 1) /* double line */
			{
				switch (interv(i,cl))
				{
				case TOP:
					exhl = (ln == 0) ? "1p" : "-1p";
					break;
				case BOTTOM:
					exhl = (ln == 1) ? "1p" : "-1p";
					break;
				case THRU:
					exhl = "1p";
					break;
				}
				if (exhl[0])
					printf("\\h'%s'", exhl);
			}
			else if (lcount == 1)
			{
				switch (interv(i,cl))
				{
				case TOP:
				case BOTTOM:
					exhl = "-1p";
					break;
				case THRU:
					exhl = "1p";
					break;
				}
				if (exhl[0])
					printf("\\h'%s'", exhl);
			}
			if (lcount > 1)
			{
				switch (interv(i,cr+1))
				{
				case TOP:
					exhr = (ln == 0) ? "-1p" : "+1p";
					break;
				case BOTTOM:
					exhr = (ln == 1) ? "-1p" : "+1p";
					break;
				case THRU:
					exhr = "-1p";
					break;
				}
			}
			else if (lcount == 1)
			{
				switch (interv(i,cr+1))
				{
				case TOP:
				case BOTTOM:
					exhr = "+1p";
					break;
				case THRU:
					exhr = "-1p";
					break;
				}
			}
		}
		printf("\\s\\n(%d", LSIZE);
		if (linsize)
			printf("\\v'-\\n(%dp/6u'", LSIZE);
		if (shortl)
		{
			printf("\\l'|\\n(%2su'", reg(cr,CRIGHT));
		}
		else
		{
			if (pr1403)
				lnch = (lintype == 2) ? " = " : "\\(ru";
			else
				lnch = "\\(ul"; /* Character for drawing line */
			if (cr+1 >= ncol)
				printf("\\l'|\\n(TWu%s%s'", exhr, lnch);
			else
				printf("\\l'(|\\n(%2su+|\\n(%2su)/2u%s%s'",
				    reg(cr,CRIGHT), reg(cr+1,CLEFT), exhr, lnch);
		}
		if (linsize)
			printf("\\v'\\n(%dp/6u'", LSIZE);
		printf("\\s0");
	}
	if (oldpos != 0)
		printf("\\v'%dp'", -oldpos);
	if ( ! nnodata)
		printf("\\v'+.5m'"); /* Return to baseline */
}

tohcol(ic) /* Generate a move to the left edge of this entry */
/* ic = column */
{
	if (ic <= 0)
		printf("\\h'|0'");
	else
		printf("\\h'(|\\n(%2su+|\\n(%2su)/2u'",
		    reg(ic,CLEFT), reg(ic-1,CRIGHT));
}

getstop() /* Mark rows where vertical lines begin */
{
	int i, c, k, junk, stopp;

	/* The linestop array was already initialized to zero in getspec() */
	stopp = 1;
	for (i = 0; i < nlin; i++)
	{
		for (c = 0; c < ncol; c++)
		{
			k = left(i, c, &junk);
			if (k >= 0 && linestop[k] == 0)
			{
				linestop[k] = ++stopp;
			}
		}
	}
	if (boxflg || allflg || dboxflg)
		linestop[0] = 1;
}

left(i, c, lwidp) /* Check for vertical line ending to the left of this entry */
int *lwidp;
/* i = row */
/* c = column */
/* lwidp = pointer to returned value for type of line (1=single, 2=double) */
{
	/* returns -1 if no line to left */
	/* returns number of line where it starts */
	/* stores into lwid the kind of line */
	int kind, li, lj;

	*lwidp = 0;
	if (i < 0) return(-1);
	kind = lefdata(i, c);
	if (kind == 0) return(-1);
	if (i+1<nlin && lefdata(next(i),c)==kind) return(-1);
	while (i >= 0 && lefdata(i,c) == kind)
	{
		i = prev(li=i);
	}
	if (prev(li) == -1) li = 0;
	*lwidp = kind;
	for (lj = i+1; lj < li; lj++)
	{
		if (instead[lj] != NULL && streql(instead[lj], ".TH"))
			return(li);
	}
	for (i = i+1; i < li; i++)
		if (fullbot[i])
			li = i;
	return(li);
}

lefdata(i, c) /* Test for a vertical line immediately to the left of this entry */
/* i = row */
/* c = column */
{
	/* Returns 1 for a single line */
	/* Returns 2 for a double line */
	/* Returns 0 if no line */
	int ck;

	i = min(i, nlin-1);
	if (ctype(i,c) == 's')
	{
		for (ck = c-1; ctype(i,ck) == 's'; ck--)
			;
		if (thish(i,ck) == 0) /* STRANGE CODE */
			return(0); /* No horizontal(?) line to the left */
	}
	i = stynum[i];
	i = lefline[c][i]; /* Number of vertical lines immediately to the left */
	if (i > 0) return(i);
	if (dboxflg && c==0) return(2);
	if (allflg) return(1);
	if (boxflg && c==0) return(1);
	return(0);
}

next(i) /* Returns the index of the next row with real data (nlin-1 if none) */
{
	while (i+1 < nlin)
	{
		i++;
		if (fullbot[i] == 0 && instead[i] == NULL) break;
	}
	return(i);
}

prev(i) /* Returns the index of the previous row with real data (-1 if none) */
{
	while (--i >= 0)
	{
		if (fullbot[i] == 0 && instead[i] == NULL) break;
	}
	return(i);
}

/* tv.c: draw vertical lines */

drawvert(start, end, c, lwid) /* Draw a vertical line */
/* start = beginning row number */
/* end = ending row number */
/* c = column number */
/* lwid determines the kind of line (1=single, 2=double) */
{
	char *exb = NULL, *ext = NULL;
	int oldpos = 0, sl, ln, pos, epb, ept, vm = 'v';

	/* Note: NR 35 has value of 1m outside of linesize */

	/* Advance ending row to next row that is not a troff request */
	while (end < nlin && instead[++end] != NULL)
		;

	for (ln = 0; ln < lwid; ln++) /* Draws one line on each iteration */
	{
		epb = ept = 0;
		pos = 2*ln-lwid+1; /* Displacement for double lines */
		if (pos != oldpos) output2("\\h'%dp'", pos-oldpos);
		oldpos = pos; /* Save for next iteration */
		if (end < nlin)
		{
			if (allflg || fullbot[end] || allh(end))
				epb=2;
			else
				switch (midbar(end, c))
				{
				case '-':
					exb = "1v-.5m";
					break;
				case '=':
					exb = "1v-.5m";
					epb = 1;
					break;
				}
		}
		if (lwid > 1) /* Double line */
		{
			switch (interh(end, c))
			{
			case THRU:
				epb -= 1;
				break;
			case RIGHT:
				epb += (ln == 0 ? 1 : -1);
				break;
			case LEFT:
				epb += (ln == 1 ? 1 : -1);
				break;
			}
		}
		else if (lwid == 1) /* Single line */
		{
			switch (interh(end, c))
			{
			case THRU:
				epb -= 1;
				break;
			case RIGHT:
			case LEFT:
				epb += 1;
				break;
			}
		}
		if (start > 0)
		{
			for (sl = start-1; sl >= 0; sl--)
				if (instead[sl] == NULL) break;
			if (sl >= 0)
			{
				if (fullbot[sl] || allh(sl))
					ept = 0;
				else
					switch (midbar(sl,c))
					{
					case '-':
						ext = ".5m";
						break;
					case '=':
						ext = ".5m";
						ept = -1;
						break;
					default:
						vm = 'm';
						break;
					}
			}
			else
				ept = -4;
		}
		else if (start == 0 && allh(0))
		{
			ept = 0;
			vm = 'm';
		}
		if (lwid > 1) /* Double line */
		{
			switch (interh(start,c))
			{
			case THRU:
				ept += 1;
				break;
			case LEFT:
				ept += (ln == 0 ? 1 : -1);
				break;
			case RIGHT:
				ept += (ln == 1 ? 1 : -1);
				break;
			}
		}
		else if (lwid == 1) /* Single line */
		{
			switch (interh(start,c))
			{
			case THRU:
				ept += 1;
				break;
			case LEFT:
			case RIGHT:
				ept -= 1;
				break;
			}
		}
		if (exb != NULL)
			output2("\\v'%s'", exb);
		if (epb)
			output2("\\v'%dp'", epb);
		output2("\\s\\n(%d", LSIZE);
		if (linsize)
			output2("\\v'-\\n(%dp/6u'", LSIZE);
		output("\\h'-\\n(#~u'"); /* adjustment for T450 nroff boxes */
		output3("\\L'|\\n(#%cu-%s",
		    linestop[start]+'a'-1, vm == 'v' ? "1v" : "\\n(35u");
		if (ext != NULL)
			output2("-(%s)", ext);
		if (exb != NULL)
			output2("-(%s)", exb);
		pos = ept-epb;
		if (pos)
			output3("%s%dp", pos >= 0 ? "+" : "", pos);
		output3("'\\s0\\v'\\n(\\*(#du-\\n(#%cu+%s",
		    linestop[start]+'a'-1, vm == 'v' ? "1v" : "\\n(35u");
		if (ext != NULL)
			output2("+%s", ext);
		if (ept)
			output3("%s%dp", (-ept) > 0 ? "+" : "", (-ept));
		output("'");
		if (linsize)
			output2("\\v'\\n(%dp/6u'", LSIZE);
	}
}

allh(i) /* Test for horizontal line in every entry of a given row */
{
	/* Returns true iff every element in line i is horizontal */
	/* also at least one must be horizontal */
	int c, k, one = 0;

	if (fullbot[i]) return(1);
	if (i >= nlin) return(dboxflg || boxflg);
	for (c = 0; c < ncol; c++)
	{
		k = thish(i, c);
		if (k == 0) return(0);
		if (k == 1) continue; /* Vertically spanned or no text */
		one = 1;
	}
	return(one);
}

thish(i, c) /* Test for a horizontal line through an entry */
/* i = row, c = column */
{
	/* Returns '-' if there is a single horizontal line through the entry*/
	/* Returns '=' if there is a double horizontal line through the entry*/
	/* Returns 1 if this is a vertically spanned entry or there is no text
	   for this entry */
	/* Returns 0 otherwise */
	int ct;
	char *s;
	struct colstr *pc;

	if (c<0 || i<0) return(0);
	ct = ctype(i,c);
	if (ct == '_' || ct == '-')
		return('-');
	if (ct == '=') return('=');
	if (ct == '^') return(1);
	if (fullbot[i]) return(fullbot[i]);
	if (ct == 's') return(thish(i,c-1));
	if (ct == 0) return(1);
	pc = &TABLE(i,c);
	s = (ct == 'a' ? pc->rcol : pc->col);
	if (s == NULL || (point(s) && *s == 0))
		return(1);
	if (vspen(s)) return(1);
	return(barent(s));
}

midbar(i, c) /* Test for a horizontal line through an entry */
/* i = row, c = column */
{
	/*
	 * Returns:  '-', '=', 1, or 0
	 */
	int k;

	k = midbcol(i, c);
	if (k == 0 && c > 0)
		k = midbcol(i, c-1);
	return(k);
}

midbcol(i, c) /* Test for a horizontal line through an entry */
/* i = row, c = column */
{
	/* Returns '-' if there is a single horizontal line through the entry */
	/* Returns '=' if there is a double horizontal line through the entry */
	/* Returns 1 if there is no text for the entry */
	/* Returns 0 otherwise */
	/* If this is a horizontally spanned entry then the above applies
	   to the closest entry to the left of this one that is not
	   horizontally spanned */
	int ct;

	while ( (ct = ctype(i,c)) == 's')
		c--;
	if (ct == '-' || ct == '=')
		return(ct);
	return(barent(TABLE(i,c).col));
}

barent(s) /* Test for a horizontal line through an entry */
char *s;
{
	/* Returns '-' if s is "_" or "\_" */
	/* Returns '=' if s is "=" or "\=" */
	/* Returns 1 if s is a null pointer */
	/* Returns 0 otherwise */
	if (s == NULL) return(1);
	if ( ! point(s)) return(0);
	if (s[0] == '\\') s++;
	if (s[1] != 0)
		return(0);
	switch (s[0])
	{
	case '_':
		return('-');
	case '=':
		return('=');
	}
	return(0);
}
