From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [BUILTIN] Add printf support for format string a, A, and F
Date: Mon, 27 Oct 2014 11:46:29 +0800
Message-ID: <20141027034628.GA5220@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:57224 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbaJ0Dqd (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 26 Oct 2014 23:46:33 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

commit c77265b4ea89359c164346e400914bb24a3716d1
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon Oct 27 11:45:01 2014 +0800

    [BUILTIN] Add printf support for format string a, A, and F
    
    This patch adds the format string characters a, A and F to the
    supported set of the built-in printf command.  They're already
    supported by the underlying printf function.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 2155764..46ef4c2 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-10-27  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Add printf support for format string a, A, and F.
+
 2014-10-13  Eric Blake <eblake@redhat.com>
 
 	* cd: support drive letters on Cygwin.
diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 5f9e81c..e0ef912 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -191,9 +191,12 @@ pc:
 				PF(f, p);
 				break;
 			}
+			case 'a':
+			case 'A':
 			case 'e':
 			case 'E':
 			case 'f':
+			case 'F':
 			case 'g':
 			case 'G': {
 				double p = getdouble();

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
