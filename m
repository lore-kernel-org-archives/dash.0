From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 2/4] input: Remove HETIO
Date: Mon, 05 Jan 2015 23:01:53 +1100
Message-ID: <E1Y86M5-0001mW-GT@gondolin.me.apana.org.au>
References: <20150105120030.GA6101@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:43334 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbbAEMCF (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 5 Jan 2015 07:02:05 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>, Eric Blake <eblake@redhat.com>, Oleg Bulatov <oleg@bulatov.me>, dash@vger.kernel.org, Juergen Daubert <jue@jue.li>

It hasn't been possible to build HETIO for over ten years.  So
let's just kill it.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 src/Makefile.am |    2 
 src/hetio.c     |  397 --------------------------------------------------------
 src/hetio.h     |   22 ---
 src/input.c     |    9 -
 src/main.c      |    8 -
 src/trap.c      |    7 
 6 files changed, 1 insertion(+), 444 deletions(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index 2a37381..120ffa2 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -26,7 +26,7 @@ dash_CFILES = \
 dash_SOURCES = \
 	$(dash_CFILES) \
 	alias.h arith_yacc.h bltin/bltin.h cd.h error.h eval.h exec.h \
-	expand.h hetio.h \
+	expand.h \
 	init.h input.h jobs.h machdep.h mail.h main.h memalloc.h miscbltin.h \
 	myhistedit.h mystring.h options.h output.h parser.h redir.h shell.h \
 	show.h system.h trap.h var.h
diff --git a/src/hetio.c b/src/hetio.c
deleted file mode 100644
index f7d175f..0000000
--- a/src/hetio.c
+++ /dev/null
@@ -1,397 +0,0 @@
-/*
- * Termios command line History and Editting for NetBSD sh (ash)
- * Copyright (c) 1999
- *	Main code:	Adam Rogoyski <rogoyski@cs.utexas.edu>
- *	Etc:		Dave Cinege <dcinege@psychosis.com>
- *
- * You may use this code as you wish, so long as the original author(s)
- * are attributed in any redistributions of the source code.
- * This code is 'as is' with no warranty.
- * This code may safely be consumed by a BSD or GPL license.
- *
- * v 0.5  19990328	Initial release
- *
- * Future plans: Simple file and path name completion. (like BASH)
- *
- */
-
-/*
-Usage and Known bugs:
-	Terminal key codes are not extensive, and more will probably
-	need to be added. This version was created on Debian GNU/Linux 2.x.
-	Delete, Backspace, Home, End, and the arrow keys were tested
-	to work in an Xterm and console. Ctrl-A also works as Home.
-	Ctrl-E also works as End. Ctrl-D and Ctrl-U perform their respective
-	functions. The binary size increase is <3K.
-
-	Editting will not display correctly for lines greater then the
-	terminal width. (more then one line.) However, history will.
-*/
-
-#include <stdio.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <string.h>
-#include <termios.h>
-#include <ctype.h>
-#include <sys/ioctl.h>
-
-#include "input.h"
-#include "output.h"
-
-#include "hetio.h"
-
-
-#define  MAX_HISTORY   15			/* Maximum length of the linked list for the command line history */
-
-#define ESC	27
-#define DEL	127
-
-static struct history *his_front = NULL;	/* First element in command line list */
-static struct history *his_end = NULL;		/* Last element in command line list */
-static struct termios old_term, new_term;	/* Current termio and the previous termio before starting ash */
-
-static int history_counter = 0;			/* Number of commands in history list */
-static int reset_term = 0;			/* Set to true if the terminal needs to be reset upon exit */
-static int hetio_inter = 0;
-
-struct history
-{
-   char *s;
-   struct history *p;
-   struct history *n;
-};
-
-
-void input_delete    (int);
-void input_home      (int *);
-void input_end       (int *, int);
-void input_backspace (int *, int *);
-
-
-
-void hetio_init(void)
-{
-	hetio_inter = 1;
-}
-
-
-void hetio_reset_term(void)
-{
-	if (reset_term)
-		tcsetattr(1, TCSANOW, &old_term);
-}
-
-
-void setIO(struct termios *new, struct termios *old)	/* Set terminal IO to canonical mode, and save old term settings. */
-{
-	tcgetattr(0, old);
-	memcpy(new, old, sizeof(*new));
-	new->c_cc[VMIN] = 1;
-	new->c_cc[VTIME] = 0;
-	new->c_lflag &= ~ICANON; /* unbuffered input */
-	new->c_lflag &= ~ECHO;
-	tcsetattr(0, TCSANOW, new);
-}
-
-void input_home(int *cursor)				/* Command line input routines */
-{
- 	while (*cursor > 0) {
-		out1c('\b');
-		--*cursor;
-	}
-	flushout(out1);
-}
-
-
-void input_delete(int cursor)
-{
-	int j = 0;
-
-	memmove(parsenextc + cursor, parsenextc + cursor + 1,
-		BUFSIZ - cursor - 1);
-	for (j = cursor; j < (BUFSIZ - 1); j++) {
-		if (!*(parsenextc + j))
-			break;
-		else
-			out1c(*(parsenextc + j));
-	}
-
-	out1str(" \b");
-
-	while (j-- > cursor)
-		out1c('\b');
-	flushout(out1);
-}
-
-
-void input_end(int *cursor, int len)
-{
-	while (*cursor < len) {
-		out1str("\033[C");
-		++*cursor;
-	}
-	flushout(out1);
-}
-
-
-void
-input_backspace(int *cursor, int *len)
-{
-	int j = 0;
-
-	if (*cursor > 0) {
-		out1str("\b \b");
-		--*cursor;
-		memmove(parsenextc + *cursor, parsenextc + *cursor + 1,
-			BUFSIZ - *cursor + 1);
-
-		for (j = *cursor; j < (BUFSIZ - 1); j++) {
-			if (!*(parsenextc + j))
-				break;
-			else
-				out1c(*(parsenextc + j));
-		}
-
-		out1str(" \b");
-
-		while (j-- > *cursor)
-			out1c('\b');
-
-		--*len;
-		flushout(out1);
-	}
-}
-
-int hetio_read_input(int fd)
-{
-	int nr = 0;
-
-	/* Are we an interactive shell? */
-	if (!hetio_inter || fd) {
-		return -255;
-	} else {
-		int len = 0;
-		int j = 0;
-		int cursor = 0;
-		int break_out = 0;
-		int ret = 0;
-		char c = 0;
-		struct history *hp = his_end;
-
-		if (!reset_term) {
-			setIO(&new_term, &old_term);
-			reset_term = 1;
-		} else {
-			tcsetattr(0, TCSANOW, &new_term);
-		}
-
-		memset(parsenextc, 0, BUFSIZ);
-
-		while (1) {
-			if ((ret = read(fd, &c, 1)) < 1)
-				return ret;
-
-			switch (c) {
-   				case 1:		/* Control-A Beginning of line */
-   					input_home(&cursor);
-					break;
-				case 5:		/* Control-E EOL */
-					input_end(&cursor, len);
-					break;
-				case 4:		/* Control-D */
-					if (!len)
-						exitshell(0);
-					break;
-				case 21: 	/* Control-U */
-					/* Return to begining of line. */
-					for (; cursor > 0; cursor--)
-						out1c('\b');
-					/* Erase old command. */
-					for (j = 0; j < len; j++) {
-						/*
-						 * Clear buffer while we're at
-						 * it.
-						 */
-						parsenextc[j] = 0;
-						out1c(' ');
-					}
-					/* return to begining of line */
-					for (; len > 0; len--)
-						out1c('\b');
-					flushout(out1);
-					break;
-				case '\b':	/* Backspace */
-				case DEL:
-					input_backspace(&cursor, &len);
-					break;
-				case '\n':	/* Enter */
-					*(parsenextc + len++ + 1) = c;
-					out1c(c);
-					flushout(out1);
-					break_out = 1;
-					break;
-				case ESC:	/* escape sequence follows */
-					if ((ret = read(fd, &c, 1)) < 1)
-						return ret;
-
-					if (c == '[' ) {    /* 91 */
-						if ((ret = read(fd, &c, 1)) < 1)
-							return ret;
-
-						switch (c) {
-							case 'A':
-								if (hp && hp->p) {		/* Up */
-									hp = hp->p;
-									goto hop;
-								}
-								break;
-							case 'B':
-								if (hp && hp->n && hp->n->s) {	/* Down */
-									hp = hp->n;
-									goto hop;
-								}
-								break;
-
-hop:						/* hop */
-								len = strlen(parsenextc);
-
-								for (; cursor > 0; cursor--)		/* return to begining of line */
-									out1c('\b');
-
-		   						for (j = 0; j < len; j++)		/* erase old command */
-									out1c(' ');
-
-								for (; j > 0; j--)		/* return to begining of line */
-									out1c('\b');
-
-								strcpy (parsenextc, hp->s);		/* write new command */
-								len = strlen (hp->s);
-								out1str(parsenextc);
-								flushout(out1);
-								cursor = len;
-								break;
-							case 'C':		/* Right */
-								if (cursor < len) {
-									out1str("\033[C");
-									cursor++;
-									flushout(out1);
-						 		}
-								break;
-							case 'D':		/* Left */
-								if (cursor > 0) {
-									out1str("\033[D");
-									cursor--;
-									flushout(out1);
-								}
-								break;
-							case '3':		/* Delete */
-								if (cursor != len) {
-									input_delete(cursor);
-									len--;
-								}
-								break;
-							case '1':		/* Home (Ctrl-A) */
-								input_home(&cursor);
-								break;
-							case '4':		/* End (Ctrl-E) */
-								input_end(&cursor, len);
-								break;
-						}
-						if (c == '1' || c == '3' || c == '4')
-							if ((ret = read(fd, &c, 1)) < 1)
-								return ret;  /* read 126 (~) */
-					}
-
-					if (c == 'O') {	/* 79 */
-						if ((ret = read(fd, &c, 1)) < 1)
-							return ret;
-						switch (c) {
-							case 'H':		/* Home (xterm) */
-      								input_home(&cursor);
-								break;
-							case 'F':		/* End (xterm_ */
-								input_end(&cursor, len);
-								break;
-						}
-					}
-
-					c = 0;
-					break;
-
-				default:				/* If it's regular input, do the normal thing */
-					if (!isprint(c))		/* Skip non-printable characters */
-						break;
-
-	       				if (len >= (BUFSIZ - 2))	/* Need to leave space for enter */
-		  				break;
-
-					len++;
-
-					if (cursor == (len - 1)) {	/* Append if at the end of the line */
-						*(parsenextc + cursor) = c;
-					} else {			/* Insert otherwise */
-						memmove(parsenextc + cursor + 1, parsenextc + cursor,
-							len - cursor - 1);
-
-						*(parsenextc + cursor) = c;
-
-						for (j = cursor; j < len; j++)
-							out1c(*(parsenextc + j));
-						for (; j > cursor; j--)
-							out1str("\033[D");
-					}
-
-					cursor++;
-					out1c(c);
-					flushout(out1);
-					break;
-			}
-
-			if (break_out)		/* Enter is the command terminator, no more input. */
-				break;
-		}
-
-		nr = len + 1;
-		tcsetattr(0, TCSANOW, &old_term);
-
-		if (*(parsenextc)) {		/* Handle command history log */
-			struct history *h = his_end;
-
-			if (!h) {       /* No previous history */
-				h = his_front = malloc(sizeof (struct history));
-				h->n = malloc(sizeof (struct history));
-				h->p = NULL;
-				h->s = strdup(parsenextc);
-
-				h->n->p = h;
-				h->n->n = NULL;
-				h->n->s = NULL;
-				his_end = h->n;
-				history_counter++;
-			} else {	/* Add a new history command */
-
-				h->n = malloc(sizeof (struct history));
-
-				h->n->p = h;
-				h->n->n = NULL;
-				h->n->s = NULL;
-				h->s = strdup(parsenextc);
-				his_end = h->n;
-
-				if (history_counter >= MAX_HISTORY) {	/* After max history, remove the last known command */
-					struct history *p = his_front->n;
-
-					p->p = NULL;
-					free(his_front->s);
-					free(his_front);
-					his_front = p;
-				} else {
-					history_counter++;
-				}
-			}
-		}
-	}
-
-	return nr;
-}
diff --git a/src/hetio.h b/src/hetio.h
deleted file mode 100644
index c3e915c..0000000
--- a/src/hetio.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Termios command line History and Editting for NetBSD sh (ash)
- * Copyright (c) 1999
- *	Main code:	Adam Rogoyski <rogoyski@cs.utexas.edu> 
- *	Etc:		Dave Cinege <dcinege@psychosis.com>
- *
- * You may use this code as you wish, so long as the original author(s)
- * are attributed in any redistributions of the source code.
- * This code is 'as is' with no warranty.
- * This code may safely be consumed by a BSD or GPL license.
- *
- * v 0.5  19990328	Initial release 
- *
- * Future plans: Simple file and path name completion. (like BASH)
- *
- */
-
-void hetio_init(void);
-int hetio_read_input(int fd);
-void hetio_reset_term(void);
-
-extern int hetio_inter;
diff --git a/src/input.c b/src/input.c
index aa5dcfc..232bb9c 100644
--- a/src/input.c
+++ b/src/input.c
@@ -58,10 +58,6 @@
 #include "myhistedit.h"
 #endif
 
-#ifdef HETIO
-#include "hetio.h"
-#endif
-
 #define EOF_NLEFT -99		/* value of parsenleft when EOF pushed back */
 #define IBUFSIZ (BUFSIZ + 1)
 
@@ -188,11 +184,6 @@ retry:
 
 	} else
 #endif
-
-#ifdef HETIO
-		nr = hetio_read_input(parsefile->fd);
-		if (nr == -255)
-#endif
 		nr = read(parsefile->fd, buf, IBUFSIZ - 1);
 
 
diff --git a/src/main.c b/src/main.c
index 985e8c4..bedb663 100644
--- a/src/main.c
+++ b/src/main.c
@@ -60,10 +60,6 @@
 #include "exec.h"
 #include "cd.h"
 
-#ifdef HETIO
-#include "hetio.h"
-#endif
-
 #define PROFILE 0
 
 int rootpid;
@@ -206,10 +202,6 @@ cmdloop(int top)
 	int numeof = 0;
 
 	TRACE(("cmdloop(%d) called\n", top));
-#ifdef HETIO
-	if(iflag && top)
-		hetio_init();
-#endif
 	for (;;) {
 		int skip;
 
diff --git a/src/trap.c b/src/trap.c
index b924661..82d4263 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -51,10 +51,6 @@
 #include "trap.h"
 #include "mystring.h"
 
-#ifdef HETIO
-#include "hetio.h"
-#endif
