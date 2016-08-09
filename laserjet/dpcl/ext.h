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
int t_size(int n);
void setsize(int n);
void rotate(char *name);
void out_list(char *str);
int in_olist(int num);
void putint(int n, FILE *fp);
int getint(FILE *fp);
void error(int kind, char *mesg, ...);
void drawwig(char *);
void drawcirc(int);
void drawarc(int, int, int, int);
void drawellip(int, int);
void put1(int);
void drawline(int dx, int dy, char *s);
