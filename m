From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 3/3] Port to HP-UX
Date: Thu, 10 Mar 2011 20:26:36 +0800
Message-ID: <20110310122636.GE10824@gondor.apana.org.au>
References: <1295413636.4278.28.camel@gemini> <1295414162.6486.5.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:48352 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780Ab1CJM0i (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 10 Mar 2011 07:26:38 -0500
Content-Disposition: inline
In-Reply-To: <1295414162.6486.5.camel@gemini>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Brian Koropoff <bkoropoff@gmail.com>
Cc: dash@vger.kernel.org

On Wed, Jan 19, 2011 at 05:16:02AM +0000, Brian Koropoff wrote:
>
>  - HP-UX needs _LARGEFILE64_SOURCE to be defined for open64()
>    and friends to be available.  This seems to be safe to
>    define everywhere, so do so.

Shouldn't this go into configure.ac? In fact, how can your patch
have any effect if configure.ac doesn't detect open64 in the
first place?

The rest looks OK.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
