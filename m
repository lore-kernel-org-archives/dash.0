From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [BUILTIN] Handle -- in dotcmd
Date: Mon, 27 Oct 2014 16:57:41 +0800
Message-ID: <20141027085741.GA6948@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:60449 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbaJ0I5p (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 27 Oct 2014 04:57:45 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: 503840@bugs.debian.org, 503840-submitter@bugs.debian.org

commit 12ad48bb31b003eb6d3106478b7760a031969a36
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon Oct 27 16:56:46 2014 +0800

    [BUILTIN] Handle -- in dotcmd
    
    This patch adds a nextopt call in dotcmd in order to handle --.
    
    Reported-by: Stephane Chazelas <stephane_chazelas@yahoo.fr>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index f015066..5212a9a 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -10,6 +10,7 @@
 	* Use error instead of warnx for fatal errors in printf.
 	* Optimise handling of backslash octals in printf.
 	* Simplify echo command.
+	* Handle -- in dotcmd.
 
 2014-10-13  Eric Blake <eblake@redhat.com>
 
diff --git a/src/main.c b/src/main.c
index 00c5e00..985e8c4 100644
--- a/src/main.c
+++ b/src/main.c
@@ -321,15 +321,19 @@ dotcmd(int argc, char **argv)
 {
 	int status = 0;
 
-	if (argc >= 2) {		/* That's what SVR2 does */
+	nextopt(nullstr);
+	argv = argptr;
+
+	if (*argv) {
 		char *fullname;
 
-		fullname = find_dot_file(argv[1]);
+		fullname = find_dot_file(*argv);
 		setinputfile(fullname, INPUT_PUSH_FILE);
 		commandname = fullname;
 		status = cmdloop(0);
 		popfile();
 	}
+
 	return status;
 }

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
