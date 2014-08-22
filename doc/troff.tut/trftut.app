'''	\"               Copyright c 1990 AT&T
'''	\"                All Rights Reserved
'''	\" THIS DOCUMENT CONTAINS PROPRIETARY INFORMATION OF
'''	\" AT&T AND IS NOT TO BE DISCLOSED OR USED EXCEPT IN
'''	\"      ACCORDANCE WITH APPLICABLE AGREEMENTS.
'''	\"
.so ../defs.doc
.ds pT "TROFF Tutorial
.aP "" "Character Set"
.po +0.25i
.sp
Different output devices support different character sets,
although there is considerable commonality.
.br
To get the one on the left, type the
four-character name on the right.
.in +1i
.TS
l l6f5 l l6f5 l l6f5 l l6f5.
\(ff	\e(ff	\(fi	\e(fi	\(fl	\e(fl	\(Fi	\e(Fi	\(Fl	\e(Fl
\(ru	\e(ru	\(em	\e(em	\(14	\e(14	\(12	\e(12	\(34	\e(34
\(co	\e(co	\(de	\e(de	\(dg	\e(dg	\(fm	\e(fm	\(ct	\e(ct	
\(rg	\e(rg	\(bu	\e(bu	\(sq	\e(sq	\(hy	\e(hy
.TE
.in -1i
.sp 0.75v
The following are special-font characters:
.in +1i
.TS
l l6f5 l l6f5 l l6f5 l l6f5.
\(pl	\e(pl	\(mi	\e(mi	\(mu	\e(mu	\(di	\e(di	
\(eq	\e(eq	\(==	\e(==	\(>=	\e(>=	\(<=	\e(<=	
\(!=	\e(!=	\(+-	\e(+-	\(no	\e(no	\(sl	\e(sl	
\(ap	\e(ap	\(~=	\e(~=	\(pt	\e(pt	\(gr	\e(gr	
\(->	\e(->	\(<-	\e(<-	\(ua	\e(ua	\(da	\e(da	
\(is	\e(is	\(pd	\e(pd	\(if	\e(if	\(rn	\e(rn	
\(sb	\e(sb	\(sp	\e(sp	\(cu	\e(cu	\(sr	\e(sr	
\(ib	\e(ib	\(ip	\e(ip	\(mo	\e(mo	\(ca	\e(ca	
\(aa	\e(aa	\(ga	\e(ga	\(ci	\e(ci	\(es	\e(es	
\(sc	\e(sc	\(dd	\e(dd	\(lh	\e(lh	\(rh	\e(rh	
\(lt	\e(lt	\(rt	\e(rt	\(lc	\e(lc	\(rc	\e(rc	
\(lb	\e(lb	\(rb	\e(rb	\(lf	\e(lf	\(rf	\e(rf	
\(lk	\e(lk	\(rk	\e(rk	\(bv	\e(bv	\(ts	\e(ts	
\(br	\e(br	\(or	\e(or	\(ul	\e(ul	\(**	\e(**
.TE
.in -1i
.sp 0.75v
These
four
characters also have two-character names. 
The
.cR '
is the apostrophe on terminals;
the
.cR `
is the
other quote mark.
.in +1i
.TS
l l8f5 l l8f5 l l8f5 l l8f5.
\'	\e'	\`	\e`	\(mi	\e\(mi	\(em	\e(em
.TE
.in -1i
.sp 0.75v
For greek, precede the roman letter by
.cR \e(*
to get the corresponding greek;
for example, 
.cR \e(*a
is
\(*a.
.in +1i
.TS
tab(!);
c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5
c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1  .
a!b!g!d!e!z!y!h!i!k!l!m!n!c!o!p!r!s!t!u!f!x!q!w!
\(*a!\(*b!\(*g!\(*d!\(*e!\(*z!\(*y!\(*h!\(*i!\(*k!\(*l!\(*m!\(*n!\(*c!\(*o!\(*p!\(*r!\(*s!\(*t!\(*u!\(*f!\(*x!\(*q!\(*w
.sp
.T&
c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5 c1f5
c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1   c1  .
A!B!G!D!E!Z!Y!H!I!K!L!M!N!C!O!P!R!S!T!U!F!X!Q!W!
\(*A!\(*B!\(*G!\(*D!\(*E!\(*Z!\(*Y!\(*H!\(*I!\(*K!\(*L!\(*M!\(*N!\(*C!\(*O!\(*P!\(*R!\(*S!\(*T!\(*U!\(*F!\(*X!\(*Q!\(*W
.TE
.in -1i
.po -0.25i
