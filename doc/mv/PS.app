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
(The examples in this appendix show how to use individual features of)11 2794 1 720 1350 t
9 R f
(MV)3537 1350 w
10 R f
( use a combination of)4 864(, and how to)3 494 2 3682 1350 t
(features as well as)3 728 1 720 1470 t
10 I f
(troff)1473 1470 w
10 R f
(preprocessors to produce view graphs of varying complexity.)7 2445 1 1671 1470 t
( input for Examples 3 through 8 precede the output.)9 2064( The)1 205(The input for Examples 1 and 2 is given in \2472.)10 1857 3 720 1650 t
( graph was formatted by)4 998(Each view)1 424 2 720 1830 t
10 I f
(troff)2174 1830 w
10 R f
(with the)1 332 1 2379 1830 t
9 R f
(MV)2741 1830 w
10 R f
(package, and postprocessed by)3 1251 1 2918 1830 t
10 I f
(dpost)4201 1830 w
10 R f
(; preprocessing)1 614 1 4426 1830 t
( output sample, originally generated as a full-page PostScript)8 2519( Each)1 259( as needed.)2 460(was performed,)1 629 4 720 1950 t
6 S f
(\322)4587 1910 w
10 R f
(image, is)1 371 1 4669 1950 t
( boxed, and merged onto the page using the)8 1907(automatically scaled to size,)3 1192 2 720 2070 t
10 I f
(mpictures)3865 2070 w
10 R f
(PostScript picture)1 735 1 4305 2070 t
( such, the frame dimensions and point sizes used for text shown in the output samples)15 3455( As)1 163(inclusion facility.)1 702 3 720 2190 t
(may differ from those speci\256ed in the input samples; the original full-page output samples are true to form.)17 4278 1 720 2310 t
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
(A-2 MV)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 1:  Output]
10 B f
( Output)1 362(Example 1:)1 486 2 720 960 t
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
/llx -10 def
/lly 207 def
/urx 563 def
/ury 800 def
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
(\257)0 100 w
8 H f
(cut)78 100 w
8 S f
(\257 \257)1 5099 1 215 100 t
8 H f
(cut)5344 100 w
8 S f
(\257)5481 100 w
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 200 t
8 H f
(3/13/2016)4889 350 w
(XYZ, Inc.)1 338 1 4910 450 t
(FOIL 1)1 253 1 4995 550 t
8 S f
(_ _)1 5328 1 72 1064 t
8 H f
(+ +)1 5083 1 165 920 t
14 H f
(Six stages of a project:)4 1470 1 576 1296 t
11 S f
(\267)576 1558 w
14 H f
(wild enthusiasm)1 1009 1 727 1558 t
11 S f
(\267)576 1820 w
14 H f
(disillusionment)727 1820 w
11 S f
(\267)576 2082 w
14 H f
(total confusion)1 917 1 727 2082 t
11 S f
(\267)576 2344 w
14 H f
(search for the guilty)3 1261 1 727 2344 t
11 S f
(\267)576 2606 w
14 H f
(punishment of the innocent)3 1722 1 727 2606 t
11 S f
(\267)576 2868 w
14 H f
(promotion of the non-participants)3 2086 1 727 2868 t
8 H f
(+ +)1 5083 1 165 4520 t
8 S f
(_ _)1 5328 1 72 4376 t
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 5600 t
8 S f
(\255)0 5700 w
8 H f
(cut)78 5700 w
8 S f
(\255 \255)1 5099 1 215 5700 t
8 H f
(cut)5344 5700 w
8 S f
(\255)5481 5700 w
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
(MV A-3)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 2:  Output]
10 B f
( Output)1 362(Example 2:)1 486 2 720 960 t
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
/llx -10 def
/lly 207 def
/urx 563 def
/ury 800 def
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
(\257)0 100 w
8 H f
(cut)78 100 w
8 S f
(\257 \257)1 5099 1 215 100 t
8 H f
(cut)5344 100 w
8 S f
(\257)5481 100 w
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 200 t
8 H f
(April 1, 1990)2 468 1 4780 350 t
(Less Trivial)1 414 1 4834 450 t
(FOIL 2)1 253 1 4995 550 t
8 S f
(_ _)1 5328 1 72 1064 t
8 H f
(+ +)1 5083 1 165 920 t
18 H f
(What the Walrus Said)3 1797 1 1837 1152 t
14 H f
(``The time has come,'' the Walrus said,)6 2474 1 576 1414 t
(``To talk of many things:)4 1523 1 576 1589 t
11 S f
(\267)936 1851 w
14 H f
(Of shoes\320and ships\320and sealing wax\320)4 2638 1 1087 1851 t
11 S f
(\267)936 2113 w
14 H f
(Of cabbages\320and kings\320)2 1701 1 1087 2113 t
11 S f
(\267)936 2375 w
14 H f
(And why the sea is boiling hot\320)6 2073 1 1087 2375 t
11 S f
(\267)936 2637 w
14 H f
(And whether pigs have wings.'')4 1976 1 1087 2637 t
8 H f
(+ +)1 5083 1 165 4520 t
8 S f
(_ _)1 5328 1 72 4376 t
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 5600 t
8 S f
(\255)0 5700 w
8 H f
(cut)78 5700 w
8 S f
(\255 \255)1 5099 1 215 5700 t
8 H f
(cut)5344 5700 w
8 S f
(\255)5481 5700 w
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
(A-4 MV)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 3:  Input]
10 B f
( Input)1 290(Example 3:)1 486 2 720 960 t
9 CW f
(.Vh 3 "Levels & Marks")4 1188 1 870 1130 t
(.T "Foil Levels & Level Marks")5 1620 1 870 1240 t
(This is the .A \(left margin\) level;)6 1890 1 870 1350 t
(.B)870 1460 w
(this is the .B level,)4 1134 1 870 1570 t
(.B)870 1680 w
(as is this;)2 594 1 870 1790 t
(.C)870 1900 w
(this is the .C level,)4 1134 1 870 2010 t
(.C)870 2120 w
(as is this;)2 594 1 870 2230 t
(.D)870 2340 w
(and this is the .D level,)5 1350 1 870 2450 t
(.D)870 2560 w
(as is this.)2 594 1 870 2670 t
(.A)870 2780 w
(The large bullet, the dash, and the small)7 2214 1 870 2890 t
(bullet are the default ``marks'' for)5 1944 1 870 3000 t
(levels .B, .C, and .D, respectively.)5 1944 1 870 3110 t
(However, these three levels can also)5 1944 1 870 3220 t
(be marked arbitrarily:)2 1188 1 870 3330 t
(.B B.)1 270 1 870 3440 t
(Like this \(this is the .B level\);)6 1782 1 870 3550 t
(.C 3.)1 270 1 870 3660 t
(like this \(this is the .C level\);)6 1782 1 870 3770 t
(.D d.)1 270 1 870 3880 t
(like this \(this is the .D level\), or)7 1944 1 870 3990 t
(.D iv.)1 324 1 870 4100 t
(like this, or even)3 972 1 870 4210 t
(.D \\\(rh-\\\(bu +4)2 810 1 870 4320 t
(like this.)1 540 1 870 4430 t
(.A)870 4540 w
(The .A level cannot be marked.)5 1620 1 870 4650 t
(.B)870 4760 w
(An arbitrary number of lines of text)6 1944 1 870 4870 t
(can be included in any item at any level;)8 2214 1 870 4980 t
(the text will be filled, but neither adjusted)7 2430 1 870 5090 t
(nor hyphenated, just like this .B level item.)7 2430 1 870 5200 t
cleartomark
showpage
saveobj restore
%%EndPage: 4 4
%%Page: 5 5
/saveobj save def
mark
5 pagesetup
10 HB f
(MV A-5)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 3:  Output]
10 B f
( Output)1 362(Example 3:)1 486 2 720 960 t
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
/llx -10 def
/lly 63 def
/urx 563 def
/ury 800 def
/w 0 def
/o 1 def
/s 0 def
/cx 2880 def
/cy -4140 def
/sx 4320 def
/sy 5760 def
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
/build_rh {
pop
gsave
size .0022 mul dup scale
currentpoint translate

15 66 moveto
15 86 lineto
16 131 lineto
17 146 lineto
18 158 lineto
19 167 lineto
21 181 lineto
24 190 lineto
34 193 lineto
49 189 lineto
58 182 lineto
60 177 lineto
60 166 lineto
59 156 lineto
58 143 lineto
57 130 lineto
56 117 lineto
55 102 lineto
54 42 lineto
53 39 lineto
49 35 lineto
34 34 lineto
19 39 lineto
16 47 lineto
15 66 lineto
stroke

65 60 moveto
65 111 lineto
66 127 lineto
67 139 lineto
69 153 lineto
72 163 lineto
83 171 lineto
98 177 lineto
113 182 lineto
128 187 lineto
143 190 lineto
158 194 lineto
173 196 lineto
188 199 lineto
203 201 lineto
218 203 lineto
233 205 lineto
248 205 lineto
263 206 lineto
278 206 lineto
293 206 lineto
308 206 lineto
323 206 lineto
338 205 lineto
353 203 lineto
368 202 lineto
383 200 lineto
394 197 lineto
389 190 lineto
389 180 lineto
391 176 lineto
391 173 lineto
380 173 lineto
365 173 lineto
350 174 lineto
335 175 lineto
320 176 lineto
305 176 lineto
290 176 lineto
275 177 lineto
260 177 lineto
245 177 lineto
240 173 lineto
240 170 lineto
245 165 lineto
260 164 lineto
275 164 lineto
290 164 lineto
305 163 lineto
320 160 lineto
327 155 lineto
330 149 lineto
330 134 lineto
328 129 lineto
323 124 lineto
309 121 lineto
294 121 lineto
279 121 lineto
264 121 lineto
249 121 lineto
234 121 lineto
228 118 lineto
228 112 lineto
234 109 lineto
249 109 lineto
264 109 lineto
279 108 lineto
294 108 lineto
306 104 lineto
311 97 lineto
312 91 lineto
312 88 lineto
311 82 lineto
305 74 lineto
290 72 lineto
275 72 lineto
260 72 lineto
245 73 lineto
230 73 lineto
215 73 lineto
205 70 lineto
205 63 lineto
217 60 lineto
232 60 lineto
247 60 lineto
262 60 lineto
277 57 lineto
283 52 lineto
285 44 lineto
285 41 lineto
284 35 lineto
280 30 lineto
268 26 lineto
253 25 lineto
238 26 lineto
223 28 lineto
208 31 lineto
193 33 lineto
178 34 lineto
163 33 lineto
148 31 lineto
133 28 lineto
118 27 lineto
103 28 lineto
88 34 lineto
73 43 lineto
67 52 lineto
65 60 lineto
stroke

396 180 moveto
396 188 lineto
399 194 lineto
410 196 lineto
416 190 lineto
416 180 lineto
415 177 lineto
411 173 lineto
400 173 lineto
396 180 lineto
stroke

grestore
} def
/saveobj save def
mark
1 pagesetup
8 S f
(\257)0 100 w
8 H f
(cut)78 100 w
8 S f
(\257 \257)1 5099 1 215 100 t
8 H f
(cut)5344 100 w
8 S f
(\257)5481 100 w
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 200 t
8 H f
(3/13/2016)4889 350 w
(Levels & Marks)2 564 1 4684 450 t
(FOIL 3)1 253 1 4995 550 t
8 S f
(\357 \357)1 3333 1 1051 690 t
8 H f
(+ +)1 3643 1 885 920 t
18 H f
(Foil Levels & Level Marks)4 2125 1 1673 1152 t
14 H f
(This is the .A \(left margin\) level;)6 2038 1 1224 1414 t
11 S f
(\267)1224 1676 w
14 H f
(this is the .B level,)4 1182 1 1375 1676 t
11 S f
(\267)1224 1938 w
14 H f
(as is this;)2 610 1 1375 1938 t
11 H f
(\320)1375 2200 w
14 H f
(this is the .C level,)4 1189 1 1585 2200 t
11 H f
(\320)1375 2462 w
14 H f
(as is this;)2 610 1 1585 2462 t
7 S f
(\267)1585 2637 w
14 H f
(and this is the .D level,)5 1475 1 1680 2637 t
7 S f
(\267)1585 2812 w
14 H f
(as is this.)2 610 1 1680 2812 t
(The large bullet, the dash, and the small bullet)8 2970 1 1224 3074 t
(are the default ``marks'' for levels .B, .C, and)8 2844 1 1224 3249 t
( these three levels)3 1176( However,)1 695(.D, respectively.)1 1009 3 1224 3424 t
(can also be marked arbitrarily:)4 1926 1 1224 3599 t
(B. Like this \(this is the .B level\);)7 2038 1 1224 3861 t
(3. like this \(this is the .C level\);)7 1982 1 1416 4123 t
(d. like this \(this is the .D level\), or)8 2158 1 1511 4298 t
(iv. like this, or even)4 1243 1 1488 4473 t
18 S1 f
()1350 4648 w
cleartomark
saveobj restore
/build_rh {
pop
gsave
size .0022 mul dup scale
currentpoint translate

15 66 moveto
15 86 lineto
16 131 lineto
17 146 lineto
18 158 lineto
19 167 lineto
21 181 lineto
24 190 lineto
34 193 lineto
49 189 lineto
58 182 lineto
60 177 lineto
60 166 lineto
59 156 lineto
58 143 lineto
57 130 lineto
56 117 lineto
55 102 lineto
54 42 lineto
53 39 lineto
49 35 lineto
34 34 lineto
19 39 lineto
16 47 lineto
15 66 lineto
stroke

65 60 moveto
65 111 lineto
66 127 lineto
67 139 lineto
69 153 lineto
72 163 lineto
83 171 lineto
98 177 lineto
113 182 lineto
128 187 lineto
143 190 lineto
158 194 lineto
173 196 lineto
188 199 lineto
203 201 lineto
218 203 lineto
233 205 lineto
248 205 lineto
263 206 lineto
278 206 lineto
293 206 lineto
308 206 lineto
323 206 lineto
338 205 lineto
353 203 lineto
368 202 lineto
383 200 lineto
394 197 lineto
389 190 lineto
389 180 lineto
391 176 lineto
391 173 lineto
380 173 lineto
365 173 lineto
350 174 lineto
335 175 lineto
320 176 lineto
305 176 lineto
290 176 lineto
275 177 lineto
260 177 lineto
245 177 lineto
240 173 lineto
240 170 lineto
245 165 lineto
260 164 lineto
275 164 lineto
290 164 lineto
305 163 lineto
320 160 lineto
327 155 lineto
330 149 lineto
330 134 lineto
328 129 lineto
323 124 lineto
309 121 lineto
294 121 lineto
279 121 lineto
264 121 lineto
249 121 lineto
234 121 lineto
228 118 lineto
228 112 lineto
234 109 lineto
249 109 lineto
264 109 lineto
279 108 lineto
294 108 lineto
306 104 lineto
311 97 lineto
312 91 lineto
312 88 lineto
311 82 lineto
305 74 lineto
290 72 lineto
275 72 lineto
260 72 lineto
245 73 lineto
230 73 lineto
215 73 lineto
205 70 lineto
205 63 lineto
217 60 lineto
232 60 lineto
247 60 lineto
262 60 lineto
277 57 lineto
283 52 lineto
285 44 lineto
285 41 lineto
284 35 lineto
280 30 lineto
268 26 lineto
253 25 lineto
238 26 lineto
223 28 lineto
208 31 lineto
193 33 lineto
178 34 lineto
163 33 lineto
148 31 lineto
133 28 lineto
118 27 lineto
103 28 lineto
88 34 lineto
73 43 lineto
67 52 lineto
65 60 lineto
stroke

396 180 moveto
396 188 lineto
399 194 lineto
410 196 lineto
416 190 lineto
416 180 lineto
415 177 lineto
411 173 lineto
400 173 lineto
396 180 lineto
stroke

grestore
} def
/saveobj save def
mark
18 S1 f
1350 4648 m
180 build_rh
1530 4648 m
18 S f
(\267)1530 4648 w
14 H f
(like this.)1 519 1 1680 4648 t
(The .A level cannot be marked.)5 2004 1 1224 4910 t
11 S f
(\267)1224 5172 w
14 H f
(An arbitrary number of lines of text can be)8 2704 1 1375 5172 t
(included in any item at any level; the text)8 2628 1 1375 5347 t
(will be filled, but neither adjusted nor)6 2344 1 1375 5522 t
(hyphenated, just like this .B level item.)6 2454 1 1375 5697 t
8 H f
(+ +)1 3643 1 885 5960 t
8 S f
(\357 \357)1 3333 1 1051 6190 t
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 7040 t
8 S f
(\255)0 7140 w
8 H f
(cut)78 7140 w
8 S f
(\255 \255)1 5099 1 215 7140 t
8 H f
(cut)5344 7140 w
8 S f
(\255)5481 7140 w
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
(A-6 MV)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 4:  Input]
10 B f
( Input)1 290(Example 4:)1 486 2 720 960 t
9 CW f
(.DF 1 R 2 I 3 B)6 810 1 870 1130 t
(.VS 4 Complex)2 702 1 870 1240 t
(.T "Of Bits & Bytes & Words")6 1512 1 870 1350 t
(.S -4)1 270 1 870 1460 t
(.I 3 A x)3 432 1 870 1570 t
(.ul 3)1 270 1 870 1680 t
(But let your communication be, Yea, yea;)6 2160 1 870 1790 t
(Nay, nay: for whatsoever is more than these)7 2322 1 870 1900 t
(cometh of evil.*)2 864 1 870 2010 t
(.I +1 a nospace)3 810 1 870 2120 t
(Matthew 5:37)1 648 1 870 2230 t
(.BR)870 2340 w
(.S)870 2450 w
(.I 0 .A)2 378 1 870 2560 t
(Binary notation has been around for a)6 1998 1 870 2670 t
(.S +6)1 270 1 870 2780 t
(long)870 2890 w
(.S)870 3000 w
(time.)870 3110 w
(.B)870 3220 w
(The above verse tells us to use:)6 1728 1 870 3330 t
(.C 1\))1 270 1 870 3440 t
(binary notation,)1 864 1 870 3550 t
(.ul)870 3660 w
(and)870 3770 w
(.C 2\))1 270 1 870 3880 t
(redundancy)870 3990 w
(.D \\\(rh)1 378 1 870 4100 t
(\(in communicating\))1 972 1 870 4210 t
(.B)870 4320 w
(Binary notation is)2 972 1 870 4430 t
(.U not)1 324 1 870 4540 t
(suited for human use, above verse to)6 1944 1 870 4650 t
(the contrary notwithstanding.)2 1566 1 870 4760 t
(.S -2)1 270 1 870 4870 t
(.TS)870 4980 w
(box;)870 5090 w
(cb | cb | cb | cb)6 918 1 870 5200 t
( n.)1 162( |)1 162( n)1 108( |)1 162( n)1 108(l |)1 216 6 870 5310 t
( Bits/Word)1 666( Bytes/Word)1 774(System Bits/Byte)1 846 3 870 5420 t
(_)870 5530 w
( 6 36)2 774(IBM-7090/94 6)1 774 2 870 5640 t
( 4 32)2 774(IBM-360/370 8)1 774 2 870 5750 t
( 2 16)2 774(PDP-11/70 8)1 774 2 870 5860 t
(.TE)870 5970 w
(.S)870 6080 w
(.S -4)1 270 1 870 6190 t
( ")1 702(.U ")1 216 2 870 6300 t
(.BR)870 6410 w
(* The use of this verse in this context)8 2106 1 870 6520 t
(is plagiarized from C. Shannon.)4 1674 1 870 6630 t
(.S)870 6740 w
cleartomark
showpage
saveobj restore
%%EndPage: 6 6
%%Page: 7 7
/saveobj save def
mark
7 pagesetup
10 HB f
(MV A-7)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 4:  Output]
10 B f
( Output)1 362(Example 4:)1 486 2 720 960 t
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
/llx -10 def
/lly 63 def
/urx 563 def
/ury 800 def
/w 0 def
/o 1 def
/s 0 def
/cx 2880 def
/cy -4140 def
/sx 4320 def
/sy 5760 def
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
/build_rh {
pop
gsave
size .0022 mul dup scale
currentpoint translate

15 66 moveto
15 86 lineto
16 131 lineto
17 146 lineto
18 158 lineto
19 167 lineto
21 181 lineto
24 190 lineto
34 193 lineto
49 189 lineto
58 182 lineto
60 177 lineto
60 166 lineto
59 156 lineto
58 143 lineto
57 130 lineto
56 117 lineto
55 102 lineto
54 42 lineto
53 39 lineto
49 35 lineto
34 34 lineto
19 39 lineto
16 47 lineto
15 66 lineto
stroke

65 60 moveto
65 111 lineto
66 127 lineto
67 139 lineto
69 153 lineto
72 163 lineto
83 171 lineto
98 177 lineto
113 182 lineto
128 187 lineto
143 190 lineto
158 194 lineto
173 196 lineto
188 199 lineto
203 201 lineto
218 203 lineto
233 205 lineto
248 205 lineto
263 206 lineto
278 206 lineto
293 206 lineto
308 206 lineto
323 206 lineto
338 205 lineto
353 203 lineto
368 202 lineto
383 200 lineto
394 197 lineto
389 190 lineto
389 180 lineto
391 176 lineto
391 173 lineto
380 173 lineto
365 173 lineto
350 174 lineto
335 175 lineto
320 176 lineto
305 176 lineto
290 176 lineto
275 177 lineto
260 177 lineto
245 177 lineto
240 173 lineto
240 170 lineto
245 165 lineto
260 164 lineto
275 164 lineto
290 164 lineto
305 163 lineto
320 160 lineto
327 155 lineto
330 149 lineto
330 134 lineto
328 129 lineto
323 124 lineto
309 121 lineto
294 121 lineto
279 121 lineto
264 121 lineto
249 121 lineto
234 121 lineto
228 118 lineto
228 112 lineto
234 109 lineto
249 109 lineto
264 109 lineto
279 108 lineto
294 108 lineto
306 104 lineto
311 97 lineto
312 91 lineto
312 88 lineto
311 82 lineto
305 74 lineto
290 72 lineto
275 72 lineto
260 72 lineto
245 73 lineto
230 73 lineto
215 73 lineto
205 70 lineto
205 63 lineto
217 60 lineto
232 60 lineto
247 60 lineto
262 60 lineto
277 57 lineto
283 52 lineto
285 44 lineto
285 41 lineto
284 35 lineto
280 30 lineto
268 26 lineto
253 25 lineto
238 26 lineto
223 28 lineto
208 31 lineto
193 33 lineto
178 34 lineto
163 33 lineto
148 31 lineto
133 28 lineto
118 27 lineto
103 28 lineto
88 34 lineto
73 43 lineto
67 52 lineto
65 60 lineto
stroke

396 180 moveto
396 188 lineto
399 194 lineto
410 196 lineto
416 190 lineto
416 180 lineto
415 177 lineto
411 173 lineto
400 173 lineto
396 180 lineto
stroke

grestore
} def
/saveobj save def
mark
1 pagesetup
8 S f
(\257)0 100 w
8 R f
(cut)74 100 w
8 S f
(\257 \257)1 5135 1 197 100 t
8 R f
(cut)5358 100 w
8 S f
(\257)5481 100 w
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 200 t
8 R f
(3/13/2016)4924 350 w
(Complex)4955 450 w
(FOIL 4)1 244 1 5004 550 t
(+ +)1 5083 1 165 920 t
22 R f
(Of Bits & Bytes & Words)5 2385 1 1543 1227 t
14 I f
(But let your communication be, Yea,)5 2096 1 2736 1514 t
(yea; Nay, nay: for whatsoever is)5 1876 1 2736 1689 t
(more than these cometh of evil.*)5 1875 1 2736 1864 t
14 R f
(Matthew 5:37)1 793 1 3456 2039 t
18 R f
(Binary notation has been around for a)6 2794 1 576 2376 t
24 R f
(long)3449 2376 w
18 R f
(time.)3935 2376 w
15 S f
(\267)576 2713 w
18 R f
(The above verse tells us to use:)6 2326 1 770 2713 t
(1\) binary notation,)2 1359 1 837 3050 t
18 I f
(and)2255 3050 w
18 R f
(2\) redundancy)1 1044 1 837 3387 t
18 S1 f
()922 3612 w
cleartomark
saveobj restore
/build_rh {
pop
gsave
size .0022 mul dup scale
currentpoint translate

15 66 moveto
15 86 lineto
16 131 lineto
17 146 lineto
18 158 lineto
19 167 lineto
21 181 lineto
24 190 lineto
34 193 lineto
49 189 lineto
58 182 lineto
60 177 lineto
60 166 lineto
59 156 lineto
58 143 lineto
57 130 lineto
56 117 lineto
55 102 lineto
54 42 lineto
53 39 lineto
49 35 lineto
34 34 lineto
19 39 lineto
16 47 lineto
15 66 lineto
stroke

65 60 moveto
65 111 lineto
66 127 lineto
67 139 lineto
69 153 lineto
72 163 lineto
83 171 lineto
98 177 lineto
113 182 lineto
128 187 lineto
143 190 lineto
158 194 lineto
173 196 lineto
188 199 lineto
203 201 lineto
218 203 lineto
233 205 lineto
248 205 lineto
263 206 lineto
278 206 lineto
293 206 lineto
308 206 lineto
323 206 lineto
338 205 lineto
353 203 lineto
368 202 lineto
383 200 lineto
394 197 lineto
389 190 lineto
389 180 lineto
391 176 lineto
391 173 lineto
380 173 lineto
365 173 lineto
350 174 lineto
335 175 lineto
320 176 lineto
305 176 lineto
290 176 lineto
275 177 lineto
260 177 lineto
245 177 lineto
240 173 lineto
240 170 lineto
245 165 lineto
260 164 lineto
275 164 lineto
290 164 lineto
305 163 lineto
320 160 lineto
327 155 lineto
330 149 lineto
330 134 lineto
328 129 lineto
323 124 lineto
309 121 lineto
294 121 lineto
279 121 lineto
264 121 lineto
249 121 lineto
234 121 lineto
228 118 lineto
228 112 lineto
234 109 lineto
249 109 lineto
264 109 lineto
279 108 lineto
294 108 lineto
306 104 lineto
311 97 lineto
312 91 lineto
312 88 lineto
311 82 lineto
305 74 lineto
290 72 lineto
275 72 lineto
260 72 lineto
245 73 lineto
230 73 lineto
215 73 lineto
205 70 lineto
205 63 lineto
217 60 lineto
232 60 lineto
247 60 lineto
262 60 lineto
277 57 lineto
283 52 lineto
285 44 lineto
285 41 lineto
284 35 lineto
280 30 lineto
268 26 lineto
253 25 lineto
238 26 lineto
223 28 lineto
208 31 lineto
193 33 lineto
178 34 lineto
163 33 lineto
148 31 lineto
133 28 lineto
118 27 lineto
103 28 lineto
88 34 lineto
73 43 lineto
67 52 lineto
65 60 lineto
stroke

396 180 moveto
396 188 lineto
399 194 lineto
410 196 lineto
416 190 lineto
416 180 lineto
415 177 lineto
411 173 lineto
400 173 lineto
396 180 lineto
stroke

grestore
} def
/saveobj save def
mark
18 S1 f
922 3612 m
180 build_rh
1102 3612 m
18 R f
(\(in communicating\))1 1434 1 1161 3612 t
15 S f
(\267)576 3949 w
18 R f
(Binary notation is not)3 1605 1 770 3949 t
18 S f
(_ __)1 230 1 2145 3965 t
18 R f
(suited for human use, above)4 2074 1 2434 3949 t
(verse to the contrary notwithstanding.)4 2772 1 770 4149 t
16 S f
(_ ________________________________________________)1 3911 1 877 4189 t
16 B f
( Bytes/Word Bits/Word)2 2009(System Bits/Byte)1 1546 2 1153 4389 t
16 S f
(_ ________________________________________________)1 3911 1 877 4429 t
16 R f
( 36)1 1045( 6)1 959(IBM-7090/94 6)1 1471 3 957 4629 t
( 32)1 1045( 4)1 959(IBM-360/370 8)1 1471 3 957 4829 t
( 16)1 1045( 2)1 959(PDP-11/70 8)1 1471 3 957 5029 t
16 S f
( \347)1 -3911(_ ________________________________________________)1 3911 2 877 5069 t
(\347)877 4989 w
(\347)877 4829 w
(\347)877 4669 w
(\347)877 4509 w
(\347)877 4349 w
(\347)1957 5069 w
(\347)1957 4989 w
(\347)1957 4829 w
(\347)1957 4669 w
(\347)1957 4509 w
(\347)1957 4349 w
(\347)2819 5069 w
(\347)2819 4989 w
(\347)2819 4829 w
(\347)2819 4669 w
(\347)2819 4509 w
(\347)2819 4349 w
(\347)3876 5069 w
(\347)3876 4989 w
(\347)3876 4829 w
(\347)3876 4669 w
(\347)3876 4509 w
(\347)3876 4349 w
(\347)4788 5069 w
(\347)4788 4989 w
(\347)4788 4829 w
(\347)4788 4669 w
(\347)4788 4509 w
(\347)4788 4349 w
12 S f
(________)770 5229 w
12 R f
(* The use of this verse in this context is plagiarized from C. Shannon.)13 3486 1 770 5419 t
8 R f
(+ +)1 5083 1 165 5960 t
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 7040 t
8 S f
(\255)0 7140 w
8 R f
(cut)74 7140 w
8 S f
(\255 \255)1 5135 1 197 7140 t
8 R f
(cut)5358 7140 w
8 S f
(\255)5481 7140 w
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
(A-8 MV)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 5:  Input]
10 B f
( Input)1 290(Example 5:)1 486 2 720 960 t
9 CW f
(.DF 1 R 2 I 3 B)6 810 1 870 1130 t
(.VS 5 "Equations")2 918 1 870 1240 t
(.T Equations)1 648 1 870 1350 t
(.EQ)870 1460 w
(gsize 18)1 432 1 870 1570 t
(delim $$)1 432 1 870 1680 t
(.EN)870 1790 w
(.S 100 5.5)2 540 1 870 1900 t
(Equations can be displayed or)4 1566 1 870 2010 t
(set in-line with the text.)4 1404 1 870 2120 t
(.SP)870 2230 w
(A displayed equation is set apart)5 1782 1 870 2340 t
(from the text:)2 756 1 870 2450 t
(.I 2 a)2 324 1 870 2560 t
(.EQ)870 2670 w
(sum from k=1 to inf m sup k-1)7 1566 1 870 2780 t
(\304=\304 1 over 1-m)3 756 1 870 2890 t
(.EN)870 3000 w
(.I 0 a)2 324 1 870 3110 t
(An in-line equation)2 1026 1 870 3220 t
($f\(t\)\304=\3042 pi int sin \( omega t\)dt$)6 1836 1 870 3330 t
(is used in the running text,)5 1512 1 870 3440 t
(rather than being displayed.)3 1512 1 870 3550 t
cleartomark
showpage
saveobj restore
%%EndPage: 8 8
%%Page: 9 9
/saveobj save def
mark
9 pagesetup
10 HB f
(MV A-9)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 5:  Output]
10 B f
( Output)1 362(Example 5:)1 486 2 720 960 t
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
/llx -10 def
/lly 207 def
/urx 563 def
/ury 800 def
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
(\257)0 100 w
8 R f
(cut)74 100 w
8 S f
(\257 \257)1 5135 1 197 100 t
8 R f
(cut)5358 100 w
8 S f
(\257)5481 100 w
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 200 t
8 R f
(3/13/2016)4924 350 w
(Equations)4929 450 w
(FOIL 5)1 244 1 5004 550 t
8 S f
(_ _)1 5328 1 72 1064 t
8 R f
(+ +)1 5083 1 165 920 t
18 R f
(Equations)2376 1152 w
14 R f
(Equations can be displayed or set in-line with the text.)9 3139 1 576 1414 t
(A displayed equation is set apart from the text:)8 2708 1 576 1764 t
14 I f
(k)2016 2292 w
14 S f
(=)2112 2292 w
14 R f
(1)2212 2292 w
23 S f
(S)2081 2152 w
14 S f
(\245)2098 1958 w
18 I f
(m)2297 2098 w
14 I f
(k)2450 2026 w
14 S f
(-)2546 2026 w
14 R f
(1)2646 2026 w
18 S f
(=)2835 2098 w
18 R f
(1)3073 2224 w
18 S f
(-)3193 2224 w
18 I f
(m)3322 2224 w
18 R f
(1)3218 1990 w
18 S1 f
(_ ____)1 413 1 3057 2044 t
14 R f
(An in-line equation)2 1110 1 576 2518 t
18 I f
(f)1745 2518 w
18 R f
(\()1825 2518 w
18 I f
(t)1899 2518 w
18 R f
(\))1964 2518 w
18 S f
(=)2142 2518 w
18 R f
(2)2345 2518 w
18 S f
(p)2450 2518 w
22 S f
(\362)2564 2536 w
18 R f
(sin \()1 284 1 2689 2518 t
18 S f
(w)2988 2518 w
18 I f
(t)3127 2518 w
18 R f
(\))3192 2518 w
18 I f
(dt)3281 2518 w
14 R f
(is used in the)3 769 1 3467 2518 t
(running text, rather than being displayed.)5 2359 1 576 2711 t
8 R f
(+ +)1 5083 1 165 4520 t
8 S f
(_ _)1 5328 1 72 4376 t
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 5600 t
8 S f
(\255)0 5700 w
8 R f
(cut)74 5700 w
8 S f
(\255 \255)1 5135 1 197 5700 t
8 R f
(cut)5358 5700 w
8 S f
(\255)5481 5700 w
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
(A-10 MV)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 6:  Input]
10 B f
( Input)1 290(Example 6:)1 486 2 720 960 t
9 CW f
(.Vw 6 "The Works")3 918 1 870 1130 t
(.EQ)870 1240 w
(gsize 14)1 432 1 870 1350 t
(delim $$)1 432 1 870 1460 t
(.EN)870 1570 w
(.TS)870 1680 w
(center doublebox tab\(!\);)2 1296 1 870 1790 t
( S)1 216( S)1 162(Cip+4 | Cb)2 540 3 870 1900 t
( L L)2 432( L)1 108(\303 |)1 378 3 870 2010 t
( C | C | C)5 540(\303 |)1 378 2 870 2120 t
( C | C | C)5 540(\303 |)1 378 2 870 2230 t
( C | C | N.)5 594(Li |)1 378 2 870 2340 t
(Users!Hardware)870 2450 w
(!_!_!_)870 2560 w
(!UNIX\\*\(Rg!Model!Serial)870 2670 w
(!System!\\\303!Number)870 2780 w
(=)870 2890 w
(OS Dev.!A!VAX!54)1 864 1 870 3000 t
(SGS Dev.!B!11/70!3275)1 1134 1 870 3110 t
(Low-End!C!11/23!221)870 3220 w
(_)870 3330 w
(And now ...!T{)2 756 1 870 3440 t
(.NA)870 3550 w
(Some filled text and an equation:)5 1782 1 870 3660 t
(T}!T{)870 3770 w
($zeta \(s\)\304=\304 prod from k=1 to inf k sup -s$)9 2322 1 870 3880 t
(.AD)870 3990 w
(T}!1.2)870 4100 w
(.TE)870 4210 w
cleartomark
showpage
saveobj restore
%%EndPage: 10 10
%%Page: 11 11
/saveobj save def
mark
11 pagesetup
10 HB f
(MV A-11)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 6:  Output]
10 B f
( Output)1 362(Example 6:)1 486 2 720 960 t
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
/llx -10 def
/lly 207 def
/urx 563 def
/ury 800 def
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
(\257)0 100 w
8 H f
(cut)78 100 w
8 S f
(\257 \257)1 5099 1 215 100 t
8 H f
(cut)5344 100 w
8 S f
(\257)5481 100 w
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 200 t
8 H f
(3/13/2016)4889 350 w
(The Works)1 395 1 4853 450 t
(FOIL 6)1 253 1 4995 550 t
8 S f
(_ _)1 5328 1 72 1064 t
8 H f
(+ +)1 5083 1 165 920 t
14 S f
(_ ___________________________________________________)1 3613 1 929 1002 t
(_ ___________________________________________________)1 3573 1 949 1022 t
14 B f
(Hardware)2861 1187 w
14 S f
(_ _______________________________________)1 2752 1 1770 1222 t
14 H f
(UNIX)2028 1397 w
10 S f
(\322)2363 1348 w
14 H f
(Serial)4034 1397 w
18 I f
(Users)1127 1379 w
14 H f
(System)2001 1572 w
(Model)3089 1484 w
(Number)3965 1572 w
14 S f
(_ ___________________________________________________)1 3573 1 949 1597 t
(_ ___________________________________________________)1 3573 1 949 1617 t
14 I f
(OS Dev.)1 477 1 1009 1782 t
14 H f
( 54)1 890(A VAX)1 1233 2 2188 1782 t
14 I f
(SGS Dev.)1 547 1 1009 1957 t
14 H f
( 3275)1 856(B 11/70)1 1267 2 2188 1957 t
14 I f
(Low-End)1009 2132 w
14 H f
( 221)1 856(C 11/23)1 1271 2 2184 2132 t
14 S f
(_ ___________________________________________________)1 3573 1 949 2167 t
14 I f
(And now ...)2 656 1 1009 2342 t
14 H f
( filled)1 340(1.2 Some)1 -1992 2 4233 2342 t
(text and an)2 720 1 1875 2517 t
(equation:)1875 2692 w
14 S f
(z)2805 2403 w
14 H f
(\()2885 2403 w
14 I f
(s)2942 2403 w
14 H f
(\))3008 2403 w
14 S f
(=)3152 2403 w
11 I f
(k)3315 2554 w
11 S f
(=)3390 2554 w
11 H f
(1)3469 2554 w
19 S f
(P)3350 2445 w
11 S f
(\245)3383 2283 w
14 I f
(k)3542 2403 w
11 S f
(-)3622 2347 w
11 I f
(s)3701 2347 w
14 S f
(_ ___________________________________________________)1 3573 1 949 2717 t
( \347)1 -3613(_ ___________________________________________________)1 3613 2 929 2737 t
(\347)929 2682 w
(\347)929 2542 w
(\347)929 2402 w
(\347)929 2262 w
(\347)929 2122 w
(\347)929 1982 w
(\347)929 1842 w
(\347)929 1702 w
(\347)929 1562 w
(\347)929 1422 w
(\347)929 1282 w
(\347)929 1142 w
(\347)949 2717 w
(\347)949 2702 w
(\347)949 2562 w
(\347)949 2422 w
(\347)949 2282 w
(\347)949 2142 w
(\347)949 2002 w
(\347)949 1862 w
(\347)949 1722 w
(\347)949 1582 w
(\347)949 1442 w
(\347)949 1302 w
(\347)949 1162 w
(\347)1770 2717 w
(\347)1770 2702 w
(\347)1770 2562 w
(\347)1770 2422 w
(\347)1770 2282 w
(\347)1770 2142 w
(\347)1770 2002 w
(\347)1770 1862 w
(\347)1770 1722 w
(\347)1770 1582 w
(\347)1770 1442 w
(\347)1770 1302 w
(\347)1770 1162 w
(\347)2700 2717 w
(\347)2700 2622 w
(\347)2700 2482 w
(\347)2700 2342 w
(\347)2700 2202 w
(\347)2700 2062 w
(\347)2700 1922 w
(\347)2700 1782 w
(\347)2700 1642 w
(\347)2700 1502 w
(\347)2700 1362 w
(\347)3860 2717 w
(\347)3860 2622 w
(\347)3860 2482 w
(\347)3860 2342 w
(\347)3860 2202 w
(\347)3860 2062 w
(\347)3860 1922 w
(\347)3860 1782 w
(\347)3860 1642 w
(\347)3860 1502 w
(\347)3860 1362 w
(\347)4522 2717 w
(\347)4522 2702 w
(\347)4522 2562 w
(\347)4522 2422 w
(\347)4522 2282 w
(\347)4522 2142 w
(\347)4522 2002 w
(\347)4522 1862 w
(\347)4522 1722 w
(\347)4522 1582 w
(\347)4522 1442 w
(\347)4522 1302 w
(\347)4522 1162 w
(\347)4542 2737 w
(\347)4542 2682 w
(\347)4542 2542 w
(\347)4542 2402 w
(\347)4542 2262 w
(\347)4542 2122 w
(\347)4542 1982 w
(\347)4542 1842 w
(\347)4542 1702 w
(\347)4542 1562 w
(\347)4542 1422 w
(\347)4542 1282 w
(\347)4542 1142 w
8 H f
(+ +)1 5083 1 165 4520 t
8 S f
(_ _)1 5328 1 72 4376 t
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 5600 t
8 S f
(\255)0 5700 w
8 H f
(cut)78 5700 w
8 S f
(\255 \255)1 5099 1 215 5700 t
8 H f
(cut)5344 5700 w
8 S f
(\255)5481 5700 w
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
(A-12 MV)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 7:  Input]
10 B f
( Input)1 290(Example 7:)1 486 2 720 960 t
9 CW f
(.VS 7 "Model")2 702 1 870 1130 t
(.T "A Working Model")3 1080 1 870 1240 t
(.SP)870 1350 w
(.PS)870 1460 w
(boxwid = 1.25i ; boxht = 0.75i)6 1620 1 870 1570 t
(arrow)870 1680 w
(box "input")1 594 1 870 1790 t
(arrow)870 1900 w
(box "process")1 702 1 870 2010 t
(arrow)870 2120 w
(box "output")1 648 1 870 2230 t
(arrow)870 2340 w
(.PE)870 2450 w
cleartomark
showpage
saveobj restore
%%EndPage: 12 12
%%Page: 13 13
/saveobj save def
mark
13 pagesetup
10 HB f
(MV A-13)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 7:  Output]
10 B f
( Output)1 362(Example 7:)1 486 2 720 960 t
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
/llx -10 def
/lly 207 def
/urx 563 def
/ury 800 def
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
(\257)0 100 w
8 H f
(cut)78 100 w
8 S f
(\257 \257)1 5099 1 215 100 t
8 H f
(cut)5344 100 w
8 S f
(\257)5481 100 w
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 200 t
8 H f
(3/13/2016)4889 350 w
(Model)5029 450 w
(FOIL 7)1 253 1 4995 550 t
8 S f
(_ _)1 5328 1 72 1064 t
8 H f
(+ +)1 5083 1 165 920 t
18 H f
(A Working Model)2 1408 1 2032 1152 t
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
14 H f
936 1859 576 1859 Dl
936 1859 864 1877 Dl
936 1859 864 1841 Dl
936 1589 936 2129 Dl
1836 1589 936 1589 Dl
1836 2129 1836 1589 Dl
936 2129 1836 2129 Dl
(input)1234 1887 w
2196 1859 1836 1859 Dl
2196 1859 2124 1877 Dl
2196 1859 2124 1841 Dl
2196 1589 2196 2129 Dl
3096 1589 2196 1589 Dl
3096 2129 3096 1589 Dl
2196 2129 3096 2129 Dl
(process)2401 1887 w
3456 1859 3096 1859 Dl
3456 1859 3384 1877 Dl
3456 1859 3384 1841 Dl
3456 1589 3456 2129 Dl
4356 1589 3456 1589 Dl
4356 2129 4356 1589 Dl
3456 2129 4356 2129 Dl
(output)3711 1887 w
4716 1859 4356 1859 Dl
4716 1859 4644 1877 Dl
4716 1859 4644 1841 Dl
8 H f
(+ +)1 5083 1 165 4520 t
8 S f
(_ _)1 5328 1 72 4376 t
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 5600 t
8 S f
(\255)0 5700 w
8 H f
(cut)78 5700 w
8 S f
(\255 \255)1 5099 1 215 5700 t
8 H f
(cut)5344 5700 w
8 S f
(\255)5481 5700 w
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
(A-14 MV)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 8:  Input]
10 B f
( Input)1 290(Example 8:)1 486 2 720 960 t
9 CW f
(.VS 8 "Age Graph")3 918 1 870 1130 t
(.T "1984 Age Distribution in U.S.")5 1836 1 870 1240 t
(.SP)870 1350 w
(.G1)870 1460 w
(coord x 0,89 y 0,5)4 972 1 870 1570 t
(label left "\\s-3Population\\s+3" "\\s-3\(in millions\)\\s+3" left 0.2)6 3456 1 870 1680 t
(label bottom "\\s-31984 Age\\s+3" down 0.2)5 2160 1 870 1790 t
(draw solid)1 540 1 870 1900 t
(copy "agepop.d")1 810 1 870 2010 t
(.G2)870 2120 w
cleartomark
showpage
saveobj restore
%%EndPage: 14 14
%%Page: 15 15
/saveobj save def
mark
15 pagesetup
10 HB f
(MV A-15)1 4320 1 720 600 t
%INFO[SECTION: LEVEL = 2, NUMBER = none, HEADING = Example 8:  Output]
10 B f
( Output)1 362(Example 8:)1 486 2 720 960 t
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
/llx -10 def
/lly 207 def
/urx 563 def
/ury 800 def
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
(\257)0 100 w
8 H f
(cut)78 100 w
8 S f
(\257 \257)1 5099 1 215 100 t
8 H f
(cut)5344 100 w
8 S f
(\257)5481 100 w
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 200 t
8 H f
(3/13/2016)4889 350 w
(Age Graph)1 397 1 4851 450 t
(FOIL 8)1 253 1 4995 550 t
8 S f
(_ _)1 5328 1 72 1064 t
8 H f
(+ +)1 5083 1 165 920 t
18 H f
(1984 Age Distribution in U.S.)4 2390 1 1541 1152 t
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
14 H f
1872 1589 1872 3029 Dl
4032 1589 1872 1589 Dl
4032 3029 4032 1589 Dl
1872 3029 4032 3029 Dl
1872 3101 1872 3029 Dl
(-0)1810 3219 w
2357 3101 2357 3029 Dl
(20)2279 3219 w
2842 3101 2842 3029 Dl
(40)2764 3219 w
3327 3101 3327 3029 Dl
(60)3249 3219 w
3813 3101 3813 3029 Dl
(80)3735 3219 w
1800 3029 1872 3029 Dl
(-0)1624 3057 w
1800 2741 1872 2741 Dl
(1)1670 2769 w
1800 2453 1872 2453 Dl
(2)1670 2481 w
1800 2165 1872 2165 Dl
(3)1670 2193 w
1800 1877 1872 1877 Dl
(4)1670 1905 w
1800 1589 1872 1589 Dl
(5)1670 1617 w
11 H f
(Population)818 2250 w
(\(in millions\))1 565 1 798 2424 t
(1984 Age)1 487 1 2709 3501 t
14 H f
1896 1962 1872 1987 Dl
1920 1982 1896 1961 Dl
1944 2010 1920 1983 Dl
1968 2087 1944 2011 Dl
1993 2099 1969 2087 Dl
2017 2112 1993 2100 Dl
2041 2123 2017 2113 Dl
2065 2119 2041 2124 Dl
2090 2133 2066 2118 Dl
2114 2086 2090 2133 Dl
2138 2052 2114 2086 Dl
2163 1946 2139 2051 Dl
2186 1958 2162 1946 Dl
2211 1997 2187 1959 Dl
2235 2015 2211 1997 Dl
2260 1979 2236 2015 Dl
2284 1939 2260 1979 Dl
2308 1860 2284 1939 Dl
2333 1825 2309 1859 Dl
2356 1813 2332 1825 Dl
2381 1805 2357 1812 Dl
2405 1748 2381 1805 Dl
2430 1765 2406 1747 Dl
2454 1794 2430 1765 Dl
2478 1794 2454 1794 Dl
2502 1818 2478 1794 Dl
2526 1829 2502 1819 Dl
2551 1842 2527 1830 Dl
2575 1883 2551 1843 Dl
2600 1895 2576 1883 Dl
2623 1961 2599 1897 Dl
2648 1939 2624 1961 Dl
2672 1955 2648 1938 Dl
2696 1990 2672 1956 Dl
2721 1960 2697 1990 Dl
2745 1976 2721 1959 Dl
2769 2205 2745 1977 Dl
2793 2193 2769 2205 Dl
2818 2186 2794 2193 Dl
2842 2170 2818 2185 Dl
2866 2280 2842 2170 Dl
2915 2317 2867 2280 Dl
2939 2344 2915 2318 Dl
2963 2359 2939 2345 Dl
2988 2384 2964 2359 Dl
3012 2377 2988 2384 Dl
3036 2382 3012 2377 Dl
3060 2412 3036 2383 Dl
3085 2389 3061 2412 Dl
3109 2405 3085 2388 Dl
3133 2361 3109 2406 Dl
3158 2353 3134 2360 Dl
3182 2367 3158 2352 Dl
3206 2349 3182 2368 Dl
3230 2355 3206 2348 Dl
3255 2347 3231 2355 Dl
3279 2341 3255 2347 Dl
3303 2357 3279 2340 Dl
3328 2362 3304 2357 Dl
3351 2358 3327 2363 Dl
3376 2380 3352 2357 Dl
3400 2406 3376 2381 Dl
3425 2431 3401 2406 Dl
3449 2450 3425 2432 Dl
3473 2472 3449 2450 Dl
3498 2478 3474 2473 Dl
3521 2480 3497 2478 Dl
3546 2505 3522 2480 Dl
3570 2521 3546 2507 Dl
3595 2545 3571 2521 Dl
3618 2561 3594 2545 Dl
3643 2592 3619 2562 Dl
3667 2614 3643 2592 Dl
3691 2633 3667 2614 Dl
3716 2665 3692 2634 Dl
3740 2681 3716 2666 Dl
3765 2709 3741 2681 Dl
3788 2732 3764 2709 Dl
3813 2755 3789 2733 Dl
3837 2790 3813 2755 Dl
3861 2778 3837 2790 Dl
3886 2820 3862 2777 Dl
3910 2843 3886 2820 Dl
3934 2865 3910 2844 Dl
3958 2877 3934 2866 Dl
3983 2891 3959 2877 Dl
4007 2909 3983 2891 Dl
4031 2928 4007 2910 Dl
8 H f
(+ +)1 5083 1 165 4520 t
8 S f
(_ _)1 5328 1 72 4376 t
8 S1 f
( ______)1 233( _)1 5023(_ ______)1 273 3 0 5600 t
8 S f
(\255)0 5700 w
8 H f
(cut)78 5700 w
8 S f
(\255 \255)1 5099 1 215 5700 t
8 H f
(cut)5344 5700 w
8 S f
(\255)5481 5700 w
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
%%EndPage: 15 15
%%Trailer
done
%%Pages: 15
%%DocumentFonts: Helvetica-Bold Times-Bold Times-Italic Times-Roman Symbol Courier Times-Roman
