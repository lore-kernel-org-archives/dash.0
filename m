From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [BUILD] Avoid compiler warning
Date: Tue, 11 Aug 2009 14:01:33 +1000
Message-ID: <20090811040133.GD10700@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:34130 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751319AbZHKQG6 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Aug 2009 12:06:58 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
Cc: dash@vger.kernel.org

On Thu, Jul 09, 2009 at 06:52:15AM -0600, Eric Blake wrote:
> Pass correct type to ctype macro.
> 
> Signed-off-by: Eric Blake <ebb9@byu.net>

Hmm, what warning did you get from the compiler?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
