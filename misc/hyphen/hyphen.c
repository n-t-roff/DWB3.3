/*
 *
 * Yet another trivial, but poorly written program that doesn't belong anywhere
 * important! Argument handling was (and still is) ridiculous, but at least it
 * no longer core dumps on Suns.
 *
 */

#include <stdio.h>
#include <stdlib.h>
char b[242];
char c[60];
int nread = 1;
char buf[BUFSIZ];

main(argc,argv)
int argc;
char *argv[];
{
	int ifile,isw,k,i,j,r;
	extern int optind;
	int stdinflg = 0;

	while ((r = getopt(argc,argv,"")) != EOF) {
		switch (r) {
		default:
			fprintf(stderr,"Usage: hyphen files\n");
			exit(1);
		}
	}
	argc -= optind;
	argv += optind;

	do {
		if ( argc == 0 || (argv[0][0] == '-' && argv[0][1] == '\0') )
			ifile = 0;
		else {
			printf("%s:\n \n",*argv);
			if ((ifile = open(*argv, 0)) < 0) {
				fprintf(stderr, "hyphen: cannot open %s\n", *argv);
				continue;
			}
		}
newl:	isw = j =  0;
	i = -1;

cont:	while((b[++i] = get(ifile)) != 0)
		{if((b[i] >= 'a' && b[i] <= 'z') ||
		(b[i] >= 'A' && b[i] <= 'Z'))
			{c[j++] = b[i];
			goto cont;
			}
		if(b[i] == '-')
		{c[j++] = b[i];
			if((b[++i] = get(ifile)) != '\n')
			{c[j++] = b[i];
			goto cont;
			}
			if(j == 1)goto newl;
			isw = 1;
			i = -1;
			while(((b[++i] = get(ifile)) == ' ')
			|| (b[i] == '\t') || (b[i] == '\n'));
			c[j++] = b[i];
			goto cont;
		}
		if(b[i] == '\n'){if(isw != 1)goto newl;
			i = -1; }
		if(isw == 1)
			{k = 0;
			c[j++] = '\n';
			while(k < j)putchar(c[k++]);
			}
		isw = j = 0;
		}
	argc--;
	argv++;
	} while ( argc > 0 );
}
/* ------------------------------------------------ */
get(ifile)
int ifile;
{
	static char *ibuf;

	if(--nread)return(*ibuf++);
	if(nread = read(ifile,buf,BUFSIZ))
		{if(nread < 0)goto err;
		ibuf = buf;
		return(*ibuf++);
		}

	nread = 1;
	return(0);

err:	nread = 1;
	fprintf(stderr,"read error\n");
	return(0);
}
