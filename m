From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: trap bug in recent versions of dash
Date: Sun, 28 Nov 2010 15:19:06 +0800
Message-ID: <20101128071906.GA8818@gondor.apana.org.au>
References: <20100811080616.GA18303@wopr.local.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:48705 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab0K1HTK (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Nov 2010 02:19:10 -0500
Content-Disposition: inline
In-Reply-To: <20100811080616.GA18303@wopr.local.invalid>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Guido Berhoerster <guido+kernel.org@berhoerster.name>
Cc: dash@vger.kernel.org

On Wed, Aug 11, 2010 at 08:06:16AM +0000, Guido Berhoerster wrote:
> Hello,
> 
> with the latest git version of dash trap actions are not
> evaluated in the context of a function.
> 
> The following script demonstrates the bug:
> ----8<----
> read_timeout () {
>     saved_traps="$(trap)"
>     trap 'printf "timed out\n"; eval "${saved_traps}"; return' TERM
>     ( sleep $1; kill -TERM $$ ) >/dev/null 2>&1 &
>     timer_pid=$!
>     read $2
>     kill $timer_pid 2>/dev/null
> }
> 
> read_timeout 5 value
> printf "read \"%s\"\n" "${value:=default}"
> 
> ---->8----
> The return statement in the trap inside the read_timeout function
> does not return from the function but rather exits the script.
> 
> With dash 0.5.5.1 it works as expected.

Indeed this was a regression caused by the SKIPEVAL removal.

This patch should fix it.

commit faefce1ebe585366b1458031f2c1f723dc630def
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Nov 28 15:17:45 2010 +0800

    [EVAL] Fixed trap/return regression due to SKIPEVAL removal
    
    On Wed, Aug 11, 2010 at 08:06:16AM +0000, Guido Berhoerster wrote:
    >
    > with the latest git version of dash trap actions are not
    > evaluated in the context of a function.
    >
    > The following script demonstrates the bug:
    > ----8<----
    > read_timeout () {
    >     saved_traps="$(trap)"
    >     trap 'printf "timed out\n"; eval "${saved_traps}"; return' TERM
    >     ( sleep $1; kill -TERM $$ ) >/dev/null 2>&1 &
    >     timer_pid=$!
    >     read $2
    >     kill $timer_pid 2>/dev/null
    > }
    >
    > read_timeout 5 value
    > printf "read \"%s\"\n" "${value:=default}"
    >
    > ---->8----
    > The return statement in the trap inside the read_timeout function
    > does not return from the function but rather exits the script.
    >
    > With dash 0.5.5.1 it works as expected.
    
    This bug was caused by the SKIPEVAL removal.  When the SKIPEVAL
    hack was added to improve set -e support in traps, dotrap was
    changed to return whether set -e was detected.  After the removal
    of SKIPEVAL, set -e is now handled through exraise.
    
    However, dotrap still returned a value which is now incorrectly
    used to trigger an exraise.
    
    This patch removes the vestigial link between dotrap and exraise.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 5ace9ff..f148ef6 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2010-11-28  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fixed trap/return regression due to SKIPEVAL removal.
+
 2010-10-18  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix ifsfirst/ifslastp leak in casematch.
diff --git a/src/eval.c b/src/eval.c
index b966749..ea4afc6 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -304,10 +304,16 @@ setstatus:
 		break;
 	}
 out:
-	if ((checkexit & exitstatus) ||
-	    (pendingsigs && dotrap()) ||
-	    (flags & EV_EXIT))
+	if (checkexit & exitstatus)
+		goto exexit;
+
+	if (pendingsigs)
+		dotrap();
+
+	if (flags & EV_EXIT) {
+exexit:
 		exraise(EXEXIT);
+	}
 }
 
 
diff --git a/src/trap.c b/src/trap.c
index 7bd60ab..3d28485 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -309,8 +309,7 @@ onsig(int signo)
  * handlers while we are executing a trap handler.
  */
 
-int
-dotrap(void)
+void dotrap(void)
 {
 	char *p;
 	char *q;
@@ -332,10 +331,8 @@ dotrap(void)
 		evalstring(p, 0);
 		exitstatus = savestatus;
 		if (evalskip)
-			return evalskip;
+			break;
 	}
