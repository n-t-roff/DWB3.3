/*
          VERSION 1.0             5/17/84
  This program searches nroff/troff source files for ".so <file>"
  commands, and reads the referenced <file> into the source
  file.
*/
#include <stdio.h>
#include <stdlib.h>
#define LEVELIMIT 10
#define BUFSIZE 512
#define LINSIZE 512
main(argc,argv)
register int argc;
char *argv[];
   {
   register int filenum,i;
   char line[LINSIZE],current_file[100];
   FILE *filept[LEVELIMIT];
   register int anyso;
   anyso=0;

   for (filenum = 1; filenum < argc; filenum++)
      {
      i = 0;
      if (*argv[filenum] == '-')
         filept[i] = stdin;
      else
	 {
	 filept[i] = fopen(argv[filenum],"r");    
         if (filept[i] == NULL)
            {
            fprintf(stderr,"xpand: can't open %s : ",argv[filenum]);
	    perror("");
            exit(2);
	    }
         }
      while (i >= 0)
         {
         while (fgetline(line,LINSIZE,filept[i]) != 0)
            {
            if (sscanf(line,".so %100s",current_file) == 1)
               {
               i++;
               anyso++;
               if (i >= LEVELIMIT)
                  {
                  fprintf(stderr,"xpand: limit of %d levels exceeded : ",LEVELIMIT);
		  perror("");
                  exit(2);
                  };
               filept[i] = fopen(current_file,"r");
               if (filept[i] == NULL)
                  {
                  fprintf(stderr,"xpand: can't open %s : ",current_file);
		  perror("");
                  exit(2);
                  }
	       }
            else
               {
               printf("%s",line);
               }
            }
         fclose(filept[i]);
         i--;
         }
      }
   if (anyso == 0) exit(0);
   exit(1);
   }
fgetline(s,lim,stream)
char s[];
register int lim;
FILE *stream;
   {
   register int c , i;
   i = 0;
   while (--lim >0 && (c=getc(stream)) != EOF && c != '\n')
      s[i++] = c;
   if (c == '\n')
      s[i++] = '\n' ;
   s[i] = '\0';
   return(i);
   }
