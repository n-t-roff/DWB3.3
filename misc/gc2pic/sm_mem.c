# include <stdio.h>
#include <stdlib.h>

char	*
sm_alloc(n)
int	n ;
{
	char	*p ;
	
	p = malloc(n) ;
	if ( p == NULL )
		error("out of memory\n") ;
	return(p) ;
}

char	*
sm_realloc(p,n)
char	*p ;
int	n ;
{
	p = realloc(p,n) ;
	if ( p == NULL )
		error("out of memory\n") ;
	return(p) ;
}

sm_free(p)
char	*p ;
{
	free(p) ;
}
