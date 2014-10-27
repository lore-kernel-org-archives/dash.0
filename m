From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 8/9] [BUILTIN] Optimise handling of backslash octals in printf
Date: Mon, 27 Oct 2014 16:26:59 +0800
Message-ID: <E1Xifdj-0001ii-La@gondolin.me.apana.org.au>
References: <20141027082546.GA6447@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:44907 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbaJ0I1E (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 27 Oct 2014 04:27:04 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by fornost.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
	id 1Xifdl-0006JW-CA
	for <dash@vger.kernel.org>; Mon, 27 Oct 2014 19:27:01 +1100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This patch removes the duplicate octal handling for %b by reusing
the existing code in conv_escape.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog          |    1 +
 src/bltin/printf.c |   30 ++++++++----------------------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 707c24d..60fd4b6 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -8,6 +8,7 @@
 	* Remove unnecessary restoration of format string in printf.
 	* Remove getintmax in printf.
 	* Use error instead of warnx for fatal errors in printf.
+	* Optimise handling of backslash octals in printf.
 
 2014-10-13  Eric Blake <eblake@redhat.com>
 
diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 4812e40..6f39526 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -272,8 +272,8 @@ conv_escape_str(char *str, char **sp)
 		if (ch != '\\')
 			continue;
 
-		ch = *str++;
-		if (ch == 'c') {
+		c = *str++;
+		if (c == 'c') {
 			/* \c as in SYSV echo - abort all processing.... */
 			c = ch = 0x100;
 			continue;
@@ -284,24 +284,11 @@ conv_escape_str(char *str, char **sp)
 		 * They start with a \0, and are followed by 0, 1, 2, 
 		 * or 3 octal digits. 
 		 */
-		if (ch == '0') {
-			unsigned char i;
-			i = 3;
-			c = 0;
-			do {
-				unsigned k = octtobin(*str);
-				if (k > 7)
-					break;
-				str++;
-				c <<= 3;
-				c += k;
-			} while (--i);
-			continue;
-		}
+		if (c == '0' && isodigit(*str))
+			str++;
 
 		/* Finally test for sequences valid in the format string */
 		str = conv_escape(str - 1, &c);
-		ch = c;
 	} while (STPUTC(c, cp), (char)ch);
 
 	*sp = cp;
@@ -322,12 +309,11 @@ conv_escape(char *str, int *conv_ch)
 
 	switch (ch) {
 	default:
-	case 0:
-		value = '\\';
-		goto out;
+		if (!isodigit(*str)) {
+			value = '\\';
+			goto out;
+		}
 
-	case '0': case '1': case '2': case '3':
-	case '4': case '5': case '6': case '7':
 		ch = 3;
 		value = 0;
 		do {
