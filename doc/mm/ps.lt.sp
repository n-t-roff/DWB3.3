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
10 R f
(SoftPackers, Inc.)1 679 1 720 1440 t
(25 Bubble Sheet Road)3 897 1 720 1560 t
( 21046)1 300(Columbia, Maryland)1 833 2 720 1680 t
(April 1, 1990)2 536 1 720 1800 t
(J. J. Jones)2 400 1 720 2160 t
(Purchasing Supervisor)1 902 1 720 2280 t
(Getem Electronics, Inc.)2 942 1 720 2400 t
(9 Circuit Lane)2 577 1 720 2520 t
( 63101)1 300(St. Louis, Missouri)2 768 2 720 2640 t
(Thank you for your interest in Softpackers' new EnviroPack)8 2412 1 720 2820 t
6 R f
(TM)3132 2770 w
10 R f
(packaging sheets.)1 704 1 3247 2820 t
( you will \256nd that EnviroPack offers many advantages over other commercially-available)11 3893(I am sure)2 427 2 720 3000 t
(packaging materials:)1 829 1 720 3120 t
8 S f
(\267)783 3300 w
10 R f
(EnviroPack is of a lighter weight material, thereby reducing shipping costs.)10 3013 1 870 3300 t
8 S f
(\267)783 3480 w
10 R f
(EnviroPack is less expensive than standard bubble sheets or styrofoam chips.)10 3082 1 870 3480 t
8 S f
(\267)783 3660 w
10 R f
( an)1 144(EnviroPack is made of a completely biodegradable compound so it is environmentally sound,)12 4026 2 870 3660 t
(important factor in a world where environmental issues are of great concern.)11 3053 1 870 3780 t
( the \256rst to try it.)5 683(We expect this product to enjoy great success and we are delighted that you will be among)16 3637 2 720 3960 t
(The attached brochure provides additional product information.)6 2537 1 720 4080 t
( you do not receive this shipment or are not pleased)10 2148( If)1 125(You will receive your trial shipment in one week.)8 2047 3 720 4260 t
(with the product, please contact me at 201-567-9876.)7 2127 1 720 4380 t
(S. P. LENAME, MANAGER, PRODUCT SALES)5 2031 1 720 4980 t
%INFO[NOTATION LIST: CODE = 3, TYPE = Att.]
%INFO[NOTATION LIST: <START>]
(Att.)720 5340 w
(Brochure)720 5460 w
%INFO[NOTATION LIST: <END>]
cleartomark
showpage
saveobj restore
%%EndPage: 1 1
%%Trailer
done
%%Pages: 1
%%DocumentFonts: Times-Roman Symbol
