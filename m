From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [BUILTIN] Fix corruption of reads with byte 0x81
Date: Thu, 10 Mar 2011 21:01:45 +0800
Message-ID: <20110310130145.GF10824@gondor.apana.org.au>
References: <4D5C4EE2.9060504@gmail.com> <4D664470.7070707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:56678 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab1CJNBs (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 10 Mar 2011 08:01:48 -0500
Content-Disposition: inline
In-Reply-To: <4D664470.7070707@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: dash@vger.kernel.org

On Thu, Feb 24, 2011 at 11:43:44AM +0000, Alexey Gladkov wrote:
> Starting with commit 55c46b dash removes CTLESC bytes ('\x81')
> from read sequence. This leads to breakage of some UTF8
> characters. Like in commit f8231a, this change fixes corruption
> by removing the faulty code.

Thanks for the diagnosis and patch!

Unfortunately we can't just delete the rmescaps call since we do
use CTLESC to represent backslash characters in the input stream
which prevents field splitting.

So the correct fix is to add extra CTLESCs wherever CTLESC appears
in the input.  The following patch should fix the problem.

commit 54413164e587dd2dc5d7bce0bd3fab61d7ba758c
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu Mar 10 20:59:46 2011 +0800

    [BUILTIN] Fix CTLESC clobbering by read(1)
    
    The changeset 55c46b7286f5d9f2d8291158203e2b61d2494420
    
    	[BUILTIN] Honor tab as IFS whitespace when splitting fields in readcmd
    
    uses CTLESC to prevent field splitting in read(1).  However,
    it did not escape CTLESC itself in the input stream.  This patch
    adds the necessary CTLESC characters so that CTLESC isn't corrupted.
    
    Reported-by: Alexey Gladkov <gladkov.alexey@gmail.com>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 173f057..6d02fa9 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2011-03-10  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fix CTLESC clobbering by read(1).
+
 2011-03-10  Brian Koropoff <bkoropoff@gmail.com>
 
 	* Port to AIX.
diff --git a/src/miscbltin.c b/src/miscbltin.c
index 653c92f..800cbbb 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -178,7 +178,7 @@ readcmd(int argc, char **argv)
 		}
 		if (c == '\0')
 			continue;
-		if (backslash) {
+		if (backslash || c == CTLESC) {
 			if (c == '\n')
 				goto resetbs;
 			STPUTC(CTLESC, p);

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
