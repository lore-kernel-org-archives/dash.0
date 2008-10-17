From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: historic syntax for loop body
Date: Fri, 17 Oct 2008 09:19:57 +0800
Message-ID: <E1Kqe0T-0003TC-Fu@gondolin.me.apana.org.au>
References: <20081008152806.GA23631@lisa.in-ulm.de>
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:45668 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752492AbYJQBUD (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 16 Oct 2008 21:20:03 -0400
In-Reply-To: <20081008152806.GA23631@lisa.in-ulm.de>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: mascheck@in-ulm.de
Cc: dash@vger.kernel.org

Sven Mascheck <mascheck@in-ulm.de> wrote:
> The manpage still documents support for the historic almquist for-loop
> syntax, "do and done may be replaced with { and }".  But it's not
> implemented anymore.

Thanks for noting this error in the manual, I'll correct it.

> I'm curious: when has it been removed?
> (I can't see it in the changelogs, and it seems to have gone between
> ash-0.3.8 and some earlier dash-0.4.x)

It was removed in 0.3.8-1.

> Why am I asking?  I was just curious and I stumbled over this because
> AFAIK dash is the only ash variant (well, except busybox) which has it
> removed; I guess simply due to POSIX, and because it had been everything
> but common usage anyway.

Yes this non-POSIX syntax offered no advantages at all and as such
was removed.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
