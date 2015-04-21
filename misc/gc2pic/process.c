#include <string.h>
# include "structs.h"

struct	input
{
	unsigned	char	c ;
	int			escaped ;
} ;

int check(struct input *p, char *q);
void read_line(char buf[], struct input (*p[3])[MAXDEPTH]);

process(name)
char	*name ;
{
	struct	input	(*p[3])[MAXDEPTH] ;
	struct	input	convbuf[3][MAXWIDTH][MAXDEPTH] ;
	char		buf[MAXLEN] ;
	enum
	{
		off ,
		pending ,
		on ,
	}	convert ;
	int	i ;
	int	j ;

	if ( strcmp(name,"-") == 0 ) {
		ft[findex] = 0;
		fp[findex++] = stdin ;
	} else {
		ft[findex] = 0;
		if ( (fp[findex++]=fopen(name,"r")) == NULL )
			error("can't open %s\n",name) ;
	}

	convert = off ;
	while ( get_line(buf) != EOF )
		if ( strncmp(".GS",buf,3) == 0 )
		{
			if ( convert != off )
				error(".GS nested\n") ;
			convert = pending ;
			conv_init(p,convbuf) ;
			printf(".ft CW\n") ;
			printf(".PS%s\n",&buf[3]) ;
			printf("gcscale = scale\n") ;
			printf("scale = 2*12*10/10\n") ;
		}
		else if ( strncmp(".GE",buf,3) == 0 )
			switch(convert)
			{
				case off :
					error(".GE without matching .GS\n") ;

				case pending :
					out() ;
					convert = off ;
					printf(".PE\n") ;
					printf(".PS\n") ;
					printf("scale = gcscale\n") ;
					printf(".PE%s\n",&buf[3]) ;
					printf(".ft\n") ;
					free_all() ;
					break ;

				case on :
					read_line("",p) ;
					write_line(p) ;
					out() ;
					convert = off ;
					printf(".PE\n") ;
					printf(".PS\n") ;
					printf("scale = gcscale\n") ;
					printf(".PE%s\n",&buf[3]) ;
					printf(".ft\n") ;
					free_all() ;
					break ;

				default :
					error("internal error (GE default)\n") ;
			}
		else if ( buf[0] == '.' )
			switch(convert)
			{
				case off :
					printf("%s\n",buf) ;
					break ;

				case pending :
					read_line("",p) ;
					convert = on ;
					printf("%s\n",buf) ;
					break ;

				case on :
					read_line("",p) ;
					write_line(p) ;
					out() ;
					free_all() ;
					printf("%s\n",buf) ;
					break ;

				default :
					error("internal error (directive default)\n") ;
			}
		else
			switch(convert)
			{
				case off :
					printf("%s\n",buf) ;
					break ;

				case pending :
					read_line(buf,p) ;
					convert = on ;
					break ;

				case on :
					read_line(buf,p) ;
					write_line(p) ;
					break ;

				default :
					error("internal error (nonmacro default)\n") ;
			}
}

int
get_line(buf)
char	buf[] ;
{
	int	i ;
	int	c ;
	char	cmdbuf[MAXLEN+5] ;

	for ( i=0 ; i<MAXLEN-1 ;  )
		switch(c=fgetc(fp[findex-1]))
		{
			case EOF :
				findex-- ;
				if ( ft[findex] == 1 )
					pclose(fp[findex]) ;
				else if ( fp[findex] != stdin )
					fclose(fp[findex]);
				if ( findex <= 0 )
					return(EOF) ;
				break ;

			case '\n' :
				buf[i] = '\0' ;
				if ( strncmp(buf,".so",3) == 0 )
				{
					if ( findex >= _NFILE )
						error(".so's too deep\n") ;
					sprintf(cmdbuf,"/bin/cat %s",&buf[3]) ;
					ft[findex] = 1;
					if ( (fp[findex++]=popen(cmdbuf,"r")) == NULL )
						error("can't open %s\n",&buf[4]) ;
					i = 0 ;
					break ;
				}
				else
					return(~EOF) ;

			default :
				buf[i++] = c ;
				break ;
		}
	error("line too long\n") ;
}

void
read_line(char buf[], struct input (*p[3])[MAXDEPTH])
{
	int		i ;
	int		j ;
	int		c ;
	int		k ;
	struct	input	(*t)[MAXDEPTH] ;

	t = p[0] ;
	p[0] = p[1] ;
	p[1] = p[2] ;
	p[2] = t ;

	for ( j=0 ; j<MAXWIDTH ; j++ )
		p[2][j][0].c = '\0' ;

	j = 1 ;
	for ( i=0 ; i<MAXLEN ; i++ )
		switch(buf[i])
		{
			case '\0' :
				return ;

			case '\t' :
				k = 8 - (j-1)%8 + j ;
				if ( k >= MAXWIDTH )
					error("file too wide\n") ;
				for ( ; j<k ; j++ )
					if ( p[2][j][0].c == '\0' )
					{
						p[2][j][0].c = ' ' ;
						p[2][j][0].escaped = 0 ;
						p[2][j][1].c = '\0' ;
					}
				break ;

			case '\b' :
				if ( j > 1 )
					j-- ;
				break ;

			default :
				if ( j >= MAXWIDTH-1 )
					error("file too wide\n") ;
				for ( k=0 ; p[2][j][k].c!='\0' ; k++ )
					;
				if ( k >= MAXDEPTH - 1 )
					error("file too deep\n") ;
				if ( k > 0  &&  p[2][j][k-1].c == buf[i] )
					p[2][j][k-1].escaped = 1 ;
				else
				{
					p[2][j][k].c = buf[i] ;
					p[2][j][k].escaped = 0 ;
					p[2][j][k+1].c = '\0' ;
				}
				j++ ;
				break ;
		}
	error("internal error (no \\0 in read_line)\n") ;
}

write_line(p)
struct	input	(*p[3])[MAXDEPTH] ;
{
	static int	x[] =
	{
		0,	1,	1,	1,	0,	-1,	-1,	-1,	0,
	} ;
	static	int	y[] =
	{
		0,	-1,	0,	1,	1,	1,	0,	-1,	-1,
	} ;
				/* conversion table: composite hyperascii
				   graphics to radial lines 1-8
				*/
	static	struct
	{
		int	charcode ;
		char	*parts ;
	} part_tab[] =
	{
		0xe7 ,	"\364\361" ,		/* horz bar */
		'|' ,	"\356\363" ,		/* vert bar */
		0xd4 ,	"\361\363" ,		/* upper left corner */
		0xe4 ,	"\363\364" ,		/* upper right corner */
		0xd3 ,	"\356\361" ,		/* lower left corner */
		0xe3 ,	"\356\364" ,		/* lower right corner */
		0xc9 ,	"\356\361\363\364"	/* cross */
	} ;
	int		i ;
	int		j ;
	int		k ;
	int		l ;
	int		len ;
	char		*parts ;
	struct	input	input ;
	int		converted ;
	int		obuf[MAXODEPTH] ;
	int		index ;
	struct	context	*contextp ;
	int		ord1 ;
	int		ord2 ;
	char		*match1 ;
	char		*match2 ;

	for ( j=1 ; p[1][j][0].c!='\0' ; j++ )
	{
		index = 0 ;
		for ( k=0 ; p[1][j][k].c!='\0' ; k++ )
		{
			input = p[1][j][k] ;
			converted = 0 ;
			if ( input.escaped == 0 )
			{
				contextp = map[input.c] ;
				for ( l=0 ; contextp[l].ordinal[0]!=0 ; l++ )
				{
					ord1 = contextp[l].ordinal[0] ;
					ord2 = contextp[l].ordinal[1] ;
					match1 = contextp[l].match[0] ;
					match2 = contextp[l].match[1] ;
					if
					(
						check(p[1+y[ord1]][j+x[ord1]],match1) != 0 &&
						(
							ord2 == 0  ||
							check(p[1+y[ord2]][j+x[ord2]],match2) != 0
						)
					)
					{
						if ( index >= MAXODEPTH )
							error("converted file too deep\n") ;
						obuf[index++] = (int)contextp[l].substitute ;
						converted = 1 ;
					}
				}
			}
			if ( converted == 0 )
			{
				for ( i=0 ; i<NEL(part_tab) ; i++ )
					if ( part_tab[i].charcode == input.c )
						break ;
				if ( i == NEL(part_tab) )
				{
					if ( index+1 > MAXODEPTH )
						error("converted file too deep\n") ;
					obuf[index++] = input.c ;
				}
				else
				{
					parts = part_tab[i].parts ;
					len = strlen(parts) ;
					if ( index+len > MAXODEPTH )
						error("converted file too deep\n") ;
					for ( i=0 ; i<len ; i++ )
						obuf[index++] = parts[i] & 0xff ;
				}
			}
		}
		save_sym(obuf,index,j,line_num) ;
	}
	line_num++ ;
}

conv_init(p,convbuf)
struct	input	(*p[3])[MAXDEPTH] ;
struct	input	convbuf[3][MAXWIDTH][MAXDEPTH] ;
{
	int	i ;
	int	j ;

	line_num = 0 ;
	Objects = NULL ;
	for ( i=0 ; i<3 ; i++ )
	{
		p[i] = convbuf[i] ;
		for ( j=0 ; j<MAXWIDTH ; j++ )
			p[i][j][0].c = '\0' ;
	}
}

int
check(struct input *p, char *q)
{
	for ( ; p->c!='\0' ; p++ )
		if ( p->escaped == 0  &&  strchr(q,p->c) != NULL )
			return(1) ;
	return(0) ;
}
