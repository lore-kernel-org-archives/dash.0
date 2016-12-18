From: Mihail Konev <k.mvc@ya.ru>
Subject: [PATCH] builtin: Fix 'echo --' handling
Date: Mon, 19 Dec 2016 01:16:06 +0500
Message-ID: <20161218201606.GA19607@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <dash-owner@vger.kernel.org>
Received: from forward16p.cmail.yandex.net ([87.250.241.143]:33766 "EHLO
        forward16p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753709AbcLRUXf (ORCPT
        <rfc822;dash@vger.kernel.org>); Sun, 18 Dec 2016 15:23:35 -0500
Received: from smtp1h.mail.yandex.net (smtp1h.mail.yandex.net [84.201.187.144])
        by forward16p.cmail.yandex.net (Yandex) with ESMTP id EFC5921A1F
        for <dash@vger.kernel.org>; Sun, 18 Dec 2016 23:16:15 +0300 (MSK)
Received: from smtp1h.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp1h.mail.yandex.net (Yandex) with ESMTP id CC70F8C0D5B
        for <dash@vger.kernel.org>; Sun, 18 Dec 2016 23:16:15 +0300 (MSK)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Ignore first "--", as the end of options.

Breaks uses that expect 'echo' to output arguments verbatim, but
fixes those that expect 'echo --' to do so (such as 'echo -- -n').

Signed-off-by: Mihail Konev <k.mvc@ya.ru>
---
 src/bltin/printf.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index a626cee2c60e..1b3df313f02d 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -450,20 +450,29 @@ int
 echocmd(int argc, char **argv)
 {
 	int nonl;
+	int dashdash_met = 0;
 
-	nonl = *++argv ? equal(*argv, "-n") : 0;
+	nonl = (*++argv && !dashdash_met) ? equal(*argv, "-n") : 0;
 	argv += nonl;
 
 	do {
-		int c;
-
-		if (likely(*argv))
-			nonl += print_escape_str("%s", NULL, NULL, *argv++);
+		int c = 1;
+
+		if (likely(*argv)) {
+			if (unlikely(equal(*argv, "--") && !dashdash_met)) {
+				dashdash_met = 1;
+				c = 0;
+			} else
+				nonl += print_escape_str("%s", NULL, NULL, *argv);
+			argv++;
+		}
 		if (likely((nonl + !*argv) > 1))
 			break;
 
-		c = *argv ? ' ' : '\n';
-		out1c(c);
+		if (c) {
+			c = *argv ? ' ' : '\n';
+			out1c(c);
+		}
 	} while (*argv);
 	return 0;
 }
-- 
2.9.2

