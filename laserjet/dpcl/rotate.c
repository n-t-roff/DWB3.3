/*
 *
 * Support routines for run time rotation of portrait mode PCL raster files
 * for use in landscape mode - slow, but it works.
 *
 */

#include <stdio.h>
#include <stdlib.h>

#include "gen.h"			/* a few general definitions */
#include "ext.h"			/* external variable definitions */
#include "path.h"			/* just for temp file directory */

char	*obptr = NULL;			/* old and */
char	*bptr = NULL;			/* new pointers to character bitmaps */
int	available = -1;			/* bytes we've currently got */

/*****************************************************************************/

rotate(name)

    char	*name;			/* pathname of the portrait raster file */

{

    FILE	*fp_in;			/* for reading *name */
    FILE	*fp_out;		/* where rotated raster file goes */
    int		width, owidth;		/* pixel width of the bitmaps */
    int		height, oheight;	/* number of rows in each bitmap */
    int		oloffset;		/* left offset for old bitmap */
    int		otoffset;		/* same but for the top offset */
    int		mapsize, omapsize;	/* number of bytes in eachh bitmap */
    int		rwid, orwid;		/* and bytes in each row */
    int		deltax;			/* character advance - doesn't change */
    int		code;			/* next character code */
    int		i, j;			/* coordinates in the old bitmap */
    int		x, y;			/* map to these in the new bitmap */
    int		topy;			/* first row (top) that's not all zeros */
    char	*nbptr;			/* trimmed of blank raster lines at top */

/*
 *
 * Uses the portrait mode raster file *name to produce an equivalent raster file
 * suitable for use in landscape mode on PCL based printers. Doing the stuff at
 * run time is slow. Host resident landscape mode raster files are an alternative,
 * and can be used in combination with this stuff.
 *
 */

    if ( temp_file == NULL )
	if ( (temp_file = tempnam(TEMPDIR, "dpcl")) == NULL )
	    error(FATAL, "can't generate temporary file name");

    if ( (fp_out = fopen(temp_file, "w")) == NULL )
	error(FATAL, "can't open temp file %s", temp_file);

    if ( (fp_in = fopen(name, "r")) == NULL )
	error(FATAL, "can't open raster file %s", name);

    if ( bptr == NULL ) {		/* first time through */
	bptr = (char *) malloc(300);
	obptr = (char *) malloc(300);
	available = 300;
    }	/* End if */

    fread(bptr, 1, 26, fp_in);		/* first read the font header */
    *(bptr+12) = 1;			/* mark it as rotated */
    fwrite(bptr, 1, 26, fp_out);	/* and then write it out */

    while ( 1 ) {
	if ( fscanf(fp_in, "\033*c%dE", &code) != 1 )
	    break;

	fscanf(fp_in, "\033(s%*dW");	/* skip the next escape code */
	fread(bptr, 1, 6, fp_in);	/* and first six bytes in the header */

	oloffset = getint(fp_in);	/* need the rest of the header */
	otoffset = getint(fp_in);
	owidth = getint(fp_in);
	oheight = getint(fp_in);
	deltax = getint(fp_in);

	rwid = (oheight + BYTE - 1) / BYTE;
	orwid = (owidth + BYTE - 1) / BYTE;

	mapsize = rwid * owidth;
	omapsize = orwid * oheight;

	if ( available < MAX(mapsize, omapsize) ) {
	    free(bptr); free(obptr);
	    available = MAX(mapsize, omapsize);

	    if ( (obptr = (char *) malloc(available)) == NULL )
		error(FATAL, "can't get memory for old bitmap");

	    if ( (bptr = (char *) malloc(available)) == NULL )
		error(FATAL, "can't get memory for new bitmap");
	}   /* End if */

	for ( i = 0; i < mapsize; i++ )	/* so we don't have to set zero bits */
	    *(bptr+i) = 0;

	fread(obptr, 1, omapsize, fp_in);

	width = rwid * 8;
	height = owidth;
	topy = owidth;

	for ( j = 0; j < oheight; j++ )
	    for ( i = 0; i < owidth; i++ )
		if ( checkbit(obptr, orwid * j * BYTE + i) ) {
		    x = j;
		    y = owidth - 1 - i;
		    setbit(bptr, rwid * y * BYTE + x);
		    if ( y < topy ) topy = y;
		}   /* End if */

	nbptr = bptr + rwid * topy;
	mapsize -= rwid * topy;
	height -= topy;

	fprintf(fp_out, "\033*c%dE", code & BMASK);
	fprintf(fp_out, "\033(s%dW", mapsize + 16);

	putc(4, fp_out); putc(0, fp_out);
	putc(14, fp_out); putc(1, fp_out);
	putc(1, fp_out); putc(0, fp_out);

	putint(-otoffset, fp_out);
	putint(height + oloffset, fp_out);
	putint(width, fp_out);
	putint(height, fp_out);
	putint(deltax, fp_out);
	fwrite(nbptr, 1, mapsize, fp_out);
    }	/* End while */

    fclose(fp_in);
    fclose(fp_out);

}   /* End of rotate */

/*****************************************************************************/

