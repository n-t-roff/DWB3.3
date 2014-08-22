#include <string.h>
# include "structs.h"

struct
{
	enum	objtype	type ;
	enum	cnvchr	cnvchr ;
	struct	point	begin ;
	struct	point	end ;
	int		b_arrow ;
	int		e_arrow ;
} strokes[] =
{
	LINE ,	L6 ,	-1 ,	0 ,	0 ,	0 ,	0 ,	0 ,
	LINE ,	L7 ,	-1 ,	-1 ,	0 ,	0 ,	0 ,	0 ,
	LINE ,	L8 ,	0 ,	-1 ,	0 ,	0 ,	0 ,	0 ,
	LINE ,	L1 ,	1 ,	-1 ,	0 ,	0 ,	0 ,	0 ,
	LINE ,	L2 ,	0 ,	0 ,	1 ,	0 ,	0 ,	0 ,
	LINE ,	L3 ,	0 ,	0 ,	1 ,	1 ,	0 ,	0 ,
	LINE ,	L4 ,	0 ,	0 ,	0 ,	1 ,	0 ,	0 ,
	LINE ,	L5 ,	0 ,	0 ,	-1 ,	1 ,	0 ,	0 ,
	LINE ,	L15 ,	1 ,	-1 ,	-1 ,	1 ,	0 ,	0 ,
	LINE ,	L26 ,	-1 ,	0 ,	1 ,	0 ,	0 ,	0 ,
	LINE ,	L37 ,	-1 ,	-1 ,	1 ,	1 ,	0 ,	0 ,
	LINE ,	L48 ,	0 ,	-1 ,	0 ,	1 ,	0 ,	0 ,
	LINE ,	A1 ,	1 ,	-1 ,	-1 ,	1 ,	1 ,	0 ,
	LINE ,	A2 ,	-1 ,	0 ,	1 ,	0 ,	0 ,	1 ,
	LINE ,	A3 ,	-1 ,	-1 ,	1 ,	1 ,	0 ,	1 ,
	LINE ,	A4 ,	0 ,	-1 ,	0 ,	1 ,	0 ,	1 ,
	LINE ,	A5 ,	1 ,	-1 ,	-1 ,	1 ,	0 ,	1 ,
	LINE ,	A6 ,	-1 ,	0 ,	1 ,	0 ,	1 ,	0 ,
	LINE ,	A7 ,	-1 ,	-1 ,	1 ,	1 ,	1 ,	0 ,
	LINE ,	A8 ,	0 ,	-1 ,	0 ,	1 ,	1 ,	0 ,

	SPLINE,	C12 ,	1 ,	-1 ,	1 ,	0 ,	0 ,	0 ,
	SPLINE,	C13 ,	1 ,	-1 ,	1 , 	1 ,	0 ,	0 ,
	SPLINE,	C14 ,	1 ,	-1 ,	0 ,	1 ,	0 ,	0 ,
	SPLINE,	C16 ,	1 ,	-1 ,	-1 ,	0 ,	0 ,	0 ,
	SPLINE,	C17 ,	1 ,	-1 ,	-1 ,	-1 ,	0 ,	0 ,
	SPLINE,	C18 ,	1 ,	-1 ,	0 ,	-1 ,	0 ,	0 ,

	SPLINE,	C23 ,	1 ,	0 ,	1 ,	1 ,	0 ,	0 ,
	SPLINE,	C24 ,	1 ,	0 ,	0 ,	1 ,	0 ,	0 ,
	SPLINE,	C25 ,	1 ,	0 ,	-1 ,	1 ,	0 ,	0 ,
	SPLINE,	C27 ,	1 ,	0 ,	-1 ,	-1 ,	0 ,	0 ,
	SPLINE,	C28 ,	1 ,	0 ,	0 ,	-1 ,	0 ,	0 ,

	SPLINE,	C34 ,	1 ,	1 ,	0 ,	1 ,	0 ,	0 ,
	SPLINE,	C35 ,	1 ,	1 ,	-1 ,	1 ,	0 ,	0 ,
	SPLINE,	C36 ,	1 ,	1 ,	-1 ,	0 ,	0 ,	0 ,
	SPLINE,	C38 ,	1 ,	1 ,	0 ,	-1 ,	0 ,	0 ,

	SPLINE,	C45 ,	0 ,	1 ,	-1 ,	1 ,	0 ,	0 ,
	SPLINE,	C46 ,	0 ,	1 ,	-1 ,	0 ,	0 ,	0 ,
	SPLINE,	C47 ,	0 ,	1 ,	-1 ,	-1 ,	0 ,	0 ,

	SPLINE,	C56 ,	-1 ,	1 ,	-1 ,	0 ,	0 ,	0 ,
	SPLINE,	C57 ,	-1 ,	1 ,	-1 ,	-1 ,	0 ,	0 ,
	SPLINE,	C58 ,	-1 ,	1 ,	0 ,	-1 ,	0 ,	0 ,

	SPLINE,	C67 ,	-1 ,	0 ,	-1 ,	-1 ,	0 ,	0 ,
	SPLINE,	C68 ,	-1 ,	0 ,	0 ,	-1 ,	0 ,	0 ,

	SPLINE,	C78 ,	-1 ,	-1 ,	0 ,	-1 ,	0 ,	0 ,

} ;

				/* troff character strings */
char	*charstr[256] =
{
/* 0 */	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,
	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,

/* 1 */	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,
	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,

/* 2 */	" " ,	"!" ,	"\\\"",	"#" ,	"$" ,	"%" ,	"&" ,	"'" ,
	"(" ,	")" ,	"*" ,	"+" ,	"," ,	"-" ,	"." ,	"/" ,

/* 3 */	"0" ,	"1" ,	"2" ,	"3" ,	"4" ,	"5" ,	"6" ,	"7" ,
	"8" ,	"9" ,	":" ,	";" ,	"<" ,	"=" ,	">" ,	"?" ,

/* 4 */	"@" ,	"A" ,	"B" ,	"C" ,	"D" ,	"E" ,	"F" ,	"G" ,
	"H" ,	"I" ,	"J" ,	"K" ,	"L" ,	"M" ,	"N" ,	"O" ,

/* 5 */	"P" ,	"Q" ,	"R" ,	"S" ,	"T" ,	"U" ,	"V" ,	"W" ,
	"X" ,	"Y" ,	"Z" ,	"[" ,	"\\e" ,	"]" ,	"^" ,	"_" ,

/* 6 */	"`" ,	"a" ,	"b" ,	"c" ,	"d" ,	"e" ,	"f" ,	"g" ,
	"h" ,	"i" ,	"j" ,	"k" ,	"l" ,	"m" ,	"n" ,	"o" ,

/* 7 */	"p" ,	"q" ,	"r" ,	"s" ,	"t" ,	"u" ,	"v" ,	"w" ,
	"x" ,	"y" ,	"z" ,	"{" ,	"|" ,	"}" ,	"~" ,	NULL ,

/* 8 */	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,
	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,

/* 9 */	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,
	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,

/* a */	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,
	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,

/* b */	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,
	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	"\\(**",

/* c */	"\\(tm","\\(co","\\(rg",NULL ,	NULL ,	NULL ,	"\\(<=",NULL ,
	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	"\\(sq",NULL ,	"\\(+-",

/* d */	"\\(bx",NULL ,	"\\(<-",NULL ,	NULL ,	"\\(ct","\\(>=","\\(bu",
	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,

/* e */	NULL ,	NULL ,	"\\(ua","\\(no","\\(!=",NULL ,	NULL ,	NULL ,
	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,

/* f */	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,
	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,	NULL ,
} ;

save_sym(pieces,n,x,y)
int	pieces[] ;
int	n ;
int	x ;
int	y ;
{
	struct	object	*object ;
	int		i ;
	int		j ;
	int		aligned() ;
	char		*text_append() ;
	char		*sm_alloc() ;

	x *= 2 ;
	y *= 2 ;
				/* GRODY!!!!!!!!!!!!! */
	x -= 2 ;

	for ( i=0 ; i<NEL(strokes) ; i++ )
	{
		for ( j=0 ; j<n ; j++ )
			if ( pieces[j] == (int)strokes[i].cnvchr )
				break ;
		if ( j == n )
			continue ;

		pieces[j] = pieces[--n] ;
		for ( object=Objects ; object!=NULL ; object=object->next )
			if
			(
				object->type == LINE
				&&
				x + strokes[i].begin.x == object->end.x
				&&
				y + strokes[i].begin.y == object->end.y
				&&
				aligned(object->begin,object->end,strokes[i].begin,strokes[i].end)
			)
				break ;
		if ( object == NULL )
		{
			object = (struct object *)sm_alloc(sizeof(*object)) ;
			object->type = strokes[i].type ;
			object->begin.x = x + strokes[i].begin.x ;
			object->begin.y = y + strokes[i].begin.y ;
			object->center.x = x ;
			object->center.y = y ;
			object->end.x = x + strokes[i].end.x ;
			object->end.y = y + strokes[i].end.y ;
			object->b_arrow = strokes[i].b_arrow ;
			object->e_arrow = strokes[i].e_arrow ;
			object->text = NULL ;
			object->next = Objects ;
			Objects = object ;
		}
		else
		{
			object->end.x = x + strokes[i].end.x ;
			object->end.y = y + strokes[i].end.y ;
			object->b_arrow |= strokes[i].b_arrow ;
			object->e_arrow |= strokes[i].e_arrow ;
		}
	}	

	for ( i=0 ; i<n ; i++ )
		if ( charstr[pieces[i]] != NULL )
			break ;
	if ( i == n )
		return ;

	for ( object=Objects ; object!=NULL ; object=object->next )
		if ( object->type == TEXT  &&  object->end.x == x-1  &&  object->end.y == y )
			break ;
	if ( object == NULL )
	{
		if ( pieces[i] != ' ' )
		{
			object = (struct object *)sm_alloc(sizeof(*object)) ;
			object->type = TEXT ;
			object->begin.x = x-1 ;
			object->begin.y = y ;
			object->end.x = x+1 ;
			object->end.y = y ;
			object->b_arrow = 0 ;
			object->e_arrow = 0 ;
			object->text = text_append(charstr[pieces[i]],NULL) ;
			object->next = Objects ;
			Objects = object ;
		}
	}
	else
		if ( pieces[i] != ' '  ||  object->text[strlen(object->text)-1] != ' ' )
		{
			object->end.x = x+1 ;
			object->text = text_append(charstr[pieces[i]],object->text) ;
		}
}
	
char	*
text_append(charstr,str)
char	*charstr ;
char	*str ;
{
	int	newlen ;
	char	*p ;
	char	*sm_realloc() ;
	char	*sm_alloc() ;
	
	if ( str == NULL )
	{
		p = sm_alloc(strlen(charstr)+1) ;
		strcpy(p,charstr) ;
	}
	else
	{
		newlen = strlen(str) + strlen(charstr) + 1 ;
		p = sm_realloc(str,newlen) ;
		strcpy(&p[strlen(str)],charstr) ;
	}
	return(p) ;
}
