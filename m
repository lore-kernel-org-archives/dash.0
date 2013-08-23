From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [EXPAND] Nested parameter expansion results in an empty string
 when quoted
Date: Fri, 23 Aug 2013 20:04:46 +1000
Message-ID: <20130823100445.GB10632@gondor.apana.org.au>
References: <CAAv6kGS+Cgg2JmRqCeWNZtxpoUuJ0wBSLac0BJJGW8kuiqUgwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([178.18.16.133]:53830 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752848Ab3HWKEr (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 23 Aug 2013 06:04:47 -0400
Content-Disposition: inline
In-Reply-To: <CAAv6kGS+Cgg2JmRqCeWNZtxpoUuJ0wBSLac0BJJGW8kuiqUgwQ@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Todor Vlaev <t.vlaev@gmail.com>
Cc: dash@vger.kernel.org

On Tue, Aug 28, 2012 at 01:27:24PM +0000, Todor Vlaev wrote:
> 
> While playing around with parameter expansion I noticed that the
> following didn't work in dash  (dash 0.5.5.1-7.4ubuntu1) as compared
> to bash even though I believe it should be POSIX-compliant:
> 
> my_str=swan; last_char="${my_str#${my_str%?}}"; echo ${last_char}
> 
> If the double quotes are removed, the last character is printed correctly.
> 
> At a quick glance through the commits after the 0.5.5.1 release I saw
> the following bug fix. Could it be related?
> 
> 0d7d66039b614b642c775432fd64aa8c11f9a64d
> [EXPAND] Fix quoted pattern patch breakage

This patch should fix the problem.

commit a7c21a6f4cb42d967854cae954efd4ee66bdea9c
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri Aug 23 20:04:12 2013 +1000

    [EXPAND] Propagate EXP_QPAT in subevalvar
    
    On Tue, Aug 28, 2012 at 01:27:24PM +0000, Todor Vlaev wrote:
    >
    > While playing around with parameter expansion I noticed that the
    > following didn't work in dash  (dash 0.5.5.1-7.4ubuntu1) as compared
    > to bash even though I believe it should be POSIX-compliant:
    >
    > my_str=swan; last_char="${my_str#${my_str%?}}"; echo ${last_char}
    >
    > If the double quotes are removed, the last character is printed correctly.
    >
    > At a quick glance through the commits after the 0.5.5.1 release I saw
    > the following bug fix. Could it be related?
    >
    > 0d7d66039b614b642c775432fd64aa8c11f9a64d
    > [EXPAND] Fix quoted pattern patch breakage
    
    We need to propagate EXP_QPAT in subevalvar as otherwise a nested
    parameter expansion within subevalvar may be expanded incorrectly.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 7354832..911d31e 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2013-08-23  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Propagate EXP_QPAT in subevalvar.
+
 2012-07-20  Kimo Rosenbaum <kimor79@yahoo.com>
 
 	* Fix typo for wait in manual.
diff --git a/src/expand.c b/src/expand.c
index ce60fe9..11fd7b7 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -650,7 +650,8 @@ subevalvar(char *p, char *str, int strloc, int subtype, int startloc, int varfla
 	char *(*scan)(char *, char *, char *, char *, int , int);
 
 	argstr(p, EXP_TILDE | (subtype != VSASSIGN && subtype != VSQUESTION ?
-			       (flag & EXP_QUOTED ? EXP_QPAT : EXP_CASE) : 0));
+			       (flag & (EXP_QUOTED | EXP_QPAT) ?
+			        EXP_QPAT : EXP_CASE) : 0));
 	STPUTC('\0', expdest);
 	argbackq = saveargbackq;
 	startp = stackblock() + startloc;

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
