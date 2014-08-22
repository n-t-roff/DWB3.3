/*
 *
 * External varible declarations - many are defined in glob.c.
 *
 */

extern char	**argv;			/* global so everyone can use them */
extern int	argc;

extern int	x_stat;			/* program exit status */
extern int	debug;			/* debug flag */
extern int	ignore;			/* what we do with FATAL errors */

extern long	lineno;			/* line number */
extern long	position;		/* byte position */
extern char	*prog_name;		/* and program name - for errors */
extern char	*temp_file;		/* temporary file - for some programs */

extern char	*optarg;		/* for getopt() */
extern int	optind;

extern void	interrupt();
extern char	*getenv();
extern char	*tempnam();
extern char	*strtok();
extern double	atof();
extern double	sqrt();

