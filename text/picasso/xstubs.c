/*	Copyright (c) 1990 AT&T	*/
/*	  All Rights Reserved  	*/

/*	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T	*/
/*	The copyright notice above does not evidence any   	*/
/*	actual or intended publication of such source code.	*/

/*	@(#)picasso:xstubs.c	1.0	*/

/*	For systems without X and OpenLook libraries		*/

int
Xokay(void) {
	return 0;
}

int
Xloop(void) {
	return 0;
}

int
Xendpl(void) {
	return 0;
}

int
Xopenpl(char *s) {
	(void)s;
	return 0;
}

int
Xclosepl(char *s) {
	(void)s;
	return 0;
}

int
Xprint(char t) {
	(void)t;
	return 0;
}

int
Xallexpose(void) {
	return 0;
}

int
writemessage(char *msgbuf, int secs, int bell) {
	(void)msgbuf;
	(void)secs;
	(void)bell;
	return 0;
}

