/* checkdoc - enhanced checkmm command */

/* Holmdel Computation Center computer counseling staff */

/* This program was originally called checkmm. The change history
   which follows starts with checkmm Version 5.3.

   Version 5.3 6/15/88 
   Version 5.4 7/25/88
   Fixed bug in tl_ck()
   added check for unended .ig or .de in text_ck
   Version 6.0 8/1/88
   Changed name of function begin_ck to memo_ck and added
   function letter_ck for business letter macros.
   Enabled .LT indicator macro tests in text_ck.
   Version 6.1 8/2/88
   Added .LO to letter type indicators in text_ck.
   Added tests for both memo and letter macros to text_ck.
   Version 6.2 8/18/88
   Added MAXLINE parameter and diagnostic for excessively long lines.
   Version 6.3 8/31/88
   Corrected false diagnostic on .SG line with business letter type
   macros and added test for .SG and no memo or letter macros.
   Version 6.4 9/9/88
   Added check for break-causing control lines to text_ck.
   Removed check for text lines before .LT (they are allowed but
   probably do not make sense).
   Added font_ck function.
   Exempted control lines from scan in eqn_ck.
   Version 6.5 11/17/88
   Added check for .VL argument to lst_ck.
   Changd nest_ck to allow .FS/.FE and .RS/.RF in certain pairs.
   Changed nest_ck to allow .EQ, .FS, and .TS in a .TL/.MT pair.
   Changed eqn_ck to remove test for matched bars.
   Added fclose call to main processing loop so file descriptors
   don't get exhausted for large numbers of input files.
   Version 6.6 11/22/88
   Fixed bug in tl_ck function.
   Added _ and = to allowed column format descriptors in tbl_ck.
   Version 7.0 3/7/89
   Reduced MAXLINE to 512 characters and changed the diagnostic
   message for longer lines.
   Added ZD as anallowable font name.
   Added to main program:
     Conversion of ' control characters to ., and
     Removal of blanks or tabs after the control character.
   Added diagnostic for .so and .nx commands in the main program.
   Added check for excess characters on an options line to tbl_ck.
   Added check for bad equation delimiters to eqn_ck.
   Added "delim off" processing to eqn_ck.
   Added warning about delimiter alone on a line to eqn_ck.
   Changed the character constant '"' to '\"' all places that it
   appeared. Probably not necessary but more consistant with the
   language definition.
   Version 7.1 3/31/89
   Several changes in eqn_ck.
   Added a warning for .sy control lines to the main program.
   Added the quote_ck function which checks for proper pairing
   of apostrophe characters for certain escape sequences.

   Changed program name to "checkdoc" and Version to 1.0 4/3/89

   Version 2.0 11/20/89
   Fixed a minor bug in eqn_ck.
   Minor changes to quote_ck.
   Removed the interface to the original checkmm which was used
   confirm that the new facility did all that the old one did.
   Added a return of an error flag to the main program so that
   shell scripts can test the success of a checkdoc run.
   Added .AL test to nest_ck.
   Fixed bug in nest_ck.
   Added the static attribute to the definition of the symbol eof.
   Fixed a bug in font_ck.
   Changed diagnostic for missing .LE in lst_ck.
   Added #undef's for toupper and tolower.
   Minor enhancement of font_ck.
   Minor enhancement of quote_ck.
   Removed unended .ig and .de from text_ck and added the function
   macro_ck. Also added the IGNORE flag in the main function which
   deals with ignore blocks and macro definitions in a global way.
   Removed .ig and .de checks from tl_ck and added BS/BE check.
   Fixed bug in text_ck involving placement of eof processing.
   Minor enhancement to ref_ck.
   Added check for fonts in table specifications.
   Two enhancements to pic_ck: width or height on .PS and scale
   not reset at .PE/.PF.
   Added a check for no quoted value at all to quote_ck.
   Removed ignore block processing from font_ck and text_ck.
   Added comment_ck and check for comments in tbl_ck.
   Added check for text blocks with fill mode off to tbl_ck.
   Added check for too many centered lines in a .BS/.BE pair
   in nest_ck.
   Added diagnostic for grap and pic in displays to nest_ck.
   Version 2.1 11/22/89
   Backed out last change above.
   Version 2.2 12/90
   Put revised code from C. Mee into tbl_ck.
   Added error() and warning() functions.
   Added new font names to font_ck.
   Added check for redundant .. to macro_ck.
   Changed global options checks in tbl_ck and added warning about
   words beginning with . in text blocks.
   Changed pic scale error diagnostic to a warning.
   Removed diagnostic about width and height not working on .PS.
   Added code to ignore an escaped backslash to quote_ck.
   Changed nest_ck to allow .PS in a .VG/.VE pair.
   Reduced fill in text block diagnostic from error to warning
   in tbl_ck.
   Added check of .us macro definition to macro_ck.
   Allowed .ft with no argument or \f followed by space or newline
   in font_ck.
   Added misc_ck function.
   Added check for \f and \s in .VG.VE pair to nest_ck.
   Added check for a single quoted string at the beginning of a
   line of text in the main program.
   Version 2.3 1/24/91
   Minor rearrangement of code in tbl_ck.
   Added check for unbalanced double quotes to misc_ck.
   Enhancement of text_ck.
   Version 2.4 2/18/91
   Minor change to nest_ck.
   Changed the logic for scale reset diagnostic in pic_ck.
   Version 2.5 3/29/91
   Removed .tr ~ check from pic_ck (fixed in DWB 3.2).
   Added % as a poor choice of equation delimiter in eqn_ck.
   Removed MT_bug function (fixed in DWB 3.2).
   Removed check for \f and \s in .VG/.VE in nest_ck.
   Version 2.6 5/2/91
   Refined the handling of period character in findcol.
   Removed tab as an allowed character in a table format spec.
   Provided for format specs with commas in tbl_ck.
   Added check for too many (>62) text blocks in tbl_ck.
   Bypass obvious comment lines in misc_ck.
   Version 3.0 10/11/91
   Provided for the processing of .so files.
   Removed #undef's for tolower and toupper (that were
   intended to preclude macro implementations of those
   functions) and removed the dependence of this code on
   side effect pointer increments when these functions(or macros)
   are called.
   Exempted .ds lines from the check for unbalanced " characters.
   Added check for .xxx to misc_ck.
   Reintroduced tab as an allowed character in a table format spec.
   Reworked the column width spec code in findcol.
   Allowed additional font numbers in .ds HF lines in misc_ck.
   Bypassed(ignored) .\" comment lines in the main function so
   that no other checks will be done on them.
   Fixed bug in the .us macro test in macro_ck.
   Version 3.1 10/15/91
   Removed calls to toupper() in ref_ck because they caused problems
   on SUN systems.
   Version 3.2 10/22/91 (more changes for DWB 3.2)
   Added maxline keyword to tbl_ck and changed default to 250.
   Added processing of files included by a .T& <filename line to
   the main function.
 */

#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAXLINE 512
int maxline=MAXLINE;
char line[MAXLINE+2];
int line_nr;
/* the static attribute is on the following line to mask a problem with
   Microsoft C which causes the symbol eof to be multiply defined unless
   the scope of this symbol eof is restricted to the current source file.
 */
static int eof;
int errflg=0;
int IGNORE=0; /* =1 when in an ignore block or in a macro definition */

main(argc,argv)
char **argv; 
int argc;
{
	char *p, *q;
	int file_nr;
	FILE *fp;
	char filename[512];
	struct save_file
	{	int line;
		FILE *fptr;
		char fname[512];
		struct save_file *next;
	} *stack, *temp;
	stack = NULL;
	printf("checkdoc version 3.2 diagnostics:\n");
	file_nr = 1;
	do{ /* loop on each file argument */
		if(argc == 1)
		{	fp = stdin;
			strcpy(filename,"stdin");
		}
		else{
			strcpy(filename,argv[file_nr]);
			fp = fopen(filename,"r");
			printf("\nFile %s:\n",filename);
		}
		if(fp == NULL){
			errflg = 1;
			printf("File %s could not be opened\n\n",argv[file_nr]);
			continue;
		}
		line_nr = 0;
		eof = 0;
		do{ /* loop on each line */
			if(fgets(line,MAXLINE+2,fp) == NULL)
			{	printf("End of file %s, %d lines\n",filename,line_nr);
				fclose(fp);
	pop:			if(stack != NULL)
				/* pop the .so file stack and continue */
				{	fp = stack->fptr;
					strcpy(filename,stack->fname);
					line_nr = stack->line;
					temp = stack->next;
					free(stack);
					stack = temp;
					printf("\nContinuing file %s:\n",filename);
					continue;
				}
				else eof++;
			}
			line_nr++;
			/* check for excessive line length */
			if(!eof && strlen(line) > MAXLINE){
				line[MAXLINE] = '\n';
				errflg = 1;
				printf("Line %d: Line should not exceed %d characters\n",line_nr,maxline);
				/* eat up remainder of the line */
				if(line[MAXLINE+1]!='\n' && line[MAXLINE+1]!='\0')
					while(getc(fp) != '\n');
			}
			/* check for a single quoted string at the beginning of a line */
			if(!IGNORE && line[0]=='\'' && strrchr(line,(int)'\'')!=line)
			{	errflg = 1;
				printf("Line %d: Single quote at the beginning of this line may\n",line_nr);
				printf("        cause it to disappear. Precede it by \\&\n");
			}
			/* change ' control character to . */
			if(line[0]=='\'') line[0] = '.';
			/* squeeze out white space after a control character */
			if(line[0]=='.'){
				p = q = &line[1];
				while(*q==' ' || *q=='\t') q++;
				if(p!=q){
					do *p++ = *q; while(*q++!='\0');
				}
			}
			/* ignore comment lines */
			if(!strncmp(line,".\\\"",3)) continue;
			/* check for additional source files and .sy command line */
			if(!eof){
				if(!strncmp(line,".so",3) ||
					(!strncmp(line,".T&",3) && strchr(line,'<'))){
					/* stack current file env & open new file */
					temp = (struct save_file *)malloc(sizeof(struct save_file));
					temp->line = line_nr;
					temp->fptr = fp;
					strcpy(temp->fname,filename);
					temp->next = stack;
					stack = temp;
					p = &line[3];
					while(*p==' ' || *p=='<') p++;
					strcpy(filename,strtok(p,"\n"));
					fp = fopen(filename,"r");
					printf("Line %d: ",line_nr);
					puts(line);
					printf("\nFile %s:\n",filename);
					line_nr = 0;
					if(fp == NULL)
					{	errflg = 1;
						printf("File %s could not be opened\n",filename);
						goto pop;
					}
					continue;
				}
				if(!strncmp(line,".nx",3)){
					/* change to a new source file */
					printf("Line %d: ",line_nr);
					fputs(line,stdout);
					printf("Ending input from file %s, %d lines done\n",filename,line_nr);
					close(fp);
					p = &line[3];
					while(*p == ' ') p++;
					strcpy(filename,strtok(p,"\n"));
					fp = fopen(filename,"r");
					printf("\nFile %s:\n",filename);
					line_nr = 0;
					if(fp == NULL)
					{	errflg = 1;
						printf("File %s could not be opened\n",filename);
						goto pop;
					}
					continue;
				}
				if(!strncmp(line,".sy",3)){
					errflg = 1;
					printf("Line %d: CAUTION! Before formatting make sure that\n",line_nr);
					printf("            you know what this .sy command does!\n");
					continue;
				}
			}
			
     /* calls of the checking functions follow */
     /* each function is called once for each line of input (unless
	IGNORE is in effect) and once at end-of-file.
        The global variables line, line_nr, errflg, and eof are
	to be used by those routines. The variable errflg should
	be set to 1 every time a error(not warning) is found.
	The functions error() and warning() are provided to help
	with this.
	The line will be terminated by a newline character.
	When eof is true(non-zero) each function must reinitialize
	itself so as to be ready for processing additional files.
     */
			macro_ck(); /* this is first becuz it sets/resets IGNORE */
			if(IGNORE) continue;
			memo_ck();
			letter_ck();
			text_ck();
			ref_ck();
			pic_ck();
			nest_ck();
			tbl_ck();
			eqn_ck();
			tl_ck();
			lst_ck();
			font_ck();
			quote_ck();
			comment_ck();
			misc_ck();
		}  while(!eof);
	} while(++file_nr < argc);
	return errflg;
}

error(msg)	/* Display an error message */
char *msg;
{
	errflg = 1;
	printf("Line %d: %s\n", line_nr, msg);
}

warning(msg)	/* Display a warning message */
char *msg;
{
	printf("Line %d: Warning: %s\n", line_nr, msg);
}

/* Special function which searches for string s2 (null terminated)
   in string s1 (newline terminated) and returns a pointer to the
   character following the occurrance, or NULL if not found.
 */
 /* D. Muir 4/2/88 */
char *index(s1,s2) char *s1, *s2;
{
	char *p, *pp, *q;
	for(p=s1; *p!='\n'; p++){
		pp = p; q = s2;
		while(*pp == *q){pp++; q++;}
		if(*q == '\0') return pp;
	}
	return NULL;
}

/* check ignore blocks and macro definitions */
/* D. Muir  10/20/89 */
/* added check for .. at nesting level 0. - D. Muir 11/20/90 */
/* added check for correctness of the .us macro definition -
   D. Muir 12/3/90 */
/* Changed strcmp to strncmp in if test for .us macro to fix
   a bug - D. Muir 10/11/91 */

macro_ck()
{
	struct stack
	{	int line_num;
		char cmd[4];	/* .ig, .de, or .am */
		char name[4];   /* macro name */
		char end_str[3];	/* .\n or block end string */
	};
	static struct stack level[11];
	static int lev_num=0;
	char *p;
	int i, j;

	if(eof)
	{	while(lev_num > 0)
		{	if(lev_num < 12)
			{	errflg = 1;
				printf("Unended %s block detected at EOF which was begun on line %d\n",
					level[lev_num].cmd,
					level[lev_num].line_num);
			}
			lev_num--;
		}
		IGNORE = 0;
		return;
	}

	if(!strncmp(level[lev_num].cmd,".ig",3)) goto ck_for_end;

	if(!strncmp(line,".de",3) || !strncmp(line,".am",3))
	{	if(lev_num < 11)
		{	lev_num++;
			IGNORE = 1;
			strncpy(level[lev_num].cmd,line,3);
			level[lev_num].line_num = line_nr;
			p = &line[3];
			while(*p == ' ') p++;
			strcpy(level[lev_num].end_str,".\n");
			strncpy(level[lev_num].name,p,2);
			p += 2;
			while(*p == ' ') p++;
			if(isgraph(*p) && strncmp(p,"\\\"",2))
			{	strncpy(level[lev_num].end_str,p,2);
				/* tab as a second char doesn't work */
				if(*(p+1)=='\t') level[lev_num].end_str[1] = '\n';
			}
			i = lev_num;
			while(--i > 0)
			{	if(!strncmp(level[lev_num].name,level[i].name,2))
				{	errflg = 1;
					printf("Line %d: Macro definition cannot redefine itself\n",line_nr);
				}
			}
		}
		return;
	}

	if(!strncmp(line,".ig",3))
	{	if(lev_num < 11)
		{	lev_num++;
			IGNORE = 1;
			strncpy(level[lev_num].cmd,line,3);
			level[lev_num].line_num = line_nr;
			strcat(level[lev_num].name,"  ");
			p = &line[3];
			while(*p == ' ') p++;
			if(isgraph(*p) && strncmp(p,"\\\"",2))
			{	strncpy(level[lev_num].end_str,p,2);
				/* tab as a second char doesn't work */
				if(*(p+1)=='\t') level[lev_num].end_str[1] = '\n';
			}
			else
			{	strcpy(level[lev_num].end_str,".\n");
			}
		}
		return;
	}

	if(lev_num > 0)
	{	if(line[0] == '.')
		{	for(i=1;i<=lev_num;i++)
			if(!strncmp(&line[1],level[i].name,2))
			{	errflg = 1;
				printf("Line %d: Macro definition cannot call itself\n",line_nr);
				return;
			}
		}
ck_for_end: /* see if any level has ended */
		for(i=1;i<=lev_num;i++) 
		{	p = &line[0];
			for(j=1;j<i;j++) /* strip any concealment chars */
			{	if(!strncmp(p,"\\\\",2)) p += 2;
			}
			if(*p=='.' && *(p+1)==level[i].end_str[0])
			{	if(level[i].end_str[1]=='\n') /* one char end string */
					p--;
				else /* two char end string */
					if(*(p+2)!=level[i].end_str[1]) continue;
				/* here if block appears to have ended */
				p += 3;  /* p points just after the end string */
				if(*p == '\t')
				{	errflg = 1;
					printf("Line %d: Extraneous tab character on this line\n",line_nr);
					return; /* becuz of the tab block does not end */
				}
				while(*p == ' ') p++;
				if(*p!='\n' && strncmp(p,"\\\"",2))
				{	errflg = 1;
					printf("Line %d: Extra trailing character(s) on this line\n",line_nr);
				}
				if(i < lev_num)
				{	errflg = 1;
					printf("Lines %d and %d: Macro definition or ignore block nesting error\n",level[i].line_num,line_nr);
				}
				lev_num = --i;
				if(lev_num == 0) IGNORE = 0;
				return;
			}
		}
	}

	if(lev_num==0 && !strcmp(line,"..\n"))
	{	errflg = 1;
		printf("Line %d: .. must be preceded by a .de, .ig, or .am\n",line_nr);
		return;
	}

	if(lev_num!=0 && !strncmp(level[lev_num].cmd,".de",3) && !strncmp(level[lev_num].name,"us",2))
	{	if(strcmp(line,"\\\\$1\\l\'|0\\(ul\'\n"))
		{	printf("Line %d: Warning: .us macro definition may be incorrect\n",line_nr);
		}
	}

	return;
}

/* Check the begining of Memo sequences. */
/* V. G. Dave and N. S. Patel 5/16/88 */
/* Corrected a false diagnostic when .SG appeared with business
   letter type macros - D. Muir 8/31/88 */
memo_ck()
{
	/* 
	STATE variable positions :

	START = 0
	.ND = 1
	.TL = 2
	.AF = 3
	.AU = 4
	.TM = 5
	.AS = 6
	.AE = 7
	.OK = 8
	.MT = 9
	.SG = 10

	*/

	static int ND, TL, AF, AU, TM, AS, AE, OK, MT, SG = 0;
	static int STATE, OLD_STATE;

	if(eof)
	{
		if ((TL || AU || AS || AE) && !MT)
		{
			errflg = 1;
			printf("Missing .MT macro detected at EOF\n");
		}
		ND=TL=AF=AU=TM=AS=AE=OK=MT=SG=0;
		STATE=OLD_STATE=0;
		return;
	}
	if(!strncmp(line,".ND",3))
	{
		if (ND == 1)
		{
			errflg = 1;
			printf("Line %d: An extra .ND\n",line_nr);
			return;
		}
		if (MT == 1)
		{
			errflg = 1;
			printf("Line %d: The .ND macro should come before  the .MT macro\n",line_nr);
		}
		else
		{
			ND = 1;
			STATE = 1;
		}
		if (STATE <= OLD_STATE)
		{
			errflg = 1;
			printf("Line %d: .ND macro out of sequence error\n", line_nr);
		}
		else
		{
			 OLD_STATE = STATE;
		}
		return;
	}
	if(!strncmp(line,".TL",3))
	{
		if (TL == 1)
		{
			errflg = 1;
			printf("Line %d: Extra .TL\n",line_nr);
			return;
		}
		if (MT == 1)
		{
			errflg = 1;
			printf("Line %d: The .TL macro should come before the .MT macro\n",line_nr);
		}
		else
		{
			TL = 1;
			STATE = 2;
		}
		if (STATE <= OLD_STATE)
		{
			errflg = 1;
			printf("Line %d: .TL macro out of sequence error\n", line_nr);
		}
		else
		{
			 OLD_STATE = STATE;
		}
		return;
	}
	if(!strncmp(line,".AF",3))
	{
		if (AF == 1)
		{
			errflg = 1;
			printf("Line %d: An extra .AF\n",line_nr);
			return;
		}
		if (MT == 1)
		{
			errflg = 1;
			printf("Line %d: The .AF macro should come before the .MT macro\n",line_nr);
		}
		else 
		{
			AF = 1;
			STATE = 3;
		}
		if (STATE <= OLD_STATE)
		{
			errflg = 1;
			printf("Line %d: .AF macro out of sequence error\n", line_nr);
		}
		else
		{
			 OLD_STATE = STATE;
		}
		return;
	}
	if(!strncmp(line,".AU",3))
	{
		if (MT == 1)
		{
			errflg = 1;
			printf("Line %d: The .AU macro should come before the .MT macro\n",line_nr);
		}
		else 
		{
			AU = 1;
			STATE = 4;
		}
		if (STATE < OLD_STATE)
		{
			errflg = 1;
			printf("Line %d: .AU macro out of sequence error\n", line_nr);
		}
		else
		{
			 OLD_STATE = STATE;
		}
		return;
	}
	if(!strncmp(line,".TM",3))
	{
		if (TM == 1)
		{
			errflg = 1;
			printf("Line %d: An extra .TM\n",line_nr);
			return;
		}
		if (MT == 1)
		{
			errflg = 1;
			printf("Line %d: The .TM macro should come before the .MT macro\n",line_nr);
		}
		else 
		{
			TM = 1;
			STATE = 5;
		}
		if (STATE <= OLD_STATE)
		{
			errflg = 1;
			printf("Line %d: .TM macro out of sequence error\n", line_nr);
		}
		else
		{
			 OLD_STATE = STATE;
		}
		return;
	}
	if(!strncmp(line,".AS",3))
	{
		if (MT == 1)
		{
			errflg = 1;
			printf("Line %d: The .AS macro should come before .MT macro\n",line_nr);
		}
		else 
		{
			AS = 1;
			STATE = 6;
		}
		if (STATE <= OLD_STATE)
		{
			errflg = 1;
			printf("Line %d: .AS macro out of sequence error\n", line_nr);
		}
		else
		{
			 OLD_STATE = STATE;
		}
		return;
	}
	if(!strncmp(line,".AE",3))
	{
		if (AS == 1 && AE == 1)
		{
			errflg = 1;
			printf("Line %d: An extra .AS/.AE pair\n",line_nr);
			return;
		}
		if (MT == 1)
		{
			errflg = 1;
			printf("Line %d: The .AE macro should come before  the .MT macro\n",line_nr);
		}
		else 
		{
			AE = 1;
			STATE = 7;
		}
		if (STATE <= OLD_STATE)
		{
			errflg = 1;
			printf("Line %d: .AE macro out of sequence error\n", line_nr);
		}
		else
		{
			 OLD_STATE = STATE;
		}
		return;
	}
	if(!strncmp(line,".OK",3))
	{
		if (OK == 1)
		{
			errflg = 1;
			printf("Line %d: An extra .OK\n",line_nr);
			return;
		}
		if (MT == 1)
		{
			errflg = 1;
			printf("Line %d: The .OK should come before the .MT macro\n",line_nr);
		}
		else 
		{
			OK = 1;
			STATE = 8;
		}
		if (STATE <= OLD_STATE)
		{
			;
		}
		else
		{
			 OLD_STATE = STATE;
		}
		return;
	}
	if(!strncmp(line,".MT",3))
	{
		if (MT == 1)
		{
			errflg = 1;
			printf("Line %d: An extra .MT\n",line_nr);
			return;
		}
		if (TL == 0)
		{
			errflg = 1;
			printf("Line %d: Missing a .TL before the .MT macro\n",line_nr);
		}
		if (AU == 0)
		{
			errflg = 1;
			printf("Line %d: Missing a .AU before the .MT macro\n",line_nr);
		}
		MT = 1;
		STATE = 9;
		if (STATE <= OLD_STATE)
		{
			;
		}
		else
		{
			 OLD_STATE = STATE;
		}
		return;
	}
	if(!strncmp(line,".SG",3))
	{
		if (SG == 1)
		{
			errflg = 1;
			printf("Line %d: Extra .SG\n",line_nr);
			return;
		}
		if (MT != 1 && STATE>1)
		{
			errflg = 1;
			printf("Line %d: Missing a .MT before the .SG macro\n",line_nr);
		}
		if (AU != 1 && STATE>1)
		{
			errflg = 1;
			printf("Line %d: Missing a .AU before the .SG macro\n",line_nr);
		}
		SG = 1;
		STATE = 10;
		OLD_STATE = STATE;
		return;
	}
}

/* Check for beginning of business letter macros */
/* D. Muir 8/1/88 */
/* Added .SG check - D. Muir 8/31/88 */
letter_ck(){
	static int state = 0;
	/* state table:
		0 = initial(base) state
		1 = .ND found
		2 = .WA found
		3 = .WE found
		4 = .IA found
		5 = .IE found
		6 = .LT found
	*/
	char *p, t_line[4];

	if(eof){
		switch(state){
		case 2:
			printf("Missing .WE detected at EOF\n");
		case 3:
			printf("Missing .IA detected at EOF\n");
		case 4:
			printf("Missing .IE detected at EOF\n");
		case 5:
			printf("Missing .LT detected at EOF\n");
			errflg = 1;
		default:
			state = 0;
			return;
		}
	}

	if(!strncmp(line,".ND",3)){
		switch(state){
		case 0:
			state = 1;
			return;
		default:
			errflg = 1;
			printf("Line %d: Extra or out-of-sequence .ND\n",line_nr);
			return;
		}
	}
	if(!strncmp(line,".WA",3)){
		switch(state){
		case 0:
		case 1:
			state = 2;
			return;
		default:
			errflg = 1;
			printf("Line %d: Extra or out-of-sequence .WA\n",line_nr);
			return;
		}
	}

	if(!strncmp(line,".WE",3)){
		switch(state){
		case 0:
		case 1:
			errflg = 1;
			printf("Line %d: .WA must precede .WE\n",line_nr);
		case 2:
			state = 3;
			return;
		default:
			errflg = 1;
			printf("Line %d: Extra or out-of-sequence .WE\n",line_nr);
		}
	}

	if(!strncmp(line,".IA",3)){
		switch(state){
		case 0:
		case 1:
			printf("Line %d: .WA must precede .IA\n",line_nr);
		case 2:
			printf("Line %d: .WE must precede .IA\n",line_nr);
			errflg = 1;
		case 3:
			state = 4;
			return;
		default:
			errflg = 1;
			printf("Line %d: Extra or out-of-sequence .IA\n",line_nr);
			return;
		}
	}

	if(!strncmp(line,".IE",3)){
		switch(state){
		case 0:
		case 1:
			printf("Line %d: .WA must precede .IE\n",line_nr);
		case 2:
			printf("Line %d: .WE must precede .IE\n",line_nr);
		case 3:
			printf("Line %d: .IA must precede .IE\n",line_nr);
			errflg = 1;
		case 4:
			state = 5;
			return;
		default:
			errflg = 1;
			printf("Line %d: Extra or out-of-sequence .IE\n",line_nr);
			return;
		}
	}

	if(!strncmp(line,".LT",3)){
		p = &line[3];
		while(*p==' ') p++;
		strncpy(t_line,p,3);
		t_line[3] = '\0';
		if((p=strtok(t_line," \n\0")) != NULL)
			if(strcmp(p,"BL") &&
			   strcmp(p,"SB") &&
			   strcmp(p,"FB") &&
			   strcmp(p,"SP")){
				errflg = 1;
				printf("Line %d: Illegal argument for .LT\n",line_nr);
			}
		switch(state){
		case 0:
		case 1:
			printf("Line %d: .WA must precede .LT\n",line_nr);
		case 2:
			printf("Line %d: .WE must precede .LT\n",line_nr);
		case 3:
			printf("Line %d: .IA must precede .LT\n",line_nr);
		case 4:
			printf("Line %d: .IE must precede .LT\n",line_nr);
			errflg = 1;
		case 5:
			state = 6;
			return;
		default:
			errflg = 1;
			printf("Line %d: Extra .LT\n",line_nr);
		}
	}

	if(!strncmp(line,".LO",3)){
		p = &line[3];
		while(*p==' ') p++;
		strncpy(t_line,p,3);
		t_line[3] = '\0';
		if((p=strtok(t_line," \n\0")) == NULL){
			errflg = 1;
			printf("Line %d: .LO requires an argument\n",line_nr);
		}
		else if(strcmp(p,"CN") &&
			strcmp(p,"RN") &&
			strcmp(p,"AT") &&
			strcmp(p,"SA") &&
			strcmp(p,"SJ")){
				errflg = 1;
				printf("Line %d: Illegal argument for .LO\n",line_nr);
			}
		if(state == 6){
			errflg = 1;
			printf("Line %d: .LO must precede .LT\n",line_nr);
		}
		return;
	}
	if(!strncmp(line,".SG",3)){
		if(state>1 && state<6){
			errflg = 1;
			printf("Line %d: Missing .LT before the .SG macro\n",line_nr);
		}
		return;
	}
}

/* Check for memo or letter text lines prior to the .MT or .LT */
/* D. Muir 5/24/88 */
/* Added check for unended .ig or .de at eof - D. Muir 7/27/88 */
/* uncommented tests for .LT indicator macros - D. Muir 8/1/88 */
/* added .LO to letter indicator macros and tests for presence
   of both letter and memo macros - D. Muir 8/2/88 */
/* Added .SG check - D. Muir 8/31/88 */
/* Removed check for text lines prior to .LT and
   Added check for control lines which cause a break and occur
   before .MT - D. Muir 9/9/88 */
/* Moved check for unended .ig and .de to the new function macro_ck.
   D. Muir 9/28/89 */
/* Moved if(DONE) return; statement after eof processing.
   D. Muir 10/2/89 */
/* Removed ignore block processing because it is now done globally
   by macro_ck - D. Muir 11/7/89 */
/* Added checks for text and break lines before .LT and added more
   strings to the break_cmd array - D. Muir 1/24/91 */
text_ck(){
	static int state = 0; /* non-zero means text lines allowed */
	/* state table:
		0 = initial(base) state
		1 = not used
		2 = in an .AS/.AE pair
		3 = following a .TL
		4 = in an .NS/.NE pair
		5 = in an .EQ/.EN pair
		6 = in a  .WA/.WE pair
		7 = in an .IA/.IE pair
		8 = in a  .BS/.BE pair
 	*/
	static int MT = 0; /* memo type macros present */
	static int LT = 0; /* letter type macros present */
	static int DONE = 0; /* diagnostic issued or .MT or .LT found */
	static int text_line = 0; /*line on which text was detected */
	static char mname[3] = "  "; /* name which ends macro or ignore block */
	static char *break_cmd[] ={
		".nf",".fi",".br",".bp",".ce",".sp",
		".H ",".P ",".AL",".BL",".DL",".ML",
		".RL",".VL",".LB",
		".in",".ti",".SK","END"		};
	static int break_line = 0; /*line on which a break was detected */
	int i;

	/* eof processing */
	if(eof){
		state=LT=MT=DONE=text_line=break_line=0;
		strcpy(mname,"  ");
		return;
	}

	if(DONE) return;

	switch(state){
	case 0:
		/* look for a text line */
		if(line[0]!='.' && line[0]!='\'' && line[0]!='\\'){
			text_line = line_nr;
			if(MT){
				errflg = 1;
mt_diag:			printf("Line %d: Memo text, or blank lines, can not come before .MT\n",text_line);
				DONE++; return;
			}
			if(LT){
				errflg = 1;
lt_diag:			printf("Line %d: Memo text, or blank lines, can not come before .LT\n",text_line);
				DONE++; return;
			}
			return;
		}
		/* look for break causing control lines */
		i = 0;
		while(strcmp(break_cmd[i],"END")){
			if(!strncmp(line,break_cmd[i++],3)){
				break_line = line_nr;
				if(MT){
					errflg = 1;
mtbr_diag:				printf("Line %d: Break causing command not allowed prior to .MT\n",break_line);
					DONE++; return;
				}
				if(LT){
					errflg = 1;
ltbr_diag:				printf("Line %d: Break causing command not allowed prior to .LT\n",break_line);
					DONE++; return;
				}
			}
		}
		/* look for memo or letter indicator macros */
		if(!MT && (!strncmp(line,".TL",3) || !strncmp(line,".AU",3) || !strncmp(line,".MT",3))){
			if(text_line) goto mt_diag;
			if(break_line) goto mtbr_diag;
			MT++;
		}
		if(!LT && (!strncmp(line,".WA",3) || !strncmp(line,".IA",3) || !strncmp(line,".LT",3) || !strncmp(line,".LO",3))){
			if(text_line) goto lt_diag;
			if(break_line) goto ltbr_diag;
			LT++;
		}
		/* test for a mixture of letter and memo macros */
		if(LT && MT){
			errflg = 1;
			printf("Line %d: Memo and business letter type macros cannot be mixed\n",line_nr);
			DONE++; return;
		}
		/* look for .MT or .LT themselves */
		if(!strncmp(line,".MT",3) || !strncmp(line,".LT",3)){
			DONE++; return;
		}
		/* look for .SG */
		if(!strncmp(line,".SG",3) && !LT && !MT){
			errflg = 1;
			printf("Line %d: Missing .MT or .LT before the .SG macro\n",line_nr);
			return;
		}
	/* next do the state transitions */
		if(!strncmp(line,".AS",3)){
			state = 2; return;
		}
		if(!strncmp(line,".TL",3)){
			state = 3; return;
		}
		if(!strncmp(line,".NS",3)){
			state = 4; return;
		}
		if(!strncmp(line,".EQ",3)){
			state = 5; return;
		}
		if(!strncmp(line,".WA",3)){
			state = 6; return;
		}
		if(!strncmp(line,".IA",3)){
			state = 7; return;
		}
		if(!strncmp(line,".BS",3)){
			state = 8; return;
		}
		return;
	case 2:
		if(!strncmp(line,".AE",3)) state = 0;
		return;
	case 3:
		if(!strncmp(line,".AF",3) || !strncmp(line,".AU",3)) state = 0;
		return;
	case 4:
		if(!strncmp(line,".NE",3)) state = 0;
		return;
	case 5:
		if(!strncmp(line,".EN",3)) state = 0;
		return;
	case 6:
		if(!strncmp(line,".WE",3)) state = 0;
		return;
	case 7:
		if(!strncmp(line,".IE",3)) state = 0;
		return;
	case 8:
		if(!strncmp(line,".BE",3)) state = 0;
		return;
	}
}

/* Check various problems with references */
/* D. Muir 2/12/88 */
/* Added previous line number to "An .RS/.RF pair must follow each..."
   diagnistic - D. Muir 11/2/89 */
/* Removed dependence on side effect increment of pointer p when
   toupper is called - D. Muir 9/26/91 */
/* Removed toupper function calls entirely. They caused problems on
   SUN systems - D. Muir 10/15/91 */
ref_ck(){
	static int state = 0;
	/* State Table:
     0 = initial(base) state
     1 = /*(Rf found
     2 = .RS found
   */
	static int Rf_line;
	char *p;

	/* EOF processing */
	if(eof){
		switch(state){
		case 1:
			errflg = 1;
			printf("Missing .RS/.RF pair detected at EOF\n");
			break;
		case 2:
			/* the following is done by nest_ck function:
			errflg = 1;
			printf("Missing .RF detected at EOF\n");
			*/
		default:
			break;
		}
		state = 0;
		return;
	} /* end of eof processing */

	/* .RS processing */
	if(!strncmp(line,".RS",3)){
		p = &line[3];
		while(*p == ' ') p++;
		if(*p != '\n'){
			if(!islower((int)*p) ||
			    !isupper((int)*(p+1)) ||
			    !(isspace((int)*(p+2)) || *(p+2) == '\n')){
				errflg = 1;
				printf("Line %d: Reference string name should be lower case followed by upper case\n",
				    line_nr);
			}
		}
		switch(state){
		case 0:
			errflg = 1;
			printf("Line %d: .RS not matched with a preceding \\*(Rf\n",line_nr);
		case 1:
			state = 2;
			return;
		case 2:
			errflg = 1;
			printf("Line %d: Missing .RF\n",line_nr);
			return;
		}
	} /* end of .RS processing */

	/* .RF processing */
	if(!strncmp(line,".RF",3)){
		switch(state){
		case 0:
		case 1:
			/* deleted because nest_ck does the function
			errflg = 1;
			printf("Line %d: .RF not preceded by a .RS\n",line_nr);
			*/
		case 2:
			state = 0;
			return;
		}
	} /* end of .RF processing */

	/* \*(Rf processing */
	p = line;
	while((p = strchr(p,'\\')) != NULL){
		if(*++p != '*') continue;
		if(*++p != '(') continue;
		p++;
		if(*p!='R' && *p!='r') continue;
		p++;
		if(*p!='F' && *p!='f') continue;
		if(*(p-1) != 'R' || *p != 'f'){
			errflg = 1;
			printf("Line %d: Automatic reference mark must be \\*(Rf\n",line_nr);
		}
		switch(state){
		case 0:
			state = 1;
			Rf_line = line_nr;
			continue;
		case 1:
			errflg = 1;
			printf("Line %d: An .RS/.RF pair must follow each \\*(Rf - See also Line %d\n",line_nr,Rf_line);
			Rf_line = line_nr;
			continue;
		case 2:
			errflg = 1;
			printf("Line %d: Missing .RF\n",line_nr);
			Rf_line = line_nr;
			continue;
		}
	} /* end of \*(Rf processing */
	return;
}

/* Check PIC drawings */
/* D. Muir 6/5/88 */
/* Added checks for width or height on the .PS line and check for
   resetting the scale - D. Muir 11/2/89 */
/* Removed cheak for width or height on .PS and changed scale reset
   to a warning - D. Muir 11/21/90 */
/* Changed scale reset diagnostic back to error and triggered it only
   when a new PIC drawing is found and the scale has not been reset -
   D. Muir 2/18/91 */
/* Removed check for .tr ~ becuz DWB3.1 ignores character translations
   in drawing functions - D. Muir 3/29/91 */
pic_ck(){
	static int state = 0;
	/* State Table:
     0 = initial(base) state
     1 = .PS found
     2 = in a display
     3 = .PS found in a display
     4 = PIC drawing ended in a display
   */
	static float scale = 1.0;
	static int ckscale = 0;
	char *p;

	/* EOF processing */
	if(eof) {
		/* the following deleted because nest_ck does the function
		if(state == 1){
			errflg = 1;
			printf("Missing .PE or .PF detected at EOF\n");
		}
		*/
		state = 0;
		scale = 1.0;
		ckscale = 0;
		return;
	}

	/* Display processing */
	if(!strncmp(line,".DS",3) || !strncmp(line,".DF",3)){
		if(state == 0) state = 2;
		return;
	}
	if(!strncmp(line,".DE",3)){
		state = 0;
		return;
	}

	/* .PS processing */
	if(!strncmp(line,".PS",3)){
		p = &line[3];
		while(*p == ' ') p++;
		if(*p == '<') return;
		switch(state){
		case 0:
		case 2:
			state++;
			if(scale != 1.0) ckscale++;
			break;
		case 1:
		case 3:
			errflg = 1;
			printf("Line %d: Missing .PE\n",line_nr);
			break;
		case 4:
			state = 3;
			break;
		}
		return;
	}

	/* .PE and .PF processing */
	if(!strncmp(line,".PE",3) || !strncmp(line,".PF",3)){
		switch(state){
		case 0:
		case 2:
		case 4:
			/* the following deleted because nest_ck does the function
			errflg = 1;
			printf("Line %d: .PE or .PF not preceded by a .PS\n",line_nr);
			*/
			break;
		case 1:
			state = 0;
			break;
		case 3:
			state = 4;
			break;
		}
		return;
	}

	/* check for a required scale setting stmt */
	if(ckscale)
	{	ckscale = 0;
		if(index(line,"scale") == NULL)
			error("scale=1 statement needed after the preceding .PS");
	}

	/* check for any scale setting statement */
	if(state==1 || state==3)
	{	if((p=index(line,"scale")) != NULL)
		{	while(*p == ' ') p++;
			sscanf(p,"=%f",&scale);
		}
	}

	return;
}

/* Check for illegal nesting and bad pairing of certain macros */
/* D. Muir 3/5/88 */
/* Change to allow RS after AS, DF, DS, and FS.
   Change to allow FS after AS ans RS.
   Change to allow EQ, FS, and TS in .TL/.MT pair.
   D. Muir 11/15/88 
   Added test for .AL in a .VG/.VE pair. D. Muir 8/10/89
   Fixed bug in \*F detection. D. Muir 9/22/89
   Added check for too many centered lines ina .BS/.BE pair
   D. Muir 11/17/89
   Added non-fatal diagnostic saying that grap and pic are not
   recommended in displays - D. Muir 11/20/89 
   Backed out above change - D. Muir 11/22/89
   Changed to allow .PS in a .VG/.VE pair - D. Muir 11/27/90
   Added check for \f and \s in a .VG/.VE pair - D. Muir 12/5/90
   Changed to allow .TS in an .AS/.AR pair - D. Muir 2/18/91
   Deleted check for \f and \s in a .VG/.VE pair - D. Muir 4/2/91
 */
#define PUSH(x) state_stack[i++]=state; state=x
#define POP  state=state_stack[--i]
nest_ck(){
	static int state=0, state_stack[20], i=0;
	/* State Table:
     0 = initial(base) state
     1 = in a .AS/.AE pair
     2 = in a .DS/.DE pair
     3 = in a .DF/.DE pair
     4 = in a .RS/.RF pair
     5 = in a .TS/.TE pair
     6 = in a .BS/.BE pair
     7 = in a .NS/.NE pair
     8 = in a .FS/.FE pair
     9 = in a .EQ/.EN pair
    10 = in a .G1/.G2 pair
    11 = in a .PS/.PE or .PF pair
    12 = in a .GS/.GE pair
    13 = in a .VG/.VE pair
    14 = in a .TL/.MT pair
   */
	char pname[8];
	static int ce_cnt;
	int Error;
	Error = 0;

set_pname:
	switch(state){
	case 0:
		break;
	case 1:
		strcpy(pname,".AS/.AE");
		break;
	case 2:
		strcpy(pname,".DS/.DE");
		break;
	case 3:
		strcpy(pname,".DF/.DE");
		break;
	case 4:
		strcpy(pname,".RS/.RF");
		break;
	case 5:
		strcpy(pname,".TS/.TE");
		break;
	case 6:
		strcpy(pname,".BS/.BE");
		if(!strncmp(line,".ce",3))
		{	ce_cnt = 1;  /* default count is one */
			sscanf(&line[3],"%d",&ce_cnt);
		}
		break;
	case 7:
		strcpy(pname,".NS/.NE");
		break;
	case 8:
		strcpy(pname,".FS/.FE");
		break;
	case 9:
		strcpy(pname,".EQ/.EN");
		break;
	case 10:
		strcpy(pname,".G1/.G2");
		break;
	case 11:
		strcpy(pname,".PS/.PE");
		break;
	case 12:
		strcpy(pname,".GS/.GE");
		break;
	case 13:
		strcpy(pname,".VG/.VE");
		break;
	case 14:
		strcpy(pname,".TL/.MT");
		break;
	}

	if(eof){
		if(state != 0){
			errflg = 1;
			printf("Missing %.3s detected at EOF\n",&pname[4]);
			POP;
			goto set_pname;
		}
		i =0; /* should already be zero but just in case */
		ce_cnt = 0;
		return;
	}
 	/* look for with centered lines in a BS/BE pair */
	if(ce_cnt && line[0]!='.') ce_cnt--;

	/* See if we have a .. line */
	if(!strncmp(line,"..",2) && (line[2] == ' ' || line[2] == '\n')){
		if(state != 0){

			errflg = 1;
			printf("Line %d: .. not allowed within a %s pair\n",line_nr,pname);
			return;
		}
	}

	/* Check other illegal nestings */
	if(!strncmp(line,".AL",3)){
		if(state==13){
			errflg = 1;
			printf("Line %d: .AL will not work in a .VG/.VE pair\n",line_nr);
		}
	}
	if(!strncmp(line,".AS",3)){
		if(state!=0 && state!=14)Error++;
		PUSH(1);
		goto end;
	}
	if(!strncmp(line,".AE",3)){
		if(state != 1){
			errflg = 1;
			printf("Line %d: .AE not preceded by a .AS\n",line_nr);
		}
		else{
			POP;
		}
		return;
	}
	if(!strncmp(line,".DS",3)){
		if(state!=0)Error++;
		PUSH(2);
		goto end;
	}
	if(!strncmp(line,".DE",3)){
		if(state!=2 && state!=3){
			errflg = 1;
			printf("Line %d: .DE not preceded by a .DS or .DF\n",line_nr);
		}
		else{
			POP;
		}
		return;
	}
	if(!strncmp(line,".DF",3)){
		if(state!=0)Error++;
		PUSH(3);
		goto end;
	}
	if(!strncmp(line,".RS",3)){
		if(state!=0 && state!=1 && state!=2 && state!=3 && state!=8)Error++;
		PUSH(4);
		goto end;
	}
	if(!strncmp(line,".RF",3)){
		if(state != 4){
			errflg = 1;
			printf("Line %d: .RF not preceded by a .RS\n",line_nr);
		}
		else{
			POP;
		}
		return;
	}
	if(!strncmp(line,".TS",3)){
		if(state!=0 && state!=1  && state!=2 && state!=3 && state!=6 && state!=7 && state!=13 && state!=14)Error++;
		PUSH(5);
		goto end;
	}
	if(!strncmp(line,".TE",3)){
		if(state != 5){
			errflg = 1;
			printf("Line %d: .TE not preceded by a .TS\n",line_nr);
		}
		else{
			POP;
		}
		return;
	}
	if(!strncmp(line,".BS",3)){
		if(state!=0)Error++;
		PUSH(6);
		goto end;
	}
	if(!strncmp(line,".BE",3)){
		if(ce_cnt)
		{	errflg = 1;
			printf("Line %d: .ce above centers too many lines\n",line_nr);
			ce_cnt = 0;
		}
		if(state != 6){
			errflg = 1;
			printf("Line %d: .BE not preceded by a .BS\n",line_nr);
		}
		else{
			POP;
		}
		return;
	}
	if(!strncmp(line,".NS",3)){
		if(state!=0 && state!=7 && state!=14)Error++;
		if(state!=7){
			PUSH(7);
		}
		goto end;
	}
	if(!strncmp(line,".NE",3)){
		if(state != 7){
			errflg = 1;
			printf("Line %d: .NE not preceded by a .NS\n",line_nr);
		}
		else{
			POP;
		}
		return;
	}
	if(!strncmp(line,".FS",3)){
		if(state!=0 && state!=1 && state!=4 && state!=14)Error++;
		PUSH(8);
		goto end;
	}
        if(index(line,"\\*F")!=NULL){
		switch(state){
		case 5:
			errflg = 1;
			printf("Line %d: Footnote in a table will require command .nr :p -1\n",line_nr);
			break;
		case 6:
			errflg = 1;
			printf("Line %d: \\*F not allowed within a %s pair\n",line_nr,pname);
			break;
		}
	}
	if(!strncmp(line,".FE",3)){
		if(state != 8){
			errflg = 1;
			printf("Line %d: .FE not preceded by a .FS\n",line_nr);
		}
		else{
			POP;
		}
		return;
	}
	if(!strncmp(line,".EQ",3)){
		if(state!=0 && state!=2 && state!=3 && state!=5 && state!=13 && state!=14)Error++;
		PUSH(9);
		goto end;
	}
	if(!strncmp(line,".EN",3)){
		if(state != 9){
			errflg = 1;
			printf("Line %d: .EN not preceded by a .EQ\n",line_nr);
		}
		else{
			POP;
		}
		return;
	}
	if(!strncmp(line,".G1",3)){
		if(state!=0 && state!=2 && state!=3) Error++;
		PUSH(10);
		goto end;
	}
	if(!strncmp(line,".G2",3)){
		if(state != 10){
			errflg = 1;
			printf("Line %d: .G2 not preceded by a .G1\n",line_nr);
		}
		else{
			POP;
		}
		return;
	}
	if(!strncmp(line,".PS",3)){
		if(state!=0 && state!=2 && state!=3 && state!=13) Error++;
		if(strchr(line,(int)'<')==NULL){
			PUSH(11);
		}
		goto end;
	}
	if(!strncmp(line,".PE",3)){
		if(state != 11){
			errflg = 1;
			printf("Line %d: .PE not preceded by a .PS\n",line_nr);
		}
		else{
			POP;
		}
		return;
	}
	if(!strncmp(line,".PF",3)){
		if(state==0) return; /* page footer macro must be assumed */
		if(state!=11){
			Error++; 
			goto end;
		}
		POP;
		return;
	}
	if(!strncmp(line,".GS",3)){
		if(state!=0 && state!=2 && state!=3)Error++;
		PUSH(12);
		goto end;
	}
	if(!strncmp(line,".GE",3)){
		if(state != 12){
			errflg = 1;
			printf("Line %d: .GE not preceded by a .GS\n",line_nr);
		}
		else{
			POP;
		}
		return;
	}
	if(!strncmp(line,".SG",3)){
		if(state!=0) Error++;
		goto end;
	}
	if(!strncmp(line,".VG",3)){
		if(state!=0) Error++;
		PUSH(13);
		goto end;
	}
	if(!strncmp(line,".VE",3)){
		if(state!=13){
			errflg = 1;
			printf("Line %d: .VE not preceded by a .VG\n",line_nr);
		}
		else {
			POP;
		}
		return;
	}
	if(!strncmp(line,".TL",3)){
		if(state!=0) Error++;
		PUSH(14);
		goto end;
	}
	if(!strncmp(line,".MT",3)){
		if(state==14) POP;
		return;
	}
	if(!strncmp(line,".H ",3) || !strncmp(line,".HU",3)){
		if(state!=0) Error++;
		goto end;
	}
end:
	if(Error){
		if(Error==2) printf("Line %d: %.3s not recommended in a %s pair\n",line_nr,line,pname);
		else{
			errflg = 1;
			printf("Line %d: %.3s not allowed within a %s pair\n",line_nr,line,pname);
		}
	}
#undef PUSH
#undef POP
}

/* Check various problems with tables */
/* D. Muir 6/3/88 */
/* Added _ and = to list of allowable column format descriptors.
   D. Muir 11/22/88 */
/* Added check for characters after the ; on the options line.
   D. Muir 2/20/89 */
/* Added check for a font request after column format key-letters.
   D. Muir 11/2/89 */
/* Added code pertaining to the 200th row - D. Muir 11/6/89 */
/* Added check for comment on data lines - D. Muir 11/08/89 */
/* Added check for text block with fill mode off - D. Muir 11/10/89 */
/* Revised code to check the number of columns in a format specification.
   C. Mee 9/26/90 */
/* Improved check for ; on global options line - D. Muir 11/21/90 */
/* Added warning about words beginning with . inside text blocks
   D. Muir 11/21/90 */
/* Reduced fill mode diagnostic for text blocks from an error to
   a warning - D. Muir 12/3/90 */
/* Moved code for checking words beginning with . in text blocks so
   that it came after the check for a line which ends a text block -
   D. Muir 1/2/91 */
/* Added facility for handling format lines with commas - D. Muir 5/1/91 */
/* Added check for too many text blocks - D. Muir 5/2/91 */
/* Added maxline to global options and made the default 250 - D. Muir
   10/21/91 */
tbl_ck(){
	static int state = 0;
	/* state table:
	0 = base (initial) state
	1 = .TS found
	2 = end of global options
	3 = end of format section
	*/
	static int NR_COLS = 0; /* from first format line */
	static int nr_cols = 0; /* for subsequent format lines and
					   for columns of data */
	static int H_OPTION = 0;
	static int T_BLOCK = 0;
	static char TAB = '\t';
	static int row_cnt;     /* for counting rows */
	static int ROW_CNT;     /* cutoff for determining table shape */
	static int tblock_cnt;  /* for counting text blocks */
	static int nf = 0,      /* no fill mode outside of displays */
		   DISPLAY = 0, /* in a display */
		   DS_nf = 0,   /* no fill in a display */
		   MAYBE = 0,   /* will need diagnostic if next line is not .nf */
		   DIAG_nf = 0; /* no fill diagnostic issued */

	char c[2], *p, *q;

	/* eof processing */
	if(eof){
		/* no need to check for missing .TE becuz nest_ck does it */
		if(T_BLOCK){
			errflg = 1;
			printf("Uncompleted table text block found at EOF\n");
		}
		if(state==2){
			errflg = 1;
			printf("Missing table format section found at EOF\n");
		}
		if(state==1){
			errflg = 1;
			printf("Missing table global options found at EOF\n");
		}
		TAB='\t'; 
		state=T_BLOCK=NR_COLS=H_OPTION=nf=DISPLAY=DIAG_nf=MAYBE=0;
		return;
	}

	/* issue no fill diagnostic, if needed */
	if(MAYBE && strncmp(line,".fi",3))
	{	if(DISPLAY) printf("Line %d: Text block may require fill to be enabled on the preceding .DS/.DF\n",line_nr-1);
		else printf("Line %d: Text block may require that fill mode be enabled\n",line_nr-1);
		DIAG_nf = 1;
	}
	MAYBE = 0;

	/* .TS processing */
	if(!strncmp(line,".TS",3)){
		state = 1;
		row_cnt = 0;
		ROW_CNT = 250;
		tblock_cnt = 0;
		p = &line[3];
		while(*p == ' ') p++;
		if(*p == 'H') H_OPTION = 1;
		return;
	}

	/* .TE processing */
	if(!strncmp(line,".TE",3)){
		if(H_OPTION){
			errflg = 1;
			printf("Line %d: Missing .TH after .TS H\n",line_nr);
		}
		if(T_BLOCK){
			errflg = 1;
			printf("Line %d: Missing end of text block (T}) detected\n",line_nr);
		}
		if(state==2){
			errflg = 1;
			printf("Line %d: Missing table format data detected\n",line_nr);
		}
		if(state==1){
			errflg = 1;
			printf("Line %d: Missing table options detected\n",line_nr);
		}
		state=T_BLOCK=NR_COLS=H_OPTION=DIAG_nf=MAYBE=0;
		TAB = '\t';
		return;
	}

	/* .TH processing */
	if(!strncmp(line,".TH",3)){
		if(!H_OPTION){
			errflg = 1;
			printf("Line %d: Missing .TS H before .TH\n",line_nr);
		}
		else H_OPTION = 0;
		return;
	}

	/* global options processing */
	if(state == 1){
		state = 2;
		if((p=strchr(line,(int)';'))!=NULL) /* we have an options line */
		{	if((q=index(line,"tab"))!=NULL) /* we have a respecified tab char */
			{	while(*q == ' ') q++;
				if(*q=='(' && *(q+2)==')')
				{	TAB = *(q+1);
					if(p == q+1) /* ; we found was tab char */
					{	if((p=strchr(q+3,(int)';')) == NULL)
						{	errflg = 1;
							printf("Line %d: Missing ; on global options line\n",line_nr);
							return;
						}
					}
				}
			}
			if((q=index(line,"maxline"))!=NULL)
			{	while(*q == ' ') q++;
				if(*q++ == '(') sscanf(q,"%d)",&ROW_CNT);
				if(ROW_CNT>16000) error("maxline value cannot exceed 16000");
			}
			if(*(p+1)!='\n'){
				errflg = 1;
				printf("Line %d: Semicolon not last character\n",line_nr);
			}
			return;
		}
	}

	/* format section processing */
	if(state == 2){
		p = line;
		while(*p==' ' || *p=='\t') p++;
		if(*p=='\n')
			return;	/* Ignore blank lines */
		if(*p=='.') { /* End of format section */
			state=3;
			if (NR_COLS == 0)
				error("Must have at least one format line");
			while(*(p+1)==' ' || *(p+1)=='\t') p++;
			if(*(p+1)!='\n')
				error(". not last character on input line");
			return;
		}
		for (;;) {
			nr_cols=findcol(&p);
			if(NR_COLS == 0){
				NR_COLS = nr_cols;
				if(NR_COLS>36) error("Too many columns");
			}
			else{
				if(nr_cols != NR_COLS)
					error("Format lines must have same number of columns");
			}
			nr_cols = 0;
			if(*p=='\n') /* End of format line */
				return;
			if(*p=='.') { /* End of format section */
				state=3;
				while(*(p+1)==' ' || *(p+1)=='\t') p++;
				if(*(p+1)!='\n')
					error(". not last character on input line");
				return;
			}
			p++; /* Here for a comma on the format line */
			if(strlen(p) == strspn(p," \n")) return;
		}
	}

	/* format respecification processing */
	if(state==3 && !strncmp(line,".T&",3)){ 
		state = 2; 
		if(row_cnt>ROW_CNT)
		{	errflg = 1;
			printf("Line %d: Table format respecification not recognized after the %dth row\n",line_nr,ROW_CNT);
		}
		return;
	}

	/* processing of data lines including text blocks */
	if(state==3 && !T_BLOCK && line[0]!='.'){
		if(++row_cnt==ROW_CNT+1)
		{	/* errflg not set becuz this may not cause trouble */
			printf("Line %d: Table contains more than %d rows...\n",line_nr,ROW_CNT);
			printf("         Column widths are established at this point\n");
		}
		if(index(line,"\\\"")!=NULL)
		{	errflg = 1;
			printf("Line %d: Comments should not appear on table data lines\n",line_nr);
		}
		p = line;
cnt_data:	
		while(*p != '\n'){
			while(*p!=TAB && *p!='\n') p++;
			if(++nr_cols > NR_COLS){
				errflg = 1;
				printf("Line %d: Too many columns of data\n",line_nr);
				nr_cols = 0;
				return;
			}
			if(*p == TAB) p++;
		}
	}

	if(state==3 && !T_BLOCK){
		if((p = index(line,"T{"))!=NULL){
			if(*p != '\n'){
				errflg = 1;
				printf("Line %d: T{ must be at the end of the input line\n",line_nr);
			}
			T_BLOCK = 1;
			if(++tblock_cnt == 63)
				error("Too many text blocks in this table");
			if(!DIAG_nf && ((DISPLAY && DS_nf) || (!DISPLAY && nf))) MAYBE = 1;
			return;
		}
		else nr_cols = 0;
	}

	if(T_BLOCK && (p=index(line,"T}"))!=NULL){
		if(p != &line[2]){
			errflg = 1;
			printf("Line %d: T} must be at the beginning of the line\n",line_nr);
		}
		if(*p!='\n' && *p!=TAB){
			errflg = 1;
			printf("Line %d: T} must be followed by the TAB character or the end of the line\n",line_nr);
		}
		T_BLOCK = 0;
		if(*p=='\n'){
			nr_cols=0; 
			return;
		}
		else{
			p++; 
			goto cnt_data;
		}
	}

	if(T_BLOCK)
	{	if(index(line," .") != NULL)
		{	printf("Line %d: Warning: period at beginning of a word in a text block may\n",line_nr);
			printf("         cause problems. To be safe precede the period with \\&\n");
		}
	}

	/* look for display and fill on/off controls */
	if(!DISPLAY && !T_BLOCK)
	{	if(!strncmp(line,".nf",3)) { nf = 1; return; }
		if(!strncmp(line,".fi",3)) { nf = 0; return; }
	}
	else if(state==0 && !strncmp(line,".fi",3))
	{	DS_nf = 0;
		return;
	}
	if(!strncmp(line,".DS",3) || !strncmp(line,".DF",3))
	{	DISPLAY = 1;
		strcpy(c,"");
		sscanf(line,"%*s%*s%1s",c);
		if(c[0]!='1' && c[0]!='F') DS_nf = 1;
		else DS_nf = 0;
		return;
	}
	if(!strncmp(line,".DE",3))
	{	DISPLAY = 0;
		return;
	}
}

/* Get column count from a tbl format specification */
/* C. Mee - 12/90 */
/* Improved differentiation of . in column width spec vs. a . which
   ends a specification line - D. Muir 5/1/91 */
/* Removed tab as an allowed character - D. Muir 5/2/91 */
/* Added back tab as an allowed (white space) charccter - D. Muir 10/4/91 */
/* Reworked code for width specs - D. Muir 10/4/91 */
/* Changed break to continue in switch statement to, possibly,
   speed up execution - D. Muir 10/4/91 */
findcol(nextp)
char **nextp;
{
	register c;
	int nc;
	char *p;

	nc = 0;	/* Initialize column count */

	/* Scan the specification looking for a key letter, '-', or '=' */
	for (p = *nextp; (c = *p) != '\0'; p++)
	{
		switch (c)
		{
		case ' ':
		case '\t':
			continue;
		case '\n':
		case '.':
		case ',':
			/* End of format for one row */
			*nextp = p;
			return nc;
		case 'L':
		case 'R':
		case 'C':
		case 'N':
		case 'A':
		case 'S':
		case 'l':
		case 'r':
		case 'c':
		case 'n':
		case 'a':
		case 's':
		case '^':
		case '-':
		case '_':
		case '=':
			/* Found a key letter */
			nc++;	/* Increment column count */
			continue;
		case 'b':
		case 'i':
		case 'B':
		case 'I':
			/* Bold or italic */
			continue;
		case 't':
		case 'T':
			continue;
		case 'd':
		case 'D':
			continue;
		case 'F':
		case 'f':
			/*
			 * Eat up a font name or number
			 *
			 * The purpose is to avoid possible confusion
			 * between keyletters and font names.
			 *
			 * This allows undocumented format f(n)
			 */
			if (isdigit(*(p+1)))
				p++; /* font number (one digit only) */
			else if (isalpha(*(p+1))) {
				/* font name (one or two letters) */
				p++;
				if (isalpha(*(p+1)))
					p++;
			}
			else if (*(p+1) == '(') {
				/* font name or number in parentheses */
				p++;
				if (isdigit(*(p+1))) {
					/* number */
					p++;
					while (isdigit(*(p+1)))
						p++;
				}
				else if (isalpha(*(p+1))) {
					/* name (one or two letters) */
					p++;
					if (isalpha(*(p+1)))
						p++;
				}
				while (*(p+1) == ' ' || *(p+1) == '\t')
					p++;
				if (*(p+1) == ')')
					p++;
				else
					error("Syntax error in table specification");
			}
			continue;
		case 'P':
		case 'p':
		case 'V':
		case 'v':
			/*
			 * Eat up a point-size or vertical-spacing change
			 *
			 * The purpose is to avoid possible confusion
			 * between the use of '-' to indicate a negative
			 * integer and the use of '-' to indicate a
			 * horizontal line
			 */
			if (*(p+1) == '-' || *(p+1) == '+')
				p++;
			if ( ! isdigit(*(p+1)))
				error("Syntax error in table specification");
			while (isdigit(*(p+1)))
				p++;
			continue;
		case 'W':
		case 'w':
			/*
			 * Eat up a column-width specification
			 */
			p++;
			if (isdigit(*p)) /* no parentheses */
			{	while (isdigit(*(p+1))) p++;
				continue;
			}
			if (*p == '(') /* parentheses */
			{
				p++;
				while (isdigit(*p)) p++;
				if (*p == '.') p++;
				while (isdigit(*p)) p++;
				if (strchr("icPmnpuv", *p) != NULL) /* scale indicator */
					p++;
				if (*p == ')') continue;
			}
			error("Invalid column width specification");
			p--; /* look at this char again */
			continue;
		case 'e':
		case 'E':
			/* Equal-width column */
			continue;
		case 'z':
		case 'Z':
			/* Zero-width */
			continue;
		case 'u':
		case 'U':
			/* Half line up */
			continue;
		case '0':
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			/* Separation between this column and the next one */
			while (isdigit(*(p+1)))
				p++;
			continue;
		case '|':
			/* Put a vertical line here */
			continue;
		default:
			error("Invalid character in table specification");
			continue;
		} /* end of switch */
	} /* end of loop */
	/* Should never get to here */
	*nextp = p;
	return nc;
}

/* Check various problems with equations */
/* D. Muir 2/17/88 */
/* Exempted control lines from delim, etc. scan - D. Muir 9/16/88 */
/* Removed check for mismatched vertical bars - D. Muir 11/16/88  */
/* Added check for bad equation delimiters - D. Muir 2/21/89 */
/* Added "delim off" statement processing - D. Muir 2/21/89 */
/* Added warning for delimiter alone on a line - D. Muir 3/7/89 */
/* Fixed bug that caused continued control lines (CONT=1) to not
   end when they should.
   Eliminated the search for in-line equation delimiters in an
   .EQ/.EN pair.
   Added EQ != 0 as a condition for exempting control lines from
   the delim, etc. scan - D. Muir 3/31/89 */
/* Fixed bug that caused .H lines not to be scanned for delimiters,
   etc. - D. Muir 4/6/89 */
/* Added % as a bad choice for delimiter - D. Muir 3/29/91 */
eqn_ck(){
	static int EQ = 0, /* in an .EQ/.EN pair */
	DEQ = 0, /* in delim/delim pair */
	CONT = 0, /* continuation of a control line */
	ALONE = 0, /* left delim alone on the line */
	PAREN = 0,
	BRACE = 0,
	BRACKET = 0;
	static char l_delim = '\0',
	r_delim = '\0';
	char *p, *q;
	int i;
	static char bad_delim[]={'%','#','{','}','~','^','\"','\n'};

	/* eof processing */
	if(eof){
		/* deleted because nest_ck does the function
		if(EQ != 0){
			errflg = 1;
			printf("Missing .EN detected at EOF\n");
		}
		*/
		if(DEQ != 0){
			errflg = 1;
			printf("Missing right equation delimiter detected at EOF\n");
		}
		EQ=DEQ=PAREN=BRACE=BRACKET=CONT=ALONE=0;
		l_delim=r_delim='\0';
		return;
	}

	/* delim statement processing */
	if(EQ == 1 && !strncmp(line,"delim",5)){
		p = &line[5];
		while(*p == ' ') p++;
		if(*(p-1) != ' ' ||
		    !isgraph((int)*p) ||
		    !isgraph((int)*(p+1))){
			errflg = 1;
			printf("Line %d: Syntax error in delim statement\n",line_nr);
			return;
		}
		if(!strncmp(p,"off",3)){
			l_delim=r_delim='\0';
			return;
		}
		l_delim = *p;
		r_delim = *(p+1);
		for(i=0; bad_delim[i]!='\n'; i++){
			if(*p==bad_delim[i] || *(p+1)==bad_delim[i]){
				errflg = 1;
				printf("Line %d: %%, #, {, }, ~, ^ and \" should not be used as equation delimiters\n",line_nr);
				return;
			}
		}
		return;
	}

	/* .H processing */
	if(!strncmp(line,".H",2)){
		if(DEQ == 1){
			errflg = 1;
			printf("Line %d: Missing right equation delimiter before .H\n",line_nr);
		}
		DEQ = EQ = PAREN = BRACE = BRACKET = CONT = 0;
	}

	/* .EQ/.EN processing */
	if(!strncmp(line,".EQ",3)){
		if(EQ == 1){
			errflg = 1;
			printf("Line %d: Missing .EN or redundant .EQ detected\n",line_nr);
		}
		EQ = 1;
		if(DEQ == 1){
			DEQ = 0;
			errflg = 1;
			printf("Line %d: .EQ not allowed within a delimited equation\n",line_nr);
		}
		return;
	}
	if(!strncmp(line,".EN",3)){
		/* nest_ck looks for redundant .EN */
		EQ = 0;
		if(DEQ == 1){
			DEQ = 0;
			errflg = 1;
			printf("Line %d: .EN not allowed within a delimited equation\n",line_nr);
		}
		if(PAREN != 0){
			errflg = 1;
			printf("Line %d: Mismatched parens in equation\n",line_nr);
		}
		if(BRACE != 0){
			errflg = 1;
			printf("Line %d: Mismatched braces in equation\n",line_nr);
		}
		if(BRACKET != 0){
			errflg = 1;
			printf("Line %d: Mismatched brackets in equation\n",line_nr);
		}
		PAREN = BRACE = BRACKET = CONT = 0;
		return;
	}

	/* delim finding and paren, etc scan */
	/* don't scan formatting control lines or their continuations 
		in an EQ/EN pair */
	if(CONT || (EQ && line[0]=='.')){
		if(line[strlen(line)-2] == '\\') CONT = 1;
		else CONT = 0;
		return;
	}
	p = line;
	p--;
	while(*++p != '\n'){ /* scan the line */
		if(DEQ || EQ){
			/* \" does not start a string */
			if(*p=='\\' && *(p+1)=='\"'){
				p++;
				continue;
			}
			if(*p == '\"'){  /* ignore quoted strings */
				if((p=strchr(++p,'\"')) == NULL){
					errflg = 1;
					printf("Line %d: Unfinished quoted string\n",line_nr);
					break;
				}
				continue;
			}
			if(!strncmp(p,"left",4)){
				q = p+4;
				while(*q == ' ') q++;
				if(*q=='[' || *q=='{' || *q=='('){
					p = q;
					continue;
				}
			}
			if(!strncmp(p,"right",5)){
				q = p+5;
				while(*q == ' ') q++;
				if(*q==']' || *q=='}' || *q==')'){
					p = q;
					continue;
				}
			}
		}
		if(!EQ){
			if(!DEQ && *p == l_delim){
				DEQ = 1;
				ALONE = 1;
				continue;
			}
			if(DEQ && *p == r_delim){
				DEQ = 0;
				ALONE = 0;
				if(PAREN != 0){
					errflg = 1;
					printf("Line %d: Mismatched parens in equation\n",line_nr);
				}
				if(BRACE != 0){
					errflg = 1;
					printf("Line %d: Mismatched braces in equation\n",line_nr);
				}
				if(BRACKET != 0){
					errflg = 1;
					printf("Line %d: Mismatched brackets in equation\n",line_nr);
				}
				PAREN = BRACE = BRACKET = 0;
				continue;
			}
		}
		if(DEQ || EQ){
			if(*p == '(' && *(p-1) != '\\'){
				PAREN++;
				continue;
			}
			if(*p == ')'){
				PAREN--;
				continue;
			}
			if(*p == '{'){
				BRACE++;
				continue;
			}
			if(*p == '}'){
				BRACE--;
				continue;
			}
			if(*p == '['){
				BRACKET++;
				continue;
			}
			if(*p == ']'){
				BRACKET--;
				continue;
			}
			/* \(xx is the special character xx and \" is allowed by eqn */
			if(*p=='\\' && *(p+1)!='(' && *(p+1)!='\"'){
				errflg = 1;
				printf("Line %d: Unquoted troff command in equation\n",line_nr);
				continue;
			}
		}
	} /* end while(*++p != '\n') */
	if(ALONE){
		/* This does not set the errflg because it may be OK */
		printf("Line %d: Warning: left equation delimiter alone on this line\n",line_nr);
		ALONE = 0;
	}
}

/* Make sure a break occurs before a .tl */
/* D. Muir 2/17/88 */
/* Bug fix: static added to char end[4]; D. Muir 7/25/88 */
/* Bug fix: end[4] changed to end[5] and limited the length of copies
   into and comparisons of that data to guard against trailing
   blanks - D Muir 11/22/88 */
/* Removed check for .ig and .de blocks because they are now handled
   globally by macro_ck. Added code to exclude .tl in a BS/BE pair.
   D. MUir 10/24/89 */
tl_ck(){
	static int state = 0;
	/* State Table:
     0 = initial(base) state
     1 = in a BS/BE pair
     2 = break causing command detected
   */
	int i;
	static char *break_cmd[] ={
		".nf",".fi",".br",".bp",".ce",".sp",
		".in",".ti",".SK","END"		};

	if(eof){ 
		state = 0; 
		return;
	}

	switch(state){
	case 0:
		if(!strncmp(line,".BS",3)){
			state = 1;
			return;
		}
		if(!strncmp(line,".tl",3)){
			errflg = 1;
			printf("Line %d: .br needed ahead of .tl\n",line_nr);
			return;
		}
		i = 0;
		while(strcmp(break_cmd[i],"END")){
			if(!strncmp(line,break_cmd[i++],3)){
				state = 2;
				return;
			}
		}
		return;
	case 1:
		if(!strncmp(line,".BE",3)) state = 0;
	case 2:
		return;
	}
}

/* Check for list pairings  */
/* V. G. Dave 4/28/88  */
/* Added check for text-indent arg on .VL - D. Muir 11/14/88 */
/* Changed diagnostic for missing .LE to provide line number where the
   list started - D. Muir 9/22/89 */
lst_ck()
{
	struct list
	{
		char type_lst[4];
		int line_num;
	};

	static struct list level[21];
	static int lev_num = 0;
	char *p;

	if(eof)
	{
		while (lev_num > 0)
		{
			if(lev_num < 22)
			{
				errflg = 1;
				printf("Unfinished %s list detected at EOF which was begun on line %d\n", 
				    level[lev_num].type_lst,
				    level[lev_num].line_num);
			}
			lev_num--;
		}
		return;
	}
	if(!strncmp(line,".LI",3) && lev_num == 0)
	{
		lev_num++;
		strncpy(level[lev_num].type_lst,".??",3);
		level[lev_num].line_num = 0;
		errflg = 1;
		printf("Line %d: Missing list begin before .LI\n",line_nr);
	}
	if(!strncmp(line,".H ",3) || !strncmp(line,".HU",3))
	{
		while (lev_num > 0)
		{
			if(lev_num < 22)
			{
				errflg = 1;
				printf("Line %d: Missing .LE for %s at line %d\n",
			 	    line_nr,
				    level[lev_num].type_lst,
				    level[lev_num].line_num);
			}
			lev_num--;
		}
	}
	if(!strncmp(line, ".VE", 3))
	{
		while (lev_num > 0)
		{
			if(lev_num < 22)
			{
				errflg = 1;
				printf("Line %d: Missing .LE for %s at line %d\n",
			 	    line_nr,
				    level[lev_num].type_lst,
				    level[lev_num].line_num);
			}
			lev_num--;
		}
	}
	if(!strncmp(line, ".AL", 3))
	{
		lev_num++;
		if (lev_num < 22)
		{
			strncpy(level[lev_num].type_lst, ".AL", 3);
			(level[lev_num].line_num = line_nr);
			if ( (lev_num > 6) && (lev_num < 22) )
			{
				errflg = 1;
				printf("Line %d: Lists nested %d deep. Maximum levels permitted is 6.\n", line_nr,
				    lev_num);
			}
		}
	}
	if (!strncmp(line, ".BL", 3))
	{
		lev_num++;
		if (lev_num < 22)
		{
			strncpy(level[lev_num].type_lst, ".BL", 3);
			(level[lev_num].line_num = line_nr);
			if ( (lev_num > 6) && (lev_num < 22) )
			{
				errflg = 1;
				printf("Line %d: Lists nested %d deep. Maximum levels permitted is 6.\n", line_nr,
				    lev_num);
			}
		}
	}
	if (!strncmp(line, ".DL", 3))
	{
		lev_num++;
		if (lev_num < 22)
		{
			strncpy(level[lev_num].type_lst, ".DL", 3);
			(level[lev_num].line_num = line_nr);
			if ( (lev_num > 6) && (lev_num < 22) )
			{
				errflg = 1;
				printf("Line %d: Lists nested %d deep. Maximum levels permitted is 6.\n", line_nr,
				    lev_num);
			}
		}
	}
	if (!strncmp(line, ".LB", 3))
	{
		lev_num++;
		if (lev_num < 22)
		{
			strncpy(level[lev_num].type_lst, ".LB", 3);
			(level[lev_num].line_num = line_nr);
			if ( (lev_num > 6) && (lev_num < 22) )
			{
				errflg = 1;
				printf("Line %d: Lists nested %d deep. Maximum levels permitted is 6.\n", line_nr,
				    lev_num);
			}
		}
	}
	if (!strncmp(line, ".ML", 3))
	{
		lev_num++;
		if (lev_num < 22)
		{
			strncpy(level[lev_num].type_lst, ".ML", 3);
			(level[lev_num].line_num = line_nr);
			if ( (lev_num > 6) && (lev_num < 22) )
			{
				errflg = 1;
				printf("Line %d: Lists nested %d deep. Maximum levels permitted is 6.\n", line_nr,
				    lev_num);
			}
		}
	}
	if (!strncmp(line, ".RL", 3))
	{
		lev_num++;
		if (lev_num < 22)
		{
			strncpy(level[lev_num].type_lst, ".RL", 3);
			(level[lev_num].line_num = line_nr);
			if ( (lev_num > 6) && (lev_num < 22) )
			{
				errflg = 1;
				printf("Line %d: Lists nested %d deep. Maximum levels permitted is 6.\n", line_nr,
				    lev_num);
			}
		}
	}
	if (!strncmp(line, ".VL", 3))
	{
		p = &line[3];
		while(*p == ' ') p++;
		if(*p == '\n'){
			errflg = 1;
			printf("Line %d: .VL must have a text-indent argument\n",line_nr);
		}
		lev_num++;
		if (lev_num < 22)
		{
			strncpy(level[lev_num].type_lst, ".VL", 3);
			(level[lev_num].line_num = line_nr);
			if ( (lev_num > 6) && (lev_num < 22) )
			{
				errflg = 1;
				printf("Line %d: Lists nested %d deep. Maximum levels permitted is 6.\n", line_nr,
				    lev_num);
			}
		}
	}
	if (!strncmp(line, ".LE", 3))
	{
		lev_num--;
		if (lev_num < 0)
		{
			errflg = 1;
			printf("Line %d: Extra .LE\n", line_nr);
			lev_num = 0;
		}
	}
	if (!strncmp(line, ".OL", 3))
	{
		lev_num++;
		if (lev_num < 22)
		{
			strncpy(level[lev_num].type_lst, ".OL", 3);
			(level[lev_num].line_num = line_nr);
			if ( (lev_num > 6) && (lev_num < 22) )
			{
				errflg = 1;
				printf("Line %d: Lists nested %d deep. Maximum levels permitted is 6.\n", line_nr,
				    lev_num);
			}
		}
	}
}

/* check for bad font selections */
/* D. Muir  9/12/88 */
/* Added ZD font - D. Muir 2/20/98 */
/* Fixed bug - strncmp had only two arguments - D. Muir 9/22/89 */
/* Added tests for string and number register interpolations
   appearing as font names and allowed them - D. Muir 9/25/89 */
/* Removed code for ignore blocks since they are now handled
   globally by the macro_ck function - D. Muir 11/6/89 */
/* Added more allowable font names - D. Muir 10/2/90 */
/* Allowed .ft with no argument or \f followed by space
   or newline - D. Muir 12/3/90 */
font_ck(){
	static char one_char_font[] = {
		'B','C','H','I','P','R','S',
		'1','2','3','4','5','6','7','8','9','\n'};
	static char *two_char_font[] = {
		"BI","CB","CE","CI","CO","CT","CW","CX",
		"GB","GR","GS","HB","HI","HK","HL","HX","LO",
		"MB","MI","MR","MX","PA","PB","PI","PX",
		"Hr","Hi","Hb","Hx","KR","KI","KB","KX",
		"AR","AI","AB","AX","NR","NI","NB","NX",
		"S1","SC","SM","TB","TX","ZD","ZI","10","\n\n"};
	int i, str_nr_test();
	char *p;

	/* eof processing */
	if(eof){
		return;
	}

	/* look for font change commands */
	if(!strncmp(line,".ft",3)){
		p = &line[3];
		while(*p == ' ') p++;
		if(*p == '\n') return; /* no arg means previous font */
		i = 0;
		while(one_char_font[i] != '\n'){
			if(*p == one_char_font[i++]) return;
		}
		i = 0;
		while(strcmp(two_char_font[i],"\n\n")){
			if(!strncmp(p,two_char_font[i++],2)) return;
		}
		errflg = 1;
		printf("Line %d: Illegal font requested\n",line_nr);
		return;
	}

	/* look for in-line font changes */
	p = line;
	while(1==1){
		if((p=index(p,"\\f")) == NULL) return;
		if(*p==' ' || *p=='\n') return; /* means previous font */
		if(*p == '('){
			i = 0;
			while(strcmp(two_char_font[i],"\n\n")){
				if(!strncmp(p+1,two_char_font[i++],2)) goto done2;
			}
			if((i=str_nr_test(p+1))!=0){
				p += i;
				continue;
			}
			else{
				errflg = 1;
				printf("Line %d: Illegal font %.2s selected\n",line_nr,(p+1));
			}
done2:			p += 2; continue;
		}
		else{
			i = 0;
			while(one_char_font[i] != '\n'){
				if(*p == one_char_font[i++]) goto done1;
			}
			if((i=str_nr_test(p))!=0){
				p += i;
				continue;
			}
			else{
				errflg = 1;
				printf("Line %d: Illegal font %.1s selected\n",line_nr,p);
			}
done1:			p++; continue;
		}
	}
}

/* Called by font_ck() to look for string and number register
   interpolations. It returns the length if one is found.
   D. Muir 9/25/89 */
str_nr_test(p)
char *p;
{
	if(*p != '\\') return 0;
	if(*(p+1) != 'n' && *(p+1) != '*') return 0;
	if(*(p+2) == '(') return 5;
	else return 3;
}

/* Check for proper closure of quoted values on escape sequences */
/* D. Muir 3/31/89 */
/* Added N as one of the "letters" - D. Muir 7/11/89 */
/* Excluded quotes in \(xx special character requests - D. Muir 9/25/89 */
/* Added check for no quoted value at all after these escape
   sequences - D. Muir 11/3/89 */
/* Added code to ignore an escaped backslash - D. Muir 11/27/90 */
quote_ck(){
	static char letter[] = "bhlLovwxDHNS" ;
	char *p, *q, *ltr;
	int i;

	if(eof) return;

	p = line;
	while(1==1){
		if((p=index(p,"\\")) == NULL) return;
		if(*p == '\\') /* escaped backslash */
		{	p++;
			continue;
		}
		for(i=0; letter[i] != '\0'; i++){
			if(*p == letter[i]){
				ltr = p; /* save ptr to current letter */
				if(*(p+1) != '\'') 
				{	errflg = 1;
					printf("Line %d: Escape sequence \\%c must be followed by a quoted value\n",line_nr,*ltr);
					break;
				}
				p += 2;
repeat:				if((q=index(p,"\'")) == NULL){
					errflg = 1;
					printf("Line %d: Unclosed quoted string on escape sequence \\%c\'\n",line_nr,*ltr);
					return;
				}
				/* an escaped quote doesn't count */
				if(*(q-2) == '\\'){
					p = q;
					goto repeat;
				}
				/* quotes in the xx positions of \(xx don't count */
				if(*(q-3) == '\\' && *(q-2) == '('){
					p = q+1;
					goto repeat;
				}
				if(*(q-4) == '\\' && *(q-3) == '('){
					p = q;
					goto repeat;
				}
				p = q; break;
			}
		}
	}
}

/* check on inappropriate locations for comments */
/* D. Muir 11/8/89 */
/* tbl_ck looks for comments on table data lines */
comment_ck()
{	static char *bad_ones[] = {"ds","fp","AU","\n\n"};
	int i;

/* eof processing */
	if(eof) return;

	if(line[0] == '.')
	{	i = 0;
		while(strcmp(bad_ones[i],"\n\n"))
		{	if(!strncmp(&line[1],bad_ones[i++],2))
			{	if(index(&line[3],"\\\"")!=NULL)
				{	errflg = 1;
					printf("Line %d: Comments should not be placed on a %.3s line\n",line_nr,line);
					return;
				}
			}
		}
	}
}

/* Miscellaneous additional checks */
/* D. Muir 12/4/90 */
/* Added check for unbalanced " on request lines - D. Muir 1/2/91 */
/* Bypass obvious comment lines - D. Muir 5/1/91 */
/* Rearranged code to exempt .ds lines from check for unbalanced
   " characters - D. Muir 9/27/91 */
/* Added warning that .xxx may incorectly be viewed as a formatting
   command - D. Muir 9/27/91 */
/* Allow font numbers 1 thru 9 in .ds HF lines - D. Muir 10/7/91 */
/* Took out bypass of .\"comment lines because this is now done in
   the main function - D. Muir 10/11/91 */
misc_ck()
{	char *p;
	int i;

	if(eof) return;

	/* look for .xxx lines */
	if(line[0]=='.' && strcspn(line," \n")>3)
		/* .x\" and .xx\" are OK */
		if((p=strchr(line,'\\'))!=NULL && (p-line)<4 && *(p+1)=='\"');
		/* .TAG is OK */
		else if(!strncmp(line,".TAG",4));
		else warning(".xxx may be an unintended formatting command");

	if(!strncmp(line,".ds",3))
	{	p = &line[3];
		while(*p==' ') p++;
		if(!strncmp(p,"HF",2))
		{	p += 2;
			while(*p==' ') p++;
			if(strspn(p,"123456789 \n") != strlen(p))
			{	error("Font numbers must be 1 thru 9");
				return;
			}
			while(strspn(p,"123456789")==1)
			{	p++;
				while(*p==' ') p++;
				if(*p=='\n') return;
			}
			error("Font numbers must be separated by space(s)");
		}
		return;
	}

	if(line[0] == '.') /* check for unbalanced " */
	{	for(i=0, p= &line[1]; *p!='\n'; p++)
		{	if(*p=='\"' && *(p-1)!='\\') i++;
		}
		if(i % 2 != 0)
		{	error("Unbalanced \" character");
		}
	}

	if(!strncmp(line,".H ",3))
	{	p = &line[3];
		while(*p==' ') p++;
		if(strspn(p,"1234567")!=1)
		{	error("First argument must be 1 thru 7");
			return;
		}
		p++;
		if(*p!=' ' && *p!='\n')
		{	error("Argument delimiters must be blank(s)");
			return;
		}
		return;
	}

	if(!strncmp(line,".HF",3))
	{	error("HF is a string - use .ds HF");
		return;
	}
	if(!strncmp(line,".HP",3))
	{	error("HP is a string - use .ds HP");
		return;
	}

}
