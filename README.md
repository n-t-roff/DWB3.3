DWB3.3
======

This is a fork of the original Documenter's Workbench Release 3.3 which had
been made available as open source from AT&T Software Technology under Eclipse
Public License 1.0 at http://www2.research.att.com/sw/download/.
The purpose of this fork is to make this software compile and working on
current UNIX systems while making only minimum changes to the source code.
It is tested on 64 bit OpenBSD, NetBSD and Linux.

The DWB does include the preprocessor _Picasso_<sup>TM</sup> which can be
used as a `pic`(1) replacement (at least if `grap`(1)
is not used).
It can also generate PostSript output directly (which can be inserted via
`.BP` or `.PI`).
The language of picasso is similar to that of pic but it has additional
capabilities (e.g. line thickness and gray-scale or color filling).
Picasso also has a GUI on OPEN LOOK<sup>&reg;</sup> systems (not tested for
this port).
The picasso documentation can be generated in directory
`doc/picasso` by typing `./Run`.

Currently tested tools are `nroff`, `neqn` (slightly), `troff`, `eqn`, `tbl`,
`pic`, `grap`, `picasso` and `dpost`.
Tested macro packages are `mpictures` and `man`.
Other tools and macro packages will follow.
If there are problems please add an issue to the
[issue list](https://github.com/n-t-roff/DWB3.3/issues).

For the configuration the file dwb.mk must be edited, although reasonable
defaults has been set.
Default installation directory is

```bash
/usr/local/dwb
```

Other settings should only be changed if really necessary.  E.g. the variable

```makefile
SYSTEM=BSD4_2
```

must be left unchanged regardless of the OS.

The software is build with

```bash
make -f dwb.mk
```

and installed with

```bash
make -f dwb.mk install
```
  
After installation locally build data is cleaned up with

```bash
make -f dwb.mk clobber
```

Bugs can be reported at
https://github.com/n-t-roff/DWB3.3/issues

If there are any problems mail can be send to troff@arcor.de
