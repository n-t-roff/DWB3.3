#include <stdlib.h>
# include "structs.h"

error(msg,v)
char	*msg ;
int	v ;
{
	fprintf(stderr,"%s: ",prog_name) ;
	fprintf(stderr,msg,v) ;
	exit(1) ;
}
