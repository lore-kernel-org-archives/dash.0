From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: bugs in cd
Date: Mon, 31 Aug 2009 22:07:26 +1000
Message-ID: <20090831120726.GB7311@gondor.apana.org.au>
References: <loom.20090714T212706-910@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:36025 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751947AbZHaMH1 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Aug 2009 08:07:27 -0400
Content-Disposition: inline
In-Reply-To: <loom.20090714T212706-910@post.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
Cc: dash@vger.kernel.org

On Tue, Jul 14, 2009 at 09:39:03PM +0000, Eric Blake wrote:
> For the cd command, POSIX 2008 requires that after all pathnames in CDPATH have 
> been tested and failed in step 5, then step 6 interprets the directory argument 
> relative to PWD.  In other words, this demonstrates a bug:
> 
> $ dash -c 'cd /tmp; mkdir -p foo; CDPATH=oops; cd foo; echo $?; pwd'
> cd: 1: can't cd to foo
> 2
> /tmp
> 
> while bash gets it correct:
> 
> $ bash -c 'cd /tmp; mkdir -p foo; CDPATH=oops; cd foo; echo $?; pwd'
> 0
> /tmp/foo

This patch fixes the first part.

commit 7877713690c498bb74823542231a81362e8eedb3
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon Aug 31 22:06:41 2009 +1000

    [CD] Lookup PWD after going through CDPATH
    
    On Tue, Jul 14, 2009 at 09:39:03PM +0000, Eric Blake wrote:
    > For the cd command, POSIX 2008 requires that after all pathnames in CDPATH
    > have been tested and failed in step 5, then step 6 interprets the directory
    > argument relative to PWD.  In other words, this demonstrates a bug:
    >
    > $ dash -c 'cd /tmp; mkdir -p foo; CDPATH=oops; cd foo; echo $?; pwd'
    > cd: 1: can't cd to foo
    > 2
    > /tmp
    >
    > while bash gets it correct:
    >
    > $ bash -c 'cd /tmp; mkdir -p foo; CDPATH=oops; cd foo; echo $?; pwd'
    > 0
    > /tmp/foo
    
    This patch fixes the problem.
    
    Reported-by: Eric Blake <ebb9@byu.net>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index cb08ae5..d9dcb0c 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -9,6 +9,7 @@
 2009-08-31  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix NUL termination in readcmd.
+	* Lookup PWD after going through CDPATH.
 
 2009-08-11  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/cd.c b/src/cd.c
index 3770664..9a69b69 100644
--- a/src/cd.c
+++ b/src/cd.c
@@ -106,7 +106,7 @@ cdcmd(int argc, char **argv)
 	if (!dest)
 		dest = nullstr;
 	if (*dest == '/')
-		goto step7;
+		goto step6;
 	if (*dest == '.') {
 		c = dest[1];
 dotdot:
@@ -122,13 +122,8 @@ dotdot:
 	}
 	if (!*dest)
 		dest = ".";
-	if (!(path = bltinlookup("CDPATH"))) {
-step6:
-step7:
-		p = dest;
-		goto docd;
-	}
-	do {
+	path = bltinlookup("CDPATH");
+	while (path) {
 		c = *path;
 		p = padvance(&path, dest);
 		if (stat(p, &statb) >= 0 && S_ISDIR(statb.st_mode)) {
@@ -137,9 +132,15 @@ step7:
 docd:
 			if (!docd(p, flags))
 				goto out;
-			break;
+			goto err;
 		}
-	} while (path);
+	}
+
+step6:
+	p = dest;
+	goto docd;
+
+err:
 	sh_error("can't cd to %s", dest);
 	/* NOTREACHED */
 out:

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
