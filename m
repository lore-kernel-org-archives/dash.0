From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: redirect bug
Date: Tue, 30 Jun 2009 15:14:03 +0800
Message-ID: <20090630071402.GA16526@gondor.apana.org.au>
References: <20090623100630.20118.qmail@riemann.fmi.uni-sofia.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:54255 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751727AbZF3HOD (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 30 Jun 2009 03:14:03 -0400
Content-Disposition: inline
In-Reply-To: <20090623100630.20118.qmail@riemann.fmi.uni-sofia.bg>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Nikola Vladov <v20-redir@riemann.fmi.uni-sofia.bg>
Cc: dash@vger.kernel.org

On Tue, Jun 23, 2009 at 10:06:30AM +0000, Nikola Vladov wrote:
> May be this is a bug:
> 
> echo XX > uu
> cat <> uu
> 
> dash truncates file uu.  The open flag O_TRUNC must be removed.
> I'm not 100% shure what POSIX say about: program <> file

Thank you.  I'll add this patch.

commit d4e757429c4006d7fe731c8ec7c9a3f21b2d23b5
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue Jun 30 15:13:28 2009 +0800

    [REDIR] Do not truncate file for FROMTO redirection
    
    On Tue, Jun 23, 2009 at 10:06:30AM +0000, Nikola Vladov wrote:
    > May be this is a bug:
    >
    > echo XX > uu
    > cat <> uu
    >
    > dash truncates file uu.  The open flag O_TRUNC must be removed.
    > I'm not 100% shure what POSIX say about: program <> file
    
    Indeed, this is a bug we inherited from NetBSD.  This patch removes
    the O_TRUNC flag for FROMTO.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index e6a1d26..37ea778 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2009-06-30  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Do not truncate file for FROMTO redirection.
+
 2009-06-27  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix quoted pattern patch breakage.
diff --git a/src/redir.c b/src/redir.c
index b01237d..54af96b 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -192,7 +192,7 @@ openredirect(union node *redir)
 		break;
 	case NFROMTO:
 		fname = redir->nfile.expfname;
-		if ((f = open64(fname, O_RDWR|O_CREAT|O_TRUNC, 0666)) < 0)
+		if ((f = open64(fname, O_RDWR|O_CREAT, 0666)) < 0)
 			goto ecreate;
 		break;
 	case NTO:
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
