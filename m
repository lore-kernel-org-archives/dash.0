From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: parser: Fix double-backslash nl in old-style command sub
Date: Tue, 26 May 2020 23:19:05 +1000
Message-ID: <20200526131904.GA27783@gondor.apana.org.au>
References: <5ec6f94c.cf6OsC6v8fwGBIKX%rmy@frippery.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:55652 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgEZNTN (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 26 May 2020 09:19:13 -0400
Content-Disposition: inline
In-Reply-To: <5ec6f94c.cf6OsC6v8fwGBIKX%rmy@frippery.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Ron Yorston <rmy@frippery.org>
Cc: dash@vger.kernel.org, dash@mattwhitlock.name

Ron Yorston <rmy@frippery.org> wrote:
>
> Alternatively I see that BusyBox ash did this:
> 
>            case '\\':
> -               pc = pgetc();
> -               if (pc == '\n') {
> -                   nlprompt();
> -                   /*
> -                    * If eating a newline, avoid putting
> -                    * the newline into the new character
> -                    * stream (via the STPUTC after the
> -                    * switch).
> -                    */
> -                   continue;
> -               }
> +               pc = pgetc(); /* or pgetc_eatbnl()? why (example)? */

Yes this is the correct fix.

---8<---
When handling backslashes within an old-style command substitution,
we should not call pgetc_eatbnl because that would treat the next
backslash character as another escape character if it was then
followed by a new-line.

This patch fixes it by calling pgetc.

Reported-by: Matt Whitlock <dash@mattwhitlock.name>
Fixes: 6bbc71d84bea ("parser: use pgetc_eatbnl() in more places")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index 3131045..03c103b 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1393,7 +1393,7 @@ parsebackq: {
 				goto done;
 
 			case '\\':
-                                pc = pgetc_eatbnl();
+                                pc = pgetc();
                                 if (pc != '\\' && pc != '`' && pc != '$'
                                     && (!synstack->dblquote || pc != '"'))
                                         STPUTC('\\', pout);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
