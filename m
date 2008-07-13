From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Mac OS X support patch
Date: Sun, 13 Jul 2008 10:53:30 +0800
Message-ID: <20080713025330.GA17872@gondor.apana.org.au>
References: <E1KHq3f-0004Wb-00@gondolin.me.apana.org.au> <487959B3.1030301@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:32975 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752475AbYGMCxj (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 12 Jul 2008 22:53:39 -0400
Content-Disposition: inline
In-Reply-To: <487959B3.1030301@zytor.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: mmentovai@gmail.com, dash@vger.kernel.org

On Sat, Jul 12, 2008 at 06:26:11PM -0700, H. Peter Anvin wrote:
>
> I'm not sure that that makes sense, however.  Unless you're hauling a 
> *lot* of off_t's around the code, the incremental complexity is hardly 
> worth it.

Either way it's pretty insignificant.  Yes the decrease in code
size isn't great but then the increase in complexity isn't large
either.  FWIW the decreases all come from stat on directories
and scripts.

> FWIW, klibc doesn't even implement the LFS64 APIs, nor does it implement 
> the legacy 32-bit off_t mode in any way.

That's already handled by autoconf.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
