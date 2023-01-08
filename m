Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5054C54EBC
	for <linux-dash@archiver.kernel.org>; Sun,  8 Jan 2023 12:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjAHMHN (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 8 Jan 2023 07:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjAHMHM (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Jan 2023 07:07:12 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FB410075
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 04:07:11 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pEUSC-00FD4D-Ud; Sun, 08 Jan 2023 20:07:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 08 Jan 2023 20:07:08 +0800
Date:   Sun, 8 Jan 2023 20:07:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH v3] parser: don't keep alloca()ing in a loop for
 substitutions
Message-ID: <Y7qx7LJwJUNVd/UD@gondor.apana.org.au>
References: <Y7aSMJlVi7fXD1DC@gondor.apana.org.au>
 <20230105134204.e7mczfzt2vbit3oc@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105134204.e7mczfzt2vbit3oc@tarta.nabijaczleweli.xyz>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thu, Jan 05, 2023 at 02:42:04PM +0100, наб wrote:
> When encountering
>   printf %010000d | tr 0 \` | sh -n
>   printf %09999d  | tr 0 \` | sh -n
> you want no output and "Syntax error: EOF in backquote substitution",
> respectively; instead, current dash segfaults.
> 
> This is because the alloca for the save buffer is run, naturally,
> in the same function, so first it allocates one byte, then two,
> then ..., then appx. 4000 (for me, depends on the binary),
> then it segfaults on the memcpy (it's even worse, since due to
> alignment, it usually allocates much more for the early stuff).
> 
> Nevertheless, the stack frame grows unboundedly, until we completely
> destroy the stack. Instead of squirreling the out block away, then
> letting subsequent allocations override the original, mark it used,
> and just re-copy it to the top of the dash stack. This increases peak
> memory usage somewhat
> (in the most pathological case ‒ the above but with three nines ‒
>  from 23.26 to 173.7KiB according to massif,
>  in parsing a regular program (ratrun from ratrun 0c)
>  from 28.68 to 29.19;
>  a simpler program (ibid., rat) stays at 5.422;
>  parsing libtoolize, debootstrap, and dkms
>  (the biggest shell programs in my /[s]bin by size + by `/$( count)
>  likewise stay the same at 12.02, 41.48, and 6.438)
> but it's barely measurable outside of truly pathological conditions
> that were a step away from a segfault previously.
> 
> Fixes: https://bugs.debian.org/966156
> ---
> I think this means we also need to turn the USTPUTC() into STPUTC(),
> since the previous code explicitly over-accounted for it in growstackto().
> 
>  src/parser.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
