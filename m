From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 9/9] [BUILTIN] Simplify echo command
Date: Mon, 27 Oct 2014 16:27:00 +0800
Message-ID: <E1Xifdk-0001iq-B7@gondolin.me.apana.org.au>
References: <20141027082546.GA6447@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:58584 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbaJ0I1E (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 27 Oct 2014 04:27:04 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by fornost.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
	id 1Xifdm-0006Jo-84
	for <dash@vger.kernel.org>; Mon, 27 Oct 2014 19:27:02 +1100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog          |    1 +
 src/bltin/printf.c |   28 ++++++++--------------------
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 60fd4b6..f015066 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -9,6 +9,7 @@
 	* Remove getintmax in printf.
 	* Use error instead of warnx for fatal errors in printf.
 	* Optimise handling of backslash octals in printf.
+	* Simplify echo command.
 
 2014-10-13  Eric Blake <eblake@redhat.com>
 
diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 6f39526..9673e10 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -442,33 +442,21 @@ check_conversion(const char *s, const char *ep)
 int
 echocmd(int argc, char **argv)
 {
-	int nonl = 0;
-	struct output *outs = out1;
-
-	if (!*++argv)
-		goto end;
-	if (equal(*argv, "-n")) {
-		nonl = ~nonl;
-		if (!*++argv)
-			goto end;
-	}
+	int nonl;
+
+	nonl = *++argv ? equal(*argv, "-n") : 0;
+	argv += nonl;
 
 	do {
 		int c;
 
-		nonl += print_escape_str("%s", NULL, NULL, *argv);
+		if (likely(*argv))
+			nonl += print_escape_str("%s", NULL, NULL, *argv++);
 		if (nonl > 0)
 			break;
 
-		c = ' ';
-		if (!*++argv) {
-end:
-			if (nonl) {
-				break;
-			}
-			c = '\n';
-		}
-		outc(c, outs);
+		c = *argv ? ' ' : '\n';
+		out1c(c);
 	} while (*argv);
 	return 0;
 }
