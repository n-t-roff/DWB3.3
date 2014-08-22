'''	\"               Copyright c 1990 AT&T
'''	\"                All Rights Reserved
'''	\" THIS DOCUMENT CONTAINS PROPRIETARY INFORMATION OF
'''	\" AT&T AND IS NOT TO BE DISCLOSED OR USED EXCEPT IN
'''	\"      ACCORDANCE WITH APPLICABLE AGREEMENTS.
'''	\"
.so ../defs.doc
.so defs.pic
'''	\" redefine tab settings for input segments
.am iS
.ta +0.5i +2i
..
.ds pT PIC
.aP "" "PIC Reference Manual"
.HU Pictures
The top-level object in
.I pic
is the ``picture'':
.iS
\f2picture\fP:
	.PS \f2optional-width\fP \f2optional-height\fP
	\f2element-list\fP
	.PE
.iE
If
.I optional-width
is present, the picture is made that many inches wide,
regardless of any dimensions used internally.
The height is scaled in the same proportion unless
.I optional-height
is present.
If instead the line is
.iS
\&.PS <f
.iE
the file
.cR f
is inserted in place of the
.cR .PS
line.
.P
If
.cR .PF
is used instead of
.cR .PE ,
the position after printing is restored to what it was
upon entry.
.P
In no case will the picture be larger than
\s-1\f5maxpsht\fP\|\(mu\|\f5maxpswid\fP\^.
.HU Elements
An
.I element-list
is a list of elements (what else?);
the elements are
.iS
\f2element\fP:
	\f2primitive  attribute-list\fP
	\f2placename\fP : \f2element\fP
	\f2placename\fP : \f2position\fP
	\f2var\fP = \f2expr\fP
	\f2direction\fP
	{ \f2element-list\fP }
	[ \f2element-list\fP ]
	for \f2var\fP = \f2expr\fP to \f2expr\fP by \f2expr\fP do { \f2anything\fP }
	if \f2expr\fP then { \f2anything\fP } else { \f2anything\fP }
	copy \f2file\fP
	copy thru \f2macro\fP
	copy \f2file\fP thru \fPmacro\fP
	sh { \f2commandline\fP }
	print \f2expr\fP
	reset \f2optional var-list\fP
	\f2troff-command\fP
.iE
.P
Elements are separated by newlines or semicolons;
a long element may be continued by ending the line with a backslash.
Comments are introduced by a
.cR #
and terminated by a newline.
.P
Variable names begin with a lower case letter;
place names begin with upper case.
Place and variable names retain their values
from one picture to the next.
.P
The current position and direction of motion are saved upon entry
to a
.cR {\(el}
block and restored upon exit.
.P
Elements within a block enclosed in
.cR [\(el]
are treated as a unit;
the dimensions are determined by the extreme points
of the contained objects.
Names, variables, and direction of motion within a block are local to that block.
.P
.I troff-command
is any line that begins with a period.
Such a line is assumed to make sense in the context where it appears;
accordingly,
if it doesn't work, don't call.
'''	\" FORCE PAGE
.SK
.HU Primitives
The primitive objects are
.iS
\f2primitive\fP:
	box
	circle
	ellipse
	arc
	line
	arrow
	spline
	move
	\f2text-list\fP
.iE
.cR arrow
is a synonym for
.cR line
.cR -> .
.HU Attributes
An
.I attribute-list
is a sequence of zero or more attributes;
each attribute consists of a keyword, perhaps followed by a value.
.iS
\f2attribute\fP:
	h(eigh)t \f2expr\fP	wid(th) \f2expr\fP
	rad(ius) \f2expr\fP	diam(eter) \f2expr\fP
	up \f2opt-expr\fP	down \f2opt-expr\fP
	right \f2opt-expr\fP	left \f2opt-expr\fP
	from \f2position\fP	to \f2position\fP
	at \f2position\fP	with \f2corner\fP
	by \f2expr, expr\fP	then
	dotted \f2opt-expr\fP	dashed \f2opt-expr\fP
	chop \f2opt-expr\fP	->  <-  <->
	invis	solid
	fill \f2opt-expr\fP	same
	\f2text-list\fP	\f2expr\fP
.iE
Missing attributes and values are filled in from defaults.
Not all attributes make sense for all primitives;
irrelevant ones are silently ignored.
The attribute
.cR at
causes the geometrical center to be put at the specified place;
.cR with
causes the position on the object to be put at the specified place.
For lines, splines and arcs,
.cR height
and
.cR width
refer to arrowhead size.
A bare
.I expr
implies motion in the current direction.
.HU Text
Text is normally an attribute of some primitive;
by default it is placed at the geometrical center of the object.
Stand-alone text is also permitted.
A
.I text-list
is a list of text items; a text item is
a quoted string optionally followed by positioning requests:
.iS
\f2text-item\fP:
	"\(el" \f2positioning \(el\fP
	sprintf("\f2format\fP", \f2expr\fP, \f2\(el\fP) \f2positioning \(el\fP
.sp 3p
\f2positioning\fP:
	center  ljust  rjust  above  below
.iE
If there are multiple text items for some primitive,
they are centered vertically except as qualified.
Positioning requests apply to each item independently.
.P
Text items can contain
.I troff
commands for size and font changes, local motions, etc.,
but make sure that these are balanced
so that the entering state is restored before exiting.
'''	\" FORCE PAGE
.SK
.HU "Positions and Places"
A position is ultimately an
.I x,y
coordinate pair, but it may be specified in other ways.
.iS
\f2position\fP:
	\f2expr, expr\fP
	\f2place\fP \(+- \f2expr, expr\fP
	\f2place\fP \(+- ( \f2expr, expr\fP )
	( \f2position\fP,\f2 position\fP )
	\f2expr\fP \f2[\fPof the way\f2]\fP between \f2position\fP and \f2position\fP
	\f2expr\fP < \f2position\fP , \f2position\fP >
	( \f2position\fP )
.sp 3p
\f2place\fP:
	\f2placename\fP \f2optional-corner\fP
	\f2corner\fP of \f2placename\fP
	\f2nth\fP \f2primitive\fP \f2optional-corner\fP
	\f2corner\fP of \f2nth\fP \f2primitive\fP
	Here
.iE
An
.I optional-corner
is one of the eight compass points
or the center or the start or end of a primitive.
.iS
\f2optional-corner\fP:
	.n  .e  .w  .s  .ne  .se  .nw  .sw  .c  .start  .end
.sp 3p
\f2corner\fP:
	top  bot  left  right  start  end
.iE
Each object in a picture has an ordinal number;
.I nth
refers to this.
.iS
\f2nth\fP:
	\f2n\fPth
	\f2n\fPth last
.iE
Since barbarisms like
.cR 1th
and
.cR 3th
are barbaric,
synonyms like
.cR 1st
and
.cR 3rd
are accepted as well.
.HU Variables
The built-in variables and their default values are:
.iS
	boxwid 0.75	boxht 0.5
	circlerad 0.25	arcrad 0.25
	ellipsewid 0.75	ellipseht 0.5
	linewid 0.5	lineht 0.5
	movewid 0.5	moveht 0.5
	textwid 0	textht 0
	arrowwid 0.05	arrowht 0.1
	dashwid 0.1	arrowhead 2
	maxpsht 11	maxpswid 8.5
	scale 1	fillval .3
.iE
These may be changed at any time,
and the new values remain in force from picture to picture until changed again
or reset by a
.cR reset
statement.
Variables changed within
.cR [
and
.cR ]
revert to their previous value upon exit from the block.
Dimensions are divided by
.cR scale
during output.
'''	\" FORCE PAGE
.SK
.HU Expressions
Expressions in
.I pic
are evaluated in floating point.
All numbers representing dimensions are taken to be in inches.
.br
.EQ
delim $$
.EN
.iS
\f2expr\fP:
	\f2expr\fP \f2op\fP \f2expr\fP
	- \f2expr\fP
	! \f2expr\fP
	( \f2expr\fP )
	variable
	number
	\f2place\fP .x
	\f2place\fP .y
	\f2place\fP .ht
	\f2place\fP .wid
	\f2place\fP .rad
	sin($expr$)  cos($expr$)  atan2($expr$,$expr$)  log($expr$)  exp($expr$)
	sqrt($expr$)  max($expr$,$expr$)  min($expr$,$expr$)  int($expr$)  rand()
.sp 3p
\f2op\fP:
	+  -   *  /   %   ^
	<  <=  >  >=  ==  !=  &&  ||
.iE
.HU Definitions
The
.cR define
and
.cR undef
statements are not part of the grammar.
.iS
\f2define\fP:
	define \f2name\fP { \f2replacement text\fP }
.sp 3p
\f2undef\fP:
	undef \f2name\fP
.iE
.br
.EQ
delim off
.EN
Occurrences of
.cR $1 ,
.cR $2 ,
etc.,
in the replacement text
will be replaced by the corresponding arguments if
.I name
is invoked as
.iS
\f2name\fP(\f2arg1\fP, \f2arg2\fP, \(el)
.iE
Non-existent arguments are replaced by null strings.
.I Replacement
.I text
may contain newlines.
The
.cR undef
statement removes the definition of a macro.
.HU "The \&\f(CB.PS\fP and \&\f(CB.PE\fP Macros"
This is the default definition of the
.cR .PS
and
.cR .PE
macros in the
.cR -ms
macro package:
.iS
\&.de PS     \e" start picture; $1 is height, $2 is width, in inches
\&.sp .3
\&.in (\e\en(.lu-\e\e$2)/2u
\&.ne \e\e$1
\&..
\&.de PE     \e" end of picture
\&.in
\&.sp .6
\&..
.iE
.P
The
.cR .PS
and
.cR .PE
macros are not defined in the
.cR -mm
macro package; display macros are used to offset the picture
from the surrounding text.
'''	\" FORCE PAGE
.SK
.HU "Summary of Features Added Since Original Version"
The built-in functions
.cR sin ,
.cR cos ,
.cR atan2 ,
.cR log ,
.cR exp ,
.cR sqrt ,
.cR max ,
.cR min ,
.cR int ,
and
.cR rand
are available.
.P
The
.cR copy
statement includes data from a file or that follows immediately:
.iS
copy "\f2filename\fP"
copy thru \f2macro\fP
copy "\f2filename\fP" thru \f2macro\fP
.iE
The
.I macro
may be either the name of a defined macro, or the body of a macro
enclosed in braces.
If no filename is given,
.cR copy
copies the input until the next
.cR .PE .
.P
The
.cR for
and
.cR if
statements provide loops and decision-making:
.iS
for \f2var\fP=\f2expr\fP to \f2expr\fP by \f2expr\fP do { \f2anything\fP }
if \f2expr\fP then { \f2anything\fP } else { \f2anything\fP }
.iE
The
.cR by
and
.cR else
clauses are optional.
The
.I expr
in an
.cR if
may use the usual relational operators
or the tests
.I str1
.cR ==
(or
.cR != )
.I str2
for two quoted strings.
.P
The
.cR sh
command executes any sequence of commands, after expanding any defined names:
.iS
sh { \f2anything\fP }
.iE
.P
In all of the above,
any single character that does not occur within the body
may be used to enclose a body,
instead of
braces, as in
.iS
define \f2name\fP X \f2replacement text\fP X
.iE
.P
Text strings are first-class citizens:
a statement beginning with a sequence of text strings is treated
as an invisible box with the strings positioned at its center.
The variable
.cR textht
and
.cR textwid
may be set to any values to control positioning.
The height of \f2n\fP such strings is \f2n\fP \(mu
.cR textht .
.P
It is possible to convert expressions to formatted strings:
.iS
sprintf("\f2format\fP", \f2expr\fP, \f2expr\fP, \(el)
.iE
is equivalent to a quoted string in any context.
Variants of
.cR %f
and
.cR %g
are the only sensible format conversions.
.P
Built-in variables may be reset to default values with
.cR reset .
.P
The
.cR undef
statement removes a macro definition.
.P
Arrowheads may be filled with the 
.cR arrowhead
variable;
their positioning is improved on arcs.
.P
The width and height of the generated picture
may be set independently from the
.cR .PS
line;
the maximum height and width are set from
.cR maxpsht 
and
.cR maxpswid .
.P
The state of
.IR troff 's
fill or no-fill mode is preserved around a picture.
.P
Input numbers may be expressed in
.cR E
notation.
.P
Numerous internal changes have been made as well.
Any number of objects, text strings, etc., may be used;
the only limit is total available memory.
Output is now produced in inches instead of units
for a particular typesetter,
so the 
.cR -T
option has gone away.
