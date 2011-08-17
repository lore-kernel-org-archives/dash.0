From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Avoid imaxdiv when only one of the results is wanted
Date: Wed, 17 Aug 2011 09:27:52 +0800
Message-ID: <20110817012752.GA16223@gondor.apana.org.au>
References: <1311635376.10727.8.camel@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:40788 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab1HQB15 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 16 Aug 2011 21:27:57 -0400
Content-Disposition: inline
In-Reply-To: <1311635376.10727.8.camel@linux>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org

On Mon, Jul 25, 2011 at 11:09:36PM +0000, Harald van Dijk wrote:
> dash rather pointlessly calls imaxdiv, only to discard one of its
> results. The call was already made conditional a while back because some
> systems don't have imaxdiv, but the generated code for the version with
> imaxdiv and the one with / and % is identical (with GCC 4.6.1 or ICC
> 12.0.2, with -O0, -O2 or -Os), so it could just as well go entirely to
> clean up the code a little bit.
> 
> Signed-off-by: Harald van Dijk <harald@gigawatt.nl>

Nice work, patch applied.

Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
