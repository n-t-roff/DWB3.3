# include <stdio.h>
#include <stdlib.h>
#include "gc2pic.h"

char	*
sm_alloc(int n)
{
	char	*p ;
	
	p = malloc(n) ;
	if ( p == NULL )
		error("out of memory\n") ;
	return(p) ;
}

char	*
sm_realloc(char *p, int n)
{
	p = realloc(p,n) ;
	if ( p == NULL )
		error("out of memory\n") ;
	return(p) ;
}

void
sm_free(void *p)
{
	free(p) ;
}
