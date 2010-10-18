From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [Partial patch] IFS and read builtin
Date: Mon, 18 Oct 2010 10:54:02 +0800
Message-ID: <20101018025402.GA29011@gondor.apana.org.au>
References: <4C71A29C.1080609@gigawatt.nl> <20100908115324.GA17029@gondor.apana.org.au> <20100908120849.GA17121@gondor.apana.org.au> <20101016191548.GA10626@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:34978 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab0JRCyK (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 17 Oct 2010 22:54:10 -0400
Content-Disposition: inline
In-Reply-To: <20101016191548.GA10626@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org

On Sat, Oct 16, 2010 at 02:15:48PM -0500, Jonathan Nieder wrote:
> 
> Bisects to f42e443bb.  Reverting it avoids the problem.  Any ideas
> before I investigate further?

Does this patch help?

diff --git a/ChangeLog b/ChangeLog
index 2faaedd..5ace9ff 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2010-10-18  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fix ifsfirst/ifslastp leak in casematch.
+
 2010-10-07  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix EXEXEC status clobbering.
diff --git a/src/expand.c b/src/expand.c
index d6c6416..1b77b7c 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1679,6 +1679,7 @@ casematch(union node *pattern, char *val)
 	STARTSTACKSTR(expdest);
 	argstr(pattern->narg.text, EXP_TILDE | EXP_CASE);
 	STACKSTRNUL(expdest);
+	ifsfree();
 	result = patmatch(stackblock(), val);
 	popstackmark(&smark);
 	return result;

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
