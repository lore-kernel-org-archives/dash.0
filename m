From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Parameter substitution bug
Date: Fri, 23 Aug 2013 20:49:17 +1000
Message-ID: <20130823104917.GF10632@gondor.apana.org.au>
References: <CAPnksqRxUvwGGQwXBPVj-yrA8a18nmLctZGD0BtBnh_vC-Muhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([178.18.16.133]:39439 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754164Ab3HWKtU (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 23 Aug 2013 06:49:20 -0400
Content-Disposition: inline
In-Reply-To: <CAPnksqRxUvwGGQwXBPVj-yrA8a18nmLctZGD0BtBnh_vC-Muhg@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Mark Lentczner <mark@glyphic.com>
Cc: dash@vger.kernel.org

On Mon, Jan 21, 2013 at 09:36:07PM +0000, Mark Lentczner wrote:
> Strangely I ran across this issue in the real world: A doubly nested
> parameter substitution with an inner glob pattern (breath) fails /only
> when in double quotes/! That is, these two expressions produce
> different results:
> 
> ${f%${f#?}}   --vs--  "${f%${f#?}}"
> 
> Strangely, that is the simplest case I get to fail.
> 
> The following script walks through the issue, and if run with bash,
> ksh, or busybox exhibits those two expressions as producing the same
> result.

This should be fixed now.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
