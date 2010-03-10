From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash arithmetic expression bug (1 << 1 + 1 | 1)
Date: Wed, 10 Mar 2010 13:29:41 +0800
Message-ID: <20100310052941.GA20555@gondor.apana.org.au>
References: <20100308233854.GA64452@stack.nl> <20100309045949.GA8665@gondor.apana.org.au> <20100309213307.GB86172@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:38029 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751347Ab0CJF3n (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 10 Mar 2010 00:29:43 -0500
Content-Disposition: inline
In-Reply-To: <20100309213307.GB86172@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

On Tue, Mar 09, 2010 at 10:33:08PM +0100, Jilles Tjoelker wrote:
> 
> Apart from the compliance issue, it is also bad to expose implementation
> details like the exact meaning of 'noeval' to scripts such that they may
> come to depend on them.

Patch applied.  Thanks a lot!
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
