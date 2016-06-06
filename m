From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: trap: Implement POSIX.1-2008 trap reset behaviour (#2)
Date: Mon, 6 Jun 2016 19:52:43 +0800
Message-ID: <20160606115243.GA22071@gondor.apana.org.au>
References: <20151207175047.GG735@joyent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:50840 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbcFFLw7 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 6 Jun 2016 07:52:59 -0400
Content-Disposition: inline
In-Reply-To: <20151207175047.GG735@joyent.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Perkin <jperkin@joyent.com>
Cc: dash@vger.kernel.org

On Mon, Dec 07, 2015 at 05:50:47PM +0000, Jonathan Perkin wrote:
> Clarifies a couple of issues with the previous patch, and expands on
> the rationale in the commit message.  Sorry for the noise -- jperkin

Thanks for the patch.

I've decided to do something similar to your final patch:

---8<---
Jonathan Perkin submitted a patch to fix the behaviour of trap
when the first argument is an integer.  Currently it is treated
as a command while POSIX requires it to be treated as a signal.

This patch is based on his idea but instead of adding an extra
argument to decode_signal I have added a new decode_signum helper.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/trap.c b/src/trap.c
index 82d4263..edb9938 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -79,6 +79,8 @@ int gotsigchld;
 
 extern char *signal_names[];
 
+static int decode_signum(const char *);
+
 #ifdef mkinit
 INCLUDE "trap.h"
 INIT {
@@ -112,7 +114,7 @@ trapcmd(int argc, char **argv)
 		}
 		return 0;
 	}
-	if (!ap[1])
+	if (!ap[1] || decode_signum(*ap) >= 0)
 		action = NULL;
 	else
 		action = *ap++;
@@ -400,18 +402,27 @@ out:
 	/* NOTREACHED */
 }
 
-int decode_signal(const char *string, int minsig)
+static int decode_signum(const char *string)
 {
-	int signo;
+	int signo = -1;
 
 	if (is_number(string)) {
 		signo = atoi(string);
-		if (signo >= NSIG) {
-			return -1;
-		}
-		return signo;
+		if (signo >= NSIG)
+			signo = -1;
 	}
 
+	return signo;
+}
+
+int decode_signal(const char *string, int minsig)
+{
+	int signo;
+
+	signo = decode_signum(string);
+	if (signo >= 0)
+		return signo;
+
 	for (signo = minsig; signo < NSIG; signo++) {
 		if (!strcasecmp(string, signal_names[signo])) {
 			return signo;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
