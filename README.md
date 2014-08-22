DWB3.3
======

This is a fork of the original Documenter's Workbench Release 3.3 which had
been made available as open source from AT&T Software Technology under Eclipse
Public License 1.0 at http://www2.research.att.com/sw/download/.
The purpose of this fork is to make this software compile and working on
current UNIX systems while making only minimum changes to the source code.
It is tested on 64 bit OpenBSD, NetBSD and Linux.

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

Bugs can be reported at:
https://github.com/carsten-kunze/DWB3.3/issues

On problems you can contact me under:<br />
Carsten Kunze &lt;carsten.kunze at arcor.de&gt;
