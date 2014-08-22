'''	\"               Copyright c 1990 AT&T
'''	\"                All Rights Reserved
'''	\" THIS DOCUMENT CONTAINS PROPRIETARY INFORMATION OF
'''	\" AT&T AND IS NOT TO BE DISCLOSED OR USED EXCEPT IN
'''	\"      ACCORDANCE WITH APPLICABLE AGREEMENTS.
'''	\"
.so ../defs.doc
.ds pT MV
.aP "" Examples
The examples in this appendix show how to use individual features of
.sM MV ,
and how to use a combination of features as well as
.I troff
preprocessors to produce view graphs of varying complexity.
.P
The input for Examples 1 and 2 is given in \(sc2.
The input for Examples 3 through 8 precede the output.
.P
Each view graph was formatted by
.I troff
with the
.sM MV
package, and postprocessed by
.IR dpost ;
preprocessing was performed, as needed.
Each output sample, originally generated as a full-page PostScript\*(Rg image,
.FS ""
PostScript is a registered trademark of Adobe Systems, Inc.
.FE
is automatically scaled to size, boxed, and merged onto the page using the
.I mpictures
PostScript picture inclusion facility.
As such, the frame dimensions and point sizes used for text
shown in the output samples may differ from
those specified in the input samples;
the original full-page output samples are true to form.
.SK
.HU "Example 1:  Output"
.sy troff -Tpost -mv mv.ex1 | dpost -B >ps.ex1
.BP ps.ex1 6.25i "" 0 o
.SK
.HU "Example 2:  Output"
.sy troff -Tpost -mv mv.ex2 | dpost -B >ps.ex2
.BP ps.ex2 6.25i "" 0 o
.SK
.HU "Example 3:  Input"
.iS
.S -1
\&.Vh 3 "Levels & Marks"
\&.T "Foil Levels & Level Marks"
This is the .A (left margin) level;
\&.B
this is the .B level,
\&.B
as is this;
\&.C
this is the .C level,
\&.C
as is this;
\&.D
and this is the .D level,
\&.D
as is this.
\&.A
The large bullet, the dash, and the small
bullet are the default ``marks'' for
levels .B, .C, and .D, respectively.
However, these three levels can also
be marked arbitrarily:
\&.B B.
Like this (this is the .B level);
\&.C 3.
like this (this is the .C level);
\&.D d.
like this (this is the .D level), or
\&.D iv.
like this, or even
\&.D \e(rh-\e(bu +4
like this.
\&.A
The .A level cannot be marked.
\&.B
An arbitrary number of lines of text
can be included in any item at any level;
the text will be filled, but neither adjusted
nor hyphenated, just like this .B level item.
.S +1
.iE
.SK
.HU "Example 3:  Output"
.sy troff -Tpost -mv mv.ex3 | dpost -B >ps.ex3
.BP ps.ex3 8i "" 0 o
.SK
.HU "Example 4:  Input"
.iS
.S -1
\&.DF 1 R 2 I 3 B
\&.VS 4 Complex
\&.T "Of Bits & Bytes & Words"
\&.S -4
\&.I 3 A x
\&.ul 3
But let your communication be, Yea, yea;
Nay, nay: for whatsoever is more than these
cometh of evil.*
\&.I +1 a nospace
Matthew 5:37
\&.BR
\&.S
\&.I 0 .A
Binary notation has been around for a
\&.S +6
long
\&.S
time.
\&.B
The above verse tells us to use:
\&.C 1)
binary notation,
\&.ul
and
\&.C 2)
redundancy
\&.D \e(rh
(in communicating)
\&.B
Binary notation is
\&.U not
suited for human use, above verse to
the contrary notwithstanding.
\&.S -2
\&.TS
box;
cb | cb | cb | cb
l  | n  | n  | n.
System	Bits/Byte	Bytes/Word	Bits/Word
_
IBM-7090/94	6	6	36
IBM-360/370	8	4	32
PDP-11/70  	8	2	16
\&.TE
\&.S
\&.S -4
\&.U "            "
\&.BR
* The use of this verse in this context
is plagiarized from C. Shannon.
\&.S
.S +1
.iE
.SK
.HU "Example 4:  Output"
.sy tbl mv.ex4 | troff -Tpost -mv - | dpost -B >ps.ex4
.BP ps.ex4 8i "" 0 o
.SK
.HU "Example 5:  Input"
.EQ
delim off
.EN
.iS
.S -1
\&.DF 1 R 2 I 3 B
\&.VS 5 "Equations"
\&.T Equations
\&.EQ
\&gsize 18
\&delim $$
\&.EN
\&.S 100 5.5
Equations can be displayed or
set in-line with the text.
\&.SP
A displayed equation is set apart
from the text:
\&.I 2 a
\&.EQ
sum from k=1 to inf m sup k-1
~=~ 1 over 1-m
\&.EN
\&.I 0 a
An in-line equation
$f(t)~=~2 pi int sin ( omega t)dt$
is used in the running text,
rather than being displayed.
.S +1
.iE
.SK
.HU "Example 5:  Output"
.sy eqn mv.ex5 | troff -Tpost -mv - | dpost -B >ps.ex5
.BP ps.ex5 6.25i "" 0 o
.SK
.HU "Example 6:  Input"
.EQ
delim off
.EN
.iS
.S -1
\&.Vw 6 "The Works"
\&.EQ
\&gsize 14
\&delim $$
\&.EN
\&.TS
\&center doublebox tab(!);
\&Cip+4 | Cb  S   S
\&^     | L   L   L
\&^     | C | C | C
\&^     | C | C | C
\&Li    | C | C | N.
\&Users!Hardware
\&!_!_!_
\&!UNIX\e*(Rg!Model!Serial
\&!System!\e^!Number
\&=
\&OS Dev.!A!VAX!54
\&SGS Dev.!B!11/70!3275
\&Low-End!C!11/23!221
\&_
\&And now ...!T{
\&.NA
\&Some filled text and an equation:
\&T}!T{
\&$zeta (s)~=~ prod from k=1 to inf k sup -s$
\&.AD
\&T}!1.2
\&.TE
.S +1
.iE
.SK
.HU "Example 6:  Output"
.sy tbl mv.ex6 | eqn | troff -Tpost -mv - | dpost -B >ps.ex6
.BP ps.ex6 6.25i "" 0 o
.SK
.HU "Example 7:  Input"
.EQ
delim off
.EN
.iS
.S -1
\&.VS 7 "Model"
\&.T "A Working Model"
\&.SP
\&.PS
\&boxwid = 1.25i ; boxht = 0.75i
\&arrow
\&box "input"
\&arrow
\&box "process"
\&arrow
\&box "output"
\&arrow
\&.PE
.S +1
.iE
.EQ
delim $$
.EN
.SK
.HU "Example 7:  Output"
.sy pic mv.ex7 | troff -Tpost -mv - | dpost -B >ps.ex7
.BP ps.ex7 6.25i "" 0 o
.SK
.HU "Example 8:  Input"
.EQ
delim off
.EN
.iS
.S -1
\&.VS 8 "Age Graph"
\&.T "1984 Age Distribution in U.S."
\&.SP
\&.G1
\&coord x 0,89 y 0,5
\&label left "\es-3Population\es+3" "\es-3(in millions)\es+3" left 0.2
\&label bottom "\es-31984 Age\es+3" down 0.2
\&draw solid
\&copy "agepop.d"
\&.G2
.S +1
.iE
.EQ
delim $$
.EN
.SK
.HU "Example 8:  Output"
.sy grap mv.ex8 | pic | troff -Tpost -mv - | dpost -B >ps.ex8
.BP ps.ex8 6.25i "" 0 o
