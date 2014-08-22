
PUBDIR=/usr/pub

u=-mm;  if echo `basename $0` | grep mv >/dev/null;  then u=-mv;  fi
if test $# = 0;
then 
cat >&2 <<!
Usage: "mmt [options] files" (or "mvt [options] files") where "options" are:
 -a	=> output to terminal
 -e	=> eqn
 -p	=> pic
 -g	=> grap
 -t	=> tbl
 -Tptty	=> format for troff device ptty (post, i10, i300, pcl, X97.ti10p, X97.ti12p)
 -Dpost => send to PostScript
 -Dlino => send to MHCC Linotronics L200P (PostScript) phototypesetter
 -Di10	=> send to Imagen Imprint-10
 -Di300 => send to Imagen 8/300
 -Dhp   => send to HP LaserJet
 -Dxrx  => send to Xerox 4050,8700,9700
 -z	=> use no postprocessor for troff output
 -	=> instead of "files" inside a pipeline.
Other options as required by TROFF and the macros.
!
exit 1
fi
#	Linotronic L200P (PostScript) phototypesetter:
#		Connected directly, use o="|dpost"
#		To MHCC service, use o="|apsend"	(default)
#	PostScript laser printers:
#		Connected directly, use o="|dpost"
#		Spooled, use locally approved command (e.g., prt)	(default)
#	Imagen (Imprint-10, 8/300) laser printers:
#		Connected directly, use o="|dimpress"	(default, stdout)
#		Spooled, use locally approved command (e.g., i10send, prt)
#	Xerox 4050 Laser Printer
#		Connected directly, use "o=|dx9700 -T$ptty"
#		Spooled, use o="|dx9700 -T$ptty | prt -lraw"	(default)
#	Hewlett-Packard LaserJet laser printers:
#		Connected directly, use o="|dpcl"	(default, stdout)
#		Spooled, use locally approved command (e.g., prt)
#	Other output devices:  Use -Tdevice, -z, and pipe to command		
#
ptty=  x=  Teqn=  ec=${PUBDIR}/eqnchar
PATH=$PATH:/bin:/usr/bin  O=  o=""  y=
a= e= f= p= z= g=
while test -n "$1" -a ! -f "$1"
do case $1 in
	-a)	O="-a"  o=  x=  ;;
	-Tpost)	ptty=post
		o="|prt -ltroff"  x=  ;;
	-Dpost)	o="|prt -ltroff"  x=  ;;
	-Dlino)	o="|apsend"  x=  ;;
	-Ti10)	ptty=i10
		o="|dimpress"  x=  ;;
	-Di10)	o="|dimpress"  x=  ;;
	-Ti300) ptty=i300  ec=${PUBDIR}/i300eqnchar
		o="|dimpress"  ;;
	-Di300)	o="|dimpress"  x=  ;;
	-TX97.ti10p)	ptty=X97.ti10p
			o="|dx9700 -T$ptty |prt -lraw" ;;
	-TX97.ti12p)	ptty=X97.ti12p
			o="|dx9700 -T$ptty |prt -lraw" ;;
	-Dxrx)	o="|dx9700 -TX97.ti10p |prt -lraw"  x=  ;;
	-Tpcl)	ptty=pcl
		o="|dpcl"  x=  ;;
	-Dhp)	o="|dpcl"  x=  ;;
	-T*)	ptty=`echo $1 | sed "s/-T//"`
		o=  x=  ;;
	-e)	e=eqn ;;
	-t)	f=tbl ;;
	-p)	p=pic ;;
	-g)	g=grap  p=pic ;;
	-y)	;;
	-)	break ;;
	-z)	z=z  ;;
	*)	a="$a $1" ;;
   esac
   shift
done
if test -z "$1";  then echo "$0: no input file" >&2;  exit 1;  fi
if test -n "$ptty"
then troff="troff -T$ptty"
else troff=troff
fi
if test -n "$z";  then o=  x=;  fi
if test "|apsend" = "$o";  then x="$x c=$1";  fi
d="$*"
if test -n "$g";  then g="grap $d|";  d="-";  fi
if test -n "$p";  then p="pic $d|";  d="-";  fi
if test -n "$f";  then f="tbl $d|";  d="-";  fi
if test -n "$e";  then e="eqn $ec $d|";  d="-";  fi
if test "$u" != "-mv";  then y=;  fi
eval "$g $p $f $e $troff $y $O $u $a $d $o $x"; exit 0
