From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/2] Fix additional use of 'j' printf length modifier.
Date: Thu, 7 Jul 2011 14:41:54 +0800
Message-ID: <20110707064154.GE16157@gondor.apana.org.au>
References: <1302921010.2620.3.camel@gemini> <1302921279.2620.6.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:40733 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab1GGGl6 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Jul 2011 02:41:58 -0400
Content-Disposition: inline
In-Reply-To: <1302921279.2620.6.camel@gemini>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Brian Koropoff <bkoropoff@gmail.com>
Cc: dash@vger.kernel.org

On Sat, Apr 16, 2011 at 02:34:39AM +0000, Brian Koropoff wrote:
> The printf builtin modifies the user's format strings
> by prefixing integer conversion specifications with the
> 'j' (intmax_t) length modifier.  Since this is not portable,
> instead prefix them with the length modifier extracted from
> the PRIdMAX constant.
> 
> Signed-off-by: Brian Koropoff <bkoropoff@gmail.com>

I'm sorry but I'm not taking this.  %j is part of ISO C99 and
POSIX so please fix your build environment instead.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
