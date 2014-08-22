# include <stdio.h>

# define NEL(x)	(sizeof(x)/sizeof(x[0]))

# define MAXLEN		1000		/* characters in input line */
# define MAXWIDTH	500		/* actual width */
# define MAXDEPTH	10		/* maximum input file depth */
# define MAXODEPTH	50		/* maximum output overprint depth */

enum	objtype
{
	NONE ,
	LINE ,
	BOX ,
	TEXT ,
	SPLINE ,
} ;

struct	point
{
	int	x ;
	int	y ;
} ;

struct	range
{
	struct	point	c ;
	struct	point	cc ;
} ;

struct	object
{
	enum	objtype	type ;
	struct	point	begin ;
	struct	point	center ;
	struct	point	end ;
	int		b_arrow ;
	int		e_arrow ;
	char		*text ;
	struct	object	*next ;
} ;

enum	cnvchr
{
	A1 = 0xf7 ,
	A2 = 0xf8 ,
	A3 = 0xf9 ,
	A4 = 0xfb ,
	A5 = 0xfc ,
	A6 = 0xfd ,
	A7 = 0xfe ,
	A8 = 0xf6 ,
	C12 = 0xa5 ,
	C13 = 0xab ,
	C14 = 0xb5 ,
	C16 = 0xb9 ,
	C17 = 0xae ,
	C18 = 0xa9 ,
	C23 = 0xa4 ,
	C24 = 0xb0 ,
	C25 = 0xb7 ,
	C27 = 0xba ,
	C28 = 0xb1 ,
	C34 = 0xa8 ,
	C35 = 0xad ,
	C36 = 0xb8 ,
	C38 = 0xb4 ,
	C45 = 0xa7 ,
	C46 = 0xaf ,
	C47 = 0xb6 ,
	C56 = 0xa3 ,
	C57 = 0xac ,
	C58 = 0xb3 ,
	C67 = 0xa6 ,
	C68 = 0xb2 ,
	C78 = 0xaa ,
	L1 = 0xef ,
	L15 = 256 ,
	L2 = 0xf1 ,
	L26 = 257 ,
	L3 = 0xf2 ,
	L37 = 258 ,
	L4 = 0xf3 ,
	L48 = 259 ,
	L5 = 0xfa ,
	L6 = 0xf4 ,
	L7 = 0xf5 ,
	L8 = 0xee ,
} ;

struct	context
{
	int	ordinal[2] ;
	char	*match[2] ;
	enum	cnvchr	substitute ;
} ;

extern	struct	context	*map[] ;
extern	struct	object	*Objects ;
extern	int		Spline_flag ;

extern	int		line_num ;

extern	char		*prog_name ;

#ifndef	_NFILE
#define _NFILE	20
#endif
extern	FILE		*fp[_NFILE] ;
extern  int 		ft[_NFILE] ;
extern	int		findex ;
