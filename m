From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: strange `printf` arguments, parsing features (bugs?)
Date: Mon, 19 May 2008 10:43:31 +0800
Message-ID: <E1JxvLX-0007jt-00@gondolin.me.apana.org.au>
References: <20080519024755.GG21428@flower.upol.cz>
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:57529 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750968AbYESCne (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 18 May 2008 22:43:34 -0400
In-Reply-To: <20080519024755.GG21428@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Oleg Verych <olecom@flower.upol.cz>
Cc: dash@vger.kernel.org

Oleg Verych <olecom@flower.upol.cz> wrote:
>
> Or, if you want to have a slash (odd number), use slash (same). If you
> what to place two slashes (even), use four (even << 1).
> 
> Nice.

Yes it is confusing, however, the `` construct is deprecated
and the $() construct is more reasonable in this regard.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
