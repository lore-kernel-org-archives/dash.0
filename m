From: Youfu Zhang <zhangyoufu@gmail.com>
Subject: [PATCH] [BUILTIN] describe_command: fix incorrect path
Date: Fri, 26 May 2017 15:04:12 +0800
Message-ID: <20170526070412.19254-1-zhangyoufu@gmail.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36576 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163817AbdEZHEZ (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 26 May 2017 03:04:25 -0400
Received: by mail-pf0-f196.google.com with SMTP id n23so788595pfb.3
        for <dash@vger.kernel.org>; Fri, 26 May 2017 00:04:25 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Youfu Zhang <zhangyoufu@gmail.com>

$ PATH=/extra/path:/usr/sbin:/usr/bin:/sbin:/bin \
> sh -xc 'command -V ls; command -V ls; command -Vp ls; command -vp ls'
+ command -V ls
ls is /bin/ls
+ command -V ls
ls is a tracked alias for /bin/ls
+ command -Vp ls
ls is a tracked alias for (null)
+ command -vp ls
Segmentation fault (core dumped)

describe_command should respect `path' argument. Looking up in the hash table
may gives incorrect index in entry.u.index and finally causes incorrect output
or SIGSEGV.

Signed-off-by: Youfu Zhang <zhangyoufu@gmail.com>
---
 src/exec.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/src/exec.c b/src/exec.c
index ec0eadd..c4eeb58 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -767,14 +767,8 @@ describe_command(out, command, path, verbose)
 		goto out;
 	}
 
-	/* Then check if it is a tracked alias */
-	if ((cmdp = cmdlookup(command, 0)) != NULL) {
-		entry.cmdtype = cmdp->cmdtype;
-		entry.u = cmdp->param;
-	} else {
-		/* Finally use brute force */
-		find_command(command, &entry, DO_ABS, path);
-	}
+	/* Brute force */
+	find_command(command, &entry, DO_ABS, path);
 
 	switch (entry.cmdtype) {
 	case CMDNORMAL: {
-- 
2.8.4 (Apple Git-73)

