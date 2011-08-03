From: maximilian attems <max@stro.at>
Subject: Kbuild dash headers generation
Date: Wed, 3 Aug 2011 11:27:00 +0200
Message-ID: <20110803092700.GG20986@stro.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <dash-owner@vger.kernel.org>
Received: from vostochny.stro.at ([78.47.22.85]:55300 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590Ab1HCJ0L (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 3 Aug 2011 05:26:11 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org, klibc@zytor.com


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hello Sam,

tried to sync current git dash for klibc,
but failed on this Kbuild step.

The attached patch can be applied with the
following:
 git am --directory="usr/dash" --exclude="usr/dash/configure.ac" \
         --exclude="usr/dash/ChangeLog" --exclude="usr/dash/dash.1" \
	 --exclude="usr/dash/Makefile.am"
	 --exclude="usr/dash/mksignames.c" \
	 --whitespace=fix -k -i -s ../dash/000X-foo.patch

(needs git am exclude support, which is in the second patch and easy)

The real trouble I have is that mkbuiltins is now generating a third
include file (token_vars.h) and had trouble to understand current hacks
for it already generating 2 different files. 

thank you very much for looking into this.

-- 
maks


--fUYQa+Pmc3FrFX/N
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-SHELL-Optimize-dash-c-command-to-avoid-a-fork.patch"

From ee5cbe9fd6bc02f31b4d955606288de36c3d4eab Mon Sep 17 00:00:00 2001
From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 7 Jul 2011 13:58:48 +0800
Subject: [klibc] [SHELL] Optimize dash -c "command" to avoid a fork

On Sun, Apr 10, 2011 at 07:36:49AM +0000, Jonathan Nieder wrote:
> From: Jilles Tjoelker <jilles@stack.nl>
> Date: Sat, 13 Jun 2009 16:17:45 -0500
>
> This change only affects strings passed to -c, when the -s option is
> not used.
>
> Use the EV_EXIT flag to inform the eval machinery that the string
> being passed is the entirety of input.  This way, a fork may be
> omitted in many special cases.
>
> If there are empty lines after the last command, the evalcmd will not
> see the end early enough and forks will not be omitted. The same thing
> seems to happen in bash.
>
> Example:
>   sh -c 'ps lT'
> No longer shows a shell process waiting for ps to finish.
>
> [jn: ported from FreeBSD SVN r194128.  Bugs are mine.]
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Instead of detecting EOF using the input layer, I'm going to
use the parser instead.  In either case, we always have to read
ahead in order to complete the parsing of the previous node.
Therefore we always know whether there is more to come, except
in the case where we see a newline/semicolon or similar.

For the purposes of sh -c, this should be sufficient.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 ChangeLog       |    4 ++++
 src/Makefile.am |    9 ++++++---
 src/eval.c      |    6 +-----
 src/eval.h      |    4 ++++
 src/main.c      |    2 +-
 src/mktokens    |    9 ++++++---
 src/parser.c    |    5 +++--
 src/parser.h    |    8 ++++++++
 8 files changed, 33 insertions(+), 14 deletions(-)

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
index ba68d55..2a37381 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -12,7 +12,8 @@ AM_CFLAGS_FOR_BUILD = -g -O2 $(COMMON_CFLAGS)
 AM_CPPFLAGS_FOR_BUILD = $(COMMON_CPPFLAGS)
 
 COMPILE_FOR_BUILD = \
-	$(CC_FOR_BUILD) $(AM_CPPFLAGS_FOR_BUILD) $(CPPFLAGS_FOR_BUILD) \
+	$(CC_FOR_BUILD) $(DEFAULT_INCLUDES) $(AM_CPPFLAGS_FOR_BUILD) \
+	$(CPPFLAGS_FOR_BUILD) \
 	$(AM_CFLAGS_FOR_BUILD) $(CFLAGS_FOR_BUILD) 
 
 bin_PROGRAMS = dash
@@ -33,7 +34,7 @@ dash_LDADD = builtins.o init.o nodes.o signames.o syntax.o
 
 HELPERS = mkinit mksyntax mknodes mksignames
 
-BUILT_SOURCES = builtins.h nodes.h syntax.h token.h
+BUILT_SOURCES = builtins.h nodes.h syntax.h token.h token_vars.h
 CLEANFILES = \
 	$(BUILT_SOURCES) $(patsubst %.o,%.c,$(dash_LDADD)) \
 	$(HELPERS) builtins.def
@@ -44,7 +45,7 @@ EXTRA_DIST = \
 	mktokens mkbuiltins builtins.def.in mkinit.c \
 	mknodes.c nodetypes nodes.c.pat mksyntax.c mksignames.c
 
-token.h: mktokens
+token.h token_vars.h: mktokens
 	sh $^
 
 builtins.def: builtins.def.in $(top_builddir)/config.h
@@ -65,5 +66,7 @@ syntax.c syntax.h: mksyntax
 signames.c: mksignames
 	./$^
 
+mksyntax: token.h
+
 $(HELPERS): %: %.c
 	$(COMPILE_FOR_BUILD) -o $@ $<
diff --git a/src/eval.c b/src/eval.c
index 86423b4..6e7b932 100644
--- a/eval.c
+++ b/eval.c
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
--- a/eval.h
+++ b/eval.h
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
--- a/main.c
+++ b/main.c
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
--- a/mktokens
+++ b/mktokens
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
--- a/parser.c
+++ b/parser.c
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
--- a/parser.h
+++ b/parser.h
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
-- 
1.7.5.4


--fUYQa+Pmc3FrFX/N
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-git-am-pass-exclude-down-to-apply.patch"

From 76e9823d99c261fcd44200069098857e51edcdeb Mon Sep 17 00:00:00 2001
From: maximilian attems <max@stro.at>
Date: Wed, 3 Aug 2011 11:21:18 +0200
Subject: [PATCH] git-am pass exclude down to apply

This allows to pass patches around from repositories,
where the other repository doesn't feature certain files.

In the special case this works for dash git sync to klibc dash.

Signed-off-by: maximilian attems <max@stro.at>
---
 git-am.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 463c741..8d185aa 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -22,6 +22,7 @@ whitespace=     pass it through git-apply
 ignore-space-change pass it through git-apply
 ignore-whitespace pass it through git-apply
 directory=      pass it through git-apply
+exclude=        pass it through git-apply
 C=              pass it through git-apply
 p=              pass it through git-apply
 patch-format=   format the patch(es) are in
@@ -366,7 +367,7 @@ do
 		;;
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
-	--whitespace|--directory)
+	--whitespace|--directory|--exclude)
 		git_apply_opt="$git_apply_opt $(sq "$1=$2")"; shift ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
-- 
1.7.5.4


--fUYQa+Pmc3FrFX/N--
