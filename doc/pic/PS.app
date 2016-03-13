%!PS
%%Version: 3.3.2
%%DocumentFonts: (atend)
%%Pages: (atend)
%%EndComments
%
% Version 3.3.2 prologue for troff files.
%

/#copies 1 store
/aspectratio 1 def
/formsperpage 1 def
/landscape false def
/linewidth .3 def
/magnification 1 def
/margin 0 def
/orientation 0 def
/resolution 720 def
/rotation 1 def
/xoffset 0 def
/yoffset 0 def

/roundpage true def
/useclippath true def
/pagebbox [0 0 612 792] def

/R  /Times-Roman def
/I  /Times-Italic def
/B  /Times-Bold def
/BI /Times-BoldItalic def
/H  /Helvetica def
/HI /Helvetica-Oblique def
/HB /Helvetica-Bold def
/HX /Helvetica-BoldOblique def
/CW /Courier def
/CO /Courier def
/CI /Courier-Oblique def
/CB /Courier-Bold def
/CX /Courier-BoldOblique def
/PA /Palatino-Roman def
/PI /Palatino-Italic def
/PB /Palatino-Bold def
/PX /Palatino-BoldItalic def
/Hr /Helvetica-Narrow def
/Hi /Helvetica-Narrow-Oblique def
/Hb /Helvetica-Narrow-Bold def
/Hx /Helvetica-Narrow-BoldOblique def
/KR /Bookman-Light def
/KI /Bookman-LightItalic def
/KB /Bookman-Demi def
/KX /Bookman-DemiItalic def
/AR /AvantGarde-Book def
/AI /AvantGarde-BookOblique def
/AB /AvantGarde-Demi def
/AX /AvantGarde-DemiOblique def
/NR /NewCenturySchlbk-Roman def
/NI /NewCenturySchlbk-Italic def
/NB /NewCenturySchlbk-Bold def
/NX /NewCenturySchlbk-BoldItalic def
/ZD /ZapfDingbats def
/ZI /ZapfChancery-MediumItalic def
/S  /S def
/S1 /S1 def
/GR /Symbol def

/inch {72 mul} bind def
/min {2 copy gt {exch} if pop} bind def

/setup {
	counttomark 2 idiv {def} repeat pop

	landscape {/orientation 90 orientation add def} if
	/scaling 72 resolution div def
	linewidth setlinewidth
	1 setlinecap

	pagedimensions
	xcenter ycenter translate
	orientation rotation mul rotate
	width 2 div neg height 2 div translate
	xoffset inch yoffset inch neg translate
	margin 2 div dup neg translate
	magnification dup aspectratio mul scale
	scaling scaling scale

	addmetrics
	0 0 moveto
} def

/pagedimensions {
	useclippath userdict /gotpagebbox known not and {
		/pagebbox [clippath pathbbox newpath] def
		roundpage currentdict /roundpagebbox known and {roundpagebbox} if
	} if
	pagebbox aload pop
	4 -1 roll exch 4 1 roll 4 copy
	landscape {4 2 roll} if
	sub /width exch def
	sub /height exch def
	add 2 div /xcenter exch def
	add 2 div /ycenter exch def
	userdict /gotpagebbox true put
} def

/addmetrics {
	/Symbol /S null Sdefs cf
	/Times-Roman /S1 StandardEncoding dup length array copy S1defs cf
} def

/pagesetup {
	/page exch def
	currentdict /pagedict known currentdict page known and {
		page load pagedict exch get cvx exec
	} if
} def

/decodingdefs [
	{counttomark 2 idiv {y moveto show} repeat}
	{neg /y exch def counttomark 2 idiv {y moveto show} repeat}
	{neg moveto {2 index stringwidth pop sub exch div 0 32 4 -1 roll widthshow} repeat}
	{neg moveto {spacewidth sub 0.0 32 4 -1 roll widthshow} repeat}
	{counttomark 2 idiv {y moveto show} repeat}
	{neg setfunnytext}
] def

/setdecoding {/t decodingdefs 3 -1 roll get bind def} bind def

/w {neg moveto show} bind def
/m {neg dup /y exch def moveto} bind def
/done {/lastpage where {pop lastpage} if} def

/f {
	dup /font exch def findfont exch
	dup /ptsize exch def scaling div dup /size exch def scalefont setfont
	linewidth ptsize mul scaling 10 mul div setlinewidth
	/spacewidth ( ) stringwidth pop def
} bind def

/changefont {
	/fontheight exch def
	/fontslant exch def
	currentfont [
		1 0
		fontheight ptsize div fontslant sin mul fontslant cos div
		fontheight ptsize div
		0 0
	] makefont setfont
} bind def

/sf {f} bind def

/cf {
	dup length 2 idiv
	/entries exch def
	/chtab exch def
	/newencoding exch def
	/newfont exch def

	findfont dup length 1 add dict
	/newdict exch def
	{1 index /FID ne {newdict 3 1 roll put}{pop pop} ifelse} forall

	newencoding type /arraytype eq {newdict /Encoding newencoding put} if

	newdict /Metrics entries dict put
	newdict /Metrics get
	begin
		chtab aload pop
		1 1 entries {pop def} for
		newfont newdict definefont pop
	end
} bind def

%
% A few arrays used to adjust reference points and character widths in some
% of the printer resident fonts. If square roots are too high try changing
% the lines describing /radical and /radicalex to,
%
%	/radical	[0 -75 550 0]
%	/radicalex	[-50 -75 500 0]
%
% Move braceleftbt a bit - default PostScript character is off a bit.
%

/Sdefs [
	/bracketlefttp		[201 500]
	/bracketleftbt		[201 500]
	/bracketrighttp		[-81 380]
	/bracketrightbt		[-83 380]
	/braceleftbt		[203 490]
	/bracketrightex		[220 -125 500 0]
	/radical		[0 0 550 0]
	/radicalex		[-50 0 500 0]
	/parenleftex		[-20 -170 0 0]
	/integral		[100 -50 500 0]
	/infinity		[10 -75 730 0]
] def

/S1defs [
	/underscore		[0 80 500 0]
	/endash			[7 90 650 0]
] def
%%EndProlog
%%BeginSetup
mark
/resolution 720 def
setup
2 setdecoding
%%EndSetup
%%Page: 1 1
/saveobj save def
mark
1 pagesetup
18 S1 f
(________________________________________________)720 870 w
12 HB f
( Reference Manual)2 1063(APPENDIX: PIC)1 988 2 720 1050 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Pictures]
10 B f
(Pictures)720 1350 w
10 R f
(The top-level object in)3 907 1 720 1530 t
10 I f
(pic)1652 1530 w
10 R f
(is the ``picture'':)2 676 1 1799 1530 t
9 I f
(picture)870 1700 w
9 CW f
(:)1125 1700 w
(.PS)1230 1810 w
9 I f
(optional-width optional-height)1 1139 1 1446 1810 t
(element-list)1230 1920 w
9 CW f
(.PE)1230 2030 w
10 R f
(If)720 2210 w
10 I f
(optional-width)816 2210 w
10 R f
( wide, regardless of any dimensions used)6 1675(is present, the picture is made that many inches)8 1929 2 1436 2210 t
( height is scaled in the same proportion unless)8 1867(internally. The)1 616 2 720 2330 t
10 I f
(optional-height)3231 2330 w
10 R f
( the line)2 326( instead)1 311( If)1 119(is present.)1 408 4 3876 2330 t
(is)720 2450 w
9 CW f
(.PS <f)1 324 1 870 2620 t
10 R f
(the \256le)1 275 1 720 2800 t
10 CW f
(f)1020 2800 w
10 R f
(is inserted in place of the)5 1001 1 1105 2800 t
10 CW f
(.PS)2131 2800 w
10 R f
(line.)2336 2800 w
(If)720 2980 w
10 CW f
(.PF)811 2980 w
10 R f
(is used instead of)3 691 1 1016 2980 t
10 CW f
(.PE)1732 2980 w
10 R f
(, the position after printing is restored to what it was upon entry.)12 2570 1 1912 2980 t
(In no case will the picture be larger than)8 1607 1 720 3160 t
9 CW f
(maxpsht)2381 3160 w
9 S f
(\264)2774 3160 w
9 CW f
(maxpswid)2839 3160 w
9 R f
(.)3278 3160 w
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Elements]
10 B f
(Elements)720 3340 w
10 R f
(An)720 3520 w
10 I f
(element-list)867 3520 w
10 R f
(is a list of elements \(what else?\); the elements are)9 1982 1 1358 3520 t
9 I f
(element)870 3690 w
9 CW f
(:)1150 3690 w
9 I f
(primitive attribute-list)1 821 1 1230 3800 t
(placename)1230 3910 w
9 CW f
(:)1674 3910 w
9 I f
(element)1782 3910 w
(placename)1230 4020 w
9 CW f
(:)1674 4020 w
9 I f
(position)1782 4020 w
(var)1230 4130 w
9 CW f
(=)1404 4130 w
9 I f
(expr)1512 4130 w
(direction)1230 4240 w
9 CW f
({)1230 4350 w
9 I f
(element-list)1338 4350 w
9 CW f
(})1812 4350 w
([)1230 4460 w
9 I f
(element-list)1338 4460 w
9 CW f
(])1812 4460 w
(for)1230 4570 w
9 I f
(var)1446 4570 w
9 CW f
(=)1620 4570 w
9 I f
(expr)1728 4570 w
9 CW f
(to)1942 4570 w
9 I f
(expr)2104 4570 w
9 CW f
(by)2318 4570 w
9 I f
(expr)2480 4570 w
9 CW f
(do {)1 216 1 2694 4570 t
9 I f
(anything)2964 4570 w
9 CW f
(})3333 4570 w
(if)1230 4680 w
9 I f
(expr)1392 4680 w
9 CW f
(then {)1 324 1 1606 4680 t
9 I f
(anything)1984 4680 w
9 CW f
(} else {)2 432 1 2353 4680 t
9 I f
(anything)2839 4680 w
9 CW f
(})3208 4680 w
(copy)1230 4790 w
9 I f
(\256le)1500 4790 w
9 CW f
(copy thru)1 486 1 1230 4900 t
9 I f
(macro)1770 4900 w
9 CW f
(copy)1230 5010 w
9 I f
(\256le)1500 5010 w
9 CW f
(thru)1664 5010 w
9 I f
(macro)1934 5010 w
9 CW f
(sh {)1 216 1 1230 5120 t
9 I f
(commandline)1500 5120 w
9 CW f
(})2039 5120 w
(print)1230 5230 w
9 I f
(expr)1554 5230 w
9 CW f
(reset)1230 5340 w
9 I f
(optional var-list)1 583 1 1554 5340 t
(troff-command)1230 5450 w
10 R f
( line)1 188(Elements are separated by newlines or semicolons; a long element may be continued by ending the)15 4132 2 720 5630 t
( are introduced by a)4 792( Comments)1 484(with a backslash.)2 685 3 720 5750 t
10 CW f
(#)2706 5750 w
10 R f
(and terminated by a newline.)4 1156 1 2791 5750 t
( and variable)2 547( Place)1 282( a lower case letter; place names begin with upper case.)10 2373(Variable names begin with)3 1118 4 720 5930 t
(names retain their values from one picture to the next.)9 2157 1 720 6050 t
(The current position and direction of motion are saved upon entry to a)12 2801 1 720 6230 t
10 CW f
({)3546 6230 w
10 S f
(\274)3606 6230 w
10 CW f
(})3706 6230 w
10 R f
(block and restored upon exit.)4 1162 1 3791 6230 t
(Elements within a block enclosed in)5 1526 1 720 6410 t
10 CW f
([)2287 6410 w
10 S f
(\274)2347 6410 w
10 CW f
(])2447 6410 w
10 R f
( as a unit; the dimensions are determined by the)9 2059(are treated)1 433 2 2548 6410 t
( variables, and direction of motion within a block are local)10 2358( Names,)1 355(extreme points of the contained objects.)5 1607 3 720 6530 t
(to that block.)2 525 1 720 6650 t
10 I f
(troff-command)720 6830 w
10 R f
( a line is assumed to make sense in the context)10 1939( Such)1 257(is any line that begins with a period.)7 1498 3 1346 6830 t
(where it appears; accordingly, if it doesn't work, don't call.)9 2373 1 720 6950 t
cleartomark
showpage
saveobj restore
%%EndPage: 1 1
%%Page: 2 2
/saveobj save def
mark
2 pagesetup
10 HB f
(A-2 PIC)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Primitives]
10 B f
(Primitives)720 960 w
10 R f
(The primitive objects are)3 1001 1 720 1140 t
9 I f
(primitive)870 1310 w
9 CW f
(:)1195 1310 w
(box)1230 1420 w
(circle)1230 1530 w
(ellipse)1230 1640 w
(arc)1230 1750 w
(line)1230 1860 w
(arrow)1230 1970 w
(spline)1230 2080 w
(move)1230 2190 w
9 I f
(text-list)1230 2300 w
10 CW f
(arrow)720 2480 w
10 R f
(is a synonym for)3 669 1 1045 2480 t
10 CW f
(line ->)1 385 1 1739 2480 t
10 R f
(.)2124 2480 w
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Attributes]
10 B f
(Attributes)720 2660 w
10 R f
(An)720 2840 w
10 I f
(attribute-list)881 2840 w
10 R f
( of zero or more attributes; each attribute consists of a keyword, perhaps)12 3065(is a sequence)2 554 2 1421 2840 t
(followed by a value.)3 815 1 720 2960 t
9 I f
(attribute)870 3130 w
9 CW f
(:)1180 3130 w
(h\(eigh\)t)1230 3240 w
9 I f
(expr)1716 3240 w
9 CW f
(wid\(th\))2670 3240 w
9 I f
(expr)3102 3240 w
9 CW f
(rad\(ius\))1230 3350 w
9 I f
(expr)1716 3350 w
9 CW f
(diam\(eter\))2670 3350 w
9 I f
(expr)3264 3350 w
9 CW f
(up)1230 3460 w
9 I f
(opt-expr)1392 3460 w
9 CW f
(down)2670 3460 w
9 I f
(opt-expr)2940 3460 w
9 CW f
(right)1230 3570 w
9 I f
(opt-expr)1554 3570 w
9 CW f
(left)2670 3570 w
9 I f
(opt-expr)2940 3570 w
9 CW f
(from)1230 3680 w
9 I f
(position)1500 3680 w
9 CW f
(to)2670 3680 w
9 I f
(position)2832 3680 w
9 CW f
(at)1230 3790 w
9 I f
(position)1392 3790 w
9 CW f
(with)2670 3790 w
9 I f
(corner)2940 3790 w
9 CW f
(by)1230 3900 w
9 I f
(expr, expr)1 366 1 1392 3900 t
9 CW f
(then)2670 3900 w
(dotted)1230 4010 w
9 I f
(opt-expr)1608 4010 w
9 CW f
(dashed)2670 4010 w
9 I f
(opt-expr)3048 4010 w
9 CW f
(chop)1230 4120 w
9 I f
(opt-expr)1500 4120 w
9 CW f
(-> <- <->)2 594 1 2670 4120 t
(invis solid)1 1710 1 1230 4230 t
(fill)1230 4340 w
9 I f
(opt-expr)1500 4340 w
9 CW f
(same)2670 4340 w
9 I f
(text-list expr)1 1600 1 1230 4450 t
10 R f
( all attributes make sense for all primitives;)7 1799( Not)1 210( are \256lled in from defaults.)5 1115(Missing attributes and values)3 1196 4 720 4630 t
( attribute)1 359( The)1 206(irrelevant ones are silently ignored.)4 1415 3 720 4750 t
10 CW f
(at)2725 4750 w
10 R f
(causes the geometrical center to be put at the speci\256ed)9 2170 1 2870 4750 t
(place;)720 4870 w
10 CW f
(with)989 4870 w
10 R f
( lines, splines and arcs,)4 949( For)1 196( object to be put at the speci\256ed place.)8 1584(causes the position on the)4 1051 4 1260 4870 t
10 CW f
(height)720 4990 w
10 R f
(and)1105 4990 w
10 CW f
(width)1274 4990 w
10 R f
( bare)1 196( A)1 122(refer to arrowhead size.)3 940 3 1599 4990 t
10 I f
(expr)2882 4990 w
10 R f
(implies motion in the current direction.)5 1566 1 3084 4990 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Text]
10 B f
(Text)720 5170 w
10 R f
(Text is normally an attribute of some primitive; by default it is placed at the geometrical center of the)18 4320 1 720 5350 t
( A)1 131( text is also permitted.)4 922(object. Stand-alone)1 805 3 720 5470 t
10 I f
(text-list)2612 5470 w
10 R f
( text items; a text item is a quoted string)9 1675(is a list of)3 419 2 2946 5470 t
(optionally followed by positioning requests:)4 1767 1 720 5590 t
9 I f
(text-item)870 5760 w
9 CW f
(:)1185 5760 w
(")1230 5870 w
9 S f
(\274)1284 5870 w
9 CW f
(")1374 5870 w
9 I f
(positioning)1482 5870 w
9 S f
(\274)1910 5870 w
9 CW f
(sprintf\(")1230 5980 w
9 I f
(format)1716 5980 w
9 CW f
(",)1956 5980 w
9 I f
(expr)2118 5980 w
9 CW f
(,)2278 5980 w
9 S f
(\274)2386 5980 w
9 CW f
(\))2476 5980 w
9 I f
(positioning)2584 5980 w
9 S f
(\274)3012 5980 w
9 I f
(positioning)870 6120 w
9 CW f
(:)1275 6120 w
(center ljust rjust above below)4 1836 1 1230 6230 t
10 R f
( some primitive, they are centered vertically except as quali\256ed.)9 2805(If there are multiple text items for)6 1515 2 720 6410 t
(Positioning requests apply to each item independently.)6 2185 1 720 6530 t
(Text items can contain)3 934 1 720 6710 t
10 I f
(troff)1689 6710 w
10 R f
(commands for size and font changes, local motions, etc., but make sure that)12 3143 1 1897 6710 t
(these are balanced so that the entering state is restored before exiting.)11 2771 1 720 6830 t
cleartomark
showpage
saveobj restore
%%EndPage: 2 2
%%Page: 3 3
/saveobj save def
mark
3 pagesetup
10 HB f
(PIC A-3)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Positions and Places]
10 B f
(Positions and Places)2 862 1 720 960 t
10 R f
(A position is ultimately an)4 1062 1 720 1140 t
10 I f
(x,y)1807 1140 w
10 R f
(coordinate pair, but it may be speci\256ed in other ways.)9 2144 1 1945 1140 t
9 I f
(position)870 1310 w
9 CW f
(:)1160 1310 w
9 I f
(expr, expr)1 366 1 1230 1420 t
(place)1230 1530 w
9 S f
(\261)1479 1530 w
9 I f
(expr, expr)1 366 1 1583 1530 t
(place)1230 1640 w
9 S f
(\261)1479 1640 w
9 CW f
(\()1583 1640 w
9 I f
(expr, expr)1 366 1 1691 1640 t
9 CW f
(\))2111 1640 w
(\()1230 1750 w
9 I f
(position)1338 1750 w
9 CW f
(,)1628 1750 w
9 I f
(position)1705 1750 w
9 CW f
(\))2049 1750 w
9 I f
(expr [)1 249 1 1230 1860 t
9 CW f
(of the way)2 540 1 1479 1860 t
9 I f
(])2019 1860 w
9 CW f
(between)2108 1860 w
9 I f
(position)2540 1860 w
9 CW f
(and)2884 1860 w
9 I f
(position)3100 1860 w
(expr)1230 1970 w
9 CW f
(<)1444 1970 w
9 I f
(position)1552 1970 w
9 CW f
(,)1896 1970 w
9 I f
(position)2004 1970 w
9 CW f
(>)2348 1970 w
(\()1230 2080 w
9 I f
(position)1338 2080 w
9 CW f
(\))1682 2080 w
9 I f
(place)870 2220 w
9 CW f
(:)1065 2220 w
9 I f
(placename optional-corner)1 1014 1 1230 2330 t
(corner)1230 2440 w
9 CW f
(of)1524 2440 w
9 I f
(placename)1686 2440 w
(nth primitive optional-corner)2 1118 1 1230 2550 t
(corner)1230 2660 w
9 CW f
(of)1524 2660 w
9 I f
(nth primitive)1 494 1 1686 2660 t
9 CW f
(Here)1230 2770 w
10 R f
(An)720 2950 w
10 I f
(optional-corner)867 2950 w
10 R f
(is one of the eight compass points or the center or the start or end of a primitive.)17 3201 1 1525 2950 t
9 I f
(optional-corner)870 3120 w
9 CW f
(:)1440 3120 w
(.n .e .w .s .ne .se .nw .sw .c .start .end)10 2808 1 1230 3230 t
9 I f
(corner)870 3370 w
9 CW f
(:)1110 3370 w
(top bot left right start end)5 1782 1 1230 3480 t
10 R f
(Each object in a picture has an ordinal number;)8 1885 1 720 3660 t
10 I f
(nth)2630 3660 w
10 R f
(refers to this.)2 524 1 2783 3660 t
9 I f
(nth)870 3830 w
9 CW f
(:)985 3830 w
9 I f
(n)1230 3940 w
9 CW f
(th)1275 3940 w
9 I f
(n)1230 4050 w
9 CW f
(th last)1 378 1 1275 4050 t
10 R f
(Since barbarisms like)2 860 1 720 4230 t
10 CW f
(1th)1605 4230 w
10 R f
(and)1810 4230 w
10 CW f
(3th)1979 4230 w
10 R f
(are barbaric, synonyms like)3 1103 1 2184 4230 t
10 CW f
(1st)3312 4230 w
10 R f
(and)3517 4230 w
10 CW f
(3rd)3686 4230 w
10 R f
(are accepted as well.)3 824 1 3891 4230 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Variables]
10 B f
(Variables)720 4410 w
10 R f
(The built-in variables and their default values are:)7 1993 1 720 4590 t
9 CW f
( 0.5)1 216( boxht)1 1116(boxwid 0.75)1 594 3 1230 4760 t
( 0.25)1 270( arcrad)1 1008(circlerad 0.25)1 756 3 1230 4870 t
( 0.5)1 216( ellipseht)1 1116(ellipsewid 0.75)1 810 3 1230 4980 t
( 0.5)1 216( lineht)1 1170(linewid 0.5)1 594 3 1230 5090 t
( 0.5)1 216( moveht)1 1170(movewid 0.5)1 594 3 1230 5200 t
( 0)1 108( textht)1 1278(textwid 0)1 486 3 1230 5310 t
( 0.1)1 216( arrowht)1 1116(arrowwid 0.05)1 702 3 1230 5420 t
( 2)1 108( arrowhead)1 1332(dashwid 0.1)1 594 3 1230 5530 t
( 8.5)1 216( maxpswid)1 1332(maxpsht 11)1 540 3 1230 5640 t
( .3)1 162( fillval)1 1440(scale 1)1 378 3 1230 5750 t
10 R f
( until changed)2 568(These may be changed at any time, and the new values remain in force from picture to picture)17 3752 2 720 5930 t
( reset by a)3 410(again or)1 326 2 720 6050 t
10 CW f
(reset)1482 6050 w
10 R f
( changed within)2 640(statement. Variables)1 841 2 1808 6050 t
10 CW f
([)3315 6050 w
10 R f
(and)3401 6050 w
10 CW f
(])3571 6050 w
10 R f
(revert to their previous value upon)5 1383 1 3657 6050 t
( are divided by)3 596( Dimensions)1 528(exit from the block.)3 788 3 720 6170 t
10 CW f
(scale)2657 6170 w
10 R f
(during output.)1 567 1 2982 6170 t
cleartomark
showpage
saveobj restore
%%EndPage: 3 3
%%Page: 4 4
/saveobj save def
mark
4 pagesetup
10 HB f
(A-4 PIC)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Expressions]
10 B f
(Expressions)720 960 w
10 R f
(Expressions in)1 591 1 720 1140 t
10 I f
(pic)1341 1140 w
10 R f
( dimensions are taken to be in)6 1229( numbers representing)2 897( All)1 183(are evaluated in \257oating point.)4 1238 4 1493 1140 t
(inches.)720 1260 w
9 I f
(expr)870 1430 w
9 CW f
(:)1030 1430 w
9 I f
(expr op expr)2 518 1 1230 1540 t
9 CW f
(-)1230 1650 w
9 I f
(expr)1338 1650 w
9 CW f
(!)1230 1760 w
9 I f
(expr)1338 1760 w
9 CW f
(\()1230 1870 w
9 I f
(expr)1338 1870 w
9 CW f
(\))1552 1870 w
(variable)1230 1980 w
(number)1230 2090 w
9 I f
(place)1230 2200 w
9 CW f
(.x)1479 2200 w
9 I f
(place)1230 2310 w
9 CW f
(.y)1479 2310 w
9 I f
(place)1230 2420 w
9 CW f
(.ht)1479 2420 w
9 I f
(place)1230 2530 w
9 CW f
(.wid)1479 2530 w
9 I f
(place)1230 2640 w
9 CW f
(.rad)1479 2640 w
(sin\()1230 2750 w
9 I f
(expr)1446 2750 w
9 CW f
(\) cos\()1 378 1 1606 2750 t
9 I f
(expr)1984 2750 w
9 CW f
(\) atan2\()1 486 1 2144 2750 t
9 I f
(expr)2630 2750 w
9 CW f
(,)2790 2750 w
9 I f
(expr)2844 2750 w
9 CW f
(\) log\()1 378 1 3004 2750 t
9 I f
(expr)3382 2750 w
9 CW f
(\) exp\()1 378 1 3542 2750 t
9 I f
(expr)3920 2750 w
9 CW f
(\))4080 2750 w
(sqrt\()1230 2860 w
9 I f
(expr)1500 2860 w
9 CW f
(\) max\()1 378 1 1660 2860 t
9 I f
(expr)2038 2860 w
9 CW f
(,)2198 2860 w
9 I f
(expr)2252 2860 w
9 CW f
(\) min\()1 378 1 2412 2860 t
9 I f
(expr)2790 2860 w
9 CW f
(,)2950 2860 w
9 I f
(expr)3004 2860 w
9 CW f
(\) int\()1 378 1 3164 2860 t
9 I f
(expr)3542 2860 w
9 CW f
(\) rand\(\))1 486 1 3702 2860 t
9 I f
(op)870 3000 w
9 CW f
(:)960 3000 w
( % \303)2 432( /)1 162( *)1 216(+ -)1 216 4 1230 3110 t
(< <= > >= == != && ||)7 1512 1 1230 3220 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Definitions]
10 B f
(De\256nitions)720 3400 w
10 R f
(The)720 3580 w
10 CW f
(define)900 3580 w
10 R f
(and)1285 3580 w
10 CW f
(undef)1454 3580 w
10 R f
(statements are not part of the grammar.)6 1566 1 1779 3580 t
9 I f
(de\256ne)870 3750 w
9 CW f
(:)1085 3750 w
(define)1230 3860 w
9 I f
(name)1608 3860 w
9 CW f
({)1857 3860 w
9 I f
(replacement text)1 598 1 1965 3860 t
9 CW f
(})2617 3860 w
9 I f
(undef)870 4000 w
9 CW f
(:)1070 4000 w
(undef)1230 4110 w
9 I f
(name)1554 4110 w
10 R f
(Occurrences of)1 616 1 720 4290 t
10 CW f
($1)1372 4290 w
10 R f
(,)1492 4290 w
10 CW f
($2)1554 4290 w
10 R f
(, etc., in the replacement text will be replaced by the corresponding arguments if)13 3366 1 1674 4290 t
10 I f
(name)720 4410 w
10 R f
(is invoked as)2 522 1 961 4410 t
9 I f
(name)870 4580 w
9 CW f
(\()1065 4580 w
9 I f
(arg1)1119 4580 w
9 CW f
(,)1289 4580 w
9 I f
(arg2)1397 4580 w
9 CW f
(,)1567 4580 w
9 S f
(\274)1675 4580 w
9 CW f
(\))1765 4580 w
10 R f
( strings.)1 321(Non-existent arguments are replaced by null)5 1786 2 720 4760 t
10 I f
(Replacement text)1 688 1 2881 4760 t
10 R f
( The)1 209(may contain newlines.)2 904 2 3598 4760 t
10 CW f
(undef)4740 4760 w
10 R f
(statement removes the de\256nition of a macro.)6 1778 1 720 4880 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = The \&.PS and \&.PE Macros]
10 B f
(The)720 5060 w
10 CB f
(.PS)912 5060 w
10 B f
(and)1117 5060 w
10 CB f
(.PE)1304 5060 w
10 B f
(Macros)1509 5060 w
10 R f
(This is the default de\256nition of the)6 1383 1 720 5240 t
10 CW f
(.PS)2128 5240 w
10 R f
(and)2333 5240 w
10 CW f
(.PE)2502 5240 w
10 R f
(macros in the)2 538 1 2707 5240 t
10 CW f
(-ms)3270 5240 w
10 R f
(macro package:)1 628 1 3475 5240 t
9 CW f
( start picture; $1 is height, $2 is width, in inches)10 2808( \\")1 378(.de PS)1 324 3 870 5410 t
(.sp .3)1 324 1 870 5520 t
(.in \(\\\\n\(.lu-\\\\$2\)/2u)1 1134 1 870 5630 t
(.ne \\\\$1)1 432 1 870 5740 t
(..)870 5850 w
( end of picture)3 810( \\")1 378(.de PE)1 324 3 870 5960 t
(.in)870 6070 w
(.sp .6)1 324 1 870 6180 t
(..)870 6290 w
10 R f
(The)720 6470 w
10 CW f
(.PS)903 6470 w
10 R f
(and)1111 6470 w
10 CW f
(.PE)1283 6470 w
10 R f
(macros are not de\256ned in the)5 1171 1 1491 6470 t
10 CW f
(-mm)2690 6470 w
10 R f
( display macros are used to offset the)7 1511(macro package;)1 631 2 2898 6470 t
(picture from the surrounding text.)4 1351 1 720 6590 t
cleartomark
showpage
saveobj restore
%%EndPage: 4 4
%%Page: 5 5
/saveobj save def
mark
5 pagesetup
10 HB f
(PIC A-5)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Summary of Features Added Since Original Version]
10 B f
(Summary of Features Added Since Original Version)6 2233 1 720 960 t
10 R f
(The built-in functions)2 872 1 720 1140 t
10 CW f
(sin)1617 1140 w
10 R f
(,)1797 1140 w
10 CW f
(cos)1847 1140 w
10 R f
(,)2027 1140 w
10 CW f
(atan2)2077 1140 w
10 R f
(,)2377 1140 w
10 CW f
(log)2427 1140 w
10 R f
(,)2607 1140 w
10 CW f
(exp)2657 1140 w
10 R f
(,)2837 1140 w
10 CW f
(sqrt)2887 1140 w
10 R f
(,)3127 1140 w
10 CW f
(max)3177 1140 w
10 R f
(,)3357 1140 w
10 CW f
(min)3407 1140 w
10 R f
(,)3587 1140 w
10 CW f
(int)3637 1140 w
10 R f
(, and)1 194 1 3817 1140 t
10 CW f
(rand)4036 1140 w
10 R f
(are available.)1 531 1 4301 1140 t
(The)720 1320 w
10 CW f
(copy)900 1320 w
10 R f
(statement includes data from a \256le or that follows immediately:)9 2534 1 1165 1320 t
9 CW f
(copy ")1 324 1 870 1490 t
9 I f
(\256lename)1194 1490 w
9 CW f
(")1499 1490 w
(copy thru)1 486 1 870 1600 t
9 I f
(macro)1410 1600 w
9 CW f
(copy ")1 324 1 870 1710 t
9 I f
(\256lename)1194 1710 w
9 CW f
(" thru)1 324 1 1499 1710 t
9 I f
(macro)1877 1710 w
10 R f
(The)720 1890 w
10 I f
(macro)908 1890 w
10 R f
( no)1 134( If)1 125( de\256ned macro, or the body of a macro enclosed in braces.)11 2429(may be either the name of a)6 1156 4 1196 1890 t
(\256lename is given,)2 708 1 720 2010 t
10 CW f
(copy)1453 2010 w
10 R f
(copies the input until the next)5 1186 1 1718 2010 t
10 CW f
(.PE)2929 2010 w
10 R f
(.)3109 2010 w
(The)720 2190 w
10 CW f
(for)900 2190 w
10 R f
(and)1105 2190 w
10 CW f
(if)1274 2190 w
10 R f
(statements provide loops and decision-making:)4 1882 1 1419 2190 t
9 CW f
(for)870 2360 w
9 I f
(var)1086 2360 w
9 CW f
(=)1206 2360 w
9 I f
(expr)1260 2360 w
9 CW f
(to)1474 2360 w
9 I f
(expr)1636 2360 w
9 CW f
(by)1850 2360 w
9 I f
(expr)2012 2360 w
9 CW f
(do {)1 216 1 2226 2360 t
9 I f
(anything)2496 2360 w
9 CW f
(})2865 2360 w
(if)870 2470 w
9 I f
(expr)1032 2470 w
9 CW f
(then {)1 324 1 1246 2470 t
9 I f
(anything)1624 2470 w
9 CW f
(} else {)2 432 1 1993 2470 t
9 I f
(anything)2479 2470 w
9 CW f
(})2848 2470 w
10 R f
(The)720 2650 w
10 CW f
(by)909 2650 w
10 R f
(and)1063 2650 w
10 CW f
(else)1241 2650 w
10 R f
( The)1 215(clauses are optional.)2 830 2 1515 2650 t
10 I f
(expr)2595 2650 w
10 R f
(in an)1 207 1 2807 2650 t
10 CW f
(if)3049 2650 w
10 R f
(may use the usual relational operators or the)7 1836 1 3204 2650 t
(tests)720 2770 w
10 I f
(str1)923 2770 w
10 CW f
(==)1104 2770 w
10 R f
(\(or)1249 2770 w
10 CW f
(!=)1390 2770 w
10 R f
(\))1510 2770 w
10 I f
(str2)1568 2770 w
10 R f
(for two quoted strings.)3 905 1 1749 2770 t
(The)720 2950 w
10 CW f
(sh)900 2950 w
10 R f
(command executes any sequence of commands, after expanding any de\256ned names:)10 3356 1 1045 2950 t
9 CW f
(sh {)1 216 1 870 3120 t
9 I f
(anything)1140 3120 w
9 CW f
(})1509 3120 w
10 R f
(In all of the above, any single character that does not occur within the body may be used to enclose a body,)21 4320 1 720 3300 t
(instead of braces, as in)4 906 1 720 3420 t
9 CW f
(define)870 3590 w
9 I f
(name)1248 3590 w
9 CW f
(X)1497 3590 w
9 I f
(replacement text)1 598 1 1605 3590 t
9 CW f
(X)2257 3590 w
10 R f
( a sequence of text strings is treated as an)9 1748(Text strings are \256rst-class citizens: a statement beginning with)8 2572 2 720 3770 t
( variable)1 352( The)1 211(invisible box with the strings positioned at its center.)8 2162 3 720 3890 t
10 CW f
(textht)3476 3890 w
10 R f
(and)3867 3890 w
10 CW f
(textwid)4042 3890 w
10 R f
( to)1 108(may be set)2 439 2 4493 3890 t
( height of)2 383( The)1 205(any values to control positioning.)4 1336 3 720 4010 t
10 I f
(n)2669 4010 w
10 R f
(such strings is)2 567 1 2744 4010 t
10 I f
(n)3336 4010 w
10 S f
(\264)3411 4010 w
10 CW f
(textht)3491 4010 w
10 R f
(.)3851 4010 w
(It is possible to convert expressions to formatted strings:)8 2260 1 720 4190 t
9 CW f
(sprintf\(")870 4360 w
9 I f
(format)1356 4360 w
9 CW f
(",)1596 4360 w
9 I f
(expr)1758 4360 w
9 CW f
(,)1918 4360 w
9 I f
(expr)2026 4360 w
9 CW f
(,)2186 4360 w
9 S f
(\274)2294 4360 w
9 CW f
(\))2384 4360 w
10 R f
( of)1 129( Variants)1 409(is equivalent to a quoted string in any context.)8 2014 3 720 4540 t
10 CW f
(%f)3318 4540 w
10 R f
(and)3485 4540 w
10 CW f
(%g)3676 4540 w
10 R f
(are the only sensible format)4 1197 1 3843 4540 t
(conversions.)720 4660 w
(Built-in variables may be reset to default values with)8 2114 1 720 4840 t
10 CW f
(reset)2859 4840 w
10 R f
(.)3159 4840 w
(The)720 5020 w
10 CW f
(undef)900 5020 w
10 R f
(statement removes a macro de\256nition.)4 1523 1 1225 5020 t
(Arrowheads may be \256lled with the)5 1384 1 720 5200 t
10 CW f
(arrowhead)2129 5200 w
10 R f
(variable; their positioning is improved on arcs.)6 1868 1 2694 5200 t
(The width and height of the generated picture may be set independently from the)13 3308 1 720 5380 t
10 CW f
(.PS)4059 5380 w
10 R f
(line; the maximum)2 770 1 4270 5380 t
(height and width are set from)5 1173 1 720 5500 t
10 CW f
(maxpsht)1918 5500 w
10 R f
(and)2363 5500 w
10 CW f
(maxpswid)2532 5500 w
10 R f
(.)3012 5500 w
(The state of)2 471 1 720 5680 t
10 I f
(troff)1216 5680 w
10 R f
('s \256ll or no-\256ll mode is preserved around a picture.)9 2036 1 1397 5680 t
(Input numbers may be expressed in)5 1417 1 720 5860 t
10 CW f
(E)2162 5860 w
10 R f
(notation.)2247 5860 w
( may be used;)3 555( number of objects, text strings, etc.,)6 1454( Any)1 222(Numerous internal changes have been made as well.)7 2089 4 720 6040 t
( units for a particular)4 849( is now produced in inches instead of)7 1512( Output)1 332(the only limit is total available memory.)6 1627 4 720 6160 t
(typesetter, so the)2 674 1 720 6280 t
10 CW f
(-T)1419 6280 w
10 R f
(option has gone away.)3 893 1 1564 6280 t
cleartomark
showpage
saveobj restore
%%EndPage: 5 5
%%Trailer
done
%%Pages: 5
%%DocumentFonts: Helvetica-Bold Times-Bold Times-Italic Courier-Bold Times-Roman Symbol Courier Times-Roman
