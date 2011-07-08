From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] avoid gcc warning: variable 'oldstackp' set but not
	used
Date: Fri, 8 Jul 2011 16:12:45 +0800
Message-ID: <20110708081245.GH16157@gondor.apana.org.au>
References: <87ei3prfpf.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:57744 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab1GHIMu (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 8 Jul 2011 04:12:50 -0400
Content-Disposition: inline
In-Reply-To: <87ei3prfpf.fsf@rho.meyering.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
Cc: dash@vger.kernel.org

On Mon, May 23, 2011 at 08:20:12AM +0000, Jim Meyering wrote:
> Compiling with gcc-4.6.0, I noticed a new warning.
> This fixes it:

Patch applied.  Thanks Jim!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
