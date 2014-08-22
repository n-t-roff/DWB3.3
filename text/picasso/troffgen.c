/*	Copyright (c) 1988 AT&T	*/
/*	  All Rights Reserved  	*/

/*	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T	*/
/*	The copyright notice above does not evidence any   	*/
/*	actual or intended publication of such source code.	*/

/*	@(#)picasso:troffgen.c	1.0	*/

#include <string.h>
#include <ctype.h>
#include "font.h"
#include "picasso.h"
#include "y.tab.h"

char	esc	    = '\\';
char	eqn_delim[] = "\0";

/* the following table of troff names for special characters is in ASCII   */
/* order of their names, so that a binary search could be done if desired. */
/* the font field is an index into the (local) fontname table fontn, so    */
/* it isn't tied to any font list elsewhere.				   */

struct	trcode	{char name[2];  char font;  unsigned char value;}
	trcode[]  = {
		'\0','\0','\0','\0',		/* null entry, never matched. */
		'!','=', 1, 0271,		/* not equal */
		'!','b', 1, 0313,		/* not subset */
		'!','m', 1, 0317,		/* not member */
		'"','a', 0, 0315,		/* hungarumlaut accent? */
		'\'','\'',0,0272,		/* right double quote? */
		'*','*', 1, '*',		/* math star */

		'*','A', 1, 'A', '*','B', 1, 'B', '*','C', 1, 'X',   /* greek */
		'*','D', 1, 'D', '*','E', 1, 'E', '*','F', 1, 'F',   /* alpha-*/
		'*','G', 1, 'G', '*','H', 1, 'Q', '*','I', 1, 'I',   /* bet.  */
		'*','K', 1, 'K', '*','L', 1, 'L', '*','M', 1, 'M',
		'*','N', 1, 'N', '*','O', 1, 'O', '*','P', 1, 'P',
		'*','Q', 1, 'Y', '*','R', 1, 'R', '*','S', 1, 'S',
		'*','T', 1, 'T', '*','U', 1, 'U', '*','W', 1, 'W',
		'*','X', 1, 'C', '*','Y', 1, 'H', '*','Z', 1, 'Z',
		'*','a', 1, 'a', '*','b', 1, 'b', '*','c', 1, 'x',
		'*','d', 1, 'd', '*','e', 1, 'e', '*','f', 1, 'f',
		'*','g', 1, 'g', '*','h', 1, 'q', '*','i', 1, 'i',
		'*','k', 1, 'k', '*','l', 1, 'l', '*','m', 1, 'm',
		'*','n', 1, 'n', '*','o', 1, 'o', '*','p', 1, 'p',
		'*','q', 1, 'y', '*','r', 1, 'r', '*','s', 1, 's',
		'*','t', 1, 't', '*','u', 1, 'u', '*','w', 1, 'w',
		'*','x', 1, 'c', '*','y', 1, 'h', '*','z', 1, 'z',

		'+','-', 1, 0261,		/* plus-minus */
		',','a', 0, 0313,		/* cedilla accent */
		'-','>', 1, 0256,		/* right arrow */
		'-','a', 0, 0305,		/* macron accent */
		'.','a', 0, 0307,		/* dot accent */
		':','a', 0, 0310,		/* diaeresis accent */
		'<','-', 1, 0254,		/* left arrow */
		'<','=', 1, 0243,		/* less than or equal */
		'=','=', 1, 0272,		/* identically equal */
		'>','=', 1, 0263,		/* greater than or equal */
		'C','O', 1, 0343,		/* copyright (sanserif) */
		'C','R', 1, 0277,		/* carriage return */
		'C','a', 0, 0316,		/* ogonek accent */
		'I','f', 1, 0301,		/* I (fraktur) */
		'L','B', 1, 0350,		/* paren, left bottom */
		'L','T', 1, 0346,		/* paren, left top */
		'O','+', 1, 0305,		/* circled plus */
		'O','x', 1, 0304,		/* circled times */
		'R','B', 1, 0370,		/* paren, right bottom */
		'R','G', 1, 0342,		/* registered (sanserif) */
		'R','T', 1, 0366,		/* paren, right top */
		'R','f', 1, 0302,		/* R (fraktur) */
		'T','M', 1, 0344,		/* trademark (sanserif) */
		'U','a', 0, 0306,		/* breve accent */
		'^','a', 0, 0303,		/* circumflex accent */
		'`','`', 0, 0252,		/* left double quote */
		'a','a', 0, 0302,		/* circumflex accent */
		'a','b', 1, 0253,		/* arrow both (left & right) */
		'a','f', 1, 0300,		/* aleph */
		'a','h', 1, 0276,		/* arrow horizontal extender */
		'a','n', 1, 0320,		/* angle */
		'a','p', 1, '~',		/* approximates */
		'a','v', 1, 0275,		/* arrow vertical extender */
		'b','<', 1, 0341,		/* left angle bracket */
		'b','>', 1, 0361,		/* right angle bracket */
		'b','u', 1, 0267,		/* bullet */
		'b','v', 1, 0352,		/* bold vertical (extender) */
		'c','.', 1, 0327,		/* centered dot */
		'c','a', 1, 0307,		/* cap */
		'c','g', 1, '@',		/* congruent to */
		'c','o', 1, 0323,		/* copyright (serif) */
		'c','r', 0, 0250,		/* currency */
		'c','t', 0, 0242,		/* cent */
		'c','u', 1, 0310,		/* cup */
		'd','a', 1, 0257,		/* down arrow */
		'd','d', 0, 0263,		/* double dagger */
		'd','e', 1, 0260,		/* degree */
		'd','g', 1, 0262,		/* dagger */
		'd','i', 1, 0270,		/* divide */
		'e','l', 1, 0274,		/* ellipsis */
		'e','m', 1, 0320,		/* emdash */
		'e','n', 0, 0261,		/* endash */
		'e','q', 1, '=',		/* equals */
		'e','s', 1, 0306,		/* empty set */
		'f','a', 1, '"',		/* for all */
		'f','i', 0, 0256,		/* fi ligature */
		'f','l', 0, 0257,		/* fl ligature */
		'f','m', 1, 0242,		/* minute (footmark) */
		'f','n', 0, 0246,		/* florin */
		'f','r', 0, 0244,		/* fraction bar */
		'g','a', 0, 0301,		/* circumflex accent */
		'g','r', 1, 0321,		/* gradient */
		'h','y', 0, '-',		/* hyphen */
		'i','b', 1, 0315,		/* improper subset  */
		'i','f', 1, 0245,		/* infinity */
		'i','p', 1, 0312,		/* improper superset */
		'i','s', 1, 0362,		/* integral sign */
		'l','&', 1, 0331,		/* logical and */
		'l','b', 1, 0356,		/* brace, left bottom */
		'l','c', 1, 0351,		/* square bracket l. ceiling */
		'l','f', 1, 0353,		/* square bracket l. floor */
		'l','k', 1, 0355,		/* brace, left middle */
		'l','t', 1, 0354,		/* brace, left top */
		'l','z', 1, 0340,		/* lozenge */
		'l','|', 1, 0332,		/* logical or */
		'm','i', 1, '-',		/* minus */
		'm','o', 1, 0316,		/* member of */
		'm','u', 1, 0264,		/* multiply */
		'n','o', 1, 0330,		/* logical not */
		'o','a', 0, 0312,		/* ring accent */
		'o','r', 1, '|',		/* or (vertical bar) */
		'p','d', 1, 0266,		/* partial derivative */
		'p','g', 0, 0266,		/* paragraph */
		'p','l', 1, '+',		/* plus */
		'p','p', 1, '^',		/* perpendicular */
		'p','s', 0, 0243,		/* pound sterling */
		'p','t', 1, 0265,		/* proportional to */
		'r','b', 1, 0376,		/* brace, right bottom */
		'r','c', 1, 0371,		/* square bracket r. ceiling */
		'r','f', 1, 0373,		/* square bracket r. floor */
		'r','g', 1, 0322,		/* registered (serif) */
		'r','k', 1, 0375,		/* brace, right middle */
		'r','n', 1, '`',		/* root extender (en) */
		'r','t', 1, 0374,		/* brace, right top */
		's','b', 1, 0314,		/* subset */
		's','c', 0, 0247,		/* section */
		's','l', 1, '/',		/* slash */
		's','p', 1, 0311,		/* superset */
		's','r', 1, 0326,		/* square root */
		's','t', 1, '\'',		/* such that */
		't','e', 1, '$',		/* there exists */
		't','f', 1, '\\',		/* therefore */
		't','m', 1, 0324,		/* trademark (serif) */
		't','s', 1, 'V',		/* terminal sigma */
		'u','a', 1, 0255,		/* up arrow */
		'u','l', 1, '_',		/* underscore */
		'v','a', 0, 0317,		/* caron accent */
		'w','s', 1, 0303,		/* Weierstrass P */
		'y','n', 0, 0245,		/* yen */
		'~','a', 0, 0304,		/* tilde accent */
		'~','~', 1, 0273,		/* approximately */

		'\0','\0','\0','\0',		/* sentinel; loop terminus */
		};
char	*fontn[] = { "R", "S" };		/* needs to be extended if any
						 * additional fonts need to
						 * represent special characters
						 * in trfont table */

/* the following table of troff names for special characters has provisional */
/* definitions of characters in the G1 set of ISO8859-1.  It is currently  */
/* not ordered in any particular way.  If the type field is 1 or 3, the case */
/* of the characters is important, if it is 2 or 3 the order is important. */

struct	isocode	{unsigned char name[2];  char type;  unsigned char value;}
	isocode[] = {
		'\0','\0','\0','\0',		/* null entry, never matched. */
		'"', ' ', 0, 0x22,		/* quotation mark */
		'+', '+', 0, 0x23,		/* number sign */
		'\'', ' ', 0, 0x27,		/* apostrophe */
		'a', 'a', 0, 0x40,		/* at sign */
		'(', '(', 0, 0x5b,		/* open bracket */
		'/', '/', 0, 0x5c,		/* backslash */
		'/', '<', 0, 0x5c,		/* backslash */
		')', ')', 0, 0x5d,		/* close bracket */
		'^', ' ', 0, 0x5e,		/* circumflex accent */
		'`', ' ', 0, 0x60,		/* grave accent */
		'(', '-', 0, 0x7b,		/* open brace */
		'/', '^', 0, 0x7c,		/* vertical bar */
		')', '-', 0, 0x7d,		/* close brace */
		'~', ' ', 0, 0x7e,		/* tilde */
		'!', '!', 0, 0xa1,		/* inverted ! */
		'c', '|', 0, 0xa2,		/* cents sign */
		'c', '/', 0, 0xa2,		/* cents sign */
		'L', '-', 0, 0xa3,		/* English pound */
		'L', '=', 0, 0xa3,		/* English pound */
		'Y', '-', 0, 0xa5,		/* yen sign */
		'Y', '=', 0, 0xa5,		/* yen sign */
		's', 'o', 0, 0xa7,		/* section sign */
		's', '!', 0, 0xa7,		/* section sign */
		's', '0', 0, 0xa7,		/* section sign */
		'x', 'o', 0, 0xa4,		/* currency sign */
		'x', '0', 0, 0xa4,		/* currency sign */
		'c', 'o', 0, 0xa9,		/* copyright sign */
		'a', '_', 0, 0xaa,		/* feminine ordinal */
		'o', '_', 0, 0xba,		/* masculine ordinal */
		'<', '<', 0, 0xab,		/* dbl open angle bracket */
		'>', '>', 0, 0xbb,		/* dbl close angle bracket */
		'0', '^', 0, 0xb0,		/* degree sign */
		' ', 0xb0, 0, 0xb0,		/* degree sign */
		'+', '-', 0, 0xb1,		/* plus or minus */
		'1', '^', 0, 0xb9,		/* superscript 1 */
		'2', '^', 0, 0xb2,		/* superscript 2 */
		'3', '^', 0, 0xb3,		/* superscript 3 */
		'/', 'u', 2, 0xb5,		/* micro sign (mu) */
		'P', '!', 0, 0xb6,		/* paragraph (pilcrow) sign */
		'.', '^', 0, 0xb7,		/* middle dot */
		'1', '4', 2, 0xbc,		/* one-quarter */
		'1', '2', 2, 0xbd,		/* one-half */
		'3', '4', 2, 0xbe,		/* three-quarters */
		'?', '?', 0, 0xbf,		/* inverted ? */
		'A', '`', 1, 0xc0,		/* grave A */
		'A', '\'', 1, 0xc1,		/* acute A */
		'A', '^', 1, 0xc2,		/* circumflex A */
		'A', '~', 1, 0xc3,		/* tilde A */
		'A', '"', 1, 0xc4,		/* umlaut A */
		'A', 0xa8, 1, 0xc4,		/* umlaut A */
		'A', '*', 1, 0xc5,		/* ring A */
		'A', 0xb0, 1, 0xc5,		/* ring A */
		'A', 'E', 3, 0xc6,		/* A E diphthong */
		'C', ',', 1, 0xc7,		/* cedilla C */
		'E', '`', 1, 0xc8,		/* grave E */
		'E', '\'', 1, 0xc9,		/* acute E */
		'E', '^', 1, 0xca,		/* circumflex E */
		'E', '"', 1, 0xcb,		/* umlaut E */
		'E', 0xa8, 1, 0xcb,		/* umlaut E */
		'I', '`', 1, 0xcc,		/* grave I */
		'I', '\'', 1, 0xcd,		/* acute I */
		'I', '^', 1, 0xce,		/* circumflex I */
		'I', '"', 1, 0xcf,		/* umlaut I */
		'I', 0xa8, 1, 0xcf,		/* umlaut I */
		'N', '~', 1, 0xd1,		/* tilde N */
		'O', '`', 1, 0xd2,		/* grave O */
		'O', '\'', 1, 0xd3,		/* acute O */
		'O', '^', 1, 0xd4,		/* circumflex O */
		'O', '~', 1, 0xd5,		/* tilde O */
		'O', '"', 1, 0xd6,		/* umlaut O */
		'O', 0xa8, 1, 0xd6,		/* umlaut O */
		'O', '/', 1, 0xd8,		/* slash O */
		'U', '`', 1, 0xd9,		/* grave U */
		'U', '\'', 1, 0xda,		/* acute U */
		'U', '^', 1, 0xdb,		/* circumflex U */
		'U', '"', 1, 0xdc,		/* umlaut U */
		'U', 0xa8, 1, 0xdc,		/* umlaut U */
		'Y', '\'', 1, 0xdd,		/* acute Y */
		's', 's', 1, 0xdf,		/* German sharp s */
		'a', '`', 1, 0xe0,		/* grave a */
		'a', '\'', 1, 0xe1,		/* acute a */
		'a', '^', 1, 0xe2,		/* circumflex a */
		'a', '~', 1, 0xe3,		/* tilde a */
		'a', '"', 1, 0xe4,		/* umlaut a */
		'a', 0xa8, 1, 0xe4,		/* umlaut a */
		'a', '*', 1, 0xe5,		/* ring a */
		'a', 0xb0, 1, 0xe5,		/* ring a */
		'a', 'e', 3, 0xe6,		/* a e diphthong */
		'c', ',', 1, 0xe7,		/* cedilla c */
		'e', '`', 1, 0xe8,		/* grave e */
		'e', '\'', 1, 0xe9,		/* acute e */
		'e', '^', 1, 0xea,		/* circumflex e */
		'e', '"', 1, 0xeb,		/* umlaut e */
		'e', 0xa8, 1, 0xeb,		/* umlaut e */
		'i', '`', 1, 0xec,		/* grave i */
		'i', '\'', 1, 0xed,		/* acute i */
		'i', '^', 1, 0xee,		/* circumflex i */
		'i', '"', 1, 0xef,		/* umlaut i */
		'i', 0xa8, 1, 0xef,		/* umlaut i */
		'n', '~', 1, 0xf1,		/* tilde n */
		'o', '`', 1, 0xf2,		/* grave o */
		'o', '\'', 1, 0xf3,		/* acute o */
		'o', '^', 1, 0xf4,		/* circumflex o */
		'o', '~', 1, 0xf5,		/* tilde o */
		'o', '"', 1, 0xf6,		/* umlaut o */
		'o', 0xa8, 1, 0xf6,		/* umlaut o */
		'o', '/', 1, 0xf8,		/* slash o */
		'u', '`', 1, 0xf9,		/* grave u */
		'u', '\'', 1, 0xfa,		/* acute u */
		'u', '^', 1, 0xfb,		/* circumflex u */
		'u', '"', 1, 0xfc,		/* umlaut u */
		'u', 0xa8, 1, 0xfc,		/* umlaut u */
		'y', '\'', 1, 0xfd,		/* acute y */
		'y', '"', 1, 0xff,		/* umlaut y */
		'y', 0xa8, 1, 0xff,		/* umlaut y */
		' ', ' ', 0, 0xa0,		/* no break space */
		'|', '|', 0, 0xa6,		/* vertical bar */
		'!', '^', 0, 0xa6,		/* vertical bar */
		'-', ',', 2, 0xac,		/* logical not */
		'-', '-', 0, 0xad,		/* soft (syllable) hyphen */
		'r', 'o', 0, 0xae,		/* registered sign */
		'-', '^', 0, 0xaf,		/* macron */
		'_', '^', 0, 0xaf,		/* macron */
		'-', ':', 0, 0xf7,		/* divide sign */
		'x', 'x', 1, 0xd7,		/* multiply sign */
		'\'', '\'', 0, 0xb4,		/* acute accent */
		',', ',', 0, 0xb8,		/* cedilla */
		'"', '"', 0, 0xa8,		/* dieresis */
		'"', ' ', 0, 0xa8,		/* dieresis */
		'T', 'H', 3, 0xde,		/* capital Icelandic thorn */
		't', 'h', 3, 0xfe,		/* small Icelandic thorn */
		'D', '-', 1, 0xd0,		/* capital Icelandic Eth */
		'd', '-', 1, 0xf0,		/* small Icelandic Eth */
		'\0','\0','\0','\0',		/* sentinel; loop terminus */
		};

int	troffcode(str)
	char	*str;
{
	int	n;

	for (n = 1; trcode[n].name[0] != '\0'; n++)
		if (str[0] == trcode[n].name[0] && str[1] == trcode[n].name[1])
			return n;
	return 0;
}

/*	Where is tolower on Sun?	*/
int
dwb_tolower(c)
    int c;
{
    if (c >= 'A' && c <= 'Z')
	c += 'a' - 'A';
    return c;
}

int
iso8859code(str)
    char	*str;
{
    int	n;
    struct	isocode	*t;

    for (n = 1; (t = &isocode[n])->name[0] != '\0'; n++)
	if (str[0] == t->name[0] && str[1] == t->name[1]	/* exact */
	     || (t->type & 1) == 0 &&		/* case unimportant */
		dwb_tolower(str[0]) == t->name[0] && dwb_tolower(str[1]) == t->name[1]
	     || (t->type & 2) == 0 &&		/* order unimportant */
		str[0] == t->name[1] && str[1] == t->name[0]
	     || t->type == 0 &&			/* both unimportant */
		dwb_tolower(str[0]) == t->name[1] && dwb_tolower(str[1]) == t->name[0])
		return n;
    return 0;
}

char	*
fromiso(c)
    unsigned char c;
{
    int     n;
    static  char    ans[4];

    for (n = 1; isocode[n].name[0] != '\0'; n++)
	if (isocode[n].value == c) {
	    ans[0] = isocode[n].name[0];
	    ans[1] = isocode[n].name[1];
	    ans[2] = '\0';
	    return ans;
	}
    return NULL;
}

static
troffparm(name, parm, prev)
	char	*name, *parm;
	int	*prev;			/* the previous value */
{
extern	double	atof();
	double	r, s=0, t;

	while (isspace(*parm))
		++parm;
	t = getfval(name);
	if (*parm == '\0')
		r = *prev;
	else {
		r = atof(parm);
		if (*parm == '+' || *parm == '-')
			s = t;
		while (*parm && !isspace(*parm))
			parm++;
		switch (parm[-1]) {
			case 'i':	r *= 72;		break;
			case 'c':	r *= (72.*50./127.);	break;
			case 'P':	r *= 12;		break;
			case 'u':	r /= 6;			break;
		}
	}
	*prev = t;
	setfval(name, r+s);
}

static	int	ft;		/* save previous font for \fP and .ft */
static	int	psize = 10,	/* ditto previous point size */
		vsize = 12;	/*    and vertical spacing */
/*
 *	troff(s) - track changes to font, point size, and line space
 *		   when specified as troff primitives.
 *
 *	s - a string which begins with '.'
 *
 *	Changes specified this way are equivalent to setting the corres-
 *	poinding picasso external variables textfont, textsize, and
 *	textspace, respectively, EXCEPT that setting those variables
 *	does not leave a record in the form of a previous value.  This
 *	latter action is reasonable since troff wouldn't recongnize or
 *	track such changes either.
 */
troff(s)
	char	*s;
{
	int	i, fp;

	if (s[1] == 'f' && s[2] == 't') {
		for (s += 3; isspace(*s); ++s)
			;
		i = getfval("textfont");	/* save current font */
		if (s == '\0')			/* reset previous */
			fp = ft;
		else if (isdigit(*s))		/* allow multi-digit nums */
			fp = checkfont((double)atoi(s));
		else
			fp = setfont(tostring(s));
		ft = i;
		setfval("textfont", fp);
	}
	else if (s[1] == 'p' && s[2] == 's')
		troffparm("textsize", s+3, &psize);
	else if (s[1] == 'v' && s[2] == 's')
		troffparm("textspace", s+3, &vsize);
	else if (s[1] == 'e')
		if (s[2] == 'o')
			esc = '\0';
		else if (s[2] == 'c') {
			for (s += 3; isspace(*s); ++s)
				;
			esc = *s ? *s : '\\';
		}
}

obj	*troffgen(s)
	char * /*YYSTYPE*/	s;
{
	troff(s);
	save_one(CENTER, 0, 0, 0, s);
	free(s);
	return makenode(TROFF, 0, (int)getfval("curlayer"));
}
/*	Split txt into substrings with uniform font and pointsize.
/*	Some '\0' chars are put in txt.
 */
char	*parse_text (txt, fp, sp)
	char	*txt;
	int	*fp, *sp;	/* font and size values may be negative! */
{
	extern int  parsing;
static	char	*buf = 0;
static	int	n   = 0,
		lim = 0;
	int	i, j, k;
	char	*bp;

	if (n == 0) {	/* new string; initialize */
		if (buf)
			free(buf);
		lim = strlen(txt);
		if ((buf = (char *) malloc(lim + 1)) == 0)
			return NULL;
		ft = *fp;
		psize = abs(*sp);
	}
	else if (n == lim) {
		n = 0;
		return NULL;
	}
	for (bp = buf; n < lim; ) {
		if (txt[n] != esc && txt[n] != *eqn_delim)
			*bp++ = txt[n++];
		else if (txt[n] == *eqn_delim) {
			if (!parsing) {
				do n++;
				while (txt[n] != eqn_delim[1] && n < lim);
				n++;
				continue;
			}
			if (bp > buf) { *bp = '\0'; return buf; }
			eqn_save(".EQ");
			while (txt[++n] != eqn_delim[1] && n < lim)
				*bp++ = txt[n];
			if (n < lim)
				++n;
			strcpy(bp, "\n.EN");
			eqn_save(buf);
			eqn_gen(TEXT);
			bp = buf;
			*bp++ = '\0';	/* fudge, to prevent a 2nd save_one() */
		}
		else {				/* fonts, sizes, troff codes  */
			if (txt[n+1] == esc) {	/* same as \e, really */
				*bp++ = esc;
				n += 2;
			}
			else switch (txt[n+1]) {
			default:		/* discard escape char */
				n += 1;
				break;
			case 'e':
				*bp++ = esc;
				n += 2;
				break;
			case '&':		/* zero-width char */
				n += 2;		/* discard it */
				break;
			case '(':
				if ((i = troffcode(txt+n+2)) == 0) {
					if ((i = iso8859code(txt+n+2)) != 0) {
						*bp++ = isocode[i].value;
						n += 4;
					}
					else
						*bp++ = txt[n++]; /* unknown */
				}
				else {
					if (bp > buf && *fp != trcode[i].font)
						{ *bp = '\0'; return buf; }
					*bp++ = trcode[i].value;
					ft = *fp;
					*fp = setfont(tostring(fontn[trcode[i].font]));
					txt[++n] = '\\';
					txt[n+1] = 'f';
					txt[n+2] = 'P';	/* restore old font */
				}
				break;
			case 'N':
				n += 3;		/* skip over \N' */
				*bp++ = atoi(txt+n);
				while (isdigit(txt[n])) n++;
				if (txt[n] == '\'')	/* it SHOULD */
					n++;
				break;
			case 'f':
				if (bp > buf) { *bp = '\0'; return buf; }
				n += 2;
				i = *fp;		/* save current font */
				if (txt[n] == 'P') {	/* reset previous */
					*fp = ft;
					++n;
				}
				else if (isdigit(txt[n]))
					*fp = checkfont((double)(txt[n++]-'0'));
				else {
					if (txt[n] != '(')
						*bp++ = txt[n++];
					else {
						*bp++ = txt[++n];
						*bp++ = txt[++n];
						++n;
					}
					*bp = '\0';
					*fp = setfont(tostring(bp=buf));
				}
				ft = i;
				break;
			case 's':
				if (bp > buf) { *bp = '\0'; return buf; }
				n += 2;
				if ((k = *sp) == 0)	/* save current size */
					k = getfval("textsize");
				if (k < 0)	k = -k;
				if (txt[n] == '+' || txt[n] == '-')
					i = txt[n++] == '-' ? -k : k;
				else
					i = 0; 
				j = 0;
				if (i == 0 && txt[n] == '0')	{/* use previous */
					i = psize;
					++n;
				}
				else {	/* only one digit significant if signed */
					if (isdigit(txt[n]))
						j = txt[n++] - '0';
					if (i == 0 && j < 4 && isdigit(txt[n]))
						j = j * 10 + txt[n++] - '0';
				}
				psize = k;
				*sp = ((k = (i < 0 ? i+j : -i-j)) > 3 || k < -3) ? k : -4;
				break;
			}
		}
	}
	*bp = '\0';
	if (bp != buf)
		return buf;
	else {
		n = 0;
		return NULL;
	}
}

int	eqn_count	  = 0;
char	psfname[L_tmpnam] = "";
char	dpost[]	= "dpost";
FILE	*eqnfp  = NULL,
	*pipefp = NULL;
int	no_eqn = 0;

eqn_save(s)
	char	*s;
{
extern	char	*gwblib;
	char	*dp, private[64], buf[BUFSIZ];

	if (pipefp == NULL && !no_eqn){/* open up eqn|troff|dpost subprocess */
		sprintf(private, "%s/%s", gwblib, dpost);
		dp = access(private,1) ? dpost : private;
		tmpnam(psfname);
		sprintf(buf, "eqn|troff -Tpost|%s -B>%s", dp, psfname);
		if ((pipefp = popen(buf, "w")) == NULL) {
			yyerror("cannot pipe through eqn");
			no_eqn = 1;
		}
	}
	if (no_eqn) {
		if (strncmp(s, ".EQ", 3) == 0 || strncmp(s, ".EN", 3) == 0 ||
					strncmp(s, "delim", 5) == 0)
			;
		else
			savetext(CENTER, s);
		return;
	}
	if (s[0] == '.' && s[1] == 'E' && s[2] == 'Q') {
		double	f = getfval("textfont");
		sprintf(buf,".ft %s\n.ps %d\n.vs %d\n", dwb_mount[(int)f]->name,
			(int)getfval("textsize"), (int)getfval("textspace"));
		fputs(buf, pipefp);
	}
	fputs(s, pipefp);
	fputc('\n', pipefp);
	scan_delim(s);
}

scan_delim(s)
	char    *s;
{
	while (isspace(*s))
		++s;
	/* probably eqn's syntax is less restrictive than the following */
	if (strncmp(s,"delim",5)==0) {
		for (s += 5; isspace(*s); ++s)
			;
		if (strcmp(s,"off")==0)
			eqn_delim[1] = eqn_delim[0] = '\0';
		else {
			eqn_delim[1] = eqn_delim[0] = *s;
			if (*s++)
				if (*s)
					eqn_delim[1] = *s;
		}
	}
}

eqn_gen(type)
	int	type;
{
extern	int	ntextlines;
	obj	*p;
	char	buf[8];

	if (!no_eqn) {
		fputs(".bp\n", pipefp);
		sprintf(buf, "%d", ++eqn_count);
		save_one(EQNTXT, 0, 0, ntextlines, buf);
	}
	if (type == TROFF) {
		p = makenode(TROFF, 0, (int)getfval("curlayer"));
		checktextcolor(p);
		codegen = 1;
	}
}
