From: Andreas Bofjall <andreas@gazonk.org>
Subject: [PATCH v2] trap: fix memory leak in exitshell()
Date: Thu,  1 Dec 2016 22:17:07 +0100
Message-ID: <20161201211707.4710-1-andreas@gazonk.org>
Return-path: <dash-owner@vger.kernel.org>
Received: from h-85-24-133-13.na.cust.bahnhof.se ([85.24.133.13]:33630 "HELO
        gazonk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751198AbcLAVRT (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 1 Dec 2016 16:17:19 -0500
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
v2: move ckfree() to out path

 src/trap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/trap.c b/src/trap.c
index edb9938..0824223 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -378,7 +378,7 @@ void
 exitshell(void)
 {
 	struct jmploc loc;
-	char *p;
+	char *p = NULL;
 
 	savestatus = exitstatus;
 	TRACE(("pid %d, exitshell(%d)\n", getpid(), savestatus));
@@ -391,6 +391,9 @@ exitshell(void)
 		evalstring(p, 0);
 	}
 out:
+	INTOFF;
+	ckfree(p);
+	INTON;
 	/*
 	 * Disable job control so that whoever had the foreground before we
 	 * started can get it back.
-- 
2.10.2

