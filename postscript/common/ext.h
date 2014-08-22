/*
 *
 * External varibles - most are in glob.c.
 *
 */

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

extern char	**argv;			/* global so everyone can use them */
extern int	argc;

extern int	x_stat;			/* program exit status */
extern int	debug;			/* debug flag */
extern int	ignore;			/* what we do with FATAL errors */

extern long	lineno;			/* line number */
extern long	position;		/* byte position */
extern char	*prog_name;		/* and program name - for errors */
extern char	*temp_file;		/* temporary file - for some programs */
extern char	*fontencoding;		/* text font encoding scheme */

extern int	dobbox;			/* enable BoundingBox stuff if TRUE */
extern double	pageheight;		/* only for BoundingBox calculations! */
extern double	pagewidth;

extern char	*optarg;		/* for getopt() */
extern int	optind;

extern void	interrupt();
extern long	ftell();
extern double	atof();
extern double	sqrt();
extern double	atan2();

void error_prognam(void);
void error_pos(void);
void error_chk_kind(int kind);

#define ERROR(kind, mesg, args)\
	do {\
		if (mesg) {\
			error_prognam();\
			fprintf args;\
			error_pos();\
		}\
		error_chk_kind(kind);\
	} while (0)

