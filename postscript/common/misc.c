/*
 *
 * General purpose routines.
 *
 */

#include <stdio.h>
#include <ctype.h>
#include <fcntl.h>
#include <stdarg.h>
#include <unistd.h>

#include "gen.h"
#include "ext.h"
#include "path.h"

int	nolist = 0;			/* number of specified ranges */
int	olist[50];			/* processing range pairs */

/*****************************************************************************/

void
out_list(char *str)

{

    int		start, stop;

/*
 *
 * Grab page ranges from str, save them in olist[], and update the nolist
 * count. Range syntax matches nroff/troff syntax.
 *
 */

    while ( *str && nolist < sizeof(olist) - 2 ) {
	start = stop = str_convert(&str, 0);

	if ( *str == '-' && *str++ )
	    stop = str_convert(&str, 9999);

	if ( start > stop )
	    error(FATAL, "illegal range %d-%d", start, stop);

	olist[nolist++] = start;
	olist[nolist++] = stop;

	if ( *str != '\0' ) str++;
    }	/* End while */

    olist[nolist] = 0;

}   /* End of out_list */

/*****************************************************************************/

int
in_olist(int num)

{

    int		i;

/*
 *
 * Return ON if num is in the current page range list. Print everything if
 * there's no list.
 *
 */
    if ( nolist == 0 )
	return(ON);

    for ( i = 0; i < nolist; i += 2 )
	if ( num >= olist[i] && num <= olist[i+1] )
	    return(ON);

    return(OFF);

}   /* End of in_olist */

/*****************************************************************************/

void
setencoding(char *name)

{

    char	path[150];

/*
 *
 * Include the font encoding file selected by name. It's a full pathname if
 * it begins with /, otherwise append suffix ".enc" and look for the file in
 * ENCODINGDIR. Missing files are silently ignored.
 *
 */

    if ( name == NULL )
	name = "Default";

    if ( *name == '/' )
	strcpy(path, name);
    else sprintf(path, "%s/%s.enc", ENCODINGDIR, name);

    cat(path);

}   /* End of setencoding */

/*****************************************************************************/

int
cat(char *file)

{

    int		fd_in;
    int		fd_out;
    char	buf[512];
    int		count;

/*
 *
 * Copy *file to stdout. Return FALSE is there was a problem.
 *
 */

    fflush(stdout);

    if ( (fd_in = open(file, O_RDONLY)) == -1 )
	return(FALSE);

    fd_out = fileno(stdout);
    while ( (count = read(fd_in, buf, sizeof(buf))) > 0 )
	write(fd_out, buf, count);

    close(fd_in);

    return(TRUE);

}   /* End of cat */

/*****************************************************************************/

int
str_convert(char **str, int err)

{

    int		i;

/*
 *
 * Grab the next integer from **str and return its value or err if *str
 * isn't an integer. *str is modified after each digit is read.
 *
 */

    if ( ! isdigit(**str) )
	return(err);

    for ( i = 0; isdigit(**str); *str += 1 )
	i = 10 * i + **str - '0';

    return(i);

}   /* End of str_convert */

/*****************************************************************************/

void
error_prognam(void) {
	fprintf(stderr, "%s: ", prog_name);
}

void
error_pos(void) {
	if ( lineno > 0 )
	    fprintf(stderr, " (line %ld)", lineno);
	if ( position > 0 )
	    fprintf(stderr, " (near byte %ld)", position);
	putc('\n', stderr);
}

void
error_chk_kind(int kind) {
    if ( kind == FATAL && ignore == OFF ) {
	if ( temp_file != NULL )
	    unlink(temp_file);
	exit(x_stat | 01);
    }	/* End if */
}

void
error(int kind, char *mesg, ...)

{

/*
 *
 * Print an error message and quit if kind is FATAL.
 *
 */

    va_list ap;

    if ( mesg != NULL && *mesg != '\0' ) {
	error_prognam();
	va_start(ap, mesg);
	vfprintf(stderr, mesg, ap);
	va_end(ap);
	error_pos();
    }	/* End if */

    error_chk_kind(kind);

}   /* End of error */

/*****************************************************************************/

void
interrupt(int sig)

{

/*
 *
 * Signal handler for translators.
 *
 */

    if ( temp_file != NULL )
	unlink(temp_file);

    exit(1);

}   /* End of interrupt */

/*****************************************************************************/

