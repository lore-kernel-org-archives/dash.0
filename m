From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: EXIT trap handling in subshells broken
Date: Fri, 17 Jan 2020 16:51:24 +0800
Message-ID: <20200117085124.ub53qala7c636owf@gondor.apana.org.au>
References: <c1a9c062-0917-d3f3-8826-811b5a4fd802@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:48050 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbgAQIv2 (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 17 Jan 2020 03:51:28 -0500
Content-Disposition: inline
In-Reply-To: <c1a9c062-0917-d3f3-8826-811b5a4fd802@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: DASH shell mailing list <dash@vger.kernel.org>

On Mon, Jan 06, 2020 at 09:57:20PM +0000, Harald van Dijk wrote:
>
> One way to fix this is to install an exception handler in evaltree(nr) to
> prevent exceptions bubbling up too far. It can just call exitshell() from
> there. It is not clear to me yet whether this is the best way.

Thanks for the report.  I think what we should do is drop the
relevant state when we enter the subshell.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
