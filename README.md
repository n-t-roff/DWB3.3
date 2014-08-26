DWB3.3
======

This is a fork of the original Documenter's Workbench Release 3.3 which had
been made available as open source from AT&T Software Technology under Eclipse
Public License 1.0 at http://www2.research.att.com/sw/download/.
The purpose of this fork is to make this software compile and working on
current UNIX systems while making only minimum changes to the source code.
It is tested on 64 bit OpenBSD, NetBSD and Linux.

The DWB does include the preprocessor ''Picasso''<sup>TM</sup> which can be
used as a <code>pic(1)</code> replacement (at least if <code>grap(1)</code>
is not used).
It can also generate PostSript output directly (which can be inserted via
<code>.BP</code> or <code>.PI</code>).
The language of picasso is similar to that of pic but it has additional
capabilities (e.g. line thickness and gray-scale or color filling).
Picasso also has a GUI on OPEN LOOK<sup>&reg;</sup> systems (not tested for
this port).
The picasso documentation can be generated in directory
<code>doc/picasso</code> by typing <code>./Run</code>.

For the configuration the file dwb.mk must be edited, although reasonable
defaults has been set.
Default installation directory is

<code>/usr/local/dwb</code>

Other settings should only be changed if really necessary.  E.g. the variable

<code>SYSTEM=BSD4_2</code>

must be left unchanged regardless of the OS.

The software is build with

<code>make -f dwb.mk</code>

and installed with

<code>make -f dwb.mk install</code>
  
After installation locally build data is cleaned up with

<code>make -f dwb.mk clobber</code>

Bugs can be reported at
https://github.com/n-t-roff/DWB3.3/issues

If there are any problems mail can be send to troff@arcor.de
