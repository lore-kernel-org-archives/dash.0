From: Andreas Bofjall <andreas@gazonk.org>
Subject: [PATCH] trap: fix memory leak in exitshell()
Date: Mon, 21 Nov 2016 22:40:52 +0100
Message-ID: <20161121214052.32428-1-andreas@gazonk.org>
Return-path: <dash-owner@vger.kernel.org>
Received: from h-85-24-133-13.na.cust.bahnhof.se ([85.24.133.13]:33086 "HELO
        gazonk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754248AbcKUVsh (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 21 Nov 2016 16:48:37 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Andreas Bofjall <andreas@gazonk.org>

After dash had executed the exit trap handler, the trap was reset but
the pointer was never freed. This leak can be demonstrated by running
dash through valgrind and executing the following shell script:

	foo() {
	    true
	}
	trap foo EXIT

Fix by properly freeing the trap pointer in exitshell().

Signed-off-by: Andreas Bofjall <andreas@gazonk.org>
---
 src/trap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/trap.c b/src/trap.c
index edb9938..5418b07 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -389,6 +389,7 @@ exitshell(void)
 		trap[0] = NULL;
 		evalskip = 0;
 		evalstring(p, 0);
+		ckfree(p);
 	}
 out:
 	/*
-- 
2.10.2

