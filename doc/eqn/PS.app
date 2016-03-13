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
(APPENDIX: Tuning)1 1187 1 720 1050 t
11 HB f
(EQN)1941 1050 w
12 HB f
(Output)2214 1050 w
10 R f
(There are numerous values that can be adjusted to tune the output of)12 2776 1 720 1350 t
10 I f
(eqn)3525 1350 w
10 R f
( In)1 138(for a particular output device.)4 1203 2 3699 1350 t
(general, it is necessary to have access to the source code to do this tuning.)14 2950 1 720 1470 t
( default)1 308( names shown below \(together with their)6 1661( The)1 210(Some values can be set without access to the source.)9 2141 4 720 1650 t
( with any)2 390( can be de\256ned)3 631( They)1 265(values\) control the positioning of diacritical marks and special characters.)9 3034 4 720 1770 t
(string value, as in)3 705 1 720 1890 t
10 CW f
(define vec_def % \\v'-.5m'\\s-3\\\(->\\s0\\v'.5m' %)4 2700 1 870 2070 t
10 R f
(The amount by which a subscript is shifted down and a superscript shifted up are controlled by)16 3869 1 720 2250 t
10 CW f
(Subbase)4620 2250 w
10 R f
(and)720 2370 w
10 CW f
(Supbase)889 2370 w
10 R f
(.)1309 2370 w
10 CW f
(vec_def \\v'-.5m'\\s-3\\\(->\\s0\\v'.5m')1 2310 1 1485 2670 t
(dyad_def \\v'-.5m'\\s-3\\z\\\(<-\\|\\\(->\\s0\\v'.5m')1 2790 1 1485 2790 t
(hat_def \\v'-.05m'\\s+1\303\\s0\\v'.05m')1 2250 1 1485 2910 t
(tilde_def \\v'-.05m'\\s+1\304\\s0\\v'.05m')1 2250 1 1485 3030 t
(dot_def \\v'-.67m'.\\v'.67m')1 1830 1 1485 3150 t
(dotdot_def \\v'-.67m'..\\v'.67m')1 1890 1 1485 3270 t
(utilde_def \\v'1.0m'\\s+2\304\\s-2\\v'-1.0m')1 2310 1 1485 3390 t
(sum_def \\|\\v'.3m'\\s+5\\\(*S\\s-5\\v'-.3m'\\|)1 2610 1 1485 3510 t
(union_def \\|\\v'.3m'\\s+5\\\(cu\\s-5\\v'-.3m'\\|)1 2610 1 1485 3630 t
(inter_def \\|\\v'.3m'\\s+5\\\(ca\\s-5\\v'-.3m'\\|)1 2610 1 1485 3750 t
(prod_def \\|\\v'.3m'\\s+5\\\(*P\\s-5\\v'-.3m'\\|)1 2610 1 1485 3870 t
(int_def \\v'.1m'\\s+4\\\(is\\s-4\\v'-.1m')1 2370 1 1485 3990 t
(Subbase 0.2)1 930 1 1485 4110 t
(Supbase 0.4)1 930 1 1485 4230 t
cleartomark
showpage
saveobj restore
%%EndPage: 1 1
%%Trailer
done
%%Pages: 1
%%DocumentFonts: Helvetica-Bold Times-Italic Times-Roman Courier Times-Roman
