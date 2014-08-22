/*
 *
 * postnprint - Expanded PostScript translator for ASCII files.
 *
 * Updated version of postprint that handles shading and font changes. The
 * program is unsupported and will likely NOT be included in the next release.
 * Instead we expect the additional features will be included in the default
 * ASCII file translator. If you use this program you're on your own!
 *
 * Currently recognized escape sequences:
 *
 *	<esc>O	increment shading level
 *	<esc>N	decrement shading level
 *
 *	<esc>R	Courier
 *	<esc>I	Courier-Oblique
 *	<esc>B	Courier-Bold
 *	<esc>X	Courier-BoldOblique
 *
 * The shading level controls the gray level of the background box. Definitions
 * in shade.ps control the number of background gray levels and the minimum gray
 * level. Both can be tuned. The escape character (octal 33 by default) can be
 * changed using the -e option. Use -e0 to disable escape sequences. Requests
 * made via escape sequences persist across page boundaries.
 *
 * The PostScript prologue is copied from *prologue before any of the input files
 * are translated. The program expects that the following procedures are defined
 * in that file:
 *
 *	setup
 *
 *	  mark ... setup -
 *
 *	    Handles special initialization stuff that depends on how the program
 *	    was called. Expects to find a mark followed by key/value pairs on the
 *	    stack. The def operator is applied to each pair up to the mark, then
 *	    the default state is set up.
 *
 *	pagesetup
 *
 *	  page pagesetup -
 *
 *	    Does whatever is needed to set things up for the next page. Expects
 *	    to find the current page number on the stack.
 *
 *	t
 *
 *	  mark string column string column ... column line t mark
 *
 *	    Prints each string on the stack starting at the horizontal position
 *	    selected by column. All strings print at vertical position line.
 *
 *	setshade
 *
 *	  l setshade -
 *
 *	    Set the shading level to l. Level 0 gets black text on a white
 *	    background. All other levels print white text on a gray (or black)
 *	    background. Number of levels and background color are controlled
 *	    by the numbers assigned to maxlevel and mingray in SHADEFILE.
 *
 *	drawrvbox
 *
 *	  line col1 col2 drawrvbox line
 *
 *	    Draws and fills a box around text that extends from column col1
 *	    to col2 and has its baseline at line. Also defined in SHADEFILE.
 *
 *	done
 *
 *	  done
 *
 *	    Makes sure the last page is printed. Only needed when we're printing
 *	    more than one page on each sheet of paper.
 *
 * Many default values, like the magnification and orientation, are defined in 
 * the prologue, which is where they belong. If they're changed (by options), an
 * appropriate definition is made after the prologue is added to the output file.
 * The -P option passes arbitrary PostScript through to the output file. Among
 * other things it can be used to set (or change) values that can't be accessed
 * by other options.
 *
 */

#include <stdio.h>
#include <signal.h>
#include <ctype.h>
#include <fcntl.h>

#include "comments.h"			/* PostScript file structuring comments */
#include "gen.h"			/* general purpose definitions */
#include "path.h"			/* for the prologue */
#include "ext.h"			/* external variable declarations */
#include "postnprint.h"			/* a few special definitions */

char	*optnames = "a:c:e:f:l:m:n:o:p:r:s:t:x:y:A:C:E:J:L:P:R:XDI";

char	*prologue = POSTNPRINT;		/* default PostScript prologue */
char	*formfile = FORMFILE;		/* stuff for multiple pages per sheet */
char	*shadefile = SHADEFILE;		/* reverse video printing */

int	formsperpage = 1;		/* page images on each piece of paper */
int	copies = 1;			/* and this many copies of each sheet */

int	linespp = LINESPP;		/* number of lines per page */
int	pointsize = POINTSIZE;		/* in this point size */
int	tabstops = TABSTOPS;		/* tabs set at these columns */
int	crmode = 0;			/* carriage return mode - 0, 1, or 2 */
int	escapechar = '\033';		/* escape character - for shading etc. */
int	extended = TRUE;		/* use extended character set */

int	level = 0;			/* current background level */

int	hpos = 0;			/* current position */
int	vpos = 0;
int	lastx = -1;			/* where the printer is */
int	lasty = -1;
int	lastend = -1;			/* end point - for shading */

int	textcount = 0;			/* number of strings on the stack */
int	stringstart = 1;		/* column where current one starts */

Fontmap	fontmap[] = FONTMAP;		/* for translating font names */
char	*fontname = "Courier";		/* use this PostScript font */
int	font = 0;			/* last font request - from escape */

int	page = 0;			/* page we're working on */
int	printed = 0;			/* printed this many pages */

FILE	*fp_in = stdin;			/* read from this file */
FILE	*fp_out = stdout;		/* and write stuff here */
FILE	*fp_acct = NULL;		/* for accounting data */

/*****************************************************************************/

main(agc, agv)

    int		agc;
    char	*agv[];

{

/*
 *
 * A simple program that translates ASCII files into PostScript. Also handles
 * escape sequences for changing fonts and shading text.
 *
 */

    argc = agc;
    argv = agv;

    prog_name = argv[0];

    init_signals();			/* interrupt handling */
    header();				/* PostScript header and prologue */
    options();				/* command line options */
    setup();				/* for PostScript */
    arguments();			/* followed by each input file */
    done();				/* print the last page etc. */
    account();				/* job accounting data */

    exit(x_stat);

}   /* End of main */

/*****************************************************************************/

init_signals()

{

/*
 *
 * Makes sure we handle interrupts.
 *
 */

    if ( signal(SIGINT, interrupt) == SIG_IGN ) {
	signal(SIGINT, SIG_IGN);
	signal(SIGQUIT, SIG_IGN);
	signal(SIGHUP, SIG_IGN);
    } else {
	signal(SIGHUP, interrupt);
	signal(SIGQUIT, interrupt);
    }   /* End else */

    signal(SIGTERM, interrupt);

}   /* End of init_signals */

/*****************************************************************************/

header()

{

    int		ch;			/* return value from getopt() */
    int		old_optind = optind;	/* for restoring optind - should be 1 */

/*
 *
 * Scans the option list looking for things, like the prologue file, that we need
 * right away but could be changed from the default. Doing things this way is an
 * attempt to conform to Adobe's latest file structuring conventions. In particular
 * they now say there should be nothing executed in the prologue, and they have
 * added two new comments that delimit global initialization calls. Once we know
 * where things really are we write out the job header, follow it by the prologue,
 * and then add the ENDPROLOG and BEGINSETUP comments.
 *
 */

    while ( (ch = getopt(argc, argv, optnames)) != EOF )
	if ( ch == 'L' )
	    prologue = optarg;
	else if ( ch == '?' )
	    error(FATAL, "");

    optind = old_optind;		/* get ready for option scanning */

    fprintf(stdout, "%s", CONFORMING);
    fprintf(stdout, "%s %s\n", VERSION, PROGRAMVERSION);
    fprintf(stdout, "%s %s\n", DOCUMENTFONTS, ATEND);
    fprintf(stdout, "%s %s\n", PAGES, ATEND);
    fprintf(stdout, "%s", ENDCOMMENTS);

    if ( cat(prologue) == FALSE )
	error(FATAL, "can't read %s", prologue);

    if ( DOROUND )
	cat(ROUNDPAGE);

    fprintf(stdout, "%s", ENDPROLOG);
    fprintf(stdout, "%s", BEGINSETUP);
    fprintf(stdout, "mark\n");

}   /* End of header */

/*****************************************************************************/

options()

{

    int		ch;			/* return value from getopt() */

/*
 *
 * Reads and processes the command line options. Added the -P option so arbitrary
 * PostScript code can be passed through. Expect it could be useful for changing
 * definitions in the prologue for which options have not been defined.
 *
 * Although any PostScript font can be used, things will only work well for
 * constant width fonts.
 *
 */

    while ( (ch = getopt(argc, argv, optnames)) != EOF ) {
	switch ( ch ) {
	    case 'a':			/* aspect ratio */
		    fprintf(stdout, "/aspectratio %s def\n", optarg);
		    break;

	    case 'c':			/* copies */
		    copies = atoi(optarg);
		    fprintf(stdout, "/#copies %s store\n", optarg);
		    break;

	    case 'e':			/* escape character - 0 to disable */
		    if ( isascii(*optarg) && isdigit(*optarg) )
			sscanf(optarg, (*optarg == '0') ? "%o" : "%d", &escapechar);
		    else escapechar = *optarg;
		    break;

	    case 'f':			/* use this PostScript font */
		    fontname = get_font(optarg);
		    fprintf(stdout, "/font /%s def\n", fontname);
		    break;

	    case 'l':			/* lines per page */
		    linespp = atoi(optarg);
		    break;

	    case 'm':			/* magnification */
		    fprintf(stdout, "/magnification %s def\n", optarg);
		    break;

	    case 'n':			/* forms per page */
		    formsperpage = atoi(optarg);
		    fprintf(stdout, "%s %s\n", FORMSPERPAGE, optarg);
		    fprintf(stdout, "/formsperpage %s def\n", optarg);
		    break;

	    case 'o':			/* output page list */
		    out_list(optarg);
		    break;

	    case 'p':			/* landscape or portrait mode */
		    if ( *optarg == 'l' )
			fprintf(stdout, "/landscape true def\n");
		    else fprintf(stdout, "/landscape false def\n");
		    break;

	    case 'r':			/* carriage return mode */
		    crmode = atoi(optarg);
		    break;

	    case 's':			/* point size */
		    pointsize = atoi(optarg);
		    fprintf(stdout, "/pointsize %s def\n", optarg);
		    break;

	    case 't':			/* tabstops */
		    tabstops = atoi(optarg);
		    break;

	    case 'x':			/* shift things horizontally */
		    fprintf(stdout, "/xoffset %s def\n", optarg);
		    break;

	    case 'y':			/* and vertically on the page */
		    fprintf(stdout, "/yoffset %s def\n", optarg);
		    break;

	    case 'A':			/* force job accounting */
	    case 'J':
		    if ( (fp_acct = fopen(optarg, "a")) == NULL )
			error(FATAL, "can't open accounting file %s", optarg);
		    break;

	    case 'C':			/* copy file straight to output */
		    if ( cat(optarg) == FALSE )
			error(FATAL, "can't read %s", optarg);
		    break;

	    case 'E':			/* text font encoding */
		    fontencoding = optarg;
		    break;

	    case 'L':			/* PostScript prologue file */
		    prologue = optarg;
		    break;

	    case 'P':			/* PostScript pass through */
		    fprintf(stdout, "%s\n", optarg);
		    break;

	    case 'R':			/* special global or page level request */
		    saverequest(optarg);
		    break;

	    case 'X':			/* obsolete - it's now always on */
		    extended = TRUE;
		    break;

	    case 'D':			/* debug flag */
		    debug = ON;
		    break;

	    case 'I':			/* ignore FATAL errors */
		    ignore = ON;
		    break;

	    case '?':			/* don't understand the option */
		    error(FATAL, "");
		    break;

	    default:			/* don't know what to do for ch */
		    error(FATAL, "missing case for option %c\n", ch);
		    break;
	}   /* End switch */
    }   /* End while */

    argc -= optind;			/* get ready for non-option args */
    argv += optind;

}   /* End of options */

/*****************************************************************************/

char *get_font(name)

    char	*name;			/* name the user asked for */

{

    int		i;			/* for looking through fontmap[] */

/*
 *
 * Called from options() to map a user's font name into a legal PostScript name.
 * If the lookup fails *name is returned to the caller. That should let you choose
 * any PostScript font, although things will only work well for constant width
 * fonts.
 *
 */

    for ( i = 0; fontmap[i].name != NULL; i++ )
	if ( strcmp(name, fontmap[i].name) == 0 )
	    return(fontmap[i].val);

    return(name);

}   /* End of get_font */

/*****************************************************************************/

setup()

{

/*
 *
 * Handles things that must be done after the options are read but before the
 * input files are processed. linespp (lines per page) can be set using the -l
 * option. If it's not positive we calculate a reasonable value using the
 * requested point size - assuming LINESPP lines fit on a page in point size
 * POINTSIZE.
 *
 */

    writerequest(0, stdout);		/* global requests eg. manual feed */
    setencoding(fontencoding);
    fprintf(stdout, "setup\n");

    if ( formsperpage > 1 ) {
	if ( cat(formfile) == FALSE )
	    error(FATAL, "can't read %s", formfile);
	fprintf(stdout, "%d setupforms\n", formsperpage);
    }	/* End if */

    if ( escapechar )
	cat(shadefile);

    fprintf(stdout, "%s", ENDSETUP);

    if ( linespp <= 0 )
	linespp = LINESPP * POINTSIZE / pointsize;

}   /* End of setup */

/*****************************************************************************/

arguments()

{

/*
 *
 * Everything left is an input file. No arguments or '-' menas stdin.
 *
 */

    if ( argc < 1 )
	text();
    else {
	while ( argc > 0 ) {
	    if ( strcmp(*argv, "-") == 0 )
		fp_in = stdin;
	    else if ( (fp_in = fopen(*argv, "r")) == NULL )
		error(FATAL, "can't open %s", *argv);
	    text();
	    if ( fp_in != stdin )
		fclose(fp_in);
	    argc--;
	    argv++;
	}   /* End while */
    }   /* End else */

}   /* End of arguments */

/*****************************************************************************/

done()

{

/*
 *
 * Finished with all the input files. Mark the end of the pages with a TRAILER
 * comment, make sure the last page prints, and add things like the PAGES comment
 * that can only be determined after all the input files have been read.
 *
 */

    fprintf(stdout, "%s", TRAILER);
    fprintf(stdout, "done\n");
    fprintf(stdout, "%s %s\n", DOCUMENTFONTS, fontname);
    fprintf(stdout, "%s %d\n", PAGES, printed);

}   /* End of done */

/*****************************************************************************/

account()

{

/*
 *
 * Writes an accounting record to *fp_acct provided it's not NULL. Accounting is
 * requested using the -A or -J options.
 *
 */

    if ( fp_acct != NULL )
	fprintf(fp_acct, " print %d\n copies %d\n", printed, copies);

}   /* End of account */

/*****************************************************************************/

text()

{

    int		ch;

/*
 *
 * Translates *fp_in into PostScript. Intercepts space, tab, backspace, newline,
 * return, and formfeed. Most everything else goes to oput(). The redirect(-1)
 * call forces the initial output to go to /dev/null - so stuff that formfeed()
 * does at the end of each page goes to /dev/null rather than the real output
 * file.
 *
 */

    redirect(-1);			/* get ready for the first page */
    formfeed();				/* force PAGE comment etc. */

    while ( (ch = getc(fp_in)) != EOF ) {
	if ( escapechar && ch == escapechar )
	    escape();
	else
	    switch ( ch ) {
		case '\n':
		    newline();
		    break;

		case '\t':
		case '\b':
		case ' ':
		    spaces(ch);
		    break;

		case '\014':
		    formfeed();
		    break;

		case '\r':
		    if ( crmode == 1 )
			hpos = 0;
		    else if ( crmode == 2 )
			newline();
		    break;

		default:
		    oput(ch);
		    break;
	    }	/* End switch */
    }	/* End while */

    formfeed();				/* next file starts on a new page? */

}   /* End of text */

/*****************************************************************************/

formfeed()

{

/*
 *
 * Finish with the last page and get ready for the next one. Also used at the
 * beginning and end of each input file, so we have to be careful about what's
 * done. The first time through (up to the redirect() call) output goes to
 * /dev/null.
 *
 * Adobe now recommends that the showpage operator occur after the page level
 * restore so it can be easily redefined to have side-effects in the printer's VM.
 * Although it seems reasonable I haven't implemented it, because it makes other
 * things, like selectively setting manual feed or choosing an alternate paper
 * tray, clumsy - at least on a per page basis. 
 *
 */

    if ( fp_out == stdout )		/* count the last page */
	printed++;

    flushtext();			/* print the last line */

    fprintf(fp_out, "cleartomark\n");
    fprintf(fp_out, "showpage\n");
    fprintf(fp_out, "saveobj restore\n");
    fprintf(fp_out, "%s %d %d\n", ENDPAGE, page, printed);

    if ( ungetc(getc(fp_in), fp_in) == EOF )
	redirect(-1);
    else redirect(++page);

    fprintf(fp_out, "%s %d %d\n", PAGE, page, printed+1);
    fprintf(fp_out, "/saveobj save def\n");
    fprintf(fp_out, "mark\n");
    writerequest(printed+1, fp_out);
    fprintf(fp_out, "%d pagesetup\n", printed+1);

    if ( escapechar ) {
	if ( level > 0 )
	    fprintf(fp_out, "%d setshade\n", level);
	if ( font != 0 )
	    fprintf(fp_out, "%c f\n", font);
    }	/* End if */

    lasty = vpos = 0;
    lastx = stringstart = lastend = hpos = 0;

}   /* End of formfeed */

/*****************************************************************************/

newline()

{

/*
 *
 * Finish the last line and get ready for the next one.
 *
 */

    endline();

    lasty = ++vpos;
    lastx = stringstart = lastend = hpos = 0;

    if ( vpos >= linespp )		/* done with this page */
	formfeed();

}   /* End of newline */

/*****************************************************************************/

spaces(ch)

    int		ch;			/* next input character */

{

    int		endcol;			/* ending column */
    int		i;			/* final distance - in spaces */

/*
 *
 * Reads consecutive white space characters and figures out where things end.
 * Put out space if we move right less than six columns.
 *
 */

    endcol = hpos;

    do {
	if ( ch == ' ' )
	    endcol++;
	else if ( ch == '\t' )
	    endcol += tabstops - ((endcol) % tabstops);
	else if ( ch == '\b' )
	    endcol--;
	else if ( ch == '\r' )
	    endcol = 0;
	else break;
    } while ( ch = getc(fp_in) );	/* if ch is 0 we quit anyway */

    ungetc(ch, fp_in);			/* wasn't white space */

    if ( endcol < 0 )			/* can't move past left edge */
	endcol = 0;

    if ( (i = endcol - hpos) >= 0 && i < 6 )
	for ( ; i > 0; i-- )
	    oput((int)' ');
    else hpos = endcol;

}   /* End of spaces */

/*****************************************************************************/

escape()

{

    int		ch;

/*
 *
 * Handle escape sequences. May eventually want to expand things a bit.
 *
 */

    flushtext();

    if ( level == 0 && lastend == -1 )
	lastend = hpos;

    switch ( ch = getc(fp_in) ) {
	case 'N':
	    if ( level > 0 )
		fprintf(fp_out, "%d setshade\n", --level);
	    break;

	case 'O':
	    fprintf(fp_out, "%d setshade\n", ++level);
	    break;

	case 'B':
	case 'I':
	case 'R':
	case 'X':
	    fprintf(fp_out, "%c f\n", font = ch);
	    break;
    }	/* End switch */

    if ( level == 0 )
	lastend = -1;

}   /* End of escape */

/*****************************************************************************/

starttext()

{

/*
 *
 * Called whenever we want to start pushing characters into an open string.
 * Already started a string if textcount is positive.
 *
 */

    if ( textcount < 1 ) {
	putc('(', fp_out);
	textcount = 1;
	lastx = stringstart = lastend = hpos;
    }	/* End if */

}   /* End of starttext */

/*****************************************************************************/

flushtext()

{

/*
 *
 * Dump all the accumulated text, but don't start a new line.
 *
 */

    if ( textcount > 0 ) {
	fprintf(fp_out, ")%d %d ", stringstart, lasty);
	if ( level > 0 )
	    fprintf(fp_out, "%d %d drawrvbox ", lastend, lastx);
	fprintf(fp_out, "t\n");
    }	/* End if */

    textcount = 0;

}   /* End of flushtext */

/*****************************************************************************/

endstring()

{

/*
 *
 * Horizontal positions changed - end the current string and start a new one.
 *
 */

    fprintf(fp_out, ")%d(", stringstart);
    textcount++;
    lastx = stringstart = hpos;

}   /* End of endstring */

/*****************************************************************************/

endline()

{

/*
 *
 * Vertical position changed.
 *
 */

    flushtext();

    lastx = stringstart = lastend = hpos;
    lasty = vpos;

}   /* End of endline */

/*****************************************************************************/

oput(ch)

    int		ch;			/* next output character */

{

/*
 *
 * Responsible for adding all printing characters from the input file to the
 * open string on top of the stack.
 *
 */

    if ( vpos != lasty )
	endline();

    starttext();

    if ( hpos != lastx )
	endstring();

    if ( isascii(ch) && isprint(ch) ) {
	if ( ch == '(' || ch == ')' || ch == '\\' )
	    putc('\\', fp_out);
	putc(ch, fp_out);
	hpos++;
    } else if ( extended == TRUE ) {
	starttext();
	fprintf(fp_out, "\\%.3o", ch & 0377);
	hpos++;
    }	/* End if */

    lastx = hpos;

}   /* End of oput */

/*****************************************************************************/

redirect(pg)

    int		pg;			/* next page we're printing */

{

    static FILE	*fp_null = NULL;	/* if output is turned off */

/*
 *
 * If we're not supposed to print page pg, fp_out will be directed to /dev/null,
 * otherwise output goes to stdout.
 *
 */

    if ( pg >= 0 && in_olist(pg) == ON )
	fp_out = stdout;
    else if ( (fp_out = fp_null) == NULL )
	fp_out = fp_null = fopen("/dev/null", "w");

}   /* End of redirect */

/*****************************************************************************/

