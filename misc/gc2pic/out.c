# include "structs.h"

out()
{
	bounds() ;
	boxes() ;
	revout(Objects) ;
}

revout(object)
struct	object	*object ;
{
	if ( object == NULL )
		return ;
	revout(object->next) ;
	draw(object) ;
}

bounds()
{
	struct	object	*object ;
	struct	point	max ;
	struct	point	min ;
	int		x() ;
	int		y() ;

	if ( Objects == NULL )		/* eliminate NULL pointer use - RLD */
		return;

	max.x = min.x = Objects->begin.x ;
	max.y = min.y = Objects->begin.y ;

	for ( object=Objects ; object!=NULL ; object=object->next )
	{
		switch(object->type)
		{
			case SPLINE :
			case LINE :
				if ( max.x < object->begin.x )
					max.x = object->begin.x  ;
				if ( min.x > object->begin.x )
					min.x = object->begin.x  ;
				if ( max.y < object->begin.y )
					max.y = object->begin.y  ;
				if ( min.y > object->begin.y )
					min.y = object->begin.y  ;
				if ( max.x < object->end.x )
					max.x = object->end.x  ;
				if ( min.x > object->end.x )
					min.x = object->end.x  ;
				if ( max.y < object->end.y )
					max.y = object->end.y  ;
				if ( min.y > object->end.y )
					min.y = object->end.y  ;
				break ;

			case TEXT :
				if ( max.x < object->begin.x )
					max.x = object->begin.x  ;
				if ( min.x > object->begin.x )
					min.x = object->begin.x  ;
				if ( max.y < object->begin.y+1 )
					max.y = object->begin.y+1  ;
				if ( min.y > object->begin.y-1 )
					min.y = object->begin.y-1 ;
				if ( max.x < object->end.x )
					max.x = object->end.x  ;
				if ( min.x > object->end.x )
					min.x = object->end.x  ;
				break ;

			case NONE :
				break ;

			default :
				error("(internal) unknown object\n") ;
		}
	}
	printf("box with .nw at (%d,%d) width %d height %d invis\n",x(min.x),y(min.y),x(max.x)-x(min.x),y(min.y)-y(max.y)) ;
}

draw(object)
struct	object	*object ;
{
	static	char	*arrow[2][2] =
	{
		"" ,	"-> " ,
		"<- " ,	"<-> " ,
	} ;
	int	x() ;
	int	y() ;

	switch(object->type)
	{
		case BOX :
			printf("box with .nw at ") ;
			point(object->begin) ;
			printf(" width %d height %d\n",x(object->end.x)-x(object->begin.x),y(object->begin.y)-y(object->end.y)) ;
			break ;

		case LINE :
			printf("line %s",arrow[object->b_arrow][object->e_arrow]) ;
			printf("from ") ;
			point(object->begin) ;
			printf(" to ") ;
			point(object->end) ;
			printf("\n") ;
			break ;

		case TEXT :
			printf("\"%s\" at ",object->text) ;
			point(object->begin) ;
			printf(" ljust\n") ;
			break ;

		case SPLINE :
			if ( Spline_flag == 1 )
			{
				printf("spline from ") ;
				point(object->begin) ;
				printf(" to ") ;
				point(object->center) ;
				printf(" to ") ;
				point(object->end) ;
				printf("\n") ;
			}
			else
			{
				printf("line from ") ;
				point(object->begin) ;
				printf(" to ") ;
				point(object->end) ;
				printf("\n") ;
			}
			break ;

		case NONE :
			break ;

		default :
			error("(internal) unknown object\n") ;
	}
}

point(pnt)
struct	point	pnt ;
{
	int	x() ;
	int	y() ;

	printf("(%d,%d)",x(pnt.x),y(pnt.y)) ;
}

int
x(n)
int	n ;
{
	return(n) ;
}


int
y(n)
int	n ;
{
/*	return(2*(2*line_num-n)) ;	*/
	return ( 2 *  -n ) ;
}

free_all()
{
	struct	object	*object ;
	struct	object	*next ;

	for ( object=Objects ; object!=NULL ; object=next )
	{
		if ( object->type == TEXT )
			sm_free(object->text) ;
		next = object->next ;
		sm_free(object) ;
	}
	Objects = NULL ;
}
/*
			for ( text=Objects ; text!=NULL ; text=text->next )
				if
				(
					text->type == TEXT  &&
					top->begin.x < text->begin.x  &&
					top->begin.y < text->begin.y  &&
					text->end.x < bottom->end.x  &&
					text->end.y < bottom->end.y
				)
					fprintf(stderr,"\tTEXT: (%d,%d) %s\n",text->begin.x,text->end.x,text->text) ;
*/
