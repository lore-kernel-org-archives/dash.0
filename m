From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] avoid overflow for very long variable name
Date: Tue, 12 Jun 2012 16:31:56 +0800
Message-ID: <20120612083155.GA13523@gondor.apana.org.au>
References: <874nr6eiqr.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from sting.hengli.com.au ([178.18.18.71]:45713 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750937Ab2FLIb6 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 12 Jun 2012 04:31:58 -0400
Content-Disposition: inline
In-Reply-To: <874nr6eiqr.fsf@rho.meyering.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
Cc: dash@vger.kernel.org

On Wed, May 23, 2012 at 08:37:48PM +0000, Jim Meyering wrote:
> 
> Otherwise, this:
>   $ perl -le 'print "v"x(2**31+1) ."=1"' | dash
> provokes integer overflow:

Thanks Jim, I'll apply your patch.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
