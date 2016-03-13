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
( Set)1 221(APPENDIX: Character)1 1349 2 720 1050 t
10 R f
(Different output devices support different character sets, although there is considerable commonality.)11 4050 1 900 1470 t
(To get the one on the left, type the four-character name on the right.)13 2713 1 900 1590 t
10 S1 f
()1620 1830 w
cleartomark
saveobj restore
%%BeginGlobal
/build_ff {
    pop
    size .05 mul neg 0 (ff) ashow
} def
%%EndGlobal
/saveobj save def
mark
10 S1 f
1620 1830 m
60 build_ff
1680 1830 m
10 CW f
(\\\(ff)1849 1830 w
10 R f
(\256)2389 1830 w
10 CW f
(\\\(fi)2639 1830 w
10 R f
(\257)3179 1830 w
10 CW f
(\\\(fl)3404 1830 w
10 S1 f
()3944 1830 w
cleartomark
saveobj restore
%%BeginGlobal
/build_Fi {
    pop
    size .05 mul neg 0 (ffi) ashow
} def
%%EndGlobal
/saveobj save def
mark
10 S1 f
3944 1830 m
84 build_Fi
4028 1830 m
10 CW f
(\\\(Fi)4178 1830 w
10 S1 f
(_)1620 1950 w
10 CW f
(\\\(ru)1849 1950 w
10 R f
(\320)2389 1950 w
10 CW f
(\\\(em)2639 1950 w
10 S1 f
()3179 1950 w
cleartomark
saveobj restore
%%BeginGlobal
/build_14 {
    pop
    /optsize ptsize def
    /osize size def
    /ofont font def

    optsize 2 div dup R exch R f
    0 size 2 mul 3 div dup neg exch 0 exch rmoveto

    (1) show
    rmoveto
    optsize R f
    (\244) show
    f
    (4) show

    optsize ofont f
} def
%%EndGlobal
/saveobj save def
mark
10 S1 f
3179 1950 m
75 build_14
3254 1950 m
10 CW f
(\\\(14)3404 1950 w
10 S1 f
()3944 1950 w
cleartomark
saveobj restore
%%BeginGlobal
/build_12 {
    pop
    /optsize ptsize def
    /osize size def
    /ofont font def

    optsize 2 div dup R exch R f
    0 size 2 mul 3 div dup neg exch 0 exch rmoveto

    (1) show
    rmoveto
    optsize R f
    (\244) show
    f
    (2) show

    optsize ofont f
} def
%%EndGlobal
/saveobj save def
mark
10 S1 f
3944 1950 m
75 build_12
4019 1950 m
10 CW f
(\\\(12)4178 1950 w
10 S f
(\323)1620 2070 w
10 CW f
(\\\(co)1849 2070 w
10 S f
(\260)2389 2070 w
10 CW f
(\\\(de)2639 2070 w
10 R f
(\262)3179 2070 w
10 CW f
(\\\(dg)3404 2070 w
10 S f
(\242)3944 2070 w
10 CW f
(\\\(fm)4178 2070 w
10 S f
(\322)1620 2190 w
10 CW f
(\\\(rg)1849 2190 w
10 S f
(\267)2389 2190 w
10 CW f
(\\\(bu)2639 2190 w
10 S1 f
()3179 2190 w
cleartomark
saveobj restore
%%BeginGlobal
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
%%EndGlobal
/saveobj save def
mark
10 S1 f
3179 2190 m
50 build_sq
3229 2190 m
10 CW f
(\\\(sq)3404 2190 w
10 R f
(-)3944 2190 w
10 CW f
(\\\(hy)4178 2190 w
10 R f
(The following are special-font characters:)4 1667 1 900 2520 t
10 S f
(+)1620 2760 w
10 CW f
(\\\(pl)1869 2760 w
10 S f
(-)2409 2760 w
10 CW f
(\\\(mi)2658 2760 w
10 S f
(\264)3198 2760 w
10 CW f
(\\\(mu)3448 2760 w
10 S f
(\270)3988 2760 w
10 CW f
(\\\(di)4238 2760 w
10 S f
(=)1620 2880 w
10 CW f
(\\\(eq)1869 2880 w
10 S f
(\272)2409 2880 w
10 CW f
(\\\(==)2658 2880 w
10 S f
(\263)3198 2880 w
10 CW f
(\\\(>=)3448 2880 w
10 S f
(\243)3988 2880 w
10 CW f
(\\\(<=)4238 2880 w
10 S f
(\271)1620 3000 w
10 CW f
(\\\(!=)1869 3000 w
10 S f
(\261)2409 3000 w
10 CW f
(\\\(+-)2658 3000 w
10 S f
(\330)3198 3000 w
10 CW f
(\\\(no)3448 3000 w
10 S f
(/)3988 3000 w
10 CW f
(\\\(sl)4238 3000 w
10 S f
(~)1620 3120 w
10 CW f
(\\\(ap)1869 3120 w
10 S f
()2409 3120 w
cleartomark
saveobj restore
%%BeginGlobal
/build_~= {
    pop
    (\176) stringwidth pop neg size -.15 mul (\176\055) ashow
} def
%%EndGlobal
/saveobj save def
mark
10 S f
2409 3120 m
55 build_~=
2464 3120 m
10 CW f
(\\\(\304=)2658 3120 w
10 S f
(\265)3198 3120 w
10 CW f
(\\\(pt)3448 3120 w
10 S f
(\321)3988 3120 w
10 CW f
(\\\(gr)4238 3120 w
10 S f
(\256)1620 3240 w
10 CW f
(\\\(->)1869 3240 w
10 S f
(\254)2409 3240 w
10 CW f
(\\\(<-)2658 3240 w
10 S f
(\255)3198 3240 w
10 CW f
(\\\(ua)3448 3240 w
10 S f
(\257)3988 3240 w
10 CW f
(\\\(da)4238 3240 w
10 S f
(\362)1620 3360 w
10 CW f
(\\\(is)1869 3360 w
10 S f
(\266)2409 3360 w
10 CW f
(\\\(pd)2658 3360 w
10 S f
(\245)3198 3360 w
10 CW f
(\\\(if)3448 3360 w
10 S f
(`)3988 3360 w
10 CW f
(\\\(rn)4238 3360 w
10 S f
(\314)1620 3480 w
10 CW f
(\\\(sb)1869 3480 w
10 S f
(\311)2409 3480 w
10 CW f
(\\\(sp)2658 3480 w
10 S f
(\310)3198 3480 w
10 CW f
(\\\(cu)3448 3480 w
10 S f
(\326)3988 3480 w
10 CW f
(\\\(sr)4238 3480 w
10 S f
(\315)1620 3600 w
10 CW f
(\\\(ib)1869 3600 w
10 S f
(\312)2409 3600 w
10 CW f
(\\\(ip)2658 3600 w
10 S f
(\316)3198 3600 w
10 CW f
(\\\(mo)3448 3600 w
10 S f
(\307)3988 3600 w
10 CW f
(\\\(ca)4238 3600 w
10 R f
(\302)1620 3720 w
10 CW f
(\\\(aa)1869 3720 w
10 R f
(\301)2409 3720 w
10 CW f
(\\\(ga)2658 3720 w
10 S1 f
()3198 3720 w
cleartomark
saveobj restore
%%BeginGlobal
/build_ci {
    pop
    size 3 mul 8 div /rad exch def
    currentpoint
    newpath
    rad add exch rad add exch rad 0 360 arc
    stroke
} def
%%EndGlobal
/saveobj save def
mark
10 S1 f
3198 3720 m
75 build_ci
3273 3720 m
10 CW f
(\\\(ci)3448 3720 w
10 S f
(\306)3988 3720 w
10 CW f
(\\\(es)4238 3720 w
10 R f
(\247)1620 3840 w
10 CW f
(\\\(sc)1869 3840 w
10 R f
(\263)2409 3840 w
10 CW f
(\\\(dd)2658 3840 w
10 S1 f
()3198 3840 w
cleartomark
saveobj restore
%%BeginGlobal
/build_lh {
pop
gsave
size .0022 mul dup scale
currentpoint translate

16 177 moveto
16 188 lineto
21 193 lineto
30 193 lineto
34 189 lineto
36 183 lineto
36 180 lineto
34 174 lineto
27 170 lineto
19 172 lineto
16 177 lineto
stroke

38 194 moveto
38 196 lineto
53 199 lineto
68 201 lineto
83 202 lineto
98 203 lineto
113 204 lineto
128 204 lineto
143 205 lineto
158 205 lineto
173 205 lineto
188 204 lineto
203 203 lineto
218 202 lineto
233 200 lineto
248 198 lineto
263 196 lineto
278 194 lineto
293 190 lineto
308 186 lineto
323 181 lineto
338 176 lineto
353 168 lineto
361 162 lineto
364 153 lineto
366 138 lineto
367 126 lineto
368 106 lineto
369 80 lineto
369 74 lineto
368 60 lineto
367 54 lineto
362 43 lineto
348 34 lineto
333 28 lineto
318 25 lineto
303 26 lineto
288 29 lineto
273 31 lineto
258 32 lineto
243 32 lineto
228 30 lineto
213 27 lineto
198 24 lineto
183 23 lineto
168 23 lineto
153 27 lineto
148 34 lineto
148 47 lineto
153 54 lineto
168 58 lineto
183 58 lineto
198 58 lineto
213 59 lineto
226 60 lineto
228 62 lineto
228 67 lineto
223 71 lineto
208 71 lineto
193 70 lineto
178 70 lineto
163 70 lineto
148 70 lineto
133 71 lineto
123 76 lineto
120 84 lineto
120 91 lineto
122 98 lineto
129 104 lineto
144 106 lineto
159 107 lineto
174 107 lineto
189 107 lineto
202 108 lineto
204 110 lineto
204 117 lineto
201 119 lineto
186 119 lineto
171 119 lineto
156 119 lineto
141 119 lineto
126 119 lineto
111 121 lineto
103 128 lineto
101 137 lineto
101 142 lineto
103 150 lineto
111 158 lineto
126 161 lineto
141 161 lineto
156 162 lineto
171 163 lineto
186 163 lineto
191 165 lineto
192 167 lineto
192 171 lineto
190 174 lineto
176 175 lineto
161 175 lineto
146 175 lineto
131 174 lineto
116 174 lineto
101 174 lineto
86 173 lineto
71 172 lineto
56 171 lineto
41 171 lineto
41 174 lineto
43 178 lineto
43 187 lineto
38 194 lineto
stroke

373 169 moveto
373 176 lineto
375 182 lineto
386 190 lineto
401 193 lineto
408 191 lineto
411 185 lineto
412 181 lineto
414 167 lineto
415 158 lineto
416 144 lineto
417 128 lineto
418 110 lineto
418 60 lineto
417 45 lineto
415 37 lineto
409 34 lineto
394 31 lineto
381 35 lineto
379 42 lineto
379 52 lineto
380 67 lineto
380 77 lineto
379 77 lineto
378 106 lineto
377 121 lineto
376 133 lineto
375 147 lineto
374 158 lineto
373 169 lineto

stroke
grestore
} def
%%EndGlobal
/saveobj save def
mark
10 S1 f
3198 3840 m
100 build_lh
3298 3840 m
10 CW f
(\\\(lh)3448 3840 w
10 S1 f
()3988 3840 w
cleartomark
saveobj restore
%%BeginGlobal
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
%%EndGlobal
/saveobj save def
mark
10 S1 f
3988 3840 m
100 build_rh
4088 3840 m
10 CW f
(\\\(rh)4238 3840 w
10 S f
(\354)1620 3960 w
10 CW f
(\\\(lt)1869 3960 w
10 S f
(\374)2409 3960 w
10 CW f
(\\\(rt)2658 3960 w
10 S f
(\351)3198 3960 w
10 CW f
(\\\(lc)3448 3960 w
10 S f
(\371)3988 3960 w
10 CW f
(\\\(rc)4238 3960 w
10 S f
(\356)1620 4080 w
10 CW f
(\\\(lb)1869 4080 w
10 S f
(\376)2409 4080 w
10 CW f
(\\\(rb)2658 4080 w
10 S f
(\353)3198 4080 w
10 CW f
(\\\(lf)3448 4080 w
10 S f
(\373)3988 4080 w
10 CW f
(\\\(rf)4238 4080 w
10 S f
(\355)1620 4200 w
10 CW f
(\\\(lk)1869 4200 w
10 S f
(\375)2409 4200 w
10 CW f
(\\\(rk)2658 4200 w
10 S f
(\357)3198 4200 w
10 CW f
(\\\(bv)3448 4200 w
10 S f
(V)3988 4200 w
10 CW f
(\\\(ts)4238 4200 w
10 S f
(\347)1620 4320 w
10 CW f
(\\\(br)1869 4320 w
10 S f
(|)2409 4320 w
10 CW f
(\\\(or)2658 4320 w
10 S f
(_)3198 4320 w
10 CW f
(\\\(ul)3448 4320 w
10 S f
(*)3988 4320 w
10 CW f
(\\\(**)4238 4320 w
10 R f
( names. The)2 509(These four characters also have two-character)5 1883 2 900 4650 t
10 CW f
(')3329 4650 w
10 R f
(is the apostrophe on terminals; the)5 1434 1 3426 4650 t
10 CW f
(`)4897 4650 w
10 R f
(is the)1 226 1 4994 4650 t
(other quote mark.)2 707 1 900 4770 t
(\302)1620 5010 w
10 CW f
(\\')1803 5010 w
10 R f
(\301)2323 5010 w
10 CW f
(\\`)2506 5010 w
10 S f
(-)3026 5010 w
10 CW f
(\\)3231 5010 w
10 S f
(-)3291 5010 w
10 R f
(\320)3746 5010 w
10 CW f
(\\\(em)3996 5010 w
10 R f
(For greek, precede the roman letter by)6 1526 1 900 5340 t
10 CW f
(\\\(*)2451 5340 w
10 R f
(to get the corresponding greek; for example,)6 1771 1 2656 5340 t
10 CW f
(\\\(*a)4452 5340 w
10 R f
(is)4717 5340 w
10 S f
(a)4809 5340 w
10 R f
(.)4872 5340 w
10 CW f
( w)1 128( q)1 126( x)1 124( f)1 123( u)1 115( s t)2 220( r)1 119( p)1 124( o)1 119( c)1 118( n)1 131( m)1 129( l)1 120( k)1 116( i)1 117( h)1 123( y)1 117( e z)2 222( d)1 110( g)1 114(a b)1 179 21 1626 5580 t
10 S f
( w)1 129( y)1 133( c)1 125( f)1 120( u)1 122( t)1 102( s)1 113( r)1 118( p)1 125( o)1 121( x)1 117( n)1 128( m)1 130( l)1 121( k)1 127( i)1 107( q)1 119( h)1 122( z)1 114( e)1 108( d)1 115( g)1 106(a b)1 179 23 1624 5700 t
10 CW f
( W)1 128( Q)1 126( X)1 124( F)1 123( U)1 115( S T)2 220( R)1 119( P)1 124( O)1 119( C)1 118( N)1 131( M)1 129( L)1 120( K)1 116( I)1 117( H)1 123( Y)1 117( E Z)2 222( D)1 110( G)1 114(A B)1 179 21 1626 5940 t
10 S f
( U F C Y W)5 624( T)1 112( R S)2 219( L M N X O P)6 744( K)1 136( I)1 96(A B G D E Z H Q)7 878 7 1620 6060 t
cleartomark
showpage
saveobj restore
%%EndPage: 1 1
%%Trailer
done
%%Pages: 1
%%DocumentFonts: Helvetica-Bold Times-Roman Symbol Courier Times-Roman
