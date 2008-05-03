From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash regression against klibc
Date: Sat, 3 May 2008 14:19:31 +0800
Message-ID: <20080503061931.GB24183@gondor.apana.org.au>
References: <449c10960805011025v675414cco36cb2d6400cc6217@mail.gmail.com> <20080502052530.GA15890@gondor.apana.org.au> <20080502062303.GA16356@gondor.apana.org.au> <449c10960805021808k6f4bb039nc37ba5177a9584d5@mail.gmail.com> <20080503022101.GA23067@gondor.apana.org.au> <481C00DF.4060706@zytor.com> <20080503061351.GA24061@gondor.apana.org.au> <449c10960805022316tf68b749rb7c4d2aeb6526853@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:41627 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754080AbYECGTg (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 3 May 2008 02:19:36 -0400
Content-Disposition: inline
In-Reply-To: <449c10960805022316tf68b749rb7c4d2aeb6526853@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan McGee <dan@archlinux.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, dash@vger.kernel.org

On Sat, May 03, 2008 at 01:16:56AM -0500, Dan McGee wrote:
>
> That change makes it work fine here. Thanks for looking into all of this.

OK this is what I've committed.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
commit d2bb89771175405c308a8a89424eeb82a15aaaee
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sat May 3 14:17:40 2008 +0800

    [CD] Test __GLIBC__ instead of _GNU_SOURCE
    
    AC_GNU_SOURCE always defines _GNU_SOURCE so testing it is pointless.
    This patch changes it to test __GLIBC__ instead.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 1126b04..94b37c4 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,7 @@
 2008-05-03  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fixed _PATH_BSHELL warning.
+	* Test __GLIBC__ instead of _GNU_SOURCE.
 
 2008-05-02  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/cd.c b/src/cd.c
index cb6e24d..73ccde0 100644
--- a/src/cd.c
+++ b/src/cd.c
@@ -249,7 +249,7 @@ inline
 STATIC char *
 getpwd()
 {
-#ifdef _GNU_SOURCE
+#ifdef __GLIBC__
 	char *dir = getcwd(0, 0);
 	return dir ? dir : nullstr;
 #else
