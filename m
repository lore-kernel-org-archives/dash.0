From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] avoid more undefined handler
Date: Fri, 8 Jul 2011 16:42:05 +0800
Message-ID: <20110708084205.GC28449@gondor.apana.org.au>
References: <874o4jc5vy.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:39867 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943Ab1GHImI (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 8 Jul 2011 04:42:08 -0400
Content-Disposition: inline
In-Reply-To: <874o4jc5vy.fsf@rho.meyering.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
Cc: dash@vger.kernel.org

On Wed, May 25, 2011 at 12:38:09PM +0000, Jim Meyering wrote:
> Clang also warned about this:
> 
>     ANALYZE: eval.c evalpipe
>     eval.c:575:10: warning: Assigned value is garbage or undefined
>                     prevfd = pip[0];
>                            ^ ~~~~~~

This isn't really a bug.  If pip[0] is garbage at this point, then
we're the last element in a pipeline and prevfd will never be used
again.

If you can think of a way of solving this without adding to the code
size then I'll gladly apply it :)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
