From: Brian Koropoff <bkoropoff@gmail.com>
Subject: [PATCH 2/3] Port to AIX
Date: Tue, 18 Jan 2011 21:15:49 -0800
Message-ID: <1295414149.6486.4.camel@gemini>
References: <1295413636.4278.28.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51467 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab1ASFPw (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 19 Jan 2011 00:15:52 -0500
Received: by gxk9 with SMTP id 9so119552gxk.19
        for <dash@vger.kernel.org>; Tue, 18 Jan 2011 21:15:51 -0800 (PST)
In-Reply-To: <1295413636.4278.28.camel@gemini>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

- AIX lacks a WCOREDUMP macro.  It's just used to
  append "(core dumped)" to the crash message, so
  #ifdef around it.

- For some reason, the nl program on AIX defaults
  to not printing line numbers ("-b n"), even though
  the spec says it should default to "-b t".
  Explicitly pass "-b a" for good measure in mkbuiltins.

Signed-off-by: Brian Koropoff <bkoropoff@gmail.com>
---
 src/jobs.c     |    2 ++
 src/mkbuiltins |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index fdb122a..88b5792 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -431,9 +431,11 @@ sprint_status(char *s, int status, int sigonly)
 #endif
 		}
 		col = fmtstr(s, 32, strsignal(st));
+#ifdef WCOREDUMP
 		if (WCOREDUMP(status)) {
 			col += fmtstr(s + col, 16, " (core dumped)");
 		}
+#endif
 	} else if (!sigonly) {
 		if (st)
 			col = fmtstr(s, 16, "Done(%d)", st);
diff --git a/src/mkbuiltins b/src/mkbuiltins
index bb1e2a4..495274e 100644
--- a/src/mkbuiltins
+++ b/src/mkbuiltins
@@ -99,7 +99,7 @@ cat <<\!
  */
 
 !
-sed 's/	-[a-z]*//' $temp2 | nl -v 0 | LC_COLLATE=C sort -u -k 3,3 |
+sed 's/	-[a-z]*//' $temp2 | nl -b a -v 0 | LC_COLLATE=C sort -u -k 3,3 |
 tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ |
 	awk '{	printf "#define %s (builtincmd + %d)\n", $3, $1}'
 printf '\n#define NUMBUILTINS %d\n' $(wc -l < $temp2)
-- 
1.7.1


