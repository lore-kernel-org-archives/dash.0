From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [Partial patch] IFS and read builtin
Date: Wed, 8 Sep 2010 20:08:49 +0800
Message-ID: <20100908120849.GA17121@gondor.apana.org.au>
References: <4C71A29C.1080609@gigawatt.nl> <20100908115324.GA17029@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:53084 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab0IHMIv (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 8 Sep 2010 08:08:51 -0400
Content-Disposition: inline
In-Reply-To: <20100908115324.GA17029@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org

On Wed, Sep 08, 2010 at 07:53:24PM +0800, Herbert Xu wrote:
> 
> commit 5c7042771753d5a968b2b7263cf9f4e02fa3820e
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Wed Sep 8 19:51:10 2010 +0800
> 
>     [EXPAND] Fix ifsfirst/ifslastp leak

Slight update, should also call ifsfree instead of removerecordregion
in read(1).

commit f42e443bb511ed3224f09b4fcf0772438ebdbbfa
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Wed Sep 8 20:07:26 2010 +0800

    [EXPAND] Fix ifsfirst/ifslastp leak
    
    As it stands expandarg may return with a non-NULL ifslastp which
    then confuses any subsequent ifsbreakup user that doesn't clear
    it directly.
    
    What's worse, if we get interrupted before we hit ifsfree in
    expandarg we will leak memory.
    
    This patch fixes this by always calling ifsfree in expandarg
    thus ensuring that ifslastp is always NULL on the normal path.
    It also adds an ifsfree call to the RESET path to ensure that
    memory isn't leaked.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 3c26149..a51975c 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2010-09-08  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fix ifsfirst/ifslastp leak.
+
 2010-09-08  maximilian attems <max@stro.at>
 
 	* Debug compile fix.
diff --git a/src/expand.c b/src/expand.c
index f2f964c..d6c6416 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -117,7 +117,6 @@ STATIC char *evalvar(char *, int);
 STATIC size_t strtodest(const char *, const char *, int);
 STATIC void memtodest(const char *, size_t, const char *, int);
 STATIC ssize_t varvalue(char *, int, int);
-STATIC void ifsfree(void);
 STATIC void expandmeta(struct strlist *, int);
 #ifdef HAVE_GLOB
 STATIC void addglob(const glob_t *);
@@ -191,8 +190,6 @@ expandarg(union node *arg, struct arglist *arglist, int flag)
 
 	argbackq = arg->narg.backquote;
 	STARTSTACKSTR(expdest);
-	ifsfirst.next = NULL;
-	ifslastp = NULL;
 	argstr(arg->narg.text, flag);
 	p = _STPUTC('\0', expdest);
 	expdest = p - 1;
@@ -215,8 +212,7 @@ expandarg(union node *arg, struct arglist *arglist, int flag)
 		*exparg.lastp = sp;
 		exparg.lastp = &sp->next;
 	}
-	if (ifsfirst.next)
-		ifsfree();
+	ifsfree();
 	*exparg.lastp = NULL;
 	if (exparg.list) {
 		*arglist->lastp = exparg.list;
@@ -1108,22 +1104,25 @@ add:
 	arglist->lastp = &sp->next;
 }
 
-STATIC void
-ifsfree(void)
+void ifsfree(void)
 {
-	struct ifsregion *p;
+	struct ifsregion *p = ifsfirst.next;
+
+	if (!p)
+		goto out;
 
 	INTOFF;
-	p = ifsfirst.next;
 	do {
 		struct ifsregion *ifsp;
 		ifsp = p->next;
 		ckfree(p);
 		p = ifsp;
 	} while (p);
-	ifslastp = NULL;
 	ifsfirst.next = NULL;
 	INTON;
+
+out:
+	ifslastp = NULL;
 }
 
 
@@ -1678,7 +1677,6 @@ casematch(union node *pattern, char *val)
 	setstackmark(&smark);
 	argbackq = pattern->narg.backquote;
 	STARTSTACKSTR(expdest);
-	ifslastp = NULL;
 	argstr(pattern->narg.text, EXP_TILDE | EXP_CASE);
 	STACKSTRNUL(expdest);
 	result = patmatch(stackblock(), val);
@@ -1718,3 +1716,13 @@ varunset(const char *end, const char *var, const char *umsg, int varflags)
 	}
 	sh_error("%.*s: %s%s", end - var - 1, var, msg, tail);
 }
+
+#ifdef mkinit
+
+INCLUDE "expand.h"
+
+RESET {
+	ifsfree();
+}
+
+#endif
diff --git a/src/expand.h b/src/expand.h
index 405af0b..4251a4a 100644
--- a/src/expand.h
+++ b/src/expand.h
@@ -70,6 +70,7 @@ int casematch(union node *, char *);
 void recordregion(int, int, int);
 void removerecordregions(int); 
 void ifsbreakup(char *, struct arglist *);
+void ifsfree(void);
 
 /* From arith.y */
 intmax_t arith(const char *);
diff --git a/src/miscbltin.c b/src/miscbltin.c
index 5ab1648..c42a01c 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -89,7 +89,7 @@ readcmd_handle_line(char *line, char **ap, size_t len)
 	
 	ifsbreakup(s, &arglist);
 	*arglist.lastp = NULL;
-	removerecordregions(0);
+	ifsfree();
 
 	for (sl = arglist.list; sl; sl = sl->next) {
 		/* remaining fields present, but no variables left. */

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
