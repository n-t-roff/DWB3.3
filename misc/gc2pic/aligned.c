# include "structs.h"

int
aligned(b1,e1,b2,e2)
struct	point	b1 ;
struct	point	e1 ;
struct	point	b2 ;
struct	point	e2 ;
{
	struct	range	x ;
	struct	range	range() ;
	struct	range	range_x() ;

/*
	e1.x -= b1.x ;
	e1.y -= b1.y ;
	e2.x += e1.x - b2.x ;
	e2.y += e1.y - b2.y ;

	x = range_x(range(e1),range(e2)) ;
	return(clk(x.c,x.cc)) ;
*/
	e1.x -= b1.x ;
	e1.y -= b1.y ;
	e2.x -= b2.x ;
	e2.y -= b2.y ;
	return(e1.x*e2.y==e1.y*e2.x) ;
}

struct	range
range(p)
struct	point	p ;
{
	struct	point	pt ;
	struct	point	pc ;
	struct	point	pcc ;
	struct	range	result ;
	
	pc.x = 2 * p.x ;
	pc.y = 2 * p.y - 1 ;
	pcc = pc ;
	pt.x = 2 * p.x ;
	pt.y = 2 * p.y + 1 ;
	if ( clk(pt,pc) )
		pc = pt ;
	if ( cclk(pt,pcc) )
		pcc = pt ;
	pt.x = 2 * p.x - 1 ;
	pt.y = 2 * p.y ;
	if ( clk(pt,pc) )
		pc = pt ;
	if ( cclk(pt,pcc) )
		pcc = pt ;
	pt.x = 2 *  p.x + 1 ;
	if ( clk(pt,pc) )
		pc = pt ;
	if ( cclk(pt,pcc) )
		pcc = pt ;
	result.c = pc ;
	result.cc = pcc ;
	return(result) ;
}

struct	range
range_x(r1,r2)
struct	range	r1 ;
struct	range	r2 ;
{
	struct	range	result ;
	
	if ( cclk(r1.c,r2.c) )
		result.c = r1.c ;
	else
		result.c = r2.c ;
	if ( clk(r1.cc,r2.cc) )
		result.cc = r1.cc ;
	else
		result.cc = r2.cc ;
	return(result) ;
}

int
clk(p1,p2)
struct	point	p1 ;
struct	point	p2 ;
{
	return ( p1.x*p2.y </*=*/ p2.x*p1.y ) ;
}

int
cclk(p1,p2)
struct	point	p1 ;
struct	point	p2 ;
{
	return ( p1.x*p2.y >/*=*/ p2.x*p1.y ) ;
}
