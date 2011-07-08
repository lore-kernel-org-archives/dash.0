From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] avoid using undefined handler
Date: Fri, 8 Jul 2011 16:30:58 +0800
Message-ID: <20110708083058.GB28449@gondor.apana.org.au>
References: <87aaebc682.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:60543 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936Ab1GHIbB (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 8 Jul 2011 04:31:01 -0400
Content-Disposition: inline
In-Reply-To: <87aaebc682.fsf@rho.meyering.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
Cc: dash@vger.kernel.org

On Wed, May 25, 2011 at 12:30:53PM +0000, Jim Meyering wrote:
> Clang had some legitimate warnings:
> 
> 2011-05-25  Jim Meyering  <meyering@redhat.com>
> 
> 	avoid using undefined handler

Indeed this looks like a real bug.

Patch applied.  Thanks Jim!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
