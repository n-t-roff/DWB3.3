'''	\"               Copyright c 1990 AT&T
'''	\"                All Rights Reserved
'''	\" THIS DOCUMENT CONTAINS PROPRIETARY INFORMATION OF
'''	\" AT&T AND IS NOT TO BE DISCLOSED OR USED EXCEPT IN
'''	\"      ACCORDANCE WITH APPLICABLE AGREEMENTS.
'''	\"
.so ../defs.doc
.ds pT EQN
.aP "" "Tuning \s-1EQN\s+1 Output"
.P
There are numerous values that can be adjusted to tune the output of
.I eqn
for a particular output device.
In general, it is necessary to have access to the source code
to do this tuning.
.P
Some values can be set without access to the source.
The names shown below (together with their default values) control the positioning
of diacritical marks and special characters.
They can be defined with any string value,
as in
.iS
define vec_def % \ev'-.5m'\es-3\e(->\es0\ev'.5m' %
.iE
.P
The amount by which a subscript is shifted down
and a superscript shifted up are controlled by
.cR Subbase
and
.cR Supbase .
.sp
.DS CB
.ft 5
.ta +15n
vec_def	\ev'-.5m'\es-3\e(->\es0\ev'.5m'
dyad_def	\ev'-.5m'\es-3\ez\e(<-\e|\e(->\es0\ev'.5m'
hat_def	\ev'-.05m'\es+1^\es0\ev'.05m'
tilde_def	\ev'-.05m'\es+1~\es0\ev'.05m'
dot_def	\ev'-.67m'.\ev'.67m'
dotdot_def	\ev'-.67m'..\ev'.67m'
utilde_def	\ev'1.0m'\es+2~\es-2\ev'-1.0m'
sum_def	\e|\ev'.3m'\es+5\e(*S\es-5\ev'-.3m'\e|
union_def	\e|\ev'.3m'\es+5\e(cu\es-5\ev'-.3m'\e|
inter_def	\e|\ev'.3m'\es+5\e(ca\es-5\ev'-.3m'\e|
prod_def	\e|\ev'.3m'\es+5\e(*P\es-5\ev'-.3m'\e|
int_def	\ev'.1m'\es+4\e(is\es-4\ev'-.1m'
Subbase	0.2
Supbase	0.4
.ft 1
.ta
.DE
.br
