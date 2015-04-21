#
# Top level makefile. Brief instructions are included here. Check the README
# file for more details.
#
# First save a copy of this file. Then adjust the following definitions (all
# come immediatedly after the initial block of comments):
#
#     MAKE	where make lives
#
#     MAKEFILE	name of this file - for recursive make calls. Must change
#		if you rename this file.
#
#     SYSTEM	best match for your version of Unix. Current choices for
#		SYSTEM are:
#
#			SYSV	- System V
#			V9	- Ninth Edition
#			BSD4_2	- Berkeley (eg. Sun 3)
#
#		Controls conditional compilation in a few places. Try SYSV
#		and /usr/5bin/cc on a Sun 4.
#
#     VERSION	of the DWB package
#
#     GROUP	group assigned to all installed files
#
#     OWNER	owner of everything that's installed
#
#     HYPHALG	default troff hyphenation algorithm. Choose 0 for troff's
#		original version and 1 for the TeX algorithm. The algorithm
#		can also be set with the .ha request.
#
#     NDEVNAME	default nroff device
#
#     TDEVNAME	default troff device
#
#     ROOT	prepended to most directory pathnames.
#
#     BINDIR	most commands go here. Main exceptions are the PostScript
#		support programs that are installed in POSTBIN. BINDIR must
#		already exist - it will not be created during an install.
#
#     HOSTDIR	hostresident font directory for PostScript printers. Only
#		used in the font download program.
#
#     FONTDIR	width table directory - for troff and most postprocessors
#
#     LIBDIR	special library directory
#
#     MACRODIR	nroff/troff macro packages. Both nroff and troff look for
#		macro packages in TMACDIR (below). If MACRODIR and TMACDIR
#		are different, files in TMACDIR usually point to the real
#		macro packages in MACRODIR using a .so request.
#
#		If you have an older version of DWB that uses separate
#		directories for MACRODIR and TMACDIR, you probably should
#		leave things be. Otherwise think about defining MACRODIR
#		and TMACDIR to be the same directory (ideally /usr/lib/tmac).
#		If you're not already doing so, there's no good reason to
#		manage macro packages in two different directories.
#
#     MAN1DIR	command manpages. A command and its manpage are installed
#		together - there's no easy way to avoid it. Setting MAN1DIR
#		(and MAN5DIR) to an existing temporary directory (e.g. /tmp)
#		means an install will work but manpages won't go anywhere
#		permanent. MAN1DIR must already exist - it will not be
#		created during an install.
#
#     MAN5DIR	miscellaneous manpages - e.g. macro packages. Manpages are
#		always installed - there's no easy way to avoid it. Setting
#		MAN5DIR (and MAN1DIR) to some existing temporary directory
#		(e.g. /tmp) means an install will work but manpages won't
#		go anywhere permanent. MAN5DIR must already exist - it will
#		not be created during an install.
#
#		Bit of a problem here that hasn't been addressed. manpages
#		that go in section 5 on System V belong in section 6 or 7
#		on Ninth (and later) Edition Unix systems.
#
#     NTERMDIR	terminal table directory - for nroff
#
#     POSTBIN	where most PostScript support programs go. One reasonable
#		choice, if the PostScript support package is not already
#		installed, is to set POSTBIN to BINDIR.
#
#     POSTLIB	prologues and miscellaneous PostScript files. Primarily for
#		the programs that live in POSTBIN.
#
#     PUBDIR	eqnchar files and a few others go here
#
#     RASTDIR	top level raster file directory - only for laserjet and
#		imagen postprocessors. Be careful if you're installing the
#		laserjet or imagen drivers. You will need at least 4.5 meg
#		in RASTDIR for each device - 9 meg if both drivers are
#		installed.
#
#     TMACDIR	where nroff and troff look for macro packages
#
#     CFLGS	common compiler options - used to build CFLAGS in the low
#		level makefiles. CFLGS and LDFLGS are best set on the make
#		command line.
#
#     LDFLGS	common link editor options - used to build LDFLAGS in the
#		low level makefiles. LDFLGS and CFLGS are best set on the
#		make command line.
#
#     DKHOST	set it to TRUE to compile the DKHOST Datakit support code
#		in postio. Temporarily resets SYSTEM to SYSV if DKHOST is
#		TRUE and SYSTEM is BSD4_2. Ignored if SYSTEM is not SYSV
#		or BSD4_2.
#
#     DKSTREAMS enables streams based DKHOST support in postio when DKHOST
#		is TRUE and SYSTEM is SYSV or BSD4_2. Choices are TRUE,
#		FALSE, or a stream module name (e.g. dknetty or dkty). TRUE
#		selects dknetty. Newer systems may expect dkty.
#
#     ROUNDPAGE	must only be set to TRUE or FALSE. TRUE means PostScript
#		translators include code that maps clipping path dimensions
#		into known paper sizes.
#
#     TARGETS	the default list of what's built by make. Each target must
#		be the name of a source directory, either at the top level
#		(this directory) or one level down. Pathnames relative to
#		the top level directory are allowed (and often preferred),
#		so either,
#
#			TARGETS=troff
#
#		or,
#
#			TARGETS=text/troff
#
#		refer to the same source directory. A target that names a
#		non-existent source directory is ignored. Setting TARGETS
#		on the make command line overrides the default list.
#
# Source files must be updated whenever this file changes. If you change any
# definitions type,
#
#	make -f dwb.mk changes
#
# to update the source files, man pages, and low level makefiles.
#
# To build (but not install) the default package (i.e. everything named by
# TARGETS) type,
#
#	make -f dwb.mk all
#
# The recommended way to build and install the package is,
#
#	make -f dwb.mk all install
#
# You'll likely have to be root for the install to work.
#
# After the package is installed use,
#
#	make -f dwb.mk clobber
#
# to delete binary files and compiled programs from the source directories.
#
# Set TARGETS on the command line to select part of the package. For example,
#
#	make -f dwb.mk TARGETS="troff devpost" all install
#
# builds and installs troff and the PostScript font tables. Quotes hide white
# space from the shell. Setting TARGETS to a top level source directory builds
# everything under that directory. For example,
#
#	make -f dwb.mk TARGETS=postscript all install
#
# builds and installs the postscript support programs (i.e. everything named
# by TARGETS in file postscript/postscript.mk).
#

#MAKE=/bin/make
MAKEFILE=dwb.mk

SYSTEM=BSD4_2
VERSION=3.3

GROUP=bin
OWNER=root

HYPHALG=0
NDEVNAME=37
TDEVNAME=post

ROOT=/usr/local/dwb
BINDIR=$(ROOT)/bin
FONTDIR=$(ROOT)/lib/font
HOSTDIR=$(ROOT)/lib/font/postscript
LIBDIR=$(ROOT)/lib/dwb
MACRODIR=$(ROOT)/lib/macros
MAN1DIR=$(ROOT)/man/man1
MAN5DIR=$(ROOT)/man/man5
NTERMDIR=$(ROOT)/lib/nterm
POSTBIN=$(ROOT)/lbin/postscript
POSTLIB=$(ROOT)/lib/postscript
PUBDIR=$(ROOT)/pub
RASTDIR=$(ROOT)/lib/raster
TMACDIR=$(ROOT)/lib/tmac

CFLGS=-O
LDFLGS=-s

#
# PostScript specific definitions - they probably don't belong here.
#

DKHOST=FALSE
DKSTREAMS=FALSE
ROUNDPAGE=FALSE

#
# $(TARGETS) is the default list of things built by make.
#

TARGETS=doc\
	imagen\
	index\
	laserjet\
	macros\
	misc\
	postscript\
	text\
	text/otbl\
	xerox

ACTION=all

all : $(TARGETS)

clean clobber:
	@$(MAKE) -e -f $(MAKEFILE) MAKE=$(MAKE) ACTION=$@ $(TARGETS)

install changes :
	@SYSTEM='$(SYSTEM)'; export SYSTEM; \
	VERSION='$(VERSION)'; export VERSION; \
	GROUP='$(GROUP)'; export GROUP; \
	OWNER='$(OWNER)'; export OWNER; \
	HYPHALG='$(HYPHALG)'; export HYPHALG; \
	NDEVNAME='$(NDEVNAME)'; export NDEVNAME; \
	TDEVNAME='$(TDEVNAME)'; export TDEVNAME; \
	BINDIR='$(BINDIR)'; export BINDIR; \
	FONTDIR='$(FONTDIR)'; export FONTDIR; \
	HOSTDIR='$(HOSTDIR)'; export HOSTDIR; \
	LIBDIR='$(LIBDIR)'; export LIBDIR; \
	MACRODIR='$(MACRODIR)'; export MACRODIR; \
	MAN1DIR='$(MAN1DIR)'; export MAN1DIR; \
	MAN5DIR='$(MAN5DIR)'; export MAN5DIR; \
	NTERMDIR='$(NTERMDIR)'; export NTERMDIR; \
	POSTBIN='$(POSTBIN)'; export POSTBIN; \
	POSTLIB='$(POSTLIB)'; export POSTLIB; \
	PUBDIR='$(PUBDIR)'; export PUBDIR; \
	RASTDIR='$(RASTDIR)'; export RASTDIR; \
	TMACDIR='$(TMACDIR)'; export TMACDIR; \
	DKHOST='$(DKHOST)'; export DKHOST; \
	DKSTREAMS='$(DKSTREAMS)'; export DKSTREAMS; \
	ROUNDPAGE='$(ROUNDPAGE)'; export ROUNDPAGE; \
	$(MAKE) -e -f $(MAKEFILE) MAKE=$(MAKE) ACTION=$@ $(TARGETS)

$(TARGETS) ::
	@TARGETS=; unset TARGETS; \
	HFILES=; unset HFILES; \
	OFILES=; unset OFILES; \
	CFLAGS=; unset CFLAGS; \
	LDFLAGS=; unset LDFLAGS; \
	YFLAGS=; unset YFLAGS; \
	SYSTEM='$(SYSTEM)'; export SYSTEM; \
	VERSION='$(VERSION)'; export VERSION; \
	CFLGS='$(CFLGS)'; export CFLGS; \
	LDFLGS='$(LDFLGS)'; export LDFLGS; \
	FONTDIR='$(FONTDIR)'; export FONTDIR; \
	HOSTDIR='$(HOSTDIR)'; export HOSTDIR; \
	POSTLIB='$(POSTLIB)'; export POSTLIB; \
	MACRODIR='$(MACRODIR)'; export MACRODIR; \
	LIBDIR='$(LIBDIR)'; export LIBDIR; \
	TMACDIR='$(TMACDIR)'; export TMACDIR; \
	DIRS=`echo */$@ */*/$@`; \
	DIRS="$@ $$DIRS"; \
	HERE=`pwd`; \
	for i in $$DIRS; do \
	    if [ -d "$$i" ]; then \
		PREFIX=`echo $$i | sed s:/\.\*::`; \
		SUFFIX=`echo $$i | sed "s:^$$PREFIX/::"`; \
		cd $$PREFIX; \
		CURRENTDIR="$$PREFIX"; export CURRENTDIR; \
		if [ -f "$$PREFIX.mk" ]; then \
		    if [ "$$PREFIX" = "$$SUFFIX" ]; \
			then $(MAKE) -e -f $$PREFIX.mk MAKE=$(MAKE) $(ACTION); \
			else $(MAKE) -e -f $$PREFIX.mk MAKE=$(MAKE) TARGETS=$$SUFFIX $(ACTION); \
		    fi; \
		    if [ $$? -ne 0 ]; then \
			exit 1; \
		    fi; \
		fi; \
		cd $$HERE; \
	    fi; \
	done

