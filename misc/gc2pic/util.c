#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
# include "structs.h"

void
error(char *msg, ...)
{
	va_list ap;
	fprintf(stderr,"%s: ",prog_name) ;
	va_start(ap, msg);
	vfprintf(stderr, msg, ap);
	va_end(ap);
	exit(1) ;
}
