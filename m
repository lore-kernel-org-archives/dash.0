From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash regression against klibc
Date: Fri, 2 May 2008 14:23:03 +0800
Message-ID: <20080502062303.GA16356@gondor.apana.org.au>
References: <449c10960805011025v675414cco36cb2d6400cc6217@mail.gmail.com> <20080502052530.GA15890@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:53751 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757887AbYEBGXH (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 May 2008 02:23:07 -0400
Content-Disposition: inline
In-Reply-To: <20080502052530.GA15890@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan McGee <dan@archlinux.org>
Cc: dash@vger.kernel.org

On Fri, May 02, 2008 at 01:25:30PM +0800, Herbert Xu wrote:
>
> I suspect the problem is klibc's getcwd implementation but this
> should confirm it for us.

Actually klibc's getcwd is just fine as it is.  It's dash that's
relying on glibc extensions of getcwd.

This patch sould make it work again.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
commit b306b8c58d10c3fa1a34edc22042e4d9b6185f87
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri May 2 14:20:44 2008 +0800

    [CD] Restored non-glibc getcwd support
    
    These days dash is expected to build with libraries other than
    glibc so we need to support the old way of calling getcwd again.
    
    Thanks to Dan McGee for reporting this bug when dash is built with
    klibc.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index f5e0dbc..5216521 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2008-05-02  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Restored non-glibc getcwd support.
+
 2008-03-07  Larry Doolittle <ldoolitt@recycle.lbl.gov>
 
 	* Fix cmdtxt crash on if statements.
diff --git a/src/cd.c b/src/cd.c
index 1849c69..0c2f1ee 100644
--- a/src/cd.c
+++ b/src/cd.c
@@ -241,8 +241,6 @@ updatepwd(const char *dir)
 }
 
 
-#define MAXPWD 256
