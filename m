From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 3/3] Port to HP-UX
Date: Tue, 15 Mar 2011 15:38:16 +0800
Message-ID: <20110315073816.GA8985@gondor.apana.org.au>
References: <1295413636.4278.28.camel@gemini> <1295414162.6486.5.camel@gemini> <20110310122636.GE10824@gondor.apana.org.au> <1299974083.3797.7.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:47041 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab1COHiS (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 15 Mar 2011 03:38:18 -0400
Content-Disposition: inline
In-Reply-To: <1299974083.3797.7.camel@gemini>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Brian Koropoff <bkoropoff@gmail.com>
Cc: dash@vger.kernel.org

On Sat, Mar 12, 2011 at 03:54:43PM -0800, Brian Koropoff wrote:
> AC_CHECK_FUNC just checks that the symbol exists in libc, so it
> succeeds.  _LARGEFILE64_SOURCE is necessary to get the system headers to
> give you function prototypes, but it doesn't affect the configure test.

OK, please regenerate the patch against the head of my tree and
please move the macro definition from Makefile into config.h
through configure.ac.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
