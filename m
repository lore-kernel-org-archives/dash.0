From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/2] [SHELL] Allow building without LINEO support.
Date: Wed, 17 Aug 2011 09:38:05 +0800
Message-ID: <20110817013805.GA16333@gondor.apana.org.au>
References: <20110816.174502.2209127983953431973.davem@davemloft.net> <20110817011235.GA22867@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:43119 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab1HQBiL (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 16 Aug 2011 21:38:11 -0400
Content-Disposition: inline
In-Reply-To: <20110817011235.GA22867@elie.gateway.2wire.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: David Miller <davem@davemloft.net>, dash@vger.kernel.org

On Tue, Aug 16, 2011 at 08:12:54PM -0500, Jonathan Nieder wrote:
> David Miller wrote:
> 
> > [Subject: [SHELL] Allow building without LINEO support.]
> 
> Thanks!  Debian has been using something like this (but unconditional)
> to convince autoconf not to use dash as CONFIG_SHELL, to work around
> bugs in various configure scripts[1].  I imagine other users might
> want the same thing, so a patch like this seems like a good idea.
> 
> I think LINEO should be LINENO in the subject line.
> 
> [1] http://bugs.debian.org/582952

So this isn't the reason why Debian has been stuck on 0.5.5.1?
If so what is the reason please?

> Makes sense.  The following on top trims away some code in the
> !WITH_LINENO case, though it's kind of ugly.  Maybe something like
> 
> 	#ifndef WITH_LINENO
> 	static void update_lineno(void) { }
> 	#else
> 	static void update_lineno(void)
> 	{
> 		lineno = errlinno;
> 		if (funcline)
> 			lineno -= funcline - 1;
> 	}
> 	#endif
> 
> would make it more palatable.

Yes please do it like that.

Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
