/*
 *
 * Definitions used by the troff post-processor PCL based printers.
 *
 * DEVNAME should be the name of a device whose font files accurately describe
 * what's available on the target printer. It can be changed using the -T option,
 * but if you do you may end up getting garbage.
 *
 */

#define	DEVNAME		"pcl"		/* name of the target printer */

/*
 *
 * XOFFSET and YOFFSET compensate for the fact that the LaserJet's origin isn't
 * quite at the upper left corner. Values are given in machine units where 300
 * dots is one inch. Positive x is to the right and positive y down the page.
 *
 */

#define XOFFSET		-65
#define YOFFSET		-150

/*
 *
 * SLOP controls how much horizontal positioning error we'll accept. It's used
 * when we output characters to make sure troff and the printer haven't gotten too
 * far out of sync. Can be changed using the -S option.
 *
 */

#define SLOP		.2		/* horizontal error - in points */

/*
 *
 * Stuff used to map unrecognized font requests into something reasonable. The
 * mapping array is initialized using FONTMAP. Normally only needed when we're
 * emulating another device.
 *
 */

typedef struct {
	char	*name;			/* font name we're looking for */
	char	*use;			/* and the one we should use */
} Fontmap;

#define	FONTMAP								\
									\
	{								\
	    { "G", "H" },							\
	    { "LO", "S" },							\
	    { "S2", "S" },							\
	    { "GI", "HI" },							\
	    { "HM", "H" },							\
	    { "HK", "H" },							\
	    { "HL", "H" },							\
	    { "PB", "B" },							\
	    { "PX", "BI" },							\
	    { NULL, NULL },							\
	}

/*
 *
 * Some of the non-integer valued functions in dpcl.c.
 *
 */

char	*mapfont();

