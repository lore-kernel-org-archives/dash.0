From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [MAN] Document optional open parenthesis for case
	patterns.
Date: Sun, 28 Nov 2010 19:40:38 +0800
Message-ID: <20101128114038.GD8818@gondor.apana.org.au>
References: <20100908024219.GA3283@zaphod.pweis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:44708 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab0K1Lkl (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Nov 2010 06:40:41 -0500
Content-Disposition: inline
In-Reply-To: <20100908024219.GA3283@zaphod.pweis.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Philipp Weis <pweis@pweis.com>
Cc: dash@vger.kernel.org

On Wed, Sep 08, 2010 at 02:42:19AM +0000, Philipp Weis wrote:
> Hi,
> 
> while inspecting some dash scripts on my system, I was surprised to
> see that some of them use an open parenthesis at the beginning of case
> patterns while that's not mentioned in the manpage. Dash currently is
> fine with and without that parenthesis (parser.c:413). The attached
> patch documents this feature.

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
