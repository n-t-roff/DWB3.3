'''	\"               Copyright c 1990 AT&T
'''	\"                All Rights Reserved
'''	\" THIS DOCUMENT CONTAINS PROPRIETARY INFORMATION OF
'''	\" AT&T AND IS NOT TO BE DISCLOSED OR USED EXCEPT IN
'''	\"      ACCORDANCE WITH APPLICABLE AGREEMENTS.
'''	\"
.so ../defs.doc
.ds pT MVIEW
.aP "" Examples
.P
This Appendix contains several view graphs produced by the
.I troff
text formatter and the
.sM MVIEW
macro package.
The table in Example 10 was created with the
.I tbl
preprocessor.
The mathematics in Example 11 were typeset with the
.I eqn
preprocessor.
The picture in Example 12 was drawn with the
.I pic
preprocessor.
The graph in Example 13 was plotted with the
.I grap
preprocessor.
.P
Each output sample, originally generated as a full page
PostScript\*(Rg image, is automatically scaled to size,
.FS ""
PostScript is a registered trademark of Adobe Systems, Inc.
.FE
boxed, and merged onto the page using the
.I mpictures
PostScript picture inclusion facility.
As such, the frame dimensions and point sizes used for
text shown in the output samples may differ from those
specified in the input samples; the original full-page
output samples are true to form.
'''	\" FORCE PG
.SK
.HU "Example 1"
.sy troff -Tpost -mview mview.ex1 | dpost -B >ps.ex1
.BP ps.ex1 6.25i 6i 0 o
.SK
.HU "Example 2"
.sy troff -Tpost -mview mview.ex2 | dpost -B >ps.ex2
.BP ps.ex2 6.25i 6i 0 o
.SK
.HU "Example 3"
.sy troff -Tpost -mview mview.ex3 | dpost -B >ps.ex3
.BP ps.ex3 6.25i 6i 0 o
.SK
.HU "Example 4"
.sy troff -Tpost -rf2 -mview mview.ex4 | dpost -B >ps.ex4
.BP ps.ex4 6.25i 6i 0 o
.SK
.HU "Example 5"
.sy troff -Tpost -mview mview.ex5 | dpost -B >ps.ex5
.BP ps.ex5 6.75i 6i 0 o
.SK
.HU "Example 6"
.sy troff -Tpost -mview mview.ex6 | dpost -B >ps.ex6
.BP ps.ex6 6.5 6i 0 o
.SK
.HU "Example 7"
.sy troff -Tpost -mview mview.ex7 | dpost -B >ps.ex7
.BP ps.ex7 7.25i 6i 0 o
.SK
.HU "Example 8"
.sy troff -Tpost -mview mview.ex8 | dpost -B >ps.ex8
.BP ps.ex8 6.25i 6i 0 o
.SK
.HU "Example 9"
.sy troff -Tpost -mview mview.ex9 | dpost -B >ps.ex9
.BP ps.ex9 6.5i 6i 0 o
.SK
.HU "Example 10"
.sy tbl mview.ex10 | troff -Tpost -mview - | dpost -B >ps.ex10
.BP ps.ex10 6.75i 6i 0 o
.SK
.HU "Example 11"
.sy eqn mview.ex11 | troff -Tpost -rf1 -mview - | dpost -B >ps.ex11
.BP ps.ex11 6.75i 6i 0 o
.SK
.HU "Example 12"
.sy pic mview.ex12 | troff -Tpost -mview - | dpost -B >ps.ex12
.BP ps.ex12 6i 6i 0 o
.SK
.HU "Example 13"
.sy grap mview.ex13 | pic | troff -Tpost -mview - | dpost -B >ps.ex13
.BP ps.ex13 6.75i 6i 0 o
