From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v4] builtin: Fix handling of trailing IFS white spaces
Date: Sun, 12 Jun 2016 20:17:48 +0800
Message-ID: <20160612121748.GA1270@gondor.apana.org.au>
References: <5661EEB7.8080908@gigawatt.nl>
 <20160606084805.GA20946@gondor.apana.org.au>
 <5755E07B.6090300@gigawatt.nl>
 <20160607092539.GA30397@gondor.apana.org.au>
 <575D3AE3.1080700@gigawatt.nl>
 <20160612110643.GA927@gondor.apana.org.au>
 <575D4381.2080903@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:47735 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbcFLMRz (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 12 Jun 2016 08:17:55 -0400
Content-Disposition: inline
In-Reply-To: <575D4381.2080903@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org, Stephane Chazelas <stephane.chazelas@gmail.com>, Gioele Barabucci <gioele@svario.it>

On Sun, Jun 12, 2016 at 01:12:01PM +0200, Harald van Dijk wrote:
> 
> It needs two spaces after the "x", not just one. With a single
> space, it does work right.

Tricky :) OK here is a new version that should fix this bug.

---8<---
The read built-in does not handle trailing IFS white spaces in
the right way, when there are more fields than variables.  Part
of the problem is that this case is handled outside of ifsbreakup.

Harald van Dijk wrote a patch to fix this by moving the magic
into ifsbreakup itself.

This patch further reorganises the ifsbreakup loop by having only
one loop over the whole string.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index b2d710d..36bea76 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -50,6 +50,7 @@
 #include <glob.h>
 #endif
 #include <ctype.h>
+#include <stdbool.h>
 
 /*
  * Routines to expand arguments to commands.  We have to deal with
@@ -203,7 +204,7 @@ expandarg(union node *arg, struct arglist *arglist, int flag)
 	 * TODO - EXP_REDIR
 	 */
 	if (flag & EXP_FULL) {
-		ifsbreakup(p, &exparg);
+		ifsbreakup(p, -1, &exparg);
 		*exparg.lastp = NULL;
 		exparg.lastp = &exparg.list;
 		expandmeta(exparg.list, flag);
@@ -1016,15 +1017,18 @@ recordregion(int start, int end, int nulonly)
  * Break the argument string into pieces based upon IFS and add the
  * strings to the argument list.  The regions of the string to be
  * searched for IFS characters have been stored by recordregion.
+ * If maxargs is non-negative, at most maxargs arguments will be created, by
+ * joining together the last arguments.
  */
 void
-ifsbreakup(char *string, struct arglist *arglist)
+ifsbreakup(char *string, int maxargs, struct arglist *arglist)
 {
 	struct ifsregion *ifsp;
 	struct strlist *sp;
 	char *start;
 	char *p;
 	char *q;
+	char *r = NULL;
 	const char *ifs, *realifs;
 	int ifsspc;
 	int nulonly;
@@ -1042,16 +1046,76 @@ ifsbreakup(char *string, struct arglist *arglist)
 			ifs = nulonly ? nullstr : realifs;
 			ifsspc = 0;
 			while (p < string + ifsp->endoff) {
+				int c;
+				bool isifs;
+				bool isdefifs;
+
 				q = p;
-				if (*p == (char)CTLESC)
-					p++;
-				if (strchr(ifs, *p)) {
+				c = *p++;
+				if (c == (char)CTLESC)
+					c = *p++;
+
+				isifs = strchr(ifs, c);
+				isdefifs = false;
+				if (isifs)
+					isdefifs = strchr(defifs, c);
+
+				/* If only reading one more argument:
+				 * If we have exactly one field,
+				 * read that field without its terminator.
+				 * If we have more than one field,
+				 * read all fields including their terminators,
+				 * except for trailing IFS whitespace.
+				 *
+				 * This means that if we have only IFS
+				 * characters left, and at most one
+				 * of them is non-whitespace, we stop
+				 * reading here.
+				 * Otherwise, we read all the remaining
+				 * characters except for trailing
+				 * IFS whitespace.
+				 *
+				 * In any case, r indicates the start
+				 * of the characters to remove, or NULL
+				 * if no characters should be removed.
+				 */
+				if (!maxargs) {
+					if (isdefifs) {
+						if (!r)
+							r = q;
+						continue;
+					}
+
+					if (!(isifs && ifsspc))
+						r = NULL;
+
+					ifsspc = 0;
+					continue;
+				}
+
+				if (ifsspc) {
+					if (isifs)
+						q = p;
+
+					start = q;
+
+					if (isdefifs)
+						continue;
+
+					isifs = false;
+				}
+
+				if (isifs) {
 					if (!nulonly)
-						ifsspc = (strchr(defifs, *p) != NULL);
+						ifsspc = isdefifs;
 					/* Ignore IFS whitespace at start */
 					if (q == start && ifsspc) {
-						p++;
 						start = p;
+						ifsspc = 0;
+						continue;
+					}
+					if (maxargs > 0 && !--maxargs) {
+						r = q;
 						continue;
 					}
 					*q = '\0';
@@ -1059,39 +1123,20 @@ ifsbreakup(char *string, struct arglist *arglist)
 					sp->text = start;
 					*arglist->lastp = sp;
 					arglist->lastp = &sp->next;
-					p++;
-					if (!nulonly) {
-						for (;;) {
-							if (p >= string + ifsp->endoff) {
-								break;
-							}
-							q = p;
-							if (*p == (char)CTLESC)
-								p++;
-							if (strchr(ifs, *p) == NULL ) {
-								p = q;
-								break;
-							} else if (strchr(defifs, *p) == NULL) {
-								if (ifsspc) {
-									p++;
-									ifsspc = 0;
-								} else {
-									p = q;
-									break;
-								}
-							} else
-								p++;
-						}
-					}
 					start = p;
-				} else
-					p++;
+					continue;
+				}
+
+				ifsspc = 0;
 			}
 		} while ((ifsp = ifsp->next) != NULL);
 		if (nulonly)
 			goto add;
 	}
 
+	if (r)
+		*r = '\0';
+
 	if (!*start)
 		return;
 
diff --git a/src/expand.h b/src/expand.h
index 6a90f67..26dc5b4 100644
--- a/src/expand.h
+++ b/src/expand.h
@@ -69,7 +69,7 @@ char *_rmescapes(char *, int);
 int casematch(union node *, char *);
 void recordregion(int, int, int);
 void removerecordregions(int); 
-void ifsbreakup(char *, struct arglist *);
+void ifsbreakup(char *, int, struct arglist *);
 void ifsfree(void);
 
 /* From arith.y */
diff --git a/src/miscbltin.c b/src/miscbltin.c
index b596fd2..39b9c47 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -67,28 +67,21 @@
  *  less fields than variables -> remaining variables unset.
  *
  *  @param line complete line of input
+ *  @param ac argument count
  *  @param ap argument (variable) list
  *  @param len length of line including trailing '\0'
  */
 static void
-readcmd_handle_line(char *s, char **ap)
+readcmd_handle_line(char *s, int ac, char **ap)
 {
 	struct arglist arglist;
 	struct strlist *sl;
-	char *backup;
-	char *line;
 
-	/* ifsbreakup will fiddle with stack region... */
-	line = stackblock();
 	s = grabstackstr(s);
 
-	/* need a copy, so that delimiters aren't lost
-	 * in case there are more fields than variables */
-	backup = sstrdup(line);
-
 	arglist.lastp = &arglist.list;
 	
-	ifsbreakup(s, &arglist);
+	ifsbreakup(s, ac, &arglist);
 	*arglist.lastp = NULL;
 	ifsfree();
 
@@ -104,21 +97,6 @@ readcmd_handle_line(char *s, char **ap)
 			return;
 		}
 
-		/* remaining fields present, but no variables left. */
-		if (!ap[1] && sl->next) {
-			size_t offset;
-			char *remainder;
-
-			/* FIXME little bit hacky, assuming that ifsbreakup 
-			 * will not modify the length of the string */
-			offset = sl->text - s;
-			remainder = backup + offset;
-			rmescapes(remainder);
-			setvar(*ap, remainder, 0);
-
-			return;
-		}
-		
 		/* set variable to field */
 		rmescapes(sl->text);
 		setvar(*ap, sl->text, 0);
@@ -211,7 +189,7 @@ start:
 out:
 	recordregion(startloc, p - (char *)stackblock(), 0);
 	STACKSTRNUL(p);
-	readcmd_handle_line(p + 1, ap);
+	readcmd_handle_line(p + 1, argc - (ap - argv), ap);
 	return status;
 }
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
