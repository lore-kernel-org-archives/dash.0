Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10910C47089
	for <linux-dash@archiver.kernel.org>; Mon,  5 Dec 2022 15:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiLEPCJ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 5 Dec 2022 10:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiLEPCH (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 5 Dec 2022 10:02:07 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9F41D0FE
        for <dash@vger.kernel.org>; Mon,  5 Dec 2022 07:02:05 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p2Cyn-0046SX-Vs; Mon, 05 Dec 2022 23:02:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 05 Dec 2022 23:02:01 +0800
Date:   Mon, 5 Dec 2022 23:02:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Alex Gorinson <algore3698@gmail.com>
Cc:     dash@vger.kernel.org, Harald van Dijk <harald@gigawatt.nl>
Subject: [v2 PATCH] expand: Add ifsfree to expand to fix a logic error that
 causes a buffer over-read
Message-ID: <Y44H6WLH/b/6+Dey@gondor.apana.org.au>
References: <CAOKKkHc=bt4p1d4hMzFbQeE14mZJJ7d1REpJ-D_BQD02re1Pdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOKKkHc=bt4p1d4hMzFbQeE14mZJJ7d1REpJ-D_BQD02re1Pdw@mail.gmail.com>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Mon, Jun 20, 2022 at 02:27:10PM -0400, Alex Gorinson wrote:
> Due to a logic error in the ifsbreakup function in expand.c if a
> heredoc and normal command is run one after the other by means of a
> semi-colon, when the second command drops into ifsbreakup the command
> will be evaluated with the ifslastp/ifsfirst struct that was set when
> the here doc was evaluated. This results in a buffer over-read that
> can leak the program's heap, stack, and arena addresses which can be
> used to beat ASLR.
> 
> Steps to Reproduce:
> First bug:
> cmd args: ~/exampleDir/example> dash
> $ M='AAAAAAAAAAAAAAAAA'    <note: 17 A's>
> $ q00(){
> $ <<000;echo
> $ ${D?$M$M$M$M$M$M}        <note: 6 $M's>
> $ 000
> $ }
> $ q00                      <note: After the q00 is typed in, the leak
> should be echo'd out; this works with ash, busybox ash, and dash and
> with all option args.>
> 
> Patch:
> Adding the following to expand.c will fix both bugs in one go.
> (Thank you to Harald van Dijk and Michael Greenberg for doing the
> heavy lifting for this patch!)
> ==========================
> --- a/src/expand.c
> +++ b/src/expand.c
> @@ -859,6 +859,7 @@
> if (discard)
> return -1;
> 
> +ifsfree();
> sh_error("Bad substitution");
> }
> 
> @@ -1739,6 +1740,7 @@
> } else
> msg = umsg;
> }
> +ifsfree();
> sh_error("%.*s: %s%s", end - var - 1, var, msg, tail);
>  }
> ==========================

Thanks for the report!

I think it's better to add the ifsfree() call to the exception
handling path as other sh_error calls may trigger this too.

Reported-by: Alex Gorinson <algore3698@gmail.com> 
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index aea5cc4..a40d8be 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1763,6 +1763,16 @@ varunset(const char *end, const char *var, const char *umsg, int varflags)
 	sh_error("%.*s: %s%s", end - var - 1, var, msg, tail);
 }
 
+void restore_handler_expandarg(struct jmploc *savehandler, int err)
+{
+	handler = savehandler;
+	if (err) {
+		if (exception != EXERROR)
+			longjmp(handler->loc, 1);
+		ifsfree();
+	}
+}
+
 #ifdef mkinit
 
 INCLUDE "expand.h"
diff --git a/src/expand.h b/src/expand.h
index c44b848..49a18f9 100644
--- a/src/expand.h
+++ b/src/expand.h
@@ -62,7 +62,9 @@ struct arglist {
 #define EXP_DISCARD	0x400	/* discard result of expansion */
 
 
+struct jmploc;
 union node;
+
 void expandarg(union node *, struct arglist *, int);
 #define rmescapes(p) _rmescapes((p), 0)
 char *_rmescapes(char *, int);
@@ -71,6 +73,7 @@ void recordregion(int, int, int);
 void removerecordregions(int); 
 void ifsbreakup(char *, int, struct arglist *);
 void ifsfree(void);
+void restore_handler_expandarg(struct jmploc *savehandler, int err);
 
 /* From arith.y */
 intmax_t arith(const char *);
diff --git a/src/parser.c b/src/parser.c
index 13c2df5..bf94697 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1589,9 +1589,7 @@ expandstr(const char *ps)
 	result = stackblock();
 
 out:
-	handler = savehandler;
-	if (err && exception != EXERROR)
-		longjmp(handler->loc, 1);
+	restore_handler_expandarg(savehandler, err);
 
 	doprompt = saveprompt;
 	unwindfiles(file_stop);
diff --git a/src/redir.c b/src/redir.c
index 93abba3..5a5835c 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -473,9 +473,7 @@ redirectsafe(union node *redir, int flags)
 		handler = &jmploc;
 		redirect(redir, flags);
 	}
-	handler = savehandler;
-	if (err && exception != EXERROR)
-		longjmp(handler->loc, 1);
+	restore_handler_expandarg(savehandler, err);
 	RESTOREINT(saveint);
 	return err;
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
