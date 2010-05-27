From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: unexpected parameter expansion
Date: Thu, 27 May 2010 21:41:47 +1000
Message-ID: <20100527114147.GA9777@gondor.apana.org.au>
References: <20100519191928.28202.qmail@10218569f54974.315fe32.mid.smarden.org> <20100519220109.GA81407@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:54864 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755064Ab0E0Llt (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 27 May 2010 07:41:49 -0400
Content-Disposition: inline
In-Reply-To: <20100519220109.GA81407@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

On Wed, May 19, 2010 at 10:01:10PM +0000, Jilles Tjoelker wrote:
> 
> Just for clarification, the open brace is inconsequential here. It does
> not pair with a close brace (only ${ does). Certain versions of bash and
> ksh implemented it that way, but it has since been corrected.
> 
> > http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02

Yeah I agree that dash should also be fixed here.  However, I've
run out of time today so this will have to wait until the next time
I look at dash.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
