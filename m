From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] setvareq: do not return a freed pointer
Date: Fri, 8 Jul 2011 16:57:14 +0800
Message-ID: <20110708085714.GE28449@gondor.apana.org.au>
References: <8739j5aaam.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:48498 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab1GHI5Q (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 8 Jul 2011 04:57:16 -0400
Content-Disposition: inline
In-Reply-To: <8739j5aaam.fsf@rho.meyering.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
Cc: dash@vger.kernel.org

On Sun, Jun 19, 2011 at 07:30:41PM +0000, Jim Meyering wrote:
> This change may be technically unnecessary, but it's worth
> the minuscule cost of the initialization.

I disagree, unless you can do this without adding to the code
size.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
