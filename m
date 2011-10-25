From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] echo: fix octal escaping with \1...\7
Date: Tue, 25 Oct 2011 17:58:04 -0400
Message-ID: <1319579884-423-1-git-send-email-vapier@gentoo.org>
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:54286 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034Ab1JYV6i (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 25 Oct 2011 17:58:38 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>

POSIX states that octal escape sequences should take the form \0num
when using echo.  dash however additionally treats \num as an octal
sequence.  This breaks some packages (like libtool) who attempt to
use strings with these escape sequences via variables to execute sed
(since sed ends up getting passed a byte instead of a literal \1).

The code that consumes this sequence includes a comment that indicates
it doesn't actually mean to do this.  So simplify the code a bit by
ignoring these sequences that lack a leading 0 and falling through to
the existing escape parsing logic.

before:
	$ echo '\1' | hexdump -C
	00000000  01 0a                 |..|
after:
	$ echo '\1' | hexdump -C
	00000000  5c 31 0a              |\1.|
(existing \01 sequence still works the same)

This also slightly shrinks the resulting compiled code :).

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
Note: I assume this still applies to the latest git.  The last
	checkout I have is from Sep 2010 though, and kernel.org does
	not yet have the dash tree back on it.

 src/bltin/printf.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index b0c3774..1d373f9 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -247,18 +247,10 @@ conv_escape_str(char *str)
 		 * They start with a \0, and are followed by 0, 1, 2, 
 		 * or 3 octal digits. 
 		 */
-		if (ch == '0') {
-			unsigned char i;
-			i = 3;
-			ch = 0;
-			do {
-				unsigned k = octtobin(*str);
-				if (k > 7)
-					break;
-				str++;
-				ch <<= 3;
-				ch += k;
-			} while (--i);
+		if (ch >= '1' && ch <= '9') {
+			/* Filter \1...\9; let \0 fall to conv_escape(). */
+			ch = '\\';
+			--str;
 			continue;
 		}
 
-- 
1.7.6.1

