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
(APPENDIX: Examples)1 1350 1 720 1050 t
10 R f
(This Appendix contains several view graphs produced by the)8 2536 1 720 1350 t
10 I f
(troff)3293 1350 w
10 R f
( the)1 160(text formatter and)2 739 2 3503 1350 t
9 R f
(MVIEW)4438 1350 w
10 R f
(macro)4791 1350 w
( table in Example 10 was created with the)8 1701(package. The)1 560 2 720 1470 t
10 I f
(tbl)3010 1470 w
10 R f
( Example 11)2 511( mathematics in)2 641(preprocessor. The)1 743 3 3145 1470 t
(were typeset with the)3 872 1 720 1590 t
10 I f
(eqn)1624 1590 w
10 R f
( with the)2 366( picture in Example 12 was drawn)6 1406(preprocessor. The)1 746 3 1800 1590 t
10 I f
(pic)4351 1590 w
10 R f
(preprocessor.)4506 1590 w
(The graph in Example 13 was plotted with the)8 1848 1 720 1710 t
10 I f
(grap)2593 1710 w
10 R f
(preprocessor.)2807 1710 w
(Each output sample, originally generated as a full page PostScript)9 2693 1 720 1890 t
6 S f
(\322)3413 1850 w
10 R f
( size,)1 213(image, is automatically scaled to)4 1335 2 3492 1890 t
( onto the page using the)5 1012(boxed, and merged)2 788 2 720 2010 t
10 I f
(mpictures)2557 2010 w
10 R f
( such, the)2 404( As)1 173(PostScript picture inclusion facility.)3 1475 3 2988 2010 t
( may differ from those speci\256ed)5 1288(frame dimensions and point sizes used for text shown in the output samples)12 3032 2 720 2130 t
(in the input samples; the original full-page output samples are true to form.)12 3000 1 720 2250 t
8 S1 f
(__________________)720 6929 w
8 R f
(PostScript is a registered trademark of Adobe Systems, Inc.)8 1895 1 840 7049 t
cleartomark
showpage
saveobj restore
%%EndPage: 1 1
%%Page: 2 2
/saveobj save def
mark
2 pagesetup
10 HB f
(A-2 MVIEW)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 1]
10 B f
(Example 1)1 453 1 720 960 t
cleartomark
saveobj restore
%ps_include: begin
save
/ed {exch def} def
{} /showpage ed
{} /copypage ed
{} /erasepage ed
{} /letter ed
currentdict /findfont known systemdict /findfont known and {
	/findfont systemdict /findfont get def
} if
36 dict dup /PS-include-dict-dw ed begin
/context ed
count array astore /o-stack ed
%ps_include: variables begin
/llx 8 def
/lly 209 def
/urx 533 def
/ury 738 def
/w 0 def
/o 1 def
/s 0 def
/cx 2880 def
/cy -3510 def
/sx 4320 def
/sy 4500 def
/ax 0.5 def
/ay 0.5 def
/rot -0 def
%ps_include: variables end
{llx lly urx ury} /bbox ed
{newpath 2 index exch 2 index exch dup 6 index exch
 moveto 3 {lineto} repeat closepath} /boxpath ed
{dup mul exch dup mul add sqrt} /len ed
{2 copy gt {exch} if pop} /min ed
{2 copy lt {exch} if pop} /max ed
{transform round exch round exch A itransform} /nice ed
{6 array} /n ed
n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed
urx llx sub 0 A dtransform len /Sx ed
0 ury lly sub A dtransform len /Sy ed
llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed
rot dup sin abs /S ed cos abs /C ed
Sx S mul Sy C mul add /H ed
Sx C mul Sy S mul add /W ed
sy H div /Scaley ed
sx W div /Scalex ed
s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if
sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed
sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed
urx llx sub 0 A dtransform exch atan rot exch sub /rot ed
n currentmatrix initgraphics setmatrix
cx cy translate
Scalex Scaley scale
rot rotate
Cx neg Cy neg translate
A concat
bbox boxpath clip newpath
w 0 ne {gsave bbox boxpath 1 setgray fill grestore} if
end
gsave
%ps_include: inclusion begin

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
mark
/rotation 1 def
/gotpagebbox true def
/resolution 720 def
setup
2 setdecoding
/saveobj save def
mark
1 pagesetup
8 S f
(\347`` `` ``\347)2 5040 1 194 720 t
36 H f
(Here is Some Text)3 2991 1 1218 1920 t
(Which Can Be)2 2309 1 1218 2550 t
(Used to Produce)2 2696 1 1218 3180 t
(A)1218 3810 w
(View Graph)1 1888 1 1218 4440 t
8 S f
(\347__ __ __\347)2 5040 1 194 5683 t
cleartomark
showpage
saveobj restore
done
%ps_include: inclusion end
grestore
PS-include-dict-dw begin
o 0 ne {gsave A defaultmatrix /A ed llx lly nice urx ury nice
	initgraphics 0.1 setlinewidth boxpath stroke grestore} if
clear o-stack aload pop
context end restore
%ps_include: end
/saveobj save def
mark
cleartomark
showpage
saveobj restore
%%EndPage: 2 2
%%Page: 3 3
/saveobj save def
mark
3 pagesetup
10 HB f
(MVIEW A-3)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 2]
10 B f
(Example 2)1 453 1 720 960 t
cleartomark
saveobj restore
%ps_include: begin
save
/ed {exch def} def
{} /showpage ed
{} /copypage ed
{} /erasepage ed
{} /letter ed
currentdict /findfont known systemdict /findfont known and {
	/findfont systemdict /findfont get def
} if
36 dict dup /PS-include-dict-dw ed begin
/context ed
count array astore /o-stack ed
%ps_include: variables begin
/llx 8 def
/lly 209 def
/urx 533 def
/ury 738 def
/w 0 def
/o 1 def
/s 0 def
/cx 2880 def
/cy -3510 def
/sx 4320 def
/sy 4500 def
/ax 0.5 def
/ay 0.5 def
/rot -0 def
%ps_include: variables end
{llx lly urx ury} /bbox ed
{newpath 2 index exch 2 index exch dup 6 index exch
 moveto 3 {lineto} repeat closepath} /boxpath ed
{dup mul exch dup mul add sqrt} /len ed
{2 copy gt {exch} if pop} /min ed
{2 copy lt {exch} if pop} /max ed
{transform round exch round exch A itransform} /nice ed
{6 array} /n ed
n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed
urx llx sub 0 A dtransform len /Sx ed
0 ury lly sub A dtransform len /Sy ed
llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed
rot dup sin abs /S ed cos abs /C ed
Sx S mul Sy C mul add /H ed
Sx C mul Sy S mul add /W ed
sy H div /Scaley ed
sx W div /Scalex ed
s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if
sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed
sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed
urx llx sub 0 A dtransform exch atan rot exch sub /rot ed
n currentmatrix initgraphics setmatrix
cx cy translate
Scalex Scaley scale
rot rotate
Cx neg Cy neg translate
A concat
bbox boxpath clip newpath
w 0 ne {gsave bbox boxpath 1 setgray fill grestore} if
end
gsave
%ps_include: inclusion begin

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
mark
/rotation 1 def
/gotpagebbox true def
/resolution 720 def
setup
2 setdecoding
/saveobj save def
mark
1 pagesetup
8 S f
(\347`` `` ``\347)2 5040 1 194 720 t
36 H f
(Here Is Some Text)3 3013 1 1207 1920 t
(Which Can be Used)3 3214 1 1106 2550 t
(To Produce)1 1871 1 1778 3180 t
(A)2593 3810 w
(View Graph)1 1888 1 1769 4440 t
8 S f
(\347__ __ __\347)2 5040 1 194 5683 t
cleartomark
showpage
saveobj restore
done
%ps_include: inclusion end
grestore
PS-include-dict-dw begin
o 0 ne {gsave A defaultmatrix /A ed llx lly nice urx ury nice
	initgraphics 0.1 setlinewidth boxpath stroke grestore} if
clear o-stack aload pop
context end restore
%ps_include: end
/saveobj save def
mark
cleartomark
showpage
saveobj restore
%%EndPage: 3 3
%%Page: 4 4
/saveobj save def
mark
4 pagesetup
10 HB f
(A-4 MVIEW)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 3]
10 B f
(Example 3)1 453 1 720 960 t
cleartomark
saveobj restore
%ps_include: begin
save
/ed {exch def} def
{} /showpage ed
{} /copypage ed
{} /erasepage ed
{} /letter ed
currentdict /findfont known systemdict /findfont known and {
	/findfont systemdict /findfont get def
} if
36 dict dup /PS-include-dict-dw ed begin
/context ed
count array astore /o-stack ed
%ps_include: variables begin
/llx 8 def
/lly 209 def
/urx 533 def
/ury 738 def
/w 0 def
/o 1 def
/s 0 def
/cx 2880 def
/cy -3510 def
/sx 4320 def
/sy 4500 def
/ax 0.5 def
/ay 0.5 def
/rot -0 def
%ps_include: variables end
{llx lly urx ury} /bbox ed
{newpath 2 index exch 2 index exch dup 6 index exch
 moveto 3 {lineto} repeat closepath} /boxpath ed
{dup mul exch dup mul add sqrt} /len ed
{2 copy gt {exch} if pop} /min ed
{2 copy lt {exch} if pop} /max ed
{transform round exch round exch A itransform} /nice ed
{6 array} /n ed
n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed
urx llx sub 0 A dtransform len /Sx ed
0 ury lly sub A dtransform len /Sy ed
llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed
rot dup sin abs /S ed cos abs /C ed
Sx S mul Sy C mul add /H ed
Sx C mul Sy S mul add /W ed
sy H div /Scaley ed
sx W div /Scalex ed
s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if
sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed
sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed
urx llx sub 0 A dtransform exch atan rot exch sub /rot ed
n currentmatrix initgraphics setmatrix
cx cy translate
Scalex Scaley scale
rot rotate
Cx neg Cy neg translate
A concat
bbox boxpath clip newpath
w 0 ne {gsave bbox boxpath 1 setgray fill grestore} if
end
gsave
%ps_include: inclusion begin

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
mark
/rotation 1 def
/gotpagebbox true def
/resolution 720 def
setup
2 setdecoding
/saveobj save def
mark
1 pagesetup
8 S f
(\347`` `` ``\347)2 5040 1 194 720 t
28 H f
(Here is some text for a poorly written)7 4570 1 429 1920 t
(view graph which I really do not want)7 4593 1 417 2550 t
(anyone to read because much of the)6 4569 1 429 3180 t
(information which it contains is of)5 4122 1 653 3810 t
(very little value.)2 1935 1 1746 4440 t
8 S f
(\347__ __ __\347)2 5040 1 194 5683 t
cleartomark
showpage
saveobj restore
done
%ps_include: inclusion end
grestore
PS-include-dict-dw begin
o 0 ne {gsave A defaultmatrix /A ed llx lly nice urx ury nice
	initgraphics 0.1 setlinewidth boxpath stroke grestore} if
clear o-stack aload pop
context end restore
%ps_include: end
/saveobj save def
mark
cleartomark
showpage
saveobj restore
%%EndPage: 4 4
%%Page: 5 5
/saveobj save def
mark
5 pagesetup
10 HB f
(MVIEW A-5)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 4]
10 B f
(Example 4)1 453 1 720 960 t
cleartomark
saveobj restore
%ps_include: begin
save
/ed {exch def} def
{} /showpage ed
{} /copypage ed
{} /erasepage ed
{} /letter ed
currentdict /findfont known systemdict /findfont known and {
	/findfont systemdict /findfont get def
} if
36 dict dup /PS-include-dict-dw ed begin
/context ed
count array astore /o-stack ed
%ps_include: variables begin
/llx 8 def
/lly 209 def
/urx 533 def
/ury 738 def
/w 0 def
/o 1 def
/s 0 def
/cx 2880 def
/cy -3510 def
/sx 4320 def
/sy 4500 def
/ax 0.5 def
/ay 0.5 def
/rot -0 def
%ps_include: variables end
{llx lly urx ury} /bbox ed
{newpath 2 index exch 2 index exch dup 6 index exch
 moveto 3 {lineto} repeat closepath} /boxpath ed
{dup mul exch dup mul add sqrt} /len ed
{2 copy gt {exch} if pop} /min ed
{2 copy lt {exch} if pop} /max ed
{transform round exch round exch A itransform} /nice ed
{6 array} /n ed
n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed
urx llx sub 0 A dtransform len /Sx ed
0 ury lly sub A dtransform len /Sy ed
llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed
rot dup sin abs /S ed cos abs /C ed
Sx S mul Sy C mul add /H ed
Sx C mul Sy S mul add /W ed
sy H div /Scaley ed
sx W div /Scalex ed
s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if
sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed
sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed
urx llx sub 0 A dtransform exch atan rot exch sub /rot ed
n currentmatrix initgraphics setmatrix
cx cy translate
Scalex Scaley scale
rot rotate
Cx neg Cy neg translate
A concat
bbox boxpath clip newpath
w 0 ne {gsave bbox boxpath 1 setgray fill grestore} if
end
gsave
%ps_include: inclusion begin

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
mark
/rotation 1 def
/gotpagebbox true def
/resolution 720 def
setup
2 setdecoding
/saveobj save def
mark
1 pagesetup
8 S f
(\347`` `` ``\347)2 5040 1 194 720 t
27 PB f
(FONTS FOR EMPHASIS)2 3120 1 1154 1620 t
26 PA f
(Fonts are sometimes used for emphasis.)5 4580 1 424 2340 t
26 PI f
(This is the italic font.)4 2224 1 424 2820 t
26 PB f
(This is the bold font.)4 2475 1 424 3300 t
26 PX f
(This is the bold-italic font.)4 3108 1 424 3780 t
26 CW f
(This is constant width.)3 3588 1 424 4260 t
26 PA f
(Now back to the regular font.)5 3395 1 424 4740 t
10 PA f
(jns)5011 5580 w
8 S f
(\347__ __ __\347)2 5040 1 194 5683 t
cleartomark
showpage
saveobj restore
done
%ps_include: inclusion end
grestore
PS-include-dict-dw begin
o 0 ne {gsave A defaultmatrix /A ed llx lly nice urx ury nice
	initgraphics 0.1 setlinewidth boxpath stroke grestore} if
clear o-stack aload pop
context end restore
%ps_include: end
/saveobj save def
mark
cleartomark
showpage
saveobj restore
%%EndPage: 5 5
%%Page: 6 6
/saveobj save def
mark
6 pagesetup
10 HB f
(A-6 MVIEW)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 5]
10 B f
(Example 5)1 453 1 720 960 t
cleartomark
saveobj restore
%ps_include: begin
save
/ed {exch def} def
{} /showpage ed
{} /copypage ed
{} /erasepage ed
{} /letter ed
currentdict /findfont known systemdict /findfont known and {
	/findfont systemdict /findfont get def
} if
36 dict dup /PS-include-dict-dw ed begin
/context ed
count array astore /o-stack ed
%ps_include: variables begin
/llx 8 def
/lly 172 def
/urx 533 def
/ury 738 def
/w 0 def
/o 1 def
/s 0 def
/cx 2880 def
/cy -3690 def
/sx 4320 def
/sy 4860 def
/ax 0.5 def
/ay 0.5 def
/rot -0 def
%ps_include: variables end
{llx lly urx ury} /bbox ed
{newpath 2 index exch 2 index exch dup 6 index exch
 moveto 3 {lineto} repeat closepath} /boxpath ed
{dup mul exch dup mul add sqrt} /len ed
{2 copy gt {exch} if pop} /min ed
{2 copy lt {exch} if pop} /max ed
{transform round exch round exch A itransform} /nice ed
{6 array} /n ed
n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed
urx llx sub 0 A dtransform len /Sx ed
0 ury lly sub A dtransform len /Sy ed
llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed
rot dup sin abs /S ed cos abs /C ed
Sx S mul Sy C mul add /H ed
Sx C mul Sy S mul add /W ed
sy H div /Scaley ed
sx W div /Scalex ed
s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if
sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed
sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed
urx llx sub 0 A dtransform exch atan rot exch sub /rot ed
n currentmatrix initgraphics setmatrix
cx cy translate
Scalex Scaley scale
rot rotate
Cx neg Cy neg translate
A concat
bbox boxpath clip newpath
w 0 ne {gsave bbox boxpath 1 setgray fill grestore} if
end
gsave
%ps_include: inclusion begin

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
mark
/rotation 1 def
/gotpagebbox true def
/resolution 720 def
setup
2 setdecoding
/saveobj save def
mark
1 pagesetup
8 S f
(\347`` `` ``\347)2 5040 1 194 720 t
19 HB f
(CHANGING SIZES)1 1637 1 1895 1422 t
19 S f
(_ _________________)1 1637 1 1895 1422 t
18 H f
(Changing the point size \(smaller or larger\) by a single)9 4276 1 466 1977 t
( change of several points)4 2011( A)1 221(point may not be noticeable.)4 2263 3 466 2347 t
(may be necessary to see the difference.)6 3204 1 466 2717 t
(Some normal-sized text)2 1895 1 1766 3457 t
16 H f
(A Bit Smaller)2 927 1 2250 3827 t
12 H f
(Much Smaller)1 734 1 2346 4197 t
14 H f
(A Bit Larger)2 740 1 2343 4567 t
18 H f
(Return to the normal point size)5 2460 1 1483 4937 t
8 S f
(\347__ __ __\347)2 5040 1 194 5683 t
10 H f
(SIZES)194 5923 w
(Example 5)1 474 1 194 6043 t
cleartomark
showpage
saveobj restore
done
%ps_include: inclusion end
grestore
PS-include-dict-dw begin
o 0 ne {gsave A defaultmatrix /A ed llx lly nice urx ury nice
	initgraphics 0.1 setlinewidth boxpath stroke grestore} if
clear o-stack aload pop
context end restore
%ps_include: end
/saveobj save def
mark
cleartomark
showpage
saveobj restore
%%EndPage: 6 6
%%Page: 7 7
/saveobj save def
mark
7 pagesetup
10 HB f
(MVIEW A-7)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 6]
10 B f
(Example 6)1 453 1 720 960 t
cleartomark
saveobj restore
%ps_include: begin
save
/ed {exch def} def
{} /showpage ed
{} /copypage ed
{} /erasepage ed
{} /letter ed
currentdict /findfont known systemdict /findfont known and {
	/findfont systemdict /findfont get def
} if
36 dict dup /PS-include-dict-dw ed begin
/context ed
count array astore /o-stack ed
%ps_include: variables begin
/llx 8 def
/lly 184 def
/urx 533 def
/ury 738 def
/w 0 def
/o 1 def
/s 0 def
/cx 2880 def
/cy -3600 def
/sx 4320 def
/sy 4680 def
/ax 0.5 def
/ay 0.5 def
/rot -0 def
%ps_include: variables end
{llx lly urx ury} /bbox ed
{newpath 2 index exch 2 index exch dup 6 index exch
 moveto 3 {lineto} repeat closepath} /boxpath ed
{dup mul exch dup mul add sqrt} /len ed
{2 copy gt {exch} if pop} /min ed
{2 copy lt {exch} if pop} /max ed
{transform round exch round exch A itransform} /nice ed
{6 array} /n ed
n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed
urx llx sub 0 A dtransform len /Sx ed
0 ury lly sub A dtransform len /Sy ed
llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed
rot dup sin abs /S ed cos abs /C ed
Sx S mul Sy C mul add /H ed
Sx C mul Sy S mul add /W ed
sy H div /Scaley ed
sx W div /Scalex ed
s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if
sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed
sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed
urx llx sub 0 A dtransform exch atan rot exch sub /rot ed
n currentmatrix initgraphics setmatrix
cx cy translate
Scalex Scaley scale
rot rotate
Cx neg Cy neg translate
A concat
bbox boxpath clip newpath
w 0 ne {gsave bbox boxpath 1 setgray fill grestore} if
end
gsave
%ps_include: inclusion begin

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
mark
/rotation 1 def
/gotpagebbox true def
/resolution 720 def
setup
2 setdecoding
/saveobj save def
mark
1 pagesetup
8 S f
(\347`` `` ``\347)2 5040 1 194 720 t
36 HB f
(A List Example)2 2591 1 1418 1722 t
33 S f
(\267)896 2782 w
35 H f
(First List Item)2 2105 1 1421 2782 t
33 S f
(\267)896 3577 w
35 H f
(Second List Item)2 2619 1 1421 3577 t
33 S f
(\267)896 4372 w
35 H f
(Third \(last\) List Item)3 3100 1 1421 4372 t
10 H f
(jns)4994 5580 w
8 S f
(\347__ __ __\347)2 5040 1 194 5683 t
10 H f
(Bullet List)1 435 1 194 5923 t
cleartomark
showpage
saveobj restore
done
%ps_include: inclusion end
grestore
PS-include-dict-dw begin
o 0 ne {gsave A defaultmatrix /A ed llx lly nice urx ury nice
	initgraphics 0.1 setlinewidth boxpath stroke grestore} if
clear o-stack aload pop
context end restore
%ps_include: end
/saveobj save def
mark
cleartomark
showpage
saveobj restore
%%EndPage: 7 7
%%Page: 8 8
/saveobj save def
mark
8 pagesetup
10 HB f
(A-8 MVIEW)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 7]
10 B f
(Example 7)1 453 1 720 960 t
cleartomark
saveobj restore
%ps_include: begin
save
/ed {exch def} def
{} /showpage ed
{} /copypage ed
{} /erasepage ed
{} /letter ed
currentdict /findfont known systemdict /findfont known and {
	/findfont systemdict /findfont get def
} if
36 dict dup /PS-include-dict-dw ed begin
/context ed
count array astore /o-stack ed
%ps_include: variables begin
/llx 8 def
/lly 112 def
/urx 533 def
/ury 738 def
/w 0 def
/o 1 def
/s 0 def
/cx 2880 def
/cy -3870 def
/sx 4320 def
/sy 5220 def
/ax 0.5 def
/ay 0.5 def
/rot -0 def
%ps_include: variables end
{llx lly urx ury} /bbox ed
{newpath 2 index exch 2 index exch dup 6 index exch
 moveto 3 {lineto} repeat closepath} /boxpath ed
{dup mul exch dup mul add sqrt} /len ed
{2 copy gt {exch} if pop} /min ed
{2 copy lt {exch} if pop} /max ed
{transform round exch round exch A itransform} /nice ed
{6 array} /n ed
n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed
urx llx sub 0 A dtransform len /Sx ed
0 ury lly sub A dtransform len /Sy ed
llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed
rot dup sin abs /S ed cos abs /C ed
Sx S mul Sy C mul add /H ed
Sx C mul Sy S mul add /W ed
sy H div /Scaley ed
sx W div /Scalex ed
s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if
sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed
sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed
urx llx sub 0 A dtransform exch atan rot exch sub /rot ed
n currentmatrix initgraphics setmatrix
cx cy translate
Scalex Scaley scale
rot rotate
Cx neg Cy neg translate
A concat
bbox boxpath clip newpath
w 0 ne {gsave bbox boxpath 1 setgray fill grestore} if
end
gsave
%ps_include: inclusion begin

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
mark
/rotation 1 def
/gotpagebbox true def
/resolution 720 def
setup
2 setdecoding
/build_bx {
    pop
    size 2 div /side exch def
    currentpoint
    newpath
    moveto
    0 side rlineto
    side 0 rlineto
    0 side neg rlineto
    closepath
    fill
} def
/build_sq {
    pop
    size 2 div /side exch def
    currentpoint
    newpath
    moveto
    0 side rlineto
    side 0 rlineto
    0 side neg rlineto
    closepath
    font B eq {fill} {stroke} ifelse
} def
/saveobj save def
mark
1 pagesetup
8 S f
(\347`` `` ``\347)2 5040 1 194 720 t
19 HB f
(READER INQUIRY)1 1647 1 1890 1690 t
18 HI f
(Please check all that apply:)4 2192 1 806 1990 t
16 S1 f
()806 2290 w
cleartomark
saveobj restore
/build_bx {
    pop
    size 2 div /side exch def
    currentpoint
    newpath
    moveto
    0 side rlineto
    side 0 rlineto
    0 side neg rlineto
    closepath
    fill
} def
/saveobj save def
mark
16 S1 f
806 2290 m
80 build_bx
886 2290 m
18 H f
(Why did you use this document?)5 2612 1 976 2290 t
16 S1 f
()976 2590 w
cleartomark
saveobj restore
/build_sq {
    pop
    size 2 div /side exch def
    currentpoint
    newpath
    moveto
    0 side rlineto
    side 0 rlineto
    0 side neg rlineto
    closepath
    font B eq {fill} {stroke} ifelse
} def
/saveobj save def
mark
16 S1 f
976 2590 m
80 build_sq
1056 2590 m
18 H f
(To learn procedures)2 1617 1 1146 2590 t
16 S1 f
()976 2890 w
976 2890 m
80 build_sq
1056 2890 m
18 H f
(To reference information)2 1967 1 1146 2890 t
16 S1 f
()976 3190 w
976 3190 m
80 build_sq
1056 3190 m
18 H f
(To solve a problem)3 1536 1 1146 3190 t
16 S1 f
()976 3490 w
976 3490 m
80 build_sq
1056 3490 m
18 H f
(Other:)1146 3490 w
16 S1 f
()806 3790 w
806 3790 m
80 build_bx
886 3790 m
18 H f
(What changes would improve this document?)5 3646 1 976 3790 t
16 S1 f
()976 4090 w
976 4090 m
80 build_sq
1056 4090 m
18 H f
(Change structure and organization)3 2775 1 1146 4090 t
16 S1 f
()976 4390 w
976 4390 m
80 build_sq
1056 4390 m
18 H f
(Add more examples)2 1606 1 1146 4390 t
16 S1 f
()976 4690 w
976 4690 m
80 build_sq
1056 4690 m
18 H f
(More detailed information)2 2038 1 1146 4690 t
16 S1 f
()976 4990 w
976 4990 m
80 build_sq
1056 4990 m
18 H f
(Other:)1146 4990 w
16 S1 f
()806 5290 w
806 5290 m
80 build_bx
886 5290 m
18 H f
(Comments:)976 5290 w
10 H f
(DocuCenter)4587 6300 w
8 S f
(\347__ __ __\347)2 5040 1 194 6403 t
10 H f
(Reader Inquiry)1 658 1 194 6643 t
cleartomark
showpage
saveobj restore
done
%ps_include: inclusion end
grestore
PS-include-dict-dw begin
o 0 ne {gsave A defaultmatrix /A ed llx lly nice urx ury nice
	initgraphics 0.1 setlinewidth boxpath stroke grestore} if
clear o-stack aload pop
context end restore
%ps_include: end
/saveobj save def
mark
cleartomark
showpage
saveobj restore
%%EndPage: 8 8
%%Page: 9 9
/saveobj save def
mark
9 pagesetup
10 HB f
(MVIEW A-9)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 8]
10 B f
(Example 8)1 453 1 720 960 t
cleartomark
saveobj restore
%ps_include: begin
save
/ed {exch def} def
{} /showpage ed
{} /copypage ed
{} /erasepage ed
{} /letter ed
currentdict /findfont known systemdict /findfont known and {
	/findfont systemdict /findfont get def
} if
36 dict dup /PS-include-dict-dw ed begin
/context ed
count array astore /o-stack ed
%ps_include: variables begin
/llx 8 def
/lly 209 def
/urx 533 def
/ury 738 def
/w 0 def
/o 1 def
/s 0 def
/cx 2880 def
/cy -3510 def
/sx 4320 def
/sy 4500 def
/ax 0.5 def
/ay 0.5 def
/rot -0 def
%ps_include: variables end
{llx lly urx ury} /bbox ed
{newpath 2 index exch 2 index exch dup 6 index exch
 moveto 3 {lineto} repeat closepath} /boxpath ed
{dup mul exch dup mul add sqrt} /len ed
{2 copy gt {exch} if pop} /min ed
{2 copy lt {exch} if pop} /max ed
{transform round exch round exch A itransform} /nice ed
{6 array} /n ed
n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed
urx llx sub 0 A dtransform len /Sx ed
0 ury lly sub A dtransform len /Sy ed
llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed
rot dup sin abs /S ed cos abs /C ed
Sx S mul Sy C mul add /H ed
Sx C mul Sy S mul add /W ed
sy H div /Scaley ed
sx W div /Scalex ed
s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if
sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed
sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed
urx llx sub 0 A dtransform exch atan rot exch sub /rot ed
n currentmatrix initgraphics setmatrix
cx cy translate
Scalex Scaley scale
rot rotate
Cx neg Cy neg translate
A concat
bbox boxpath clip newpath
w 0 ne {gsave bbox boxpath 1 setgray fill grestore} if
end
gsave
%ps_include: inclusion begin

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
mark
/rotation 1 def
/gotpagebbox true def
/resolution 720 def
setup
2 setdecoding
/saveobj save def
mark
1 pagesetup
8 S f
(\347`` `` ``\347)2 5040 1 194 720 t
24 H f
(I. Research)1 1402 1 623 1440 t
( Technology)1 1310(II. Electronics)1 1616 2 556 1875 t
( Circuits Development)2 2349(A. Integrated)1 1552 2 1129 2310 t
(\(1\) LSI)1 894 1 1665 2745 t
(\(2\) VLSI)1 1055 1 1665 3180 t
( Device Materials)2 1841(B. Electronic)1 1523 2 1129 3615 t
( Assembly Technology)2 2418(C. System)1 1281 2 1117 4050 t
( Planning)1 1004(III. Network)1 1388 2 489 4485 t
( Systems)1 988(IV. Transmission)1 1961 2 462 4920 t
8 S f
(\347__ __ __\347)2 5040 1 194 5683 t
cleartomark
showpage
saveobj restore
done
%ps_include: inclusion end
grestore
PS-include-dict-dw begin
o 0 ne {gsave A defaultmatrix /A ed llx lly nice urx ury nice
	initgraphics 0.1 setlinewidth boxpath stroke grestore} if
clear o-stack aload pop
context end restore
%ps_include: end
/saveobj save def
mark
cleartomark
showpage
saveobj restore
%%EndPage: 9 9
%%Page: 10 10
/saveobj save def
mark
10 pagesetup
10 HB f
(A-10 MVIEW)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 9]
10 B f
(Example 9)1 453 1 720 960 t
cleartomark
saveobj restore
%ps_include: begin
save
/ed {exch def} def
{} /showpage ed
{} /copypage ed
{} /erasepage ed
{} /letter ed
currentdict /findfont known systemdict /findfont known and {
	/findfont systemdict /findfont get def
} if
36 dict dup /PS-include-dict-dw ed begin
/context ed
count array astore /o-stack ed
%ps_include: variables begin
/llx 8 def
/lly 196 def
/urx 533 def
/ury 738 def
/w 0 def
/o 1 def
/s 0 def
/cx 2880 def
/cy -3600 def
/sx 4320 def
/sy 4680 def
/ax 0.5 def
/ay 0.5 def
/rot -0 def
%ps_include: variables end
{llx lly urx ury} /bbox ed
{newpath 2 index exch 2 index exch dup 6 index exch
 moveto 3 {lineto} repeat closepath} /boxpath ed
{dup mul exch dup mul add sqrt} /len ed
{2 copy gt {exch} if pop} /min ed
{2 copy lt {exch} if pop} /max ed
{transform round exch round exch A itransform} /nice ed
{6 array} /n ed
n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed
urx llx sub 0 A dtransform len /Sx ed
0 ury lly sub A dtransform len /Sy ed
llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed
rot dup sin abs /S ed cos abs /C ed
Sx S mul Sy C mul add /H ed
Sx C mul Sy S mul add /W ed
sy H div /Scaley ed
sx W div /Scalex ed
s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if
sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed
sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed
urx llx sub 0 A dtransform exch atan rot exch sub /rot ed
n currentmatrix initgraphics setmatrix
cx cy translate
Scalex Scaley scale
rot rotate
Cx neg Cy neg translate
A concat
bbox boxpath clip newpath
w 0 ne {gsave bbox boxpath 1 setgray fill grestore} if
end
gsave
%ps_include: inclusion begin

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
mark
/rotation 1 def
/gotpagebbox true def
/resolution 720 def
setup
2 setdecoding
/saveobj save def
mark
1 pagesetup
8 S f
(\347`` `` ``\347)2 5040 1 194 720 t
19 HB f
(TYPESETTING FACILITIES)1 2409 1 1509 1330 t
18 H f
( number of)2 863(Preprocessors A)1 1561 2 389 1730 t
18 HI f
(troff)2863 1730 w
18 H f
(preprocessors are)1 1454 1 3223 1730 t
(available to aid in formatting view)5 2662 1 1829 1930 t
(graphs with tables, equations, pictures,)4 3125 1 1829 2130 t
(and graphs.)1 956 1 1829 2330 t
(Formatter The)1 1752 1 389 2630 t
18 HI f
(troff)2191 2630 w
18 H f
(text formatter is the heart of)5 2206 1 2551 2630 t
(UNIX)1829 2830 w
14 S f
(\322)2260 2767 w
18 H f
( This)1 441(system text processing.)2 1885 2 2421 2830 t
(software does the actual formatting of)5 3013 1 1829 3030 t
(the input text.)2 1086 1 1829 3230 t
( postprocessors are available to)4 2551(Postprocessors Several)1 2053 2 389 3530 t
(translate the)1 995 1 1829 3730 t
18 HI f
(troff)2874 3730 w
18 H f
(output language to the)3 1804 1 3234 3730 t
(page description language needed to)4 2982 1 1829 3930 t
(drive a particular type of output device:)6 3104 1 1829 4130 t
18 HI f
(dpost)1829 4330 w
18 H f
(prepares output for PostScript)3 2400 1 2322 4330 t
(printers and typesetters,)2 1937 1 1829 4530 t
18 HI f
(dimpress)3816 4530 w
18 H f
(for)4597 4530 w
(Imagen printers, and)2 1657 1 1829 4730 t
18 HI f
(dpcl)3536 4730 w
18 H f
(for HP laser)2 952 1 3918 4730 t
(printers.)1829 4930 w
10 H f
(Example 9)1 474 1 4648 5580 t
8 S f
(\347__ __ __\347)2 5040 1 194 5683 t
10 H f
(Variable List in Filled mode)4 1204 1 222 5803 t
cleartomark
showpage
saveobj restore
done
%ps_include: inclusion end
grestore
PS-include-dict-dw begin
o 0 ne {gsave A defaultmatrix /A ed llx lly nice urx ury nice
	initgraphics 0.1 setlinewidth boxpath stroke grestore} if
clear o-stack aload pop
context end restore
%ps_include: end
/saveobj save def
mark
cleartomark
showpage
saveobj restore
%%EndPage: 10 10
%%Page: 11 11
/saveobj save def
mark
11 pagesetup
10 HB f
(MVIEW A-11)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 10]
10 B f
(Example 10)1 503 1 720 960 t
cleartomark
saveobj restore
%ps_include: begin
save
/ed {exch def} def
{} /showpage ed
{} /copypage ed
{} /erasepage ed
{} /letter ed
currentdict /findfont known systemdict /findfont known and {
	/findfont systemdict /findfont get def
} if
36 dict dup /PS-include-dict-dw ed begin
/context ed
count array astore /o-stack ed
%ps_include: variables begin
/llx 8 def
/lly 172 def
/urx 533 def
/ury 738 def
/w 0 def
/o 1 def
/s 0 def
/cx 2880 def
/cy -3690 def
/sx 4320 def
/sy 4860 def
/ax 0.5 def
/ay 0.5 def
/rot -0 def
%ps_include: variables end
{llx lly urx ury} /bbox ed
{newpath 2 index exch 2 index exch dup 6 index exch
 moveto 3 {lineto} repeat closepath} /boxpath ed
{dup mul exch dup mul add sqrt} /len ed
{2 copy gt {exch} if pop} /min ed
{2 copy lt {exch} if pop} /max ed
{transform round exch round exch A itransform} /nice ed
{6 array} /n ed
n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed
urx llx sub 0 A dtransform len /Sx ed
0 ury lly sub A dtransform len /Sy ed
llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed
rot dup sin abs /S ed cos abs /C ed
Sx S mul Sy C mul add /H ed
Sx C mul Sy S mul add /W ed
sy H div /Scaley ed
sx W div /Scalex ed
s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if
sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed
sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed
urx llx sub 0 A dtransform exch atan rot exch sub /rot ed
n currentmatrix initgraphics setmatrix
cx cy translate
Scalex Scaley scale
rot rotate
Cx neg Cy neg translate
A concat
bbox boxpath clip newpath
w 0 ne {gsave bbox boxpath 1 setgray fill grestore} if
end
gsave
%ps_include: inclusion begin

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
mark
/rotation 1 def
/gotpagebbox true def
/resolution 720 def
setup
2 setdecoding
/saveobj save def
mark
1 pagesetup
8 S f
(\347`` `` ``\347)2 5040 1 194 720 t
21 HB f
(READABILITY OF TEXT)2 2359 1 1534 1230 t
19 HB f
(Line Width and Leading for 10-Point Type)6 3750 1 839 1590 t
20 S f
(_ _____________________________________________)1 4534 1 447 2110 t
20 H f
( 2-Point 4-Point)2 1832( 1-Point)1 1083(Line Set)1 1234 3 692 2470 t
( Leading Leading)2 1832( Leading)1 1051(Width Solid)1 1372 3 626 2830 t
20 S f
(_ _____________________________________________)1 4534 1 447 2980 t
(_ _____________________________________________)1 4534 1 447 3000 t
20 H f
( \2615.3 \2617.1)2 1832( \2616.0)1 895( \2619.3)1 768(9 Pica)1 558 4 659 3350 t
( \2610.3 \2611.7)2 1832( \2610.6)1 895( \2614.5)1 768(14 Pica)1 670 4 547 3710 t
( \2612.0)1 916( 0.0)1 916( \2615.1)1 895( \2615.0)1 768(19 Pica)1 670 5 547 4070 t
( \2612.4 \2613.6)2 1832( \2613.8)1 895( \2613.7)1 768(31 Pica)1 670 4 547 4430 t
( \2615.9 \2618.8)2 1832( \2619.0)1 895( \2619.1)1 768(43 Pica)1 670 4 547 4790 t
20 S f
( \347)1 -4534(_ _____________________________________________)1 4534 2 447 4950 t
(\347)447 4910 w
(\347)447 4710 w
(\347)447 4510 w
(\347)447 4310 w
(\347)447 4110 w
(\347)447 3910 w
(\347)447 3710 w
(\347)447 3510 w
(\347)447 3310 w
(\347)447 3110 w
(\347)447 2910 w
(\347)447 2710 w
(\347)447 2510 w
(\347)447 2310 w
(\347)1307 4950 w
(\347)1307 4910 w
(\347)1307 4710 w
(\347)1307 4510 w
(\347)1307 4310 w
(\347)1307 4110 w
(\347)1307 3910 w
(\347)1307 3710 w
(\347)1307 3510 w
(\347)1307 3310 w
(\347)1307 3110 w
(\347)1307 2910 w
(\347)1307 2710 w
(\347)1307 2510 w
(\347)1307 2310 w
(\347)1327 4950 w
(\347)1327 4910 w
(\347)1327 4710 w
(\347)1327 4510 w
(\347)1327 4310 w
(\347)1327 4110 w
(\347)1327 3910 w
(\347)1327 3710 w
(\347)1327 3510 w
(\347)1327 3310 w
(\347)1327 3110 w
(\347)1327 2910 w
(\347)1327 2710 w
(\347)1327 2510 w
(\347)1327 2310 w
(\347)2233 4950 w
(\347)2233 4910 w
(\347)2233 4710 w
(\347)2233 4510 w
(\347)2233 4310 w
(\347)2233 4110 w
(\347)2233 3910 w
(\347)2233 3710 w
(\347)2233 3510 w
(\347)2233 3310 w
(\347)2233 3110 w
(\347)2233 2910 w
(\347)2233 2710 w
(\347)2233 2510 w
(\347)2233 2310 w
(\347)3149 4950 w
(\347)3149 4910 w
(\347)3149 4710 w
(\347)3149 4510 w
(\347)3149 4310 w
(\347)3149 4110 w
(\347)3149 3910 w
(\347)3149 3710 w
(\347)3149 3510 w
(\347)3149 3310 w
(\347)3149 3110 w
(\347)3149 2910 w
(\347)3149 2710 w
(\347)3149 2510 w
(\347)3149 2310 w
(\347)4065 4950 w
(\347)4065 4910 w
(\347)4065 4710 w
(\347)4065 4510 w
(\347)4065 4310 w
(\347)4065 4110 w
(\347)4065 3910 w
(\347)4065 3710 w
(\347)4065 3510 w
(\347)4065 3310 w
(\347)4065 3110 w
(\347)4065 2910 w
(\347)4065 2710 w
(\347)4065 2510 w
(\347)4065 2310 w
(\347)4981 4950 w
(\347)4981 4910 w
(\347)4981 4710 w
(\347)4981 4510 w
(\347)4981 4310 w
(\347)4981 4110 w
(\347)4981 3910 w
(\347)4981 3710 w
(\347)4981 3510 w
(\347)4981 3310 w
(\347)4981 3110 w
(\347)4981 2910 w
(\347)4981 2710 w
(\347)4981 2510 w
(\347)4981 2310 w
10 H f
(Example 10)1 530 1 4592 5580 t
8 S f
(\347__ __ __\347)2 5040 1 194 5683 t
10 H f
(Readability of Text)2 831 1 194 5923 t
(\(tbl sample\))1 523 1 194 6043 t
cleartomark
showpage
saveobj restore
done
%ps_include: inclusion end
grestore
PS-include-dict-dw begin
o 0 ne {gsave A defaultmatrix /A ed llx lly nice urx ury nice
	initgraphics 0.1 setlinewidth boxpath stroke grestore} if
clear o-stack aload pop
context end restore
%ps_include: end
/saveobj save def
mark
cleartomark
showpage
saveobj restore
%%EndPage: 11 11
%%Page: 12 12
/saveobj save def
mark
12 pagesetup
10 HB f
(A-12 MVIEW)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 11]
10 B f
(Example 11)1 503 1 720 960 t
cleartomark
saveobj restore
%ps_include: begin
save
/ed {exch def} def
{} /showpage ed
{} /copypage ed
{} /erasepage ed
{} /letter ed
currentdict /findfont known systemdict /findfont known and {
	/findfont systemdict /findfont get def
} if
36 dict dup /PS-include-dict-dw ed begin
/context ed
count array astore /o-stack ed
%ps_include: variables begin
/llx 8 def
/lly 172 def
/urx 533 def
/ury 738 def
/w 0 def
/o 1 def
/s 0 def
/cx 2880 def
/cy -3690 def
/sx 4320 def
/sy 4860 def
/ax 0.5 def
/ay 0.5 def
/rot -0 def
%ps_include: variables end
{llx lly urx ury} /bbox ed
{newpath 2 index exch 2 index exch dup 6 index exch
 moveto 3 {lineto} repeat closepath} /boxpath ed
{dup mul exch dup mul add sqrt} /len ed
{2 copy gt {exch} if pop} /min ed
{2 copy lt {exch} if pop} /max ed
{transform round exch round exch A itransform} /nice ed
{6 array} /n ed
n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed
urx llx sub 0 A dtransform len /Sx ed
0 ury lly sub A dtransform len /Sy ed
llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed
rot dup sin abs /S ed cos abs /C ed
Sx S mul Sy C mul add /H ed
Sx C mul Sy S mul add /W ed
sy H div /Scaley ed
sx W div /Scalex ed
s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if
sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed
sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed
urx llx sub 0 A dtransform exch atan rot exch sub /rot ed
n currentmatrix initgraphics setmatrix
cx cy translate
Scalex Scaley scale
rot rotate
Cx neg Cy neg translate
A concat
bbox boxpath clip newpath
w 0 ne {gsave bbox boxpath 1 setgray fill grestore} if
end
gsave
%ps_include: inclusion begin

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
mark
/rotation 1 def
/gotpagebbox true def
/resolution 720 def
setup
2 setdecoding
/saveobj save def
mark
1 pagesetup
8 S f
(\347`` `` ``\347)2 5040 1 194 720 t
29 B f
(Equations Are Easy)2 2468 1 1479 1752 t
28 R f
(You do not need to be a mathematician to)8 4671 1 378 2262 t
(format equations on the UNIX)4 3413 1 378 2602 t
24 S f
(\322)3791 2504 w
28 R f
(system.)4051 2602 w
(For example, the input)3 2531 1 378 2942 t
26 CW f
(sum from i=1 to n x sub i)7 3900 1 763 3452 t
28 R f
(produces)378 4044 w
20 I f
(i)1455 4315 w
20 S f
(=)1560 4315 w
20 R f
(1)1703 4315 w
29 S f
(S)1543 4116 w
20 I f
(n)1578 3875 w
24 I f
(x)1822 4044 w
20 I f
(i)1961 4092 w
28 R f
(on paper.)1 1038 1 2107 4044 t
(The eqn language makes it easy!)5 3650 1 378 4947 t
10 R f
(Example 11)1 480 1 4654 5580 t
8 S f
(\347__ __ __\347)2 5040 1 194 5683 t
10 R f
(Equations Are Easy)2 793 1 194 5923 t
(\(eqn sample\))1 518 1 194 6043 t
cleartomark
showpage
saveobj restore
done
%ps_include: inclusion end
grestore
PS-include-dict-dw begin
o 0 ne {gsave A defaultmatrix /A ed llx lly nice urx ury nice
	initgraphics 0.1 setlinewidth boxpath stroke grestore} if
clear o-stack aload pop
context end restore
%ps_include: end
/saveobj save def
mark
cleartomark
showpage
saveobj restore
%%EndPage: 12 12
%%Page: 13 13
/saveobj save def
mark
13 pagesetup
10 HB f
(MVIEW A-13)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 12]
10 B f
(Example 12)1 503 1 720 960 t
cleartomark
saveobj restore
%ps_include: begin
save
/ed {exch def} def
{} /showpage ed
{} /copypage ed
{} /erasepage ed
{} /letter ed
currentdict /findfont known systemdict /findfont known and {
	/findfont systemdict /findfont get def
} if
36 dict dup /PS-include-dict-dw ed begin
/context ed
count array astore /o-stack ed
%ps_include: variables begin
/llx 8 def
/lly 244 def
/urx 533 def
/ury 666 def
/w 0 def
/o 1 def
/s 0 def
/cx 2880 def
/cy -3420 def
/sx 4320 def
/sy 4320 def
/ax 0.5 def
/ay 0.5 def
/rot -0 def
%ps_include: variables end
{llx lly urx ury} /bbox ed
{newpath 2 index exch 2 index exch dup 6 index exch
 moveto 3 {lineto} repeat closepath} /boxpath ed
{dup mul exch dup mul add sqrt} /len ed
{2 copy gt {exch} if pop} /min ed
{2 copy lt {exch} if pop} /max ed
{transform round exch round exch A itransform} /nice ed
{6 array} /n ed
n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed
urx llx sub 0 A dtransform len /Sx ed
0 ury lly sub A dtransform len /Sy ed
llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed
rot dup sin abs /S ed cos abs /C ed
Sx S mul Sy C mul add /H ed
Sx C mul Sy S mul add /W ed
sy H div /Scaley ed
sx W div /Scalex ed
s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if
sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed
sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed
urx llx sub 0 A dtransform exch atan rot exch sub /rot ed
n currentmatrix initgraphics setmatrix
cx cy translate
Scalex Scaley scale
rot rotate
Cx neg Cy neg translate
A concat
bbox boxpath clip newpath
w 0 ne {gsave bbox boxpath 1 setgray fill grestore} if
end
gsave
%ps_include: inclusion begin

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
mark
/rotation 1 def
/gotpagebbox true def
/resolution 720 def
setup
2 setdecoding

/inpath false def
/savematrix matrix def

/Dl {
	inpath
		{pop pop neg lineto}
		{newpath neg moveto neg lineto stroke}
	ifelse
} bind def

/De {
	/y1 exch 2 div def
	/x1 exch 2 div def
	/savematrix savematrix currentmatrix def
	neg exch x1 add exch translate
	x1 y1 scale
	0 0 1 0 360
	inpath
		{1 0 moveto arc savematrix setmatrix}
		{newpath arc savematrix setmatrix stroke}
	ifelse
} bind def

/Da {
	/dy2 exch def
	/dx2 exch def
	/dy1 exch def
	/dx1 exch def
	dy1 add neg exch dx1 add exch
	dx1 dx1 mul dy1 dy1 mul add sqrt
	dy1 dx1 neg atan
	dy2 neg dx2 atan
	inpath
		{arc}
		{newpath arc stroke}
	ifelse
} bind def

/DA {
	/dy2 exch def
	/dx2 exch def
	/dy1 exch def
	/dx1 exch def
	dy1 add neg exch dx1 add exch
	dx1 dx1 mul dy1 dy1 mul add sqrt
	dy1 dx1 neg atan
	dy2 neg dx2 atan
	inpath
		{arcn}
		{newpath arcn stroke}
	ifelse
} bind def

/Ds {
	/y2 exch def
	/x2 exch def
	/y1 exch def
	/x1 exch def
	/y0 exch def
	/x0 exch def
	x0 5 x1 mul add 6 div
	y0 5 y1 mul add -6 div
	x2 5 x1 mul add 6 div
	y2 5 y1 mul add -6 div
	x1 x2 add 2 div
	y1 y2 add -2 div
	inpath
		{curveto}
		{newpath x0 x1 add 2 div y0 y1 add -2 div moveto curveto stroke}
	ifelse
} bind def
/saveobj save def
mark
1 pagesetup
8 S f
(\347`` `` ``\347)2 5040 1 194 1440 t
21 HB f
(A Working Model)2 1716 1 1856 2610 t
cleartomark
saveobj restore

/inpath false def
/savematrix matrix def

/Dl {
	inpath
		{pop pop neg lineto}
		{newpath neg moveto neg lineto stroke}
	ifelse
} bind def

/De {
	/y1 exch 2 div def
	/x1 exch 2 div def
	/savematrix savematrix currentmatrix def
	neg exch x1 add exch translate
	x1 y1 scale
	0 0 1 0 360
	inpath
		{1 0 moveto arc savematrix setmatrix}
		{newpath arc savematrix setmatrix stroke}
	ifelse
} bind def

/Da {
	/dy2 exch def
	/dx2 exch def
	/dy1 exch def
	/dx1 exch def
	dy1 add neg exch dx1 add exch
	dx1 dx1 mul dy1 dy1 mul add sqrt
	dy1 dx1 neg atan
	dy2 neg dx2 atan
	inpath
		{arc}
		{newpath arc stroke}
	ifelse
} bind def

/DA {
	/dy2 exch def
	/dx2 exch def
	/dy1 exch def
	/dx1 exch def
	dy1 add neg exch dx1 add exch
	dx1 dx1 mul dy1 dy1 mul add sqrt
	dy1 dx1 neg atan
	dy2 neg dx2 atan
	inpath
		{arcn}
		{newpath arcn stroke}
	ifelse
} bind def

/Ds {
	/y2 exch def
	/x2 exch def
	/y1 exch def
	/x1 exch def
	/y0 exch def
	/x0 exch def
	x0 5 x1 mul add 6 div
	y0 5 y1 mul add -6 div
	x2 5 x1 mul add 6 div
	y2 5 y1 mul add -6 div
	x1 x2 add 2 div
	y1 y2 add -2 div
	inpath
		{curveto}
		{newpath x0 x1 add 2 div y0 y1 add -2 div moveto curveto stroke}
	ifelse
} bind def
/saveobj save def
mark
20 H f
1004 3360 644 3360 Dl
1004 3360 932 3378 Dl
1004 3360 932 3342 Dl
1004 3090 1004 3630 Dl
1904 3090 1004 3090 Dl
1904 3630 1904 3090 Dl
1004 3630 1904 3630 Dl
(input)1236 3400 w
2264 3360 1904 3360 Dl
2264 3360 2192 3378 Dl
2264 3360 2192 3342 Dl
2264 3090 2264 3630 Dl
3164 3090 2264 3090 Dl
3164 3630 3164 3090 Dl
2264 3630 3164 3630 Dl
(process)2363 3400 w
3524 3360 3164 3360 Dl
3524 3360 3452 3378 Dl
3524 3360 3452 3342 Dl
3524 3090 3524 3630 Dl
4424 3090 3524 3090 Dl
4424 3630 4424 3090 Dl
3524 3630 4424 3630 Dl
(output)3694 3400 w
4784 3360 4424 3360 Dl
4784 3360 4712 3378 Dl
4784 3360 4712 3342 Dl
10 H f
(Example 12)1 530 1 4592 4860 t
8 S f
(\347__ __ __\347)2 5040 1 194 4963 t
10 H f
(A Working Model)2 763 1 194 5203 t
(\(pic sample\))1 545 1 194 5323 t
cleartomark
showpage
saveobj restore
done
%ps_include: inclusion end
grestore
PS-include-dict-dw begin
o 0 ne {gsave A defaultmatrix /A ed llx lly nice urx ury nice
	initgraphics 0.1 setlinewidth boxpath stroke grestore} if
clear o-stack aload pop
context end restore
%ps_include: end
/saveobj save def
mark
cleartomark
showpage
saveobj restore
%%EndPage: 13 13
%%Page: 14 14
/saveobj save def
mark
14 pagesetup
10 HB f
(A-14 MVIEW)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 13]
10 B f
(Example 13)1 503 1 720 960 t
cleartomark
saveobj restore
%ps_include: begin
save
/ed {exch def} def
{} /showpage ed
{} /copypage ed
{} /erasepage ed
{} /letter ed
currentdict /findfont known systemdict /findfont known and {
	/findfont systemdict /findfont get def
} if
36 dict dup /PS-include-dict-dw ed begin
/context ed
count array astore /o-stack ed
%ps_include: variables begin
/llx 8 def
/lly 172 def
/urx 533 def
/ury 738 def
/w 0 def
/o 1 def
/s 0 def
/cx 2880 def
/cy -3690 def
/sx 4320 def
/sy 4860 def
/ax 0.5 def
/ay 0.5 def
/rot -0 def
%ps_include: variables end
{llx lly urx ury} /bbox ed
{newpath 2 index exch 2 index exch dup 6 index exch
 moveto 3 {lineto} repeat closepath} /boxpath ed
{dup mul exch dup mul add sqrt} /len ed
{2 copy gt {exch} if pop} /min ed
{2 copy lt {exch} if pop} /max ed
{transform round exch round exch A itransform} /nice ed
{6 array} /n ed
n defaultmatrix n currentmatrix n invertmatrix n concatmatrix /A ed
urx llx sub 0 A dtransform len /Sx ed
0 ury lly sub A dtransform len /Sy ed
llx urx add 2 div lly ury add 2 div A transform /Cy ed /Cx ed
rot dup sin abs /S ed cos abs /C ed
Sx S mul Sy C mul add /H ed
Sx C mul Sy S mul add /W ed
sy H div /Scaley ed
sx W div /Scalex ed
s 0 eq {Scalex Scaley min dup /Scalex ed /Scaley ed} if
sx Scalex W mul sub 0 max ax 0.5 sub mul cx add /cx ed
sy Scaley H mul sub 0 max ay 0.5 sub mul cy add /cy ed
urx llx sub 0 A dtransform exch atan rot exch sub /rot ed
n currentmatrix initgraphics setmatrix
cx cy translate
Scalex Scaley scale
rot rotate
Cx neg Cy neg translate
A concat
bbox boxpath clip newpath
w 0 ne {gsave bbox boxpath 1 setgray fill grestore} if
end
gsave
%ps_include: inclusion begin

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
mark
/rotation 1 def
/gotpagebbox true def
/resolution 720 def
setup
2 setdecoding

/inpath false def
/savematrix matrix def

/Dl {
	inpath
		{pop pop neg lineto}
		{newpath neg moveto neg lineto stroke}
	ifelse
} bind def

/De {
	/y1 exch 2 div def
	/x1 exch 2 div def
	/savematrix savematrix currentmatrix def
	neg exch x1 add exch translate
	x1 y1 scale
	0 0 1 0 360
	inpath
		{1 0 moveto arc savematrix setmatrix}
		{newpath arc savematrix setmatrix stroke}
	ifelse
} bind def

/Da {
	/dy2 exch def
	/dx2 exch def
	/dy1 exch def
	/dx1 exch def
	dy1 add neg exch dx1 add exch
	dx1 dx1 mul dy1 dy1 mul add sqrt
	dy1 dx1 neg atan
	dy2 neg dx2 atan
	inpath
		{arc}
		{newpath arc stroke}
	ifelse
} bind def

/DA {
	/dy2 exch def
	/dx2 exch def
	/dy1 exch def
	/dx1 exch def
	dy1 add neg exch dx1 add exch
	dx1 dx1 mul dy1 dy1 mul add sqrt
	dy1 dx1 neg atan
	dy2 neg dx2 atan
	inpath
		{arcn}
		{newpath arcn stroke}
	ifelse
} bind def

/Ds {
	/y2 exch def
	/x2 exch def
	/y1 exch def
	/x1 exch def
	/y0 exch def
	/x0 exch def
	x0 5 x1 mul add 6 div
	y0 5 y1 mul add -6 div
	x2 5 x1 mul add 6 div
	y2 5 y1 mul add -6 div
	x1 x2 add 2 div
	y1 y2 add -2 div
	inpath
		{curveto}
		{newpath x0 x1 add 2 div y0 y1 add -2 div moveto curveto stroke}
	ifelse
} bind def
/saveobj save def
mark
1 pagesetup
8 S f
(\347`` `` ``\347)2 5040 1 194 720 t
21 HB f
(1984 Age Distribution in U.S.)4 2880 1 1274 1908 t
cleartomark
saveobj restore

/inpath false def
/savematrix matrix def

/Dl {
	inpath
		{pop pop neg lineto}
		{newpath neg moveto neg lineto stroke}
	ifelse
} bind def

/De {
	/y1 exch 2 div def
	/x1 exch 2 div def
	/savematrix savematrix currentmatrix def
	neg exch x1 add exch translate
	x1 y1 scale
	0 0 1 0 360
	inpath
		{1 0 moveto arc savematrix setmatrix}
		{newpath arc savematrix setmatrix stroke}
	ifelse
} bind def

/Da {
	/dy2 exch def
	/dx2 exch def
	/dy1 exch def
	/dx1 exch def
	dy1 add neg exch dx1 add exch
	dx1 dx1 mul dy1 dy1 mul add sqrt
	dy1 dx1 neg atan
	dy2 neg dx2 atan
	inpath
		{arc}
		{newpath arc stroke}
	ifelse
} bind def

/DA {
	/dy2 exch def
	/dx2 exch def
	/dy1 exch def
	/dx1 exch def
	dy1 add neg exch dx1 add exch
	dx1 dx1 mul dy1 dy1 mul add sqrt
	dy1 dx1 neg atan
	dy2 neg dx2 atan
	inpath
		{arcn}
		{newpath arcn stroke}
	ifelse
} bind def

/Ds {
	/y2 exch def
	/x2 exch def
	/y1 exch def
	/x1 exch def
	/y0 exch def
	/x0 exch def
	x0 5 x1 mul add 6 div
	y0 5 y1 mul add -6 div
	x2 5 x1 mul add 6 div
	y2 5 y1 mul add -6 div
	x1 x2 add 2 div
	y1 y2 add -2 div
	inpath
		{curveto}
		{newpath x0 x1 add 2 div y0 y1 add -2 div moveto curveto stroke}
	ifelse
} bind def
/saveobj save def
mark
20 H f
2120 2388 2120 3828 Dl
4280 2388 2120 2388 Dl
4280 3828 4280 2388 Dl
2120 3828 4280 3828 Dl
2120 3900 2120 3828 Dl
(-0)2031 4030 w
2605 3900 2605 3828 Dl
(20)2493 4030 w
3090 3900 3090 3828 Dl
(40)2978 4030 w
3575 3900 3575 3828 Dl
(60)3463 4030 w
4061 3900 4061 3828 Dl
(80)3949 4030 w
2048 3828 2120 3828 Dl
(-0)1814 3868 w
2048 3540 2120 3540 Dl
(1)1880 3580 w
2048 3252 2120 3252 Dl
(2)1880 3292 w
2048 2964 2120 2964 Dl
(3)1880 3004 w
2048 2676 2120 2676 Dl
(4)1880 2716 w
2048 2388 2120 2388 Dl
(5)1880 2428 w
18 H f
(Population)900 3028 w
(\(in millions\))1 910 1 873 3268 t
(1984 Age)1 777 1 2812 4312 t
20 H f
2144 2761 2120 2786 Dl
2168 2781 2144 2760 Dl
2192 2809 2168 2782 Dl
2216 2886 2192 2810 Dl
2241 2898 2217 2886 Dl
2265 2911 2241 2899 Dl
2289 2922 2265 2912 Dl
2313 2918 2289 2923 Dl
2338 2932 2314 2917 Dl
2362 2885 2338 2932 Dl
2386 2851 2362 2885 Dl
2411 2745 2387 2850 Dl
2434 2757 2410 2745 Dl
2459 2796 2435 2758 Dl
2483 2814 2459 2796 Dl
2508 2778 2484 2814 Dl
2532 2738 2508 2778 Dl
2556 2659 2532 2738 Dl
2581 2624 2557 2658 Dl
2604 2612 2580 2624 Dl
2629 2604 2605 2611 Dl
2653 2547 2629 2604 Dl
2678 2564 2654 2546 Dl
2702 2593 2678 2564 Dl
2726 2593 2702 2593 Dl
2750 2617 2726 2593 Dl
2774 2628 2750 2618 Dl
2799 2641 2775 2629 Dl
2823 2682 2799 2642 Dl
2848 2694 2824 2682 Dl
2871 2760 2847 2696 Dl
2896 2738 2872 2760 Dl
2920 2754 2896 2737 Dl
2944 2789 2920 2755 Dl
2969 2759 2945 2789 Dl
2993 2775 2969 2758 Dl
3017 3004 2993 2776 Dl
3041 2992 3017 3004 Dl
3066 2985 3042 2992 Dl
3090 2969 3066 2984 Dl
3114 3079 3090 2969 Dl
3163 3116 3115 3079 Dl
3187 3143 3163 3117 Dl
3211 3158 3187 3144 Dl
3236 3183 3212 3158 Dl
3260 3176 3236 3183 Dl
3284 3181 3260 3176 Dl
3308 3211 3284 3182 Dl
3333 3188 3309 3211 Dl
3357 3204 3333 3187 Dl
3381 3160 3357 3205 Dl
3406 3152 3382 3159 Dl
3430 3166 3406 3151 Dl
3454 3148 3430 3167 Dl
3478 3154 3454 3147 Dl
3503 3146 3479 3154 Dl
3527 3140 3503 3146 Dl
3551 3156 3527 3139 Dl
3576 3161 3552 3156 Dl
3599 3157 3575 3162 Dl
3624 3179 3600 3156 Dl
3648 3205 3624 3180 Dl
3673 3230 3649 3205 Dl
3697 3249 3673 3231 Dl
3721 3271 3697 3249 Dl
3746 3277 3722 3272 Dl
3769 3279 3745 3277 Dl
3794 3304 3770 3279 Dl
3818 3320 3794 3306 Dl
3843 3344 3819 3320 Dl
3866 3360 3842 3344 Dl
3891 3391 3867 3361 Dl
3915 3413 3891 3391 Dl
3939 3432 3915 3413 Dl
3964 3464 3940 3433 Dl
3988 3480 3964 3465 Dl
4013 3508 3989 3480 Dl
4036 3531 4012 3508 Dl
4061 3554 4037 3532 Dl
4085 3589 4061 3554 Dl
4109 3577 4085 3589 Dl
4134 3619 4110 3576 Dl
4158 3642 4134 3619 Dl
4182 3664 4158 3643 Dl
4206 3676 4182 3665 Dl
4231 3690 4207 3676 Dl
4255 3708 4231 3690 Dl
4279 3727 4255 3709 Dl
10 H f
(Example 13)1 530 1 4592 5580 t
8 S f
(\347__ __ __\347)2 5040 1 194 5683 t
10 H f
(Age Distribution)1 708 1 194 5923 t
(\(grap sample\))1 618 1 194 6043 t
cleartomark
showpage
saveobj restore
done
%ps_include: inclusion end
grestore
PS-include-dict-dw begin
o 0 ne {gsave A defaultmatrix /A ed llx lly nice urx ury nice
	initgraphics 0.1 setlinewidth boxpath stroke grestore} if
clear o-stack aload pop
context end restore
%ps_include: end
/saveobj save def
mark
cleartomark
showpage
saveobj restore
%%EndPage: 14 14
%%Trailer
done
%%Pages: 14
%%DocumentFonts: Helvetica-Bold Times-Bold Times-Italic Times-Roman Symbol Times-Roman
