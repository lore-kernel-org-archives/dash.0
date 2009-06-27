From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: memalloc.c patch ( 4*sizeof(void*) )
Date: Sun, 28 Jun 2009 00:05:07 +0800
Message-ID: <20090627160507.GA24139@gondor.apana.org.au>
References: <20090522195011.9388.qmail@riemann.fmi.uni-sofia.bg> <20090610050456.GA16563@gondor.apana.org.au> <20090610063335.20442.qmail@riemann.fmi.uni-sofia.bg> <20090627133229.GB23267@gondor.apana.org.au> <20090627152933.1235.qmail@riemann.fmi.uni-sofia.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:41355 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753948AbZF0QFH (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 27 Jun 2009 12:05:07 -0400
Content-Disposition: inline
In-Reply-To: <20090627152933.1235.qmail@riemann.fmi.uni-sofia.bg>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Nikola Vladov <vladov@riemann.fmi.uni-sofia.bg>
Cc: dash@vger.kernel.org

On Sat, Jun 27, 2009 at 06:29:33PM +0300, Nikola Vladov wrote:
>
> "2" above is too small.  SHELL_ALIGN is 2*sizeof(void *).
>
> Then we must have
>          buf_size + shell_align + malloc_meta_data <= 512.

shell_align doesn't add anything if the value is already aligned.

> I have tested next and they works OK.
>    MINSIZE (512  -SHELL_ALIGN(sizeof(void*) * 3))
>    MINSIZE (512  -sizeof(void*) * 4)

OK, and you've also tested 512 - sizeof(void *) * 2 to make sure
that it doesn't work? If so we should pick the * 3 variant.
 
> For malloc which uses sbrk (like DL-malloc) the above does not
> help.  In my opinion in this case we have to use
> fist 512, sacond 1024, third 2048, all other 4096 chuks.

Does it hurt though? If not we should just make this unconditional.

PS Please do reply-to-all instead of reply-to-author.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
