Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393B8C3DA7D
	for <linux-dash@archiver.kernel.org>; Tue,  3 Jan 2023 09:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjACJIo (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 3 Jan 2023 04:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjACJIn (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 3 Jan 2023 04:08:43 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23006DFC8
        for <dash@vger.kernel.org>; Tue,  3 Jan 2023 01:08:40 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pCdHh-00DOQo-Um; Tue, 03 Jan 2023 17:08:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 03 Jan 2023 17:08:37 +0800
Date:   Tue, 3 Jan 2023 17:08:37 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     dash@vger.kernel.org
Subject: [PATCH] input: Disable lleft in SMALL mode
Message-ID: <Y7PwlSeCwzgXztfc@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Counting lleft is only necessary if history support is enabled.
Therefore it can be safely disabled if SMALL is defined.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index 8691617..7b37ae2 100644
--- a/src/input.c
+++ b/src/input.c
@@ -54,9 +54,7 @@
 #include "alias.h"
 #include "parser.h"
 #include "main.h"
-#ifndef SMALL
 #include "myhistedit.h"
-#endif
 
 #define IBUFSIZ (BUFSIZ + 1)
 
@@ -256,12 +254,10 @@ retry:
 
 static int preadbuffer(void)
 {
-	char *q;
-	int more;
-#ifndef SMALL
 	int something;
-#endif
 	char savec;
+	int more;
+	char *q;
 
 	if (unlikely(parsefile->strpush)) {
 		popstring();
@@ -271,11 +267,11 @@ static int preadbuffer(void)
 		return PEOF;
 	flushall();
 
-	more = parsefile->lleft;
+	more = input_get_lleft(parsefile);
 	if (more <= 0) {
 again:
 		if ((more = preadfd()) <= 0) {
-			parsefile->lleft = parsefile->nleft = 0;
+			input_set_lleft(parsefile, parsefile->nleft = 0);
 			return PEOF;
 		}
 	}
@@ -283,37 +279,38 @@ again:
 	q = parsefile->nextc;
 
 	/* delete nul characters */
-#ifndef SMALL
 	something = 0;
-#endif
 	for (;;) {
 		int c;
 
 		more--;
 		c = *q;
 
-		if (!c)
+		if (!c) {
 			memmove(q, q + 1, more);
-		else {
-			q++;
+			goto check;
+		}
 
-			if (c == '\n') {
-				parsefile->nleft = q - parsefile->nextc - 1;
-				break;
-			}
+		q++;
 
-#ifndef SMALL
-			switch (c) {
-			default:
-				something = 1;
-				/* fall through */
-			case '\t':
-			case ' ':
-				break;
-			}
-#endif
+		if (IS_DEFINED_SMALL)
+			goto check;
+
+		switch (c) {
+		case '\n':
+			parsefile->nleft = q - parsefile->nextc - 1;
+			goto check;
+
+		default:
+			something = 1;
+			/* fall through */
+
+		case '\t':
+		case ' ':
+			break;
 		}
 
+check:
 		if (more <= 0) {
 			parsefile->nleft = q - parsefile->nextc - 1;
 			if (parsefile->nleft < 0)
@@ -321,12 +318,12 @@ again:
 			break;
 		}
 	}
-	parsefile->lleft = more;
+	input_set_lleft(parsefile, more);
 
-	savec = *q;
+	if (!IS_DEFINED_SMALL)
+		savec = *q;
 	*q = '\0';
 
-#ifndef SMALL
 	if (parsefile->fd == 0 && hist && something) {
 		HistEvent he;
 		INTOFF;
@@ -334,7 +331,6 @@ again:
 			parsefile->nextc);
 		INTON;
 	}
-#endif
 
 	if (vflag) {
 		out2str(parsefile->nextc);
@@ -343,7 +339,8 @@ again:
 #endif
 	}
 
-	*q = savec;
+	if (!IS_DEFINED_SMALL)
+		*q = savec;
 
 	return (signed char)*parsefile->nextc++;
 }
@@ -458,7 +455,7 @@ setinputfd(int fd, int push)
 	parsefile->fd = fd;
 	if (parsefile->buf == NULL)
 		parsefile->buf = ckmalloc(IBUFSIZ);
-	parsefile->lleft = parsefile->nleft = 0;
+	input_set_lleft(parsefile, parsefile->nleft = 0);
 	plinno = 1;
 }
 
diff --git a/src/input.h b/src/input.h
index 8830b66..1ff5773 100644
--- a/src/input.h
+++ b/src/input.h
@@ -76,7 +76,9 @@ struct parsefile {
 	int linno;		/* current line */
 	int fd;			/* file descriptor (or -1 if string) */
 	int nleft;		/* number of chars left in this line */
+#ifndef SMALL
 	int lleft;		/* number of chars left in this buffer */
+#endif
 	char *nextc;		/* next char in buffer */
 	char *buf;		/* input buffer */
 	struct strpush *strpush; /* for pushing strings at this level */
@@ -110,3 +112,19 @@ void setinputstring(char *);
 void popfile(void);
 void unwindfiles(struct parsefile *);
 void popallfiles(void);
+
+static inline int input_get_lleft(struct parsefile *pf)
+{
+#ifdef SMALL
+	return 0;
+#else
+	return pf->lleft;
+#endif
+}
+
+static inline void input_set_lleft(struct parsefile *pf, int len)
+{
+#ifndef SMALL
+	pf->lleft = len;
+#endif
+}
diff --git a/src/myhistedit.h b/src/myhistedit.h
index 22e5c43..1736f62 100644
--- a/src/myhistedit.h
+++ b/src/myhistedit.h
@@ -31,9 +31,27 @@
  *	@(#)myhistedit.h	8.2 (Berkeley) 5/4/95
  */
 
+#ifdef SMALL
+typedef void History;
+typedef void EditLine;
+typedef int HistEvent;
+
+enum {
+	H_APPEND,
+	H_ENTER,
+};
+
+#define hist NULL
+
+static inline void history(History *h, HistEvent *he, int action, char *p)
+{
+}
+#else
 #include <histedit.h>
 
 extern History *hist;
+#endif
+
 extern EditLine *el;
 extern int displayhist;
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
