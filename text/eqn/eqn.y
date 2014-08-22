%{
#include "e.h"

int	yylex(void);
%}

%union {
	int token;
	char *str;
}

%token <str> CONTIG QTEXT SPACE THIN TAB
%token <token> MATRIX LCOL CCOL RCOL COL ABOVE
%token <token> MARK LINEUP
%token <token> SUM INT PROD UNION INTER
%token <token> DEFINE TDEFINE NDEFINE DELIM GSIZE GFONT INCLUDE IFDEF
%token <token> DOTEQ DOTEN

%type <str> text
%type <token> eqn box lineupbox sbox tbox size font intgrl left right diacrit
%type <token> fwd up back down column col collist list

%right	FROM TO
%left	OVER SQRT
%right	SUP SUB
%right	SIZE FONT ROMAN ITALIC BOLD FAT
%right	UP DOWN BACK FWD
%left	LEFT RIGHT
%right	DOT DOTDOT HAT TILDE BAR LOWBAR HIGHBAR UNDER VEC DYAD UTILDE

%%

stuff	: eqn 		{ putout($1); }
	| error		{ ERROR "syntax error" WARNING; }	/* should be SYNTAX */
	|		{ eqnreg = 0; }
	;

eqn	: box
	| eqn box	{ $$ = eqnbox($1, $2, 0); }
	| eqn lineupbox	{ $$ = eqnbox($1, $2, 1); }
	| LINEUP	{ $$ = lineup(0); }
	;

lineupbox: LINEUP box	{ $$ = $2; lineup(1); } /* CK: lineup() overwr. $$ ? */
	;

sbox	: SUP box	%prec SUP	{ $$ = $2; }
	|		%prec SUP	{ $$ = 0; }
	;

tbox	: TO box	%prec TO	{ $$ = $2; }
	|		%prec FROM	{ $$ = 0; }
	;

box	: '{' eqn '}'	{ $$ = $2; }
	| QTEXT		{ $$ = text(QTEXT, $1); }
	| CONTIG	{ $$ = text(CONTIG, $1); }
	| SPACE		{ $$ = text(SPACE, NULL); }
	| THIN		{ $$ = text(THIN, NULL); }
	| TAB		{ $$ = text(TAB, NULL); }
	| SUM		{ $$ = funny(SUM); }
	| PROD		{ $$ = funny(PROD); }
	| UNION		{ $$ = funny(UNION); }
	| INTER		{ $$ = funny(INTER); }
 	| box OVER box			{ $$ = boverb($1, $3); }
	| MARK box			{ $$ = mark($2); }
	| size box	%prec SIZE	{ $$ = size($1, $2); }
	| font box	%prec FONT	{ $$ = font($1, $2); }
	| FAT box			{ $$ = fatbox($2); }
	| SQRT box			{ $$ = dwb_sqrt($2); }
	| box SUB {ps -= deltaps;} box sbox	%prec SUB	{ $$ = subsup($1, $4, $5); }
	| box SUP {ps -= deltaps;} box		%prec SUP	{ $$ = subsup($1, 0, $4); }
	| intgrl SUB {ps -= deltaps;} box sbox	%prec SUB	{ $$ = integral($1, $4, $5); }
	| intgrl SUP {ps -= deltaps;} box	%prec SUP	{ $$ = integral($1, 0, $4); }
	| intgrl						{ $$ = integral($1, 0, 0); }
	| box FROM {ps -= deltaps;} box tbox	%prec FROM	{ $$ = fromto($1, $4, $5); }
	| box TO {ps -= deltaps;} box		%prec TO	{ $$ = fromto($1, 0, $4); }
	| left eqn right			{ $$ = paren($1, $2, $3); }
	| left eqn 				{ $$ = paren($1, $2, 0); }
	| box diacrit			{ diacrit($1, $2); }
	| fwd box	%prec UP	{ $$ = move(FWD, $1, $2); }
	| up box	%prec UP	{ $$ = move(UP, $1, $2); }
	| back box	%prec UP	{ $$ = move(BACK, $1, $2); }
	| down box	%prec UP	{ $$ = move(DOWN, $1, $2); }
	| column			{ $$ = pile($1); ct = $1; }
	| MATRIX { $<token>$ = ct; } '{' collist '}'
	  { $$ = matrix($<token>2); ct = $<token>2; }
	;

intgrl	: INT		{ $$ = setintegral(); }
	;

fwd	: FWD text	{ $$ = atoi($2); } ;
up	: UP text	{ $$ = atoi($2); } ;
back	: BACK text	{ $$ = atoi($2); } ;
down	: DOWN text	{ $$ = atoi($2); } ;

diacrit	: HAT		{ $$ = HAT; }
	| VEC		{ $$ = VEC; }
	| DYAD		{ $$ = DYAD; }
	| BAR		{ $$ = BAR; }
	| LOWBAR	{ $$ = LOWBAR; }
	| HIGHBAR	{ $$ = HIGHBAR; }
	| UNDER		{ $$ = UNDER; }	/* underbar */
	| DOT		{ $$ = DOT; }
	| TILDE		{ $$ = TILDE; }
	| UTILDE	{ $$ = UTILDE; }
	| DOTDOT	{ $$ = DOTDOT; } /* umlaut = double dot */
	;

left	: LEFT text	{ $$ = ($2)[0]; }
	| LEFT '{'	{ $$ = '{'; }
	;

right	: RIGHT text	{ $$ = ($2)[0]; }
	| RIGHT '}'	{ $$ = '}'; }
	;

collist	: column
	| collist column
	;

column	: col '{' list '}'				{ column($1, DEFGAP); }
	| col text { $<token>$ = atoi($2); } '{' list '}'
	  { column($1, $<token>3); }
	;

col	: LCOL		{ $$ = startcol(LCOL); }
	| CCOL		{ $$ = startcol(CCOL); }
	| RCOL		{ $$ = startcol(RCOL); }
	| COL		{ $$ = startcol(COL); }
	;

list	: eqn			{ lp[ct++] = $1; }
	| list ABOVE eqn	{ lp[ct++] = $3; }
	;

size	: SIZE text	{ $$ = ps; setsize((char *) $2); }
	;

font    : ROMAN         { static char R[]="R"; $$ = setfont(R); }
        | ITALIC        { static char I[]="I"; $$ = setfont(I); }
        | BOLD          { static char B[]="B"; $$ = setfont(B); }
        | FONT text     { $$ = setfont($2); }
        ;

text	: CONTIG
	| QTEXT
	;

%%
