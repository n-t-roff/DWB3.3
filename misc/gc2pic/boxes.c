# include "structs.h"

boxes()
{
	struct	object	*top ;
	struct	object	*left ;
	struct	object	*bottom ;
	struct	object	*right ;
	struct	object	*text ;

	for ( top=Objects ; top!=NULL ; top=top->next )
		if ( horz(top) )
		{
			for ( left=Objects ; left!=NULL ; left=left->next )
				if ( vert(left)  &&  eqpt(top->begin,left->begin) )
					break ;
			if ( left == NULL )
				continue ;

			for ( bottom=Objects ; bottom!=NULL ; bottom=bottom->next )
				if ( horz(bottom)  &&  eqpt(left->end,bottom->begin)  &&  bottom->end.x == top->end.x )
					break ;
			if ( bottom == NULL )
				continue ;

			for ( right=Objects ; right!=NULL ; right=right->next )
				if ( vert(right)  &&  eqpt(bottom->end,right->end)  &&  eqpt(right->begin,top->end) )
					break ;
			if ( right == NULL )
				continue ;

			top->type = BOX ;
			top->end = bottom->end ;
			left->type = NONE ;
			bottom->type = NONE ;
			right->type = NONE ;
		}
}

int
horz(p)
struct	object	*p ;
{
	return ( p->type == LINE  &&  p->begin.y == p->end.y ) ;
}

int
vert(p)
struct	object	*p ;
{
	return ( p->type == LINE  &&  p->begin.x == p->end.x ) ;
}

eqpt(p,q)
struct	point	p ;
struct	point	q ;
{
	return ( p.x == q.x  &&  p.y == q.y ) ;
}
