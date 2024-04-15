Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA096773D
	for <dash@vger.kernel.org>; Mon, 15 Apr 2024 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182487; cv=none; b=tCSsoE3UnICwF7y7iWgqdcII9QGEHmbBmRLYkF2tJuZKkuVizJrsjp6pNq46Yds8t2WVG8Bme0dn0snDV/zSTdMnAnR1QAZpwDxQA+YJmgNTV8su6P062RCT7PP4gS59sHoFQvTFa96aKfFriXe2QCdS2wYOiM/oiQXffKqjaTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182487; c=relaxed/simple;
	bh=lyzsZAlhG+E2SgSdUAaZZ8J5q+ab2LJZJFVVl1LWD/4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K1OLWMyUCfRfIFoYMa00ThMUR7ig//AGazUayRtDuVnG+kYk3t5C62LPYT5diVBYqNILS0UM9F4YVot4I9zJC4Mn+troKpqzNAE/V+3rmRqt4ypvRXb10i1IxHoeTGwvz5gp93eXGgPy4RwX+s5GJTnQAf0WOe2hsO/yqqmKfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rwL1P-001qt7-Ig; Mon, 15 Apr 2024 20:01:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 15 Apr 2024 20:01:33 +0800
Date: Mon, 15 Apr 2024 20:01:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: dash@vger.kernel.org
Subject: [PATCH] jobs: Preserve parent jobs for simple commands
Message-ID: <Zh0XHZYkHvBUbHde@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Do not free parent shell jobs if a simple command with the first
word being "jobs" is executed as a command substitution.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/jobs.c   | 6 ++++++
 src/parser.c | 6 ++++++
 src/parser.h | 3 +++
 src/trap.c   | 5 +++--
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index dce8e22..7053e22 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -53,6 +53,7 @@
 #include <termios.h>
 #undef CEOF			/* syntax.h redefines this */
 #endif
+#include "builtins.h"
 #include "exec.h"
 #include "eval.h"
 #include "init.h"
@@ -913,6 +914,11 @@ static void forkchild(struct job *jp, union node *n, int mode)
 	if (lvforked)
 		return;
 
+	freejob(jp);
+
+	if (issimplecmd(n, JOBSCMD->name))
+		return;
+
 	for (jp = curjob; jp; jp = jp->prev_job)
 		freejob(jp);
 }
diff --git a/src/parser.c b/src/parser.c
index 299c260..f4d76c2 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -132,6 +132,12 @@ int isassignment(const char *p)
 	return *q == '=';
 }
 
+int issimplecmd(union node *n, const char *name)
+{
+	return n && n->type == NCMD && n->ncmd.args &&
+	       equal(n->ncmd.args->narg.text, name);
+}
+
 static inline int realeofmark(const char *eofmark)
 {
 	return eofmark && eofmark != FAKEEOFMARK;
diff --git a/src/parser.h b/src/parser.h
index 729c15c..433573d 100644
--- a/src/parser.h
+++ b/src/parser.h
@@ -36,6 +36,8 @@
 
 #include "token.h"
 
+union node;
+
 /* control characters in argument strings */
 #define CTL_FIRST -127		/* first 'special' character */
 #define CTLESC -127		/* escape next character */
@@ -85,6 +87,7 @@ extern int checkkwd;
 
 
 int isassignment(const char *p);
+int issimplecmd(union node *n, const char *name);
 union node *parsecmd(int);
 void fixredir(union node *, const char *, int);
 const char *getprompt(void *);
diff --git a/src/trap.c b/src/trap.c
index 525a009..0886619 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -37,6 +37,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include "builtins.h"
 #include "shell.h"
 #include "main.h"
 #include "nodes.h"	/* for other headers */
@@ -47,6 +48,7 @@
 #include "options.h"
 #include "syntax.h"
 #include "output.h"
+#include "parser.h"
 #include "memalloc.h"
 #include "error.h"
 #include "trap.h"
@@ -170,8 +172,7 @@ void clear_traps(union node *n)
 	int simplecmd;
 	char **tp;
 
-	simplecmd = n && n->type == NCMD && n->ncmd.args &&
-		    equal(n->ncmd.args->narg.text, "trap");
+	simplecmd = issimplecmd(n, TRAPCMD->name);
 
 	INTOFF;
 	for (tp = trap ; tp < &trap[NSIG] ; tp++) {
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
