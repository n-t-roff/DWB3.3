/*
 *
 * Some definitions and structure declarations used to manage the host resident
 * PCL raster files.
 *
 * The ability to download fonts to PCL printers is rather limited. Not sure
 * how many we're allowed to have active at one time. MAXFAMILY restricts the
 * number.
 *
 */

#define MAXFAMILY	32		/* most families we can ever use */
#define FAMOFFSET	32		/* add this to the family number */

/*
 *
 * L_FNAME is the maximum length of the font name string stored in field name[]
 * below. Probably should agree with the size of array namefont[] as defined in
 * troff'd dev.h structure.
 *
 */

#define L_FNAME		10		/* longest allowed font name */
#define MAX_SIZES	20		/* only used in Sizedata */
#define MAXFONTS	60		/* slots for RASTERLIST data */

/*
 *
 * Sizedata keeps track of what raster files are available. Filled in from the
 * RASTERLIST file and used to match the current font and point size with an
 * available raster file.
 *
 */

typedef struct {
	char	name[L_FNAME];		/* internal font name */
	int	sizes[MAX_SIZES];	/* available sizes */
} Sizedata;

/*
 *
 * Rastdata keeps track of the fonts we've downloaded along with names that have
 * been assigned to fonts. Used to make sure we download a raster file at most
 * once per job.
 *
 */

typedef struct {
    int			size;		/* point size that's been read in */
    char		name[L_FNAME];	/* name of font's raster file */
    int			internalname;	/* number recognized by the printer */
    char		*rast;		/* start of the raster file */
    int			bytes;		/* in the raster file */
    int			offsets[256];	/* char data offsets */
    char		used[256];	/* downloaded? */
} Rastdata;

/*
 *
 * External declarations of things that may be needed by others.
 *
 */

extern Rastdata		fam_data[];	/* data on raster files we've read */
extern Rastdata		*fam;		/* &fam_data[cur_fam] */
extern int		next_fam;	/* next available family number */
extern int		cur_fam;	/* family we're using right now */
extern int		last_fam;	/* last family we told printer about */

