From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: patch to get dash to build on FreeBSD
Date: Thu, 26 Nov 2009 11:07:44 +0800
Message-ID: <20091126030744.GA2402@gondor.apana.org.au>
References: <a0777e080911072333o1a336148oee139c2e40041907@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:39887 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754323AbZKZDHl (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 25 Nov 2009 22:07:41 -0500
Content-Disposition: inline
In-Reply-To: <a0777e080911072333o1a336148oee139c2e40041907@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eitan Adler <eitanadlerlist@gmail.com>
Cc: dash@vger.kernel.org

Eitan Adler <eitanadlerlist@gmail.com> wrote:
> mksignames.c fails to build on freeBSD.
> If you apply the following patch the shell builds and based on very
> limited testing the dash appears to work.

Thanks, but I don't think this is enough.  We assume in plenty
of other places that NSIG is the maximum for signal numbers, e.g.,
traps.c.  So I think we need to change all those places if this is
to work on FreeBSD.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
