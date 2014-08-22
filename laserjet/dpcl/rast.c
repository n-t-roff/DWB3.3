/*
 *
 * A few routines that we use to manage raster files for PCL based printers.
 * Much was borrowed from the code written for Imagen printers. Downloads
 * individual bitmaps if fast is TRUE, otherwise downloads entire raster
 * file as in previous versions. No attempt has been made to clean things
 * up - stuff leaves much to be desired!
 *
 */

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <string.h>

#include "ext.h"			/* external variable definitions */
#include "gen.h"			/* definitions used by everyone */
#include "rast.h"			/* raster file definitions */

Rastdata	fam_data[MAXFAMILY+1];	/* data about raster files we've read */
Rastdata	*fam = NULL;		/* &fam_data[cur_fam] */

int		fam_num = 0;		/* use this as next family number */
int		next_fam = 0;		/* next free spot in fam_data[] */
int		cur_fam = 0;		/* family number we're using right now */
int		last_fam = MAXFAMILY+1;	/* last one we told printer about */

int		maxrast = 0;		/* number of RASTERLIST entries */
Sizedata	sizedata[MAXFONTS];	/* stuff read from RASTERLIST */

extern char	*rastdir;
extern char	*rastdev;
extern char	*realdev;
extern char	*mode;
extern FILE	*tf;
extern int	fast;

extern char	*rastalloc();

/*****************************************************************************/

getfamdata(f, s)

    char	*f;
    int		s;

{

    int		i;

/*
 *
 * Looks for family data for font *f and size s in the fam_data[] data structure.
 * Returns the index where it was found, or next_fam if not found.
 *
 */


    for ( i = 0; i < next_fam; i++ )
	if ( fam_data[i].size == s && strcmp(f, fam_data[i].name) == 0 )
	    break;
    return(i);

}   /* End of getfamdata */

/*****************************************************************************/

getrastdata(f, s)

    char	*f;
    int		s;

{

    int		i;
    int		first = FALSE;

/*
 *
 * Called whenever we want to make sure the raster file for font f, size s, has
 * been downloaded. fam_data[] keeps track of the the fonts or bitmaps that have
 * been downloaded.
 *
 */

    s = mapsize(f, s);			/* best available size */

    cur_fam = getfamdata(f, s);		/* use this family next */
    fam = &fam_data[cur_fam];		/* its entry in fam_data[] */

    if ( cur_fam >= next_fam ) {	/* didn't find it */
	if ( next_fam > MAXFAMILY )	/* only allow up to MAXFAMILY fonts */
	    error(FATAL, "job uses too many raster files");

	first = TRUE;
	strcpy(fam->name, f);		/* initialze some of the fields */
	fam->size = s;
	fam->internalname = -1;		/* font number */
	fam->rast = NULL;		/* copy of raster file */
	next_fam++;			/* only use it once */
    }   /* End if */

    if ( fam->rast == NULL )		/* raster data is missing */
	readrastfile(f, s);

    if ( first == TRUE && fast == TRUE )
	getoffsets(fam);

}   /* End of getrastdata */

/*****************************************************************************/

readrastfile(f, s)

    char	*f;
    int		s;

{

    char	name[100];
    char	*p;
    int		fd;
    int		size;
    struct stat buf;

/*
 *
 * Handles downloading the raster file for font f and size s. Landscape mode is
 * supported in two different ways. First if we've requeseted landscape mode and
 * there's an appropriate raster file that ends in the suffix ".land" we use it,
 * otherwise we do a run time rotation of the portrait mode raster file and use
 * the resulting raster file. Downloaded raster files are assigned unique font
 * names (actually numbers) that we assign and then use to identify a downloaded
 * raster file. The raster file must be preceeded be two escape sequences that
 * assign the number and then tell the printer the size (26 bytes) of the font
 * header. In addition we need to enter the font's number in the header before
 * sending to the printer. Sure seems dumb!! Once that's done we copy the rest of
 * the raster file to the output file.
 *
 */

    sprintf(name, "%s/rast%s/%s.%d", rastdir, (rastdev == NULL) ? realdev : rastdev, f, s);

    if ( *mode == 'l' ) {
	p = name + strlen(name);
	strcat(name, ".land");
	if ( access(name, 04) != 0 ) {	/* rotate the portrait mode file */
	    *p = '\0';
	    rotate(name);
	    strcpy(name, temp_file);
	}   /* End if */
    }	/* End if */

    if ( (fd = open(name, 0)) == -1 )
	error(FATAL, "can't open raster file %s", name);

    if ( fstat(fd, &buf) == -1 )
	error(FATAL, "can't get file size for %s", name);

    if ( (p = (char *) rastalloc(buf.st_size)) == NULL )
	error(FATAL, "no memory for raster file %s", name);

    if ( read(fd, p, buf.st_size) != buf.st_size )
	error(FATAL, "can't read raster file %s", name);

    *(p+25) = (cur_fam + FAMOFFSET) & 0377;

    fprintf(tf, "\033*c%dD", (cur_fam + FAMOFFSET) & 0377);
    fprintf(tf, "\033)s26W");
    fflush(tf);

    size = (fast == FALSE) ? buf.st_size : 26;
    if ( write(fileno(tf), p, size) != size )
	error(FATAL, "can't write raster file %s", name);

    fam->internalname = cur_fam;
    fam->rast = p;
    fam->bytes = buf.st_size;

    close(fd);

    if ( fast == FALSE )
	free(p);

}   /* End of readrastfile */

/*****************************************************************************/

getoffsets(f)

    Rastdata	*f;

{

    char	*ptr;
    char	*last;
    int		num;
    int		bytes;
int    i;

/*
 *
 * Grabs offset data for characters in the raster file described by *f.
 *
 */

    if ( f->rast == NULL )
	error(FATAL, "missing raster data");

    ptr = f->rast + 26;
    last = f->rast + f->bytes;

    while ( ptr < last ) {
	if ( sscanf(ptr, "\033*c%dE\033(s%dW", &num, &bytes) != 2 )
	    error(FATAL, "bad character data");
	f->offsets[num] = ptr - f->rast;
	while ( *ptr++ != 'W' )
	    if ( ptr > last )
		error(FATAL, "raster file error");
	ptr += bytes;
    }	/* End while */

}   /* End of getoffsets */

/*****************************************************************************/

char *rastalloc(size)

    unsigned	size;			/* allocate this many bytes */

{

    char	*ptr;			/* block of memory we just got */

/*
 *
 * Allocates size bytes for the next raster file.
 *
 */

    while ( (ptr = (char *)malloc(size)) == NULL )
	if ( freerast(1) == 0 )
	    error(FATAL, "can't allocate memory for raster file");
    return(ptr);

}   /* End of rastalloc */

/*****************************************************************************/

freerast(count)

    int		count;			/* max number of calls to free() */

{

    int		called;			/* number of calls made so far */
    int		i;			/* loop index */

/*
 *
 * Free memory used to store count raster files. Returns the number of calls
 * to free().
 *
 */

    for ( called = 0, i = 0; i < next_fam && called < count; i++ )
	if ( fam_data[i].rast != NULL )  {
	    free(fam_data[i].rast);
	    fam_data[i].rast = NULL;
	    called++;
	}   /* End if */

    return(called);

}   /* End of freerast */

/*****************************************************************************/

rasterlist()

{

    int		n;
    int		i;
    char	name[100];
    FILE	*fp;

/*
 *
 * Reads data about raster files and saves it in sizedata. Quit if we can't
 * read the RASTERLIST file.
 *
 */

    sprintf(name, "%s/rast%s/RASTERLIST", rastdir, (rastdev == NULL) ? realdev : rastdev);
    if ( (fp = fopen(name, "r")) == NULL )
	error(FATAL, "can't open %s", name);

    while ( fscanf(fp, "%s", sizedata[maxrast].name) != EOF ) {
	i = 0;
	while ( fscanf(fp, "%d", &n) != EOF && n < 100 )
	    sizedata[maxrast].sizes[i++] = n;
	sizedata[maxrast++].sizes[i] = 999;
    }	/* End while */

    fclose(fp);

}   /* End of rasterlist */

/*****************************************************************************/

setfamily()

{

/*
 *
 * Makes sure the printer is using the font we want.
 *
 */

    if ( last_fam != cur_fam ) {
	fprintf(tf, "\033(%dX", (cur_fam + FAMOFFSET) & 0377);
	last_fam = cur_fam;
    }	/* End if */

}   /* End of setfamily */

/*****************************************************************************/

mapsize(f, s)

    char	*f;
    int		s;

{

    int		i, j;

/*
 *
 * Maps the font *f and point size s into a size that really has an available
 * raster file. All done based on the data read from the RASTERLIST file.
 *
 */

    if ( maxrast == 0 )
	error(FATAL, "no raster list data");

    for ( i = 0; i < maxrast; i++ )
	if ( strcmp(f, sizedata[i].name) == 0 )
	    break;

    if ( i >= maxrast )		/* didn't find the font */
	error(FATAL, "missing raster list data for font %s", f);

    for ( j = 1; s >= sizedata[i].sizes[j]; j++ ) ;
    return(sizedata[i].sizes[--j]);

}   /* End of mapsize */

/*****************************************************************************/

download(c)

    int		c;

{

    char	*ptr;
    int		bytes;
    int		num;
    int		i;

/*
 *
 * Called from oput() to download data for character c in the current font.
 *
 */

    if ( fast == FALSE || tf != stdout )
	return;

    if ( fam->rast == NULL )
	error(FATAL, "missing raster data");

    if ( fam->used[c] == 0 ) {
	if ( fam->offsets[c] == 0 )
	    error(FATAL, "missing data for character %c", c);
	ptr = fam->rast + fam->offsets[c];
	if ( sscanf(ptr, "\033*c%dE\033(s%dW", &num, &bytes) != 2 )
	    error(FATAL, "bad character data");
	fprintf(tf, "\033*c%dD", (fam->internalname + FAMOFFSET) & 0377);
	do {
	    putc(*ptr, tf);
	} while ( *ptr++ != 'W' );
	for ( i = 0; i < bytes; i++ )
	    putc(*ptr++, tf);
	fam->used[c] = 1;
    }	/* End if */

}   /* End of download */

/*****************************************************************************/

checkbit(p, n)

    char	*p;
    int		n;

{

/*
 *
 * Returns the value set in the n-th bit in the bitmap at address p.
 *
 */

    return(((p[n / BYTE] >> ((BYTE - 1) - n % BYTE)) & 01));

}   /* End of checkbit */

/*****************************************************************************/

setbit(p, n)

    char	*p;
    int		n;

{

/*
 *
 * Turns on the n-th bit in the bitmap at address p.
 *
 */

    p[n / BYTE] |= 01 << ((BYTE - 1) - n % BYTE);

}   /* End of setbit */

/*****************************************************************************/

dumpbitmap(bptr, height, width, rwid)

    char	*bptr;
    int		height, width, rwid;

{

    int		i, j;

/*
 *
 * A debugging routine used to dump bitmaps out to a terminal.
 *
 */

    fprintf(stderr, "height=%d, width=%d, rwid=%d\n", height, width, rwid);

    for ( j = 0; j < height; j++ ) {
	for ( i = 0; i < width; i++ )
	    if ( checkbit(bptr, j * rwid * BYTE + i) )
		putc('X', stderr);
	    else putc('.', stderr);
	putc('\n', stderr);
    }	/* End for */

}   /* End of dumpbitmap */

/*****************************************************************************/

