char gc2picxver[] = "@(#)main.c	4.0 12/06/85";		/* SCCS */
/*
				gc2pic
				gc to pic file format translator
				Chris Scussel
				AT&T Bell Labs
				ihnp4!ihuxi!trough
				(312) 979-4737
*/

#include <stdlib.h>
#include <string.h>
# include "structs.h"
#include "gc2pic.h"

int
main(int argc, char **argv)
{
	int	i ;

	prog_name = argv[0] ;

	findex = 0 ;
	Spline_flag = 0 ;
	i = 1 ;
	if ( i < argc  &&  strcmp(argv[i],"+s") == 0 )
	{
		Spline_flag = 1 ;
		i++ ;
	}
	if ( i == argc )
		process("-") ;
	else
		for ( ; i<argc ; i++ )
			process(argv[i]) ;
	return (0) ;
}
