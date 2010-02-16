From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: test -x should use faccessat, not stat
Date: Tue, 16 Feb 2010 20:04:13 +0800
Message-ID: <20100216120413.GA32318@gondor.apana.org.au>
References: <20100214061137.GA9882@gondor.apana.org.au> <4B794CA2.1080707@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:46939 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754227Ab0BPMEQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 16 Feb 2010 07:04:16 -0500
Content-Disposition: inline
In-Reply-To: <4B794CA2.1080707@byu.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
Cc: dash@vger.kernel.org

On Mon, Feb 15, 2010 at 06:31:14AM -0700, Eric Blake wrote:
> 
> Finally, it is worth pointing out that on at least cygwin, faccessat and
> friends are faster than stat.  Do you want me to prepare the patch?

First of all I completely agree with you that the current dash
behaviour is busted.  As to how we should fix it, let me think
about this a little more before making a decision.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
