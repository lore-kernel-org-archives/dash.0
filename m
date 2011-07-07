From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: build issues when using pcc
Date: Thu, 7 Jul 2011 15:22:27 +0800
Message-ID: <20110707072227.GG16157@gondor.apana.org.au>
References: <20110522123414.GD6142@port70.net> <20110522164605.GA8654@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:43880 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab1GGHWf (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Jul 2011 03:22:35 -0400
Content-Disposition: inline
In-Reply-To: <20110522164605.GA8654@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Szabolcs Nagy <nsz@port70.net>, dash@vger.kernel.org

On Sun, May 22, 2011 at 04:46:05PM +0000, Jonathan Nieder wrote:
>
> Subject: [OUTPUT] Make outc an inline function
> 
> As "gcc -pedantic" warns, ISO C forbids conditional expressions with
> only one void side.  So the (needslow ?  slowpath() : fastpath) code
> for outc in the !USE_GLIBC_STDIO case might not be portable.
> 
> More importantly, it's hard to read.  Rip it out and replace it
> with an inline function which should generate the same code.
> 
> Reported-by: Szabolcs Nagy <nsz@port70.net>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Patch applied.

I've also added this one-liner on top to eliminate an unnecessary
promotion caused by this patch.

commit 155b0b518f485b8b5cb574cd2f0dc936c3fd1902
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu Jul 7 15:22:03 2011 +0800

    [BUILTIN] Eliminate unnecessary promotion in echocmd
    
    The patch to make outc into an inline function created an unnecessary
    promotion in echocmd due to its use of char vs. the int used by outc.
    This patch changes echocmd to use int instead.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index ade43e9..2093fc7 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,7 @@
 2011-07-07  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Optimize dash -c "command" to avoid a fork.
+	* Eliminate unnecessary promotion in echocmd.
 
 2011-05-22  Jonathan Nieder <jrnieder@gmail.com>
 
diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index b0c3774..893295c 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -443,7 +443,7 @@ echocmd(int argc, char **argv)
 	}
 
 	do {
-		char c;
+		int c;
 
 		nonl += conv_escape_str(*argv);
 		outstr(stackblock(), outs);

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
