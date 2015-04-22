DWB3.3
======

This is a fork of the original Documenter's Workbench Release 3.3 which had
been made available as open source from AT&T Software Technology under Eclipse
Public License 1.0 at http://www2.research.att.com/sw/download/.
The purpose of this fork is to make this software compile and working on
current UNIX systems while making only minimum changes to the source code.
It is tested on 64 bit OpenBSD, NetBSD, FreeBSD, and Linux.

The DWB does include the preprocessor *Picasso* which can be
used as a `pic`(1) replacement (at least if `grap`(1)
is not used).
It can also generate PostSript output directly (which can be inserted via
`.BP` or `.PI`).
The language of picasso is similar to that of pic but it has additional
capabilities (e.g. setting line thickness and gray-scale or color filling).
Picasso also has a GUI on OPEN LOOK systems (not tested for
this port).
The picasso documentation can be generated in directory
`doc/picasso` by typing `./Run`.
(`text/picasso` also contains the original AT&T `yacc` source code...)

Please note that DWB is of limited use for viewing today's manual pages.
mdoc(7) had not been available when DWB 3.3 was released so this macro
package is not included.
Well written manual pages using man(7) usually should work but some
(e.g. generated from other languages) are using special groff(1)
features which are not available in DWB.
On the other hand many DWB manual pages are only formated correctly by
DWB itself since there are some DWB extensions in it's man macros.
groff(1), Heirloom nroff, or mandoc(1) should not be used to view DWB
manual pages.

A list of the currently tested components can be found in the
[wiki](https://github.com/n-t-roff/DWB3.3/wiki/Porting-status).
If there are any problems please add an issue to the
[issue list](https://github.com/n-t-roff/DWB3.3/issues).

The source code can be downloaded as a zip archive with the "Download ZIP"
button or with the git command
```bash
git clone https://github.com/n-t-roff/DWB3.3.git
```
For the configuration the file dwb.mk can be modified, although reasonable
defaults has been set.
Default installation directory is
```bash
/usr/local/dwb
```
This would require to add `/usr/local/dwb/man/man1` and
`/usr/local/dwb/man/man5` to the systems man path.
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
A git repository can be kept up-to-date with `git pull`.

Bugs can be reported at the
[issue list](https://github.com/n-t-roff/DWB3.3/issues).

Please note that the included README file is kept unchanged from the original DWB package.
Parts of it's contents may be outdated.

If there are any problems mail can be send to &lt;troff [at] arcor [dot] de&gt;.
