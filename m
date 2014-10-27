From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 7/9] [BUILTIN] Use error instead of warnx for fatal errors in printf
Date: Mon, 27 Oct 2014 16:26:58 +0800
Message-ID: <E1Xifdi-0001iP-TG@gondolin.me.apana.org.au>
References: <20141027082546.GA6447@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:41451 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbaJ0I1C (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 27 Oct 2014 04:27:02 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by fornost.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
	id 1Xifdj-0006JN-Oh
	for <dash@vger.kernel.org>; Mon, 27 Oct 2014 19:26:59 +1100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This patch replaces uses of warnx where we abort with error since
the effect is the same.  The exit status however changes from 1 to
2.  Non-fatal errors where we continue are unchanged.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog          |    1 +
 src/bltin/printf.c |   17 +++++------------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 5b9b03a..707c24d 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -7,6 +7,7 @@
 	* Add ifdefs around MEM_OUT handling in outmem.
 	* Remove unnecessary restoration of format string in printf.
 	* Remove getintmax in printf.
+	* Use error instead of warnx for fatal errors in printf.
 
 2014-10-13  Eric Blake <eblake@redhat.com>
 
diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index ebc74ae..4812e40 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -132,10 +132,8 @@ int printfcmd(int argc, char *argv[])
 	argv = argptr;
 	format = *argv;
 
-	if (!format) {
-		warnx("usage: printf format [arg ...]");
-		goto err;
-	}
+	if (!format)
+		error("usage: printf format [arg ...]");
 
 	gargv = ++argv;
 
@@ -190,10 +188,8 @@ pc:
 			fmt += strspn(fmt, SKIP2);
 
 			ch = *fmt;
-			if (!ch) {
-				warnx("missing format character");
-				goto err;
-			}
+			if (!ch)
+				error("missing format character");
 			/* null terminate format string to we can use it
 			   as an argument to printf. */
 			nextch = fmt[1];
@@ -246,8 +242,7 @@ pc:
 				break;
 			}
 			default:
-				warnx("%s: invalid directive", start);
-				goto err;
+				error("%s: invalid directive", start);
 			}
 			*++fmt = nextch;
 		}
@@ -255,8 +250,6 @@ pc:
 
 out:
 	return rval;
-err:
-	return 1;
 }
 
 
