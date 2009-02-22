From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [JOBS] Do not close stderr when /dev/tty fails to open
Date: Sun, 22 Feb 2009 19:33:04 +0800
Message-ID: <20090222113304.GA3015@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:40588 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753457AbZBVLdI (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 22 Feb 2009 06:33:08 -0500
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.63 #1 (Debian))
	id 1LbCa0-0007qd-EK
	for <dash@vger.kernel.org>; Sun, 22 Feb 2009 22:33:04 +1100
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>)
	id 1LbCa0-0000mu-2c
	for dash@vger.kernel.org; Sun, 22 Feb 2009 19:33:04 +0800
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

[JOBS] Do not close stderr when /dev/tty fails to open

As it stands if we fail to open /dev/tty we end up closing stderr
after saving it at a higher fd.

Thanks to David van Gorkom for reporting this.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index d87e5d4..dcb7182 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -2,6 +2,7 @@
 
 	* Fix dowait signal race.
 	* Remove EXSIG.
+	* Do not close stderr when /dev/tty fails to open.
 
 2009-01-14  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/jobs.c b/src/jobs.c
index 69a84f7..b1ab7ab 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -195,6 +195,9 @@ setjobctl(int on)
 			while (!isatty(fd))
 				if (--fd < 0)
 					goto out;
+			fd = dup(fd);
+			if (fd < 0)
+				goto out;
 		}
 		fd = savefd(fd);
 		do { /* while we are in the background */
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
