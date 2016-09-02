From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [BUG] regression in builtin echo
Date: Fri, 2 Sep 2016 21:14:39 +0800
Message-ID: <20160902131439.GA12162@gondor.apana.org.au>
References: <3efcd42c-e20b-3506-3d62-69b85c027ef4@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:50825 "EHLO
        helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbcIBNOs (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 2 Sep 2016 09:14:48 -0400
Content-Disposition: inline
In-Reply-To: <3efcd42c-e20b-3506-3d62-69b85c027ef4@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: luigi.tarenga@gmail.com, dash@vger.kernel.org

Harald van Dijk <harald@gigawatt.nl> wrote:
> 
> While the original code implementing the echo command was overly 
> complicated, the simplified version does not do the right thing, as you 
> noticed.

Indeed.

However, we don't need to rewrite the function to fix this.

---8<---
Subject: builtin: Fix echo -n early termination

The commit 7a784244625d5489c0fc779201c349555dc5f8bc ("[BUILTIN]
Simplify echo command") broke echo -n by making it always terminate
after printing the first argument.

This patch fixes this by only terminating when we have reached
the end of the arguments.

Fixes: 7a784244625d ("[BUILTIN] Simplify echo command")
Reported-by: Luigi Tarenga <luigi.tarenga@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>


diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 1112253..a626cee 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -459,7 +459,7 @@ echocmd(int argc, char **argv)
 
 		if (likely(*argv))
 			nonl += print_escape_str("%s", NULL, NULL, *argv++);
-		if (nonl > 0)
+		if (likely((nonl + !*argv) > 1))
 			break;
 
 		c = *argv ? ' ' : '\n';

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
