
/*
 *
 * A post-processor that splits troff output into smaller, sef-consistent pieces.
 * breaks always come at page boundaries, but only after exceeding page_break
 * pages or byte_break characters in the current section. Output goes either to
 * stdout with sections separated by *sep_str (-s option) or to a collection
 * output files that can be selected using the -f option.
 * 
 */

#include <stdio.h>
#include <ctype.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>

#define	NON_FATAL	0
#define	FATAL		1
#define	OFF		0
#define	ON		1
#define	MAX_FNAME	2
#define	NFONT		100

void out_file(void);

int	argc;				/* global so everyone can use them */
char	**argv;

char	*prog_name;			/* for error messages */

int	page_break = 20;		/* max pages and */
long	byte_break = 100000;		/* bytes per section */
int	pages = 0;			/* current page and */
long	bytes = 0;			/* byte count */

char	*sep_str = "";			/* section separator */
char	*filename = NULL;		/* output file for next section */
char	*prefix = "dsplit.out";		/* built by combining this string */
int	suffix = 1;			/* with this suffix - for uniqueness */
int	do_report = OFF;		/* report the name of each output file */

FILE	*fp_out;		/* everything is written here */

/*
 *
 * The current typesetter state. Remembering some of the stuff is no longer needed
 * with newer versions of troff.
 *
 */

char	dwb_devname[20] = "";		/* name of the typesetter */
int	res = 0;			/* resolution */
int	hort = 1;			/* minimum horizontal step */
int	vert = 1;			/* minimum vertical step */
int	nfonts = 0;			/* font positions */
int	font = 1;			/* current font */
int	size = 10;			/* size */
int	slant = 0;			/* slant */
int	height = 0;			/* and height */

struct  {				/* mounted fonts */

	char	name[MAX_FNAME+1];

} fontname[NFONT];

/*****************************************************************************/

main(agc, agv)

    int	    agc;
    char    *agv[];

{

/*
 *
 * A post-processor that splits troff output into smaller, self-consistent pieces.
 * 
 */

    fp_out = stdout;		/* everything is written here */
    argc = agc;				/* so everyone can use them */
    argv = agv;

    prog_name = argv[0];

    options();				/* read the command line options */
    arguments();			/* translate the input files */

}   /* End of main */

/*****************************************************************************/

options()

{

    int		ch;			/* getopt() return value */
    char	*names = "p:b:s:f:r";

    extern int	optind;
    extern char	*optarg;

/*
 *
 * Grabs the command line options. 
 * 
 */

    while ( (ch = getopt(argc, argv, names)) != EOF ) {

	switch ( ch )  {

	    case 'p':			/* break after this many pages */
		    page_break = atoi(optarg);
		    break;

	    case 'b':			/* or this many bytes */
		    byte_break = atol(optarg);
		    break;

	    case 's':			/* separates sections */
		    prefix = "";
		    sep_str = optarg;
		    break;

	    case 'f':			/* pathname prefix for sections */
		    sep_str = "";
		    prefix = optarg;
		    break;

	    case 'r':			/* report output file names */
		    do_report = ON;
		    break;

	    case '?':			/* don't understand the option */
		    error(FATAL, "");
		    break;

	    default:			/* don't know what to do for ch */
		    error(FATAL, "missing case for option %c", ch);
		    break;

	}   /* End switch */

    }	/* End while */

    argc -= optind;
    argv += optind;

}   /* End of options */

/*****************************************************************************/

arguments()

{

    FILE    *fp_in;			/* next input file */

/*
 *
 * Makes sure all the non-option command line arguments are processed. If we get
 * here and there aren't any arguments left, or if '-' is one of the input files
 * we process stdin. 
 * 
 */

    if ( argc < 1 )
	conv(stdin);
    else {
	while ( argc > 0 )  {
	    if ( strcmp(*argv, "-") == 0 )
		fp_in = stdin;
	    else if ( (fp_in = fopen(*argv, "r")) == NULL )
		error(FATAL, "can't open %s", *argv);
	    conv(fp_in);
	    if ( fp_in != stdin )
		fclose(fp_in);
	    argc--;
	    argv++;
	}   /* End while */
    }	/* End else **/

}   /* End of arguments */

/*****************************************************************************/

conv(fp)

    FILE    *fp;			/* next input file */

{

    int	    ch;
    int	    c;

/*
 *
 * Reads a troff output file and echoes most everything to *fp_out. Tracks a few
 * things, like the current font, so the state can be restored at the start of
 * each section.
 * 
 */

    file_init();			/* get ready for the next file */

    while ( (ch = getc(fp)) != EOF )  {

	if ( ch != 'p' )
	    put_char(ch, fp_out);

	switch ( ch )  {

	    case 'w':			/* ignore these */
	    case ' ':
	    case '\n':
	    case 0:
			break;

	    case '0':			/* two digits and a character */
	    case '1':
	    case '2':
	    case '3':
	    case '4':
	    case '5':
	    case '6':
	    case '7':
	    case '8':
	    case '9':
			if ( ! isdigit(c = getc(fp)) )
			    error(FATAL, "digit missing");
			put_char(c, fp_out);

		/* fall through */

	    case 'c':			/* ASCII character */
			put_char(getc(fp), fp_out);
			break;

	    case 'h':			/* relative horizontal */
	    case 'H':			/* absolute horizontal */
	    case 'v':			/* relative vertical */
	    case 'V':			/* and absolute vertical motion */
			get_int(fp);
			break;

	    case 'C':			/* special character */
			put_char(getc(fp), fp_out);
			put_char(getc(fp), fp_out);
			break;

	    case 'D':			/* drawing command */
	    case 't':			/* text string */
	    case 'n':			/* end of line */
	    case '#':			/* comment */
			do
			    put_char(c = getc(fp), fp_out);
			while ( c != '\n'  &&  c != EOF );
			break;

	    case 'x':			/* device control */
			devcntrl(fp);
			break;

	    case 'p':			/* new page */
			new_page();
			put_char(ch, fp_out);
			get_int(fp);
			break;

	    case 's':			/* point size */
			size = get_int(fp);
			break;

	    case 'f':			/* font */
			font = get_int(fp);
			break;

	    default:			/* something's wrong */
			error(FATAL, "unknown input character 0%o %c", ch, ch);
			break;

	}   /* End switch */

    }	/* End while */

    if ( fp_out != stdout && do_report == ON )
	fprintf(stdout, "%s\n", filename);

}   /* End of conv */

/*****************************************************************************/

file_init()

{

    int	    i;				/* loop index */

/*
 *
 * Gets everything ready for the next input file. 
 * 
 */

    dwb_devname[0] = '\0';
    res = 0;
    hort = 1;
    vert = 1;
    font = 1;
    size = 10;
    nfonts = 0;
    slant = 0;
    height = 0;

    for ( i = 0; i < NFONT; i++ )
	fontname[i].name[0] = '\0';

    pages = 0;
    bytes = 0;

    out_file();				/* set up the output file */

}   /* End of file_init */

/*****************************************************************************/

void
out_file(void)

{

/*
 *
 * If prefix is NULL or points to the null string output goes to stdout with
 * each section separated by the string *sep_str. Otherwise *prefix and suffix
 * are used to generate an output file name that's used for the next section. 
 * 
 */

    if ( prefix == NULL || *prefix == '\0' ) {	/* using stdout */
	fp_out = stdout;
	return;
    }	/* End if */

    if ( filename == NULL || *filename == '\0' )
	filename = (char *) malloc(strlen(prefix) + 5);

    sprintf(filename, "%s%.2d", prefix, suffix++);

    if ( ! access(filename, 00) )	/* don't clobber an existing file? */
	error(FATAL, "output file %s already exists", filename);

    if ( (fp_out = fopen(filename, "w")) == NULL )
	error(FATAL, "can't open output file %s", filename);

    sep_str = NULL;

}   /* End of out_file */

/*****************************************************************************/

devcntrl(fp)

    FILE    *fp;

{

    char    line[200];			/* rest of the line saved here */
    char    cmd[20];			/* requested device command */
    int	    num;			/* font number, height, or slant */
    char    name[20];			/* name of the font */

/*
 *
 * Handles troff's device control commands. Unrecognized device control commands
 * are copied to the output file, and otherwise ignored.
 * 
 */

    fgets(line, sizeof(line), fp);

    sscanf(line, "%s", cmd);

    switch ( cmd[0] )  {

	case 'i':			/* init */
	case 't':			/* trailer */
	case 'p':			/* pause */
	case 's':			/* stop */
		break;

	case 'T':			/* typesetter name */
		sscanf(line, "%*s %10s", dwb_devname);
		break;

	case 'r':			/* resolution */
		sscanf(line, "%*s %d %d %d", &res, &hort, &vert);
		break;

	case 'f':			/* mount a font */
		sscanf(line, "%*s %d %s", &num, name);
		loadfont(num, name);
		break;

	case 'H':			/* height */
		sscanf(line, "%*s %d", &height);
		break;

	case 'S':			/* slant */
		sscanf(line, "%*s %d", &slant);
		break;

	default:			/* ignore anything not recognized */
		break;

    }	/* End switch */

    put_string(line, fp_out);

}   /* End of devcntrl */

/*****************************************************************************/

loadfont(pos, name)

    int	    pos;			/* this font position */
    char    *name;			/* now contains this font */

{

/*
 *
 * Keeps track of the mounted fonts - no longer terribly important since newer
 * versions of troff mount them at the start of each page. 
 * 
 */

    if ( pos < 0  ||  pos >= NFONT )
	error(FATAL, "illegal font position %d", pos);

    strncpy(fontname[pos].name, name, MAX_FNAME);

    fontname[pos].name[MAX_FNAME] = '\0';

    if ( pos > nfonts )
	nfonts = pos;

}   /* End of loadfont */

/*****************************************************************************/

new_page()

{

/*
 *
 * Check the page or byte limit before starting a new page. 
 * 
 */

    if ( ++pages > page_break  ||  bytes > byte_break )  {
	pages = 1;
	bytes = 500;			/* to cover section initialization */
	end_section();
	new_section();
    }	/* End if */

}   /* End of new_page */

/*****************************************************************************/

end_section()

{

/*
 *
 * Ends the last section.
 * 
 */

    fprintf(fp_out, "x trailer\n");
    fprintf(fp_out, "x stop\n");

    if ( sep_str != NULL  &&  *sep_str != '\0' )
	fprintf(fp_out, "%s\n", sep_str);

    if ( fp_out != stdout )  {
	fclose(fp_out);
	if ( do_report == ON )  {
	    fprintf(stdout, "%s\n", filename);
	    fflush(stdout);
	}   /* End if */
    }	/* End if */

}   /* End of end_section */

/*****************************************************************************/

new_section()

{

    int	    i;				/* loop index */

/*
 *
 * Gets ready for the next section - the checks are unnecessary!
 * 
 */

    if ( nfonts <= 0 )			/* no fonts are loaded? */
	error(FATAL, "no font positions loaded");

    if ( res <= 0 )			/* need a resolution */
	error(FATAL, "bad device resolution %d", res);

    if ( dwb_devname[0] == '\0' )		/* and a typesetter name */
	error(FATAL, "no device name given");

    out_file();				/* sets fp_out for the next section */

    fprintf(fp_out, "x T %s\n", dwb_devname);
    fprintf(fp_out, "x res %d %d %d\n", res, hort, vert);
    fprintf(fp_out, "x init\n");

    for ( i = 0; i <= nfonts; i++ )
	if ( fontname[i].name[0] != '\0' )
	    fprintf(fp_out, "x font %d %s\n", i, fontname[i].name);

    if ( height > 0 )
	fprintf(fp_out, "x H %d\n", height);

    if ( slant != 0 )
	fprintf(fp_out, "x S %d\n", slant);

    fprintf(fp_out, "V0\n");
    fprintf(fp_out, "s%d\n", size);
    fprintf(fp_out, "f%d\n", font);

}   /* End of new_section */

/*****************************************************************************/

get_int(fp_in)

    FILE    *fp_in;

{

    int	    n;				/* value */
    int	    ch;				/* next digit */

/*
 * 
 * Reads digits from file *fp_in, copies them to *fp_out, and returns the value of
 * the integer.
 * 
 */

    n = 0;

    while ( isdigit(ch = getc(fp_in)) )  {
	put_char(ch, fp_out);
	n = n * 10 + (ch - '0');
    }	/* End while */

    ungetc(ch, fp_in);
    return(n);

}   /* End of get_int */

/*****************************************************************************/

put_char(ch, fp)

    int	    ch;				/* write this character */
    FILE    *fp;			/* to this file */

{

/*
 *
 * Handles character input and keeps track of the byte count in the current
 * section. 
 * 
 */

    if ( putc(ch, fp) == EOF )
	error(FATAL, "can't output character");

    bytes++;

}   /* End of put_char */

/*****************************************************************************/

put_string(str, fp)

    char    *str;			/* write this string */
    FILE    *fp;			/* out to this file */

{

/*
 *
 * Writes a string to the output file. The byte count is updated by put_char(),
 * but could just as easily be done here. 
 * 
 */

    while ( *str != '\0' )
	put_char(*str++, fp);

}   /* End of put_string */

/*****************************************************************************/

error(kind, mesg, a1, a2)

    int		kind;			/* FATAL or NON_FATAL */
    char	*mesg;			/* error message */
    unsigned	a1, a2;			/* control string arguments */

{

/*
 *
 * Writes *mesg to stderr and quits if kind is FATAL. 
 * 
 */

    fprintf(stderr, "%s: ", prog_name);
    fprintf(stderr, mesg, a1, a2);
    putc('\n', stderr);

    if ( kind == FATAL )
	exit(1);

}   /* End of error */

/*****************************************************************************/

