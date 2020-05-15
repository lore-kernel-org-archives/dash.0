From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] input: Fix compiling against libedit with -fno-common
Date: Fri, 15 May 2020 16:30:50 +1000
Message-ID: <20200515063050.GA28740@gondor.apana.org.au>
References: <20200502183706.2719782-1-floppym@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:34380 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgEOGaz (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 15 May 2020 02:30:55 -0400
Content-Disposition: inline
In-Reply-To: <20200502183706.2719782-1-floppym@gentoo.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
Cc: dash@vger.kernel.org, jer@gentoo.org, floppym@gentoo.org

Mike Gilbert <floppym@gentoo.org> wrote:
> From: Jeroen Roovers <jer@gentoo.org>
> 
> With -fno-common, which will be enabled by default in GCC 10, we see
> this error:
> 
> ld: input.o:(.bss+0x0): multiple definition of `el';
> histedit.o:(.bss+0x8): first defined here
> 
> To fix this, simply remove the definition as it is not needed.
> 
> Signed-off-by: Jeroen Roovers <jer@gentoo.org>
> Signed-off-by: Mike Gilbert <floppym@gentoo.org>
> ---
> src/input.c | 4 ----
> 1 file changed, 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
