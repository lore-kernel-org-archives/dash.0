From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/2] Fix additional use of 'j' printf length modifier.
Date: Thu, 7 Jul 2011 15:44:42 +0800
Message-ID: <20110707074441.GA17997@gondor.apana.org.au>
References: <1302921010.2620.3.camel@gemini> <1302921279.2620.6.camel@gemini> <20110707064154.GE16157@gondor.apana.org.au> <20110707071244.GB11514@elie> <4E156109.4080600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:53439 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab1GGHop (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Jul 2011 03:44:45 -0400
Content-Disposition: inline
In-Reply-To: <4E156109.4080600@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Brian Koropoff <bkoropoff@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, dash@vger.kernel.org

On Thu, Jul 07, 2011 at 12:32:25AM -0700, Brian Koropoff wrote:
>
> C99 also guarantees the presence of imaxdiv, but arith_yacc.c happily
> #ifdefs around it if the build environment lacks it.  I submitted other
> patches in the same spirit (working around non-compliant vsnprintf) and they
> were accepted.  Would a patch that retains the old code verbatim but
> #ifdefs in an alternate implementation on legacy systems be more acceptable?

I guess so if that's the only thing keeping you from building this
on hupx.

Can you also split your other patch up so that each patch does
one thing only?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
