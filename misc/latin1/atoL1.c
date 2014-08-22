#include <stdio.h>
#include <stdlib.h>
main() {	/* filter escaped 7 bit ASCII to 8 bit Latin-1 */
#define DIGRAPH(c1,c2) (c1<<8)|c2
	int c, d, i, c1;
	static int latin1[] = {	/* VT200 compose-code sequence, skip ASCII */
	DIGRAPH('8', '0'),	/* first 32 are gibberish in troff */
	DIGRAPH('8', '1'),
	DIGRAPH('8', '2'),
	DIGRAPH('8', '3'),
	DIGRAPH('8', '4'),
	DIGRAPH('8', '5'),
	DIGRAPH('8', '6'),
	DIGRAPH('8', '7'),
	DIGRAPH('8', '8'),
	DIGRAPH('8', '9'),
	DIGRAPH('8', 'A'),
	DIGRAPH('8', 'B'),
	DIGRAPH('8', 'C'),
	DIGRAPH('8', 'D'),
	DIGRAPH('8', 'E'),
	DIGRAPH('8', 'F'),
	DIGRAPH('9', '0'),
	DIGRAPH('9', '1'),
	DIGRAPH('9', '2'),
	DIGRAPH('9', '3'),
	DIGRAPH('9', '4'),
	DIGRAPH('9', '5'),
	DIGRAPH('9', '6'),
	DIGRAPH('9', '7'),
	DIGRAPH('9', '8'),
	DIGRAPH('9', '9'),
	DIGRAPH('9', 'A'),
	DIGRAPH('9', 'B'),
	DIGRAPH('9', 'C'),
	DIGRAPH('9', 'D'),
	DIGRAPH('9', 'E'),
	DIGRAPH('9', 'F'),
	DIGRAPH('\0', ' '),	/* NBSP, special case */
	DIGRAPH('!', '!'),
	DIGRAPH('c', '|'),
	DIGRAPH('L', '-'),
	DIGRAPH('x', 'o'),
	DIGRAPH('Y', '-'),
	DIGRAPH('|', '|'),
	DIGRAPH('s', 'o'),
	DIGRAPH('"', '"'),
	DIGRAPH('c', 'o'),
	DIGRAPH('a', '_'),
	DIGRAPH('<', '<'),
	DIGRAPH('-', ','),
	DIGRAPH('-', '-'),
	DIGRAPH('r', 'o'),
	DIGRAPH('-', '^'),
	DIGRAPH('0', '^'),
	DIGRAPH('+', '-'),
	DIGRAPH('2', '^'),
	DIGRAPH('3', '^'),
	DIGRAPH('\0','\''),	/* acute accent, special case */
	DIGRAPH('/', 'u'),
	DIGRAPH('P', '!'),
	DIGRAPH('.', '^'),
	DIGRAPH(',', ','),
	DIGRAPH('1', '^'),
	DIGRAPH('o', '_'),
	DIGRAPH('>', '>'),
	DIGRAPH('1', '4'),
	DIGRAPH('1', '2'),
	DIGRAPH('3', '4'),
	DIGRAPH('?', '?'),
	DIGRAPH('A', '`'),
	DIGRAPH('A', '\''),
	DIGRAPH('A', '^'),
	DIGRAPH('A', '~'),
	DIGRAPH('A', '"'),
	DIGRAPH('A', '*'),
	DIGRAPH('A', 'E'),
	DIGRAPH('C', ','),
	DIGRAPH('E', '`'),
	DIGRAPH('E', '\''),
	DIGRAPH('E', '^'),
	DIGRAPH('E', '"'),
	DIGRAPH('I', '`'),
	DIGRAPH('I', '\''),
	DIGRAPH('I', '^'),
	DIGRAPH('I', '"'),
	DIGRAPH('D', '-'),
	DIGRAPH('N', '~'),
	DIGRAPH('O', '`'),
	DIGRAPH('O', '\''),
	DIGRAPH('O', '^'),
	DIGRAPH('O', '~'),
	DIGRAPH('O', '"'),
	DIGRAPH('x', 'x'),
	DIGRAPH('O', '/'),
	DIGRAPH('U', '`'),
	DIGRAPH('U', '\''),
	DIGRAPH('U', '^'),
	DIGRAPH('U', '"'),
	DIGRAPH('Y', '\''),
	DIGRAPH('T', 'H'),
	DIGRAPH('s', 's'),
	DIGRAPH('a', '`'),
	DIGRAPH('a', '\''),
	DIGRAPH('a', '^'),
	DIGRAPH('a', '~'),
	DIGRAPH('a', '"'),
	DIGRAPH('a', '*'),
	DIGRAPH('a', 'e'),
	DIGRAPH('c', ','),
	DIGRAPH('e', '`'),
	DIGRAPH('e', '\''),
	DIGRAPH('e', '^'),
	DIGRAPH('e', '"'),
	DIGRAPH('i', '`'),
	DIGRAPH('i', '\''),
	DIGRAPH('i', '^'),
	DIGRAPH('i', '"'),
	DIGRAPH('d', '-'),
	DIGRAPH('n', '~'),
	DIGRAPH('o', '`'),
	DIGRAPH('o', '\''),
	DIGRAPH('o', '^'),
	DIGRAPH('o', '~'),
	DIGRAPH('o', '"'),
	DIGRAPH('-', ':'),
	DIGRAPH('o', '/'),
	DIGRAPH('u', '`'),
	DIGRAPH('u', '\''),
	DIGRAPH('u', '^'),
	DIGRAPH('u', '"'),
	DIGRAPH('y', '\''),
	DIGRAPH('t', 'h'),
	DIGRAPH('y', '"') };

#define NLAT (sizeof latin1 / sizeof latin1[0])
	while ( (c = getchar()) != EOF ) {
		if ( c == '\\' ) {
			if ( (c = getchar()) == '(') {
				c1 = getchar(); c = getchar();
			}
			else c1 = '\0';

			d = DIGRAPH(c1, c);
			for (i=0; i<NLAT; i++)
				if (d == latin1[i]) break;

			if ( i >= NLAT ) {	/* not VT200 */
				putchar('\\');
				if (c1 != '\0') {
					putchar('(');
					putchar(c1);
				}

			}
			else c = i + 0200;	/* synthesize Latin-1 char */
		}
		putchar(c);
	}
	exit(0);
}
