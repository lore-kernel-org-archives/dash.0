From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/3] Port to Solaris
Date: Thu, 10 Mar 2011 20:16:59 +0800
Message-ID: <20110310121659.GC10824@gondor.apana.org.au>
References: <1295413636.4278.28.camel@gemini> <1295414140.6486.3.camel@gemini> <20110121130602.GA70470@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:40577 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab1CJMRG (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 10 Mar 2011 07:17:06 -0500
Content-Disposition: inline
In-Reply-To: <20110121130602.GA70470@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: Brian Koropoff <bkoropoff@gmail.com>, dash@vger.kernel.org

On Fri, Jan 21, 2011 at 01:06:02PM +0000, Jilles Tjoelker wrote:
>
> What you can do is use PRIdMAX from <inttypes.h>, normally defined as
> "jd". You can then define this to "lld" or "jd" if it is not defined.
> I think this makes the code uglier (just like your change), but oh well.

I agree.  Brian, please update your patch accordingly.

Thanks!

> By the way, I wonder what the advantage of imaxdiv() above separate %
> and / is. Compilers can detect the matching between a % b and a / b and
> do it in one operation, and any use of imaxdiv() trips gcc's
> -Waggregate-return.

It used to generate smaller code with gcc.  If gcc now knows how
to optimise it properly then I guess we can remove imaxdiv.

I just checked and gcc 4.4.5 still generates two divisions without
imaxdiv.  On the other hand gcc doesn't even inline imaxdiv.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
