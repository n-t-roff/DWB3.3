# include "structs.h"
#include "gc2pic.h"

static int horz(struct	object	*p);
static int vert(struct	object	*p);
static int eqpt(struct	point	p, struct	point	q);

void
boxes(void)
{
	struct	object	*top ;
	struct	object	*left ;
	struct	object	*bottom ;
	struct	object	*right ;

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

static int
horz(struct	object	*p)
{
	return ( p->type == LINE  &&  p->begin.y == p->end.y ) ;
}

static int
vert(struct	object	*p)
{
	return ( p->type == LINE  &&  p->begin.x == p->end.x ) ;
}

static int
eqpt(struct	point	p, struct	point	q)
{
	return ( p.x == q.x  &&  p.y == q.y ) ;
}
