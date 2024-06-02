Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0709EA34
	for <dash@vger.kernel.org>; Sun,  2 Jun 2024 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717291755; cv=none; b=kAPYPM3NV/9jz3+7ptmYrJWk/9Ia5bP4zWzv5TWqS/13lqKNLh27ONZBBOJaO8IjhbTVON7sGEDpLriD7deSy3B/fchazuafVyuYLwz7HZV2fMpYO8z82hVK9Qmhp+WWyslS7M4N6Zf5LJ3P7PfkVwIwTEIMjeQEGs8rF0Qb/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717291755; c=relaxed/simple;
	bh=Fc2IWehlzBuHjHueNdATIJlsfIzWttnfPNdiYfwlIIQ=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=C2PIkfoyo9yUYjBc8lPUTUn1u21HVa5Czz7zK6cCebcg4e5MriYG9MKo5Ebl5cjhC78WBJScsomT/EhOdqv+DOtI5JTSQHrs/m5CqsQURo1drct+2jbRtl4CssSllXGyoctYQ/5MJWgRkCa+IVjUR/N8y7WpFCWL6YuDYXnW7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sDa20-004iWI-35;
	Sun, 02 Jun 2024 09:29:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 02 Jun 2024 09:29:11 +0800
Date: Sun, 02 Jun 2024 09:29:11 +0800
Message-Id: <4efd0e929ea676787cf6fffcfa1fba0fa1a6c559.1717291579.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1717291579.git.herbert@gondor.apana.org.au>
References: <cover.1717291579.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 12/13] builtin: Use pgetc in read(1)
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Use pgetc instead of read(2) in read(1).  This allows any future
buffering in the input layer to be used by read(1).  This also
allows read(1) to call helpers in the parser that may use the
input layer.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/input.c     | 42 ++++++++++++++++++++++++++++--------------
 src/input.h     |  1 +
 src/miscbltin.c | 39 +++++++++++++++++++--------------------
 3 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/src/input.c b/src/input.c
index 1712e5f..6779069 100644
--- a/src/input.c
+++ b/src/input.c
@@ -42,19 +42,20 @@
  * This file implements the input routines used by the parser.
  */
 
-#include "eval.h"
-#include "shell.h"
-#include "redir.h"
-#include "syntax.h"
-#include "input.h"
-#include "output.h"
-#include "options.h"
-#include "memalloc.h"
-#include "error.h"
 #include "alias.h"
-#include "parser.h"
+#include "error.h"
+#include "eval.h"
+#include "input.h"
 #include "main.h"
+#include "memalloc.h"
 #include "myhistedit.h"
+#include "options.h"
+#include "output.h"
+#include "parser.h"
+#include "redir.h"
+#include "shell.h"
+#include "syntax.h"
+#include "trap.h"
 
 #define IBUFSIZ (BUFSIZ + PUNGETC_MAX + 1)
 
@@ -258,7 +259,7 @@ retry:
 	}
 
 	if (nr < 0) {
-		if (errno == EINTR)
+		if (errno == EINTR && !(basepf.prev && pending_sig))
 			goto retry;
 	}
 	return nr;
@@ -522,6 +523,13 @@ pushfile(void)
 	parsefile = pf;
 }
 
+void pushstdin(void)
+{
+	INTOFF;
+	basepf.prev = parsefile;
+	parsefile = &basepf;
+	INTON;
+}
 
 void
 popfile(void)
@@ -529,6 +537,11 @@ popfile(void)
 	struct parsefile *pf = parsefile;
 
 	INTOFF;
+	parsefile = pf->prev;
+	pf->prev = NULL;
+	if (pf == &basepf)
+		goto out;
+
 	if (pf->fd >= 0)
 		close(pf->fd);
 	if (pf->buf)
@@ -539,15 +552,16 @@ popfile(void)
 		popstring();
 		freestrings(parsefile->spfree);
 	}
-	parsefile = pf->prev;
 	ckfree(pf);
+
+out:
 	INTON;
 }
 
 
-void unwindfiles(struct parsefile *stop)
+void __attribute__((noinline)) unwindfiles(struct parsefile *stop)
 {
-	while (parsefile != stop)
+	while (basepf.prev || parsefile != stop)
 		popfile();
 }
 
diff --git a/src/input.h b/src/input.h
index 151b1c6..c59d784 100644
--- a/src/input.h
+++ b/src/input.h
@@ -109,6 +109,7 @@ void pungetn(int);
 void pushstring(char *, void *);
 int setinputfile(const char *, int);
 void setinputstring(char *);
+void pushstdin(void);
 void popfile(void);
 void unwindfiles(struct parsefile *);
 void popallfiles(void);
diff --git a/src/miscbltin.c b/src/miscbltin.c
index 8a0ddf4..10d256e 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -46,18 +46,20 @@
 #include <ctype.h>
 #include <inttypes.h>
 
-#include "shell.h"
-#include "options.h"
-#include "var.h"
-#include "output.h"
-#include "memalloc.h"
 #include "error.h"
+#include "expand.h"
+#include "input.h"
+#include "memalloc.h"
 #include "miscbltin.h"
 #include "mystring.h"
 #include "main.h"
-#include "expand.h"
+#include "options.h"
+#include "output.h"
 #include "parser.h"
+#include "shell.h"
+#include "syntax.h"
 #include "trap.h"
+#include "var.h"
 
 #undef rflag
 
@@ -115,14 +117,13 @@ readcmd_handle_line(char *s, int ac, char **ap)
 int
 readcmd(int argc, char **argv)
 {
-	char **ap;
-	char c;
-	int rflag;
 	char *prompt;
-	char *p;
 	int startloc;
 	int newloc;
 	int status;
+	char **ap;
+	int rflag;
+	char *p;
 	int i;
 
 	rflag = 0;
@@ -145,19 +146,17 @@ readcmd(int argc, char **argv)
 	status = 0;
 	STARTSTACKSTR(p);
 
+	pushstdin();
+
 	goto start;
 
 	for (;;) {
-		switch (read(0, &c, 1)) {
-		case 1:
-			break;
-		default:
-			if (errno == EINTR && !pending_sig)
-				continue;
-				/* fall through */
-		case 0:
+		int c;
+
+		c = pgetc();
+		if (c == PEOF) {
 			status = 1;
-			goto out;
+			break;
 		}
 		if (c == '\0')
 			continue;
@@ -186,7 +185,7 @@ start:
 			newloc = startloc - 1;
 		}
 	}
-out:
+	popfile();
 	recordregion(startloc, p - (char *)stackblock(), 0);
 	STACKSTRNUL(p);
 	readcmd_handle_line(p + 1, argc - (ap - argv), ap);
-- 
2.39.2

