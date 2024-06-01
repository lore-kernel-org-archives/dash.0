Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BDD23B0
	for <dash@vger.kernel.org>; Sat,  1 Jun 2024 04:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717217400; cv=none; b=VDs4lKEQF+Ibj5CW/AzPi1cFr6soR90emEI8QKW4D2He2a9SmTpqbsD/hvOnvvzC//fh7OyPrw56l8n2ZNo375EUHKQHNJzYr+/9bj0915TVbv8uIjDckZMCpmWWqGXfCI3LZte2e3xOOhFCLXn8yvT4sN9yseTFrUcvT4BOPvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717217400; c=relaxed/simple;
	bh=fZB2XNisJKnRa6vH66+9jsOxCsRwLexy99YkZPhqoO0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BzcmyE/KtRMkXphiDBaSPS+kni9vMID7vd/tgiF/v0Bjau5+Yhv0HNhoLfQ8riNn8mKu7RopdXcMRNTsbLreW8cInufZXd7yWE3KOp3NNMWt9WdgqyUjtyTDgffqs7u7H4/CH9perDQEtM/GTeBpRpsVjTItCAiHJnVMLOB5jds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sDGgh-004VxM-0X;
	Sat, 01 Jun 2024 12:49:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 01 Jun 2024 12:49:53 +0800
Date: Sat, 1 Jun 2024 12:49:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] expand: Fix expmeta resource leakage
Message-ID: <ZlqocSUt5MwP8FpC@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If memory allocation fails in expmeta, the DIRP will be leaked
along with expdir.

Fix this by adding setjmp/longjmp, and converting expdir to use
stack memory.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/expand.c | 167 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 92 insertions(+), 75 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index e7e8ce0..ce245e4 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -32,49 +32,50 @@
  * SUCH DAMAGE.
  */
 
-#include <sys/types.h>
-#include <sys/time.h>
-#include <sys/stat.h>
+#include <ctype.h>
 #include <dirent.h>
-#include <unistd.h>
-#ifdef HAVE_GETPWNAM
-#include <pwd.h>
-#endif
-#include <stdlib.h>
-#include <stdio.h>
-#include <inttypes.h>
-#include <limits.h>
-#include <string.h>
 #ifdef HAVE_FNMATCH
 #include <fnmatch.h>
 #endif
 #ifdef HAVE_GLOB
 #include <glob.h>
 #endif
-#include <ctype.h>
+#include <inttypes.h>
+#include <limits.h>
+#ifdef HAVE_GETPWNAM
+#include <pwd.h>
+#endif
+#include <setjmp.h>
 #include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/time.h>
+#include <sys/stat.h>
+#include <unistd.h>
 
 /*
  * Routines to expand arguments to commands.  We have to deal with
  * backquotes, shell variables, and file metacharacters.
  */
 
-#include "shell.h"
-#include "main.h"
-#include "nodes.h"
+#include "error.h"
 #include "eval.h"
 #include "expand.h"
-#include "syntax.h"
-#include "parser.h"
 #include "jobs.h"
-#include "options.h"
-#include "var.h"
-#include "output.h"
+#include "main.h"
 #include "memalloc.h"
-#include "error.h"
 #include "mystring.h"
+#include "nodes.h"
+#include "options.h"
+#include "output.h"
+#include "parser.h"
+#include "shell.h"
 #include "show.h"
+#include "syntax.h"
 #include "system.h"
+#include "var.h"
 
 /*
  * _rmescape() flags
@@ -120,7 +121,7 @@ static size_t memtodest(const char *p, size_t len, int flags);
 STATIC ssize_t varvalue(char *, int, int, int);
 STATIC void expandmeta(struct strlist *);
 static void addglob(const glob64_t *);
-STATIC void expmeta(char *, unsigned, unsigned);
+static char *expmeta(char *, unsigned, size_t);
 STATIC struct strlist *expsort(struct strlist *);
 STATIC struct strlist *msort(struct strlist *, int);
 STATIC void addfname(char *);
@@ -1225,10 +1226,6 @@ static void addglob(const glob64_t *pglob)
 	} while (*++p);
 }
 
-STATIC char *expdir;
-STATIC unsigned expdir_max;
-
-
 STATIC void
 expandmeta(struct strlist *str)
 {
@@ -1255,11 +1252,8 @@ expandmeta(struct strlist *str)
 		INTOFF;
 		p = preglob(str->text, RMESCAPE_ALLOC | RMESCAPE_HEAP);
 		len = strlen(p);
-		expdir_max = len + PATH_MAX;
-		expdir = ckmalloc(expdir_max);
 
 		expmeta(p, len, 0);
-		ckfree(expdir);
 		if (p != str->text)
 			ckfree(p);
 		INTON;
@@ -1282,27 +1276,59 @@ nometa:
 	}
 }
 
+static void addfname_common(char *name)
+{
+	struct strlist *sp;
+
+	sp = (struct strlist *)stalloc(sizeof *sp);
+	sp->text = name;
+	*exparg.lastp = sp;
+	exparg.lastp = &sp->next;
+}
+
+static char *addfnamealt(char *enddir, size_t expdir_len)
+{
+	char *name;
+
+	name = grabstackstr(enddir);
+	addfname_common(name);
+
+	STARTSTACKSTR(enddir);
+	return stnputs(name, expdir_len, enddir) - expdir_len;
+}
 
 /*
  * Do metacharacter (i.e. *, ?, [...]) expansion.
  */
 
-STATIC void
-expmeta(char *name, unsigned name_len, unsigned expdir_len)
+static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 {
-	char *enddir = expdir + expdir_len;
-	char *p;
-	const char *cp;
-	char *start;
-	char *endname;
-	int metaflag;
+	struct jmploc *volatile savehandler;
+	struct jmploc jmploc;
 	struct stat64 statb;
-	DIR *dirp;
 	struct dirent64 *dp;
-	int atend;
+	volatile int err;
+	char *endname;
+	char *enddir;
+	int metaflag;
 	int matchdot;
+	char *start;
+	size_t len;
+	DIR *dirp;
+	int atend;
+	char *cp;
+	char *p;
 	int esc;
 
+	*(DIR *volatile *)&dirp = NULL;
+	savehandler = handler;
+	if (unlikely(err = setjmp(jmploc.loc)))
+		goto out;
+
+	len = expdir_len + name_len + 1;
+	cp = growstackto(len);
+	enddir = cp + expdir_len;
+
 	metaflag = 0;
 	start = name;
 	for (p = name; esc = 0, *p; p += esc + 1) {
@@ -1334,16 +1360,16 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 	}
 	if (metaflag == 0) {	/* we've reached the end of the file name */
 		if (!expdir_len)
-			return;
+			goto out_opendir;
 		p = name;
 		do {
 			if (*p == '\\' && p[1])
 				p++;
 			*enddir++ = *p;
 		} while (*p++);
-		if (lstat64(expdir, &statb) >= 0)
-			addfname(expdir);
-		return;
+		if (lstat64(cp, &statb) >= 0)
+			cp = addfnamealt(enddir, expdir_len);
+		goto out_opendir;
 	}
 	endname = p;
 	if (name < start) {
@@ -1355,12 +1381,11 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 		} while (p < start);
 	}
 	*enddir = 0;
-	cp = expdir;
 	expdir_len = enddir - cp;
-	if (!expdir_len)
-		cp = dotdir;
-	if ((dirp = opendir(cp)) == NULL)
-		return;
+
+	*(DIR *volatile *)&dirp = opendir(expdir_len ? cp : dotdir);
+	if (!dirp)
+		goto out_opendir;
 	if (*endname == 0) {
 		atend = 1;
 	} else {
@@ -1379,32 +1404,29 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 		if (dp->d_name[0] == '.' && ! matchdot)
 			continue;
 		if (pmatch(start, dp->d_name)) {
-			if (atend) {
-				scopy(dp->d_name, enddir);
-				addfname(expdir);
-			} else {
-				unsigned offset;
-				unsigned len;
+			len = strlen(dp->d_name) + 1;
 
-				p = stpcpy(enddir, dp->d_name);
-				*p = '/';
-
-				offset = p - expdir + 1;
-				len = offset + name_len + NAME_MAX;
-				if (len > expdir_max) {
-					len += PATH_MAX;
-					expdir = ckrealloc(expdir, len);
-					expdir_max = len;
-				}
-
-				expmeta(endname, name_len, offset);
-				enddir = expdir + expdir_len;
+			enddir = cp + expdir_len;
+			enddir = stnputs(dp->d_name, len, enddir);
+			if (atend)
+				cp = addfnamealt(enddir, expdir_len);
+			else {
+				enddir[-1] = '/';
+				len += expdir_len;
+				cp = expmeta(endname, name_len, len);
 			}
 		}
 	}
-	closedir(dirp);
 	if (! atend)
 		endname[-esc - 1] = esc ? '\\' : '/';
+
+out:
+	closedir(*(DIR *volatile *)&dirp);
+out_opendir:
+	handler = savehandler;
+	if (err)
+		longjmp(handler->loc, 1);
+	return cp;
 }
 
 
@@ -1415,12 +1437,7 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 STATIC void
 addfname(char *name)
 {
-	struct strlist *sp;
-
-	sp = (struct strlist *)stalloc(sizeof *sp);
-	sp->text = sstrdup(name);
-	*exparg.lastp = sp;
-	exparg.lastp = &sp->next;
+	addfname_common(sstrdup(name));
 }
 
 
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
