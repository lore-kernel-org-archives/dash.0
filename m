From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Job control bug in revision 3800d4934391b,
Date: Sat, 29 May 2010 09:40:49 +1000
Message-ID: <20100528234049.GA27455@gondor.apana.org.au>
References: <20100528153423.GA3885@jg.home> <20100528224334.GA26879@gondor.apana.org.au> <20100528225321.GA11940@jg.home> <20100528231039.GA27140@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:35399 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753151Ab0E1Xky (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 28 May 2010 19:40:54 -0400
Content-Disposition: inline
In-Reply-To: <20100528231039.GA27140@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Kris Maglione <maglione.k@gmail.com>
Cc: dash@vger.kernel.org

On Sat, May 29, 2010 at 09:10:39AM +1000, Herbert Xu wrote:
> On Fri, May 28, 2010 at 07:01:25PM -0400, Kris Maglione wrote:
> >
> > That's interesting. I've had three users complain about it so far. strace 
> > is attached.
> 
> Thanks, I have reproduced it here now.  It looks like it only
> happens occasionally on my system.

I think this patch should fix it, but please do test it as I
can only rarely reproduce this on my machine.

diff --git a/ChangeLog b/ChangeLog
index 54d2972..5a11a8c 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2010-05-29  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Continue after EINTR in read(1) with no pending signals.
+
 2010-05-27  Jilles Tjoelker <jilles@stack.nl>
 
 	* Force fork if any trap is set, not just on EXIT.
diff --git a/src/miscbltin.c b/src/miscbltin.c
index 046f2f2..5ab1648 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -57,6 +57,7 @@
 #include "main.h"
 #include "expand.h"
 #include "parser.h"
+#include "trap.h"
 
 #undef rflag
 
@@ -158,9 +159,16 @@ readcmd(int argc, char **argv)
 	backslash = 0;
 	STARTSTACKSTR(p);
 	for (;;) {
-		if (read(0, &c, 1) != 1) {
-			status = 1;
+		switch (read(0, &c, 1)) {
+		case 1:
 			break;
+		default:
+			if (errno == EINTR && !pendingsigs)
+				continue;
+				/* fall through */
+		case 0:
+			status = 1;
+			goto out;
 		}
 		if (c == '\0')
 			continue;
@@ -181,6 +189,7 @@ put:
 resetbs:
 		backslash = 0;
 	}
+out:
 	STACKSTRNUL(p);
 	readcmd_handle_line(stackblock(), ap, p + 1 - (char *)stackblock());
 	return status;

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
