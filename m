From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [Partial patch] IFS and read builtin
Date: Wed, 8 Sep 2010 19:53:24 +0800
Message-ID: <20100908115324.GA17029@gondor.apana.org.au>
References: <4C71A29C.1080609@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:44124 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab0IHLx0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 8 Sep 2010 07:53:26 -0400
Content-Disposition: inline
In-Reply-To: <4C71A29C.1080609@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org

Harald van Dijk <harald@gigawatt.nl> wrote:
> [-- text/plain, encoding 7bit, charset: ISO-8859-1, 20 lines --]
> 
> Hi, as has been reported already dash currently has a bug where the read builtin ignores the read environment's IFS setting. As a result,
> 
>  echo a:b | { IFS=: read a b; echo $a; }
> 
> will write out a:b. I tried to see what changed between 0.5.5.1 and 0.5.6, and found that the old code used bltinlookup("IFS"). So, I made the new code also use that. The above example works properly with the attached patch.

This problem should be fixed in the main trunk.  I will make a
new release soon.

> However, testing further, I found that there is bad interaction (even without my patch, where the IFS assignment below should just be ignored) between the code that handles variable assignments, and read. Try this:
> 
>   $ src/dash -c 'printf "a\t\tb\n" | { IFS=$(printf "\t") read a b c; echo "|$a|$b|$c|"; }'
>   |a||b|
>   $ src/dash -c 'printf "a\t\tb\n" | { IFS="$(printf "\t")" read a b c; echo "|$a|$b|$c|"; }'
>   |a|b||
> 
> This happens because expbackq is correctly called without EXP_QUOTED, which makes it call recordregion, which isn't cleared by the time read calls ifsbreakup. I'm not sure how that should be solved, and if there are more cases where it would fail. The simplest way to solve this for read is to call removerecordregions(0) before recordregion(0, len - 1, 0). I have tested that locally, and it works. I am not familiar enough with the code to judge whether the same situation can also happen in other cases that would also need fixing, which is why I have not included that part in the attached patch.

Thanks for catching this.

This is the result of ifslastp leaking out of expandarg which isn't
supposed to happen.  The following patch should fix it plus a real
memory leak that occurs if we bail before hitting ifsfree.

commit 5c7042771753d5a968b2b7263cf9f4e02fa3820e
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Wed Sep 8 19:51:10 2010 +0800

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

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
