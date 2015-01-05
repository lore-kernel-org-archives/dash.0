From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4/4] input: Allow two consecutive calls to pungetc
Date: Mon, 05 Jan 2015 23:01:56 +1100
Message-ID: <E1Y86M8-0001nI-D5@gondolin.me.apana.org.au>
References: <20150105120030.GA6101@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:35813 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbbAEMCL (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 5 Jan 2015 07:02:11 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>, Eric Blake <eblake@redhat.com>, Oleg Bulatov <oleg@bulatov.me>, dash@vger.kernel.org, Juergen Daubert <jue@jue.li>

The commit ef91d3d6a4c39421fd3a391e02cd82f9f3aee4a8 ([PARSER]
Handle backslash newlines properly after dollar sign) created
cases where we make two consecutive calls to pungetc.  As we
don't explicitly support that there are corner cases where you
end up with garbage input leading to undefined behaviour.

This patch adds explicit support for two consecutive calls to
pungetc.

Reported-by: Jilles Tjoelker <jilles@stack.nl>
Reported-by: Juergen Daubert <jue@jue.li>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 src/input.c |   30 ++++++++++++++++++++++--------
 src/input.h |   12 ++++++++++++
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/src/input.c b/src/input.c
index 6223a73..06c08d4 100644
--- a/src/input.c
+++ b/src/input.c
@@ -102,10 +102,20 @@ RESET {
 int
 pgetc(void)
 {
+	int c;
+
+	if (parsefile->unget)
+		return parsefile->lastc[--parsefile->unget];
+
 	if (--parsefile->nleft >= 0)
-		return (signed char)*parsefile->nextc++;
+		c = (signed char)*parsefile->nextc++;
 	else
-		return preadbuffer();
+		c = preadbuffer();
+
+	parsefile->lastc[1] = parsefile->lastc[0];
+	parsefile->lastc[0] = c;
+
+	return c;
 }
 
 
@@ -194,7 +204,7 @@ static int preadbuffer(void)
 #endif
 	char savec;
 
-	while (unlikely(parsefile->strpush)) {
+	if (unlikely(parsefile->strpush)) {
 		if (
 			parsefile->nleft == -1 &&
 			parsefile->strpush->ap &&
@@ -204,8 +214,7 @@ static int preadbuffer(void)
 			return PEOA;
 		}
 		popstring();
-		if (--parsefile->nleft >= 0)
-			return (signed char)*parsefile->nextc++;
+		return pgetc();
 	}
 	if (unlikely(parsefile->nleft == EOF_NLEFT ||
 		     parsefile->buf == NULL))
@@ -290,15 +299,14 @@ again:
 }
 
 /*
- * Undo the last call to pgetc.  Only one character may be pushed back.
+ * Undo a call to pgetc.  Only two characters may be pushed back.
  * PEOF may be pushed back.
  */
 
 void
 pungetc(void)
 {
-	parsefile->nleft++;
-	parsefile->nextc--;
+	parsefile->unget++;
 }
 
 /*
@@ -322,6 +330,8 @@ pushstring(char *s, void *ap)
 		sp = parsefile->strpush = &(parsefile->basestrpush);
 	sp->prevstring = parsefile->nextc;
 	sp->prevnleft = parsefile->nleft;
+	sp->unget = parsefile->unget;
+	memcpy(sp->lastc, parsefile->lastc, sizeof(sp->lastc));
 	sp->ap = (struct alias *)ap;
 	if (ap) {
 		((struct alias *)ap)->flag |= ALIASINUSE;
@@ -329,6 +339,7 @@ pushstring(char *s, void *ap)
 	}
 	parsefile->nextc = s;
 	parsefile->nleft = len;
+	parsefile->unget = 0;
 	INTON;
 }
 
@@ -353,6 +364,8 @@ popstring(void)
 	}
 	parsefile->nextc = sp->prevstring;
 	parsefile->nleft = sp->prevnleft;
+	parsefile->unget = sp->unget;
+	memcpy(parsefile->lastc, sp->lastc, sizeof(sp->lastc));
 /*dprintf("*** calling popstring: restoring to '%s'\n", parsenextc);*/
 	parsefile->strpush = sp->prev;
 	if (sp != &(parsefile->basestrpush))
@@ -439,6 +452,7 @@ pushfile(void)
 	pf->fd = -1;
 	pf->strpush = NULL;
 	pf->basestrpush.prev = NULL;
+	pf->unget = 0;
 	parsefile = pf;
 }
 
diff --git a/src/input.h b/src/input.h
index ad8b463..ec97c1d 100644
--- a/src/input.h
+++ b/src/input.h
@@ -49,6 +49,12 @@ struct strpush {
 	int prevnleft;
 	struct alias *ap;	/* if push was associated with an alias */
 	char *string;		/* remember the string since it may change */
+
+	/* Remember last two characters for pungetc. */
+	int lastc[2];
+
+	/* Number of outstanding calls to pungetc. */
+	int unget;
 };
 
 /*
@@ -66,6 +72,12 @@ struct parsefile {
 	char *buf;		/* input buffer */
 	struct strpush *strpush; /* for pushing strings at this level */
 	struct strpush basestrpush; /* so pushing one is fast */
+
+	/* Remember last two characters for pungetc. */
+	int lastc[2];
+
+	/* Number of outstanding calls to pungetc. */
+	int unget;
 };
 
 extern struct parsefile *parsefile;
