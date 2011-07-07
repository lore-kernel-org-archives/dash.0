From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 4/4] [MAIN] Optimize dash -c "command" to avoid a fork
Date: Thu, 7 Jul 2011 13:56:03 +0800
Message-ID: <20110707055602.GA17215@gondor.apana.org.au>
References: <20110410071734.GA16736@elie> <20110410073649.GD17649@elie> <20110707034833.GC16157@gondor.apana.org.au> <20110707042753.GA7684@elie> <20110707045719.GA16810@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:44403 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab1GGF4I (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Jul 2011 01:56:08 -0400
Content-Disposition: inline
In-Reply-To: <20110707045719.GA16810@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org, Jilles Tjoelker <jilles@stack.nl>, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

On Thu, Jul 07, 2011 at 12:57:19PM +0800, Herbert Xu wrote:
> On Wed, Jul 06, 2011 at 11:27:53PM -0500, Jonathan Nieder wrote:
> >
> > Will that work?  Without the preadateof check, I would worry that
> > passing EV_EXIT to evalstring would break:
> > 
> > 	$ dash -c 'echo one
> > 		echo two'
> > 	one
> 
> You're right.  I'll back this out for now.

OK, what about this patch?

diff --git a/ChangeLog b/ChangeLog
index 7367c33..c457fc8 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2011-07-07  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Optimize dash -c "command" to avoid a fork.
+
 2011-04-10  Jonathan Nieder <jrnieder@gmail.com>
  
 	* Remove unused EV_BACKCMD flag.
diff --git a/src/Makefile.am b/src/Makefile.am
index ba68d55..05ed70a 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -33,7 +33,7 @@ dash_LDADD = builtins.o init.o nodes.o signames.o syntax.o
 
 HELPERS = mkinit mksyntax mknodes mksignames
 
-BUILT_SOURCES = builtins.h nodes.h syntax.h token.h
+BUILT_SOURCES = builtins.h nodes.h syntax.h token.h token_vars.h
 CLEANFILES = \
 	$(BUILT_SOURCES) $(patsubst %.o,%.c,$(dash_LDADD)) \
 	$(HELPERS) builtins.def
@@ -44,7 +44,7 @@ EXTRA_DIST = \
 	mktokens mkbuiltins builtins.def.in mkinit.c \
 	mknodes.c nodetypes nodes.c.pat mksyntax.c mksignames.c
 
-token.h: mktokens
+token.h token_vars.h: mktokens
 	sh $^
 
 builtins.def: builtins.def.in $(top_builddir)/config.h
diff --git a/src/eval.c b/src/eval.c
index 86423b4..6e7b932 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -65,10 +65,6 @@
 #endif
 
 
-/* flags in argument to evaltree */
-#define EV_EXIT 01		/* exit after evaluating tree */
-#define EV_TESTED 02		/* exit status is checked; ignore -e flag */
-
 int evalskip;			/* set if we are skipping commands */
 STATIC int skipcount;		/* number of levels to skip */
 MKINIT int loopnest;		/* current loop nesting level */
@@ -169,7 +165,7 @@ evalstring(char *s, int flags)
 
 	status = 0;
 	while ((n = parsecmd(0)) != NEOF) {
-		evaltree(n, flags);
+		evaltree(n, flags & ~(parser_eof() ? 0 : EV_EXIT));
 		status = exitstatus;
 		popstackmark(&smark);
 		if (evalskip)
diff --git a/src/eval.h b/src/eval.h
index ac394e8..4e4de30 100644
--- a/src/eval.h
+++ b/src/eval.h
@@ -46,6 +46,10 @@ struct backcmd {		/* result of evalbackcmd */
 	struct job *jp;		/* job structure for command */
 };
 
+/* flags in argument to evaltree */
+#define EV_EXIT 01		/* exit after evaluating tree */
+#define EV_TESTED 02		/* exit status is checked; ignore -e flag */
+
 int evalstring(char *, int);
 union node;	/* BLETCH for ansi C */
 void evaltree(union node *, int);
diff --git a/src/main.c b/src/main.c
index b38dc27..af987c6 100644
--- a/src/main.c
+++ b/src/main.c
@@ -171,7 +171,7 @@ state2:
 state3:
 	state = 4;
 	if (minusc)
-		evalstring(minusc, 0);
+		evalstring(minusc, sflag ? 0 : EV_EXIT);
 
 	if (sflag || minusc == NULL) {
 state4:	/* XXX ??? - why isn't this before the "if" statement */
diff --git a/src/mktokens b/src/mktokens
index 7c873af..cd52241 100644
--- a/src/mktokens
+++ b/src/mktokens
@@ -71,13 +71,16 @@ TEND	1	"}"
 nl=`wc -l /tmp/ka$$`
 exec > token.h
 awk '{print "#define " $1 " " NR-1}' /tmp/ka$$
+
+exec > token_vars.h
+
 echo '
 /* Array indicating which tokens mark the end of a list */
-const char tokendlist[] = {'
+static const char tokendlist[] = {'
 awk '{print "\t" $2 ","}' /tmp/ka$$
 echo '};
 
-const char *const tokname[] = {'
+static const char *const tokname[] = {'
 sed -e 's/"/\\"/g' \
     -e 's/[^	 ]*[	 ][	 ]*[^	 ]*[	 ][	 ]*\(.*\)/	"\1",/' \
     /tmp/ka$$
@@ -85,7 +88,7 @@ echo '};
 '
 sed 's/"//g' /tmp/ka$$ | awk '
 /TNOT/{print "#define KWDOFFSET " NR-1; print ""; 
-      print "STATIC const char *const parsekwd[] = {"}
+      print "static const char *const parsekwd[] = {"}
 /TNOT/,/neverfound/{if (last) print "	\"" last "\","; last = $3}
 END{print "	\"" last "\"\n};"}'
 
diff --git a/src/parser.c b/src/parser.c
index 528d005..6de2762 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -64,7 +64,7 @@
  */
 
 /* values returned by readtoken */
-#include "token.h"
+#include "token_vars.h"
 
 
 
@@ -86,7 +86,7 @@ struct heredoc *heredoclist;	/* list of here documents to read */
 int doprompt;			/* if set, prompt the user */
 int needprompt;			/* true if interactive and at start of line */
 int lasttoken;			/* last token read */
-MKINIT int tokpushback;		/* last token pushed back */
+int tokpushback;		/* last token pushed back */
 char *wordtext;			/* text of last word returned by readtoken */
 int checkkwd;
 struct nodelist *backquotelist;
@@ -210,6 +210,7 @@ list(int nlflag)
 				parseheredoc();
 			else
 				pungetc();		/* push back EOF on input */
+			tokpushback++;
 			return n1;
 		default:
 			if (nlflag == 1)
diff --git a/src/parser.h b/src/parser.h
index e6caed6..2875cce 100644
--- a/src/parser.h
+++ b/src/parser.h
@@ -34,6 +34,8 @@
  *	@(#)parser.h	8.3 (Berkeley) 5/4/95
  */
 
+#include "token.h"
+
 /* control characters in argument strings */
 #define CTL_FIRST -127		/* first 'special' character */
 #define CTLESC -127		/* escape next character */
@@ -73,6 +75,7 @@
  * must be distinct from NULL, so we use the address of a variable that
  * happens to be handy.
  */
+extern int lasttoken;
 extern int tokpushback;
 #define NEOF ((union node *)&tokpushback)
 extern int whichprompt;		/* 1 == PS1, 2 == PS2 */
@@ -91,3 +94,8 @@ goodname(const char *p)
 {
 	return !*endofname(p);
 }
+
+static inline int parser_eof(void)
+{
+	return tokpushback && lasttoken == TEOF;
+}

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
