From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Bug when parsing redirection syntax error
Date: Thu, 4 Jun 2020 13:56:08 +1000
Message-ID: <20200604035608.GA2485@gondor.apana.org.au>
References: <1851e5f2-80f5-4bd6-9993-e23a0980bd1e@mattwhitlock.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:35708 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgFDD4M (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 3 Jun 2020 23:56:12 -0400
Content-Disposition: inline
In-Reply-To: <1851e5f2-80f5-4bd6-9993-e23a0980bd1e@mattwhitlock.name>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Matt Whitlock <dash@mattwhitlock.name>
Cc: dash@vger.kernel.org

Matt Whitlock <dash@mattwhitlock.name> wrote:
> $ cat <<<EOF
> dash: 4: Syntax error: redirection unexpected
> $ true
> dash: 4: Etrue: not found
> 
> This is with Dash 0.5.11.
> 
> It looks like the first character after the unexpected redirection operator 
> mistakenly gets retained in a buffer somewhere and interferes with the next 
> command to be read.

This is because dash needs to clear the unget buffer on reset.

Reported-by: Matt Whitlock <dash@mattwhitlock.name>
Fixes: 17db43b58415 ("input: Allow two consecutive calls to pungetc")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index 4987732..d7c101b 100644
--- a/src/input.c
+++ b/src/input.c
@@ -87,6 +87,7 @@ INIT {
 RESET {
 	/* clear input buffer */
 	basepf.lleft = basepf.nleft = 0;
+	basepf.unget = 0;
 	popallfiles();
 }
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
