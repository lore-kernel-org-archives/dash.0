From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 4/4] [VAR] Replace cmdenviron with localvars
Date: Thu, 27 May 2010 13:51:41 +1000
Message-ID: <20100527035141.GB5323@gondor.apana.org.au>
References: <20100526105948.GA26352@gondor.apana.org.au> <E1OHELi-0006sy-Nn@gondolin.me.apana.org.au> <20100526223723.GB5679@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:35251 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756992Ab0E0Dvo (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 26 May 2010 23:51:44 -0400
Content-Disposition: inline
In-Reply-To: <20100526223723.GB5679@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org, pape@smarden.org

On Thu, May 27, 2010 at 12:37:23AM +0200, Jilles Tjoelker wrote:
> 
> This change breaks passing variable assignments to regular builtins.
> For example,
>   dash -c 'HOME=/ cd; pwd'
> This should print /. (For some reason, this does not work in ksh93
> either.)

Thanks, I have fixed it as follows.

commit 1d806ac1fbafb867f6252e184e1be05c0829ab71
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu May 27 11:50:19 2010 +0800

    [VAR] Do not poplocalvars prematurely on regular utilities
    
    The recent cmdenviron removal broke regular utilities by calling
    poplocalvars too early.  This patch fixes that by postponing the
    poplocalvars for regular utilities until they have completed.
    
    In order to ensure that local still works, it is now a special
    built-in.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index eb12538..4fc35a6 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,7 @@
 2010-05-27  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix poplocalvar on abnormal exit from function.
+	* Do not poplocalvars prematurely on regular utilities.
 
 2010-05-26  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/builtins.def.in b/src/builtins.def.in
index 266d0ec..4441fe4 100644
--- a/src/builtins.def.in
+++ b/src/builtins.def.in
@@ -71,7 +71,7 @@ falsecmd	-u false
 getoptscmd	-u getopts
 hashcmd		hash
 jobscmd		-u jobs
-localcmd	-a local
+localcmd	-as local
 printfcmd	printf
 pwdcmd		pwd
 readcmd		-u read
diff --git a/src/eval.c b/src/eval.c
index 2cd931b..337667f 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -847,9 +847,11 @@ bail:
 		/* NOTREACHED */
 
 	case CMDBUILTIN:
-		poplocalvars(spclbltin > 0 || argc == 0);
-		if (execcmd && argc > 1)
-			listsetvar(varlist.list, VEXPORT);
+		if (spclbltin > 0 || argc == 0) {
+			poplocalvars(1);
+			if (execcmd && argc > 1)
+				listsetvar(varlist.list, VEXPORT);
+		}
 		if (evalbltin(cmdentry.u.cmd, argc, argv, flags)) {
 			int status;
 			int i;

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
