From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: % in $PATH
Date: Mon, 10 Nov 2014 21:20:02 +0800
Message-ID: <20141110132002.GA8372@gondor.apana.org.au>
References: <20141105115946.GA4029@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:43998 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaKJNUG (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 10 Nov 2014 08:20:06 -0500
Content-Disposition: inline
In-Reply-To: <20141105115946.GA4029@chaz.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Stephane Chazelas <stephane.chazelas@gmail.com>
Cc: dash@vger.kernel.org

On Wed, Nov 05, 2014 at 11:59:47AM +0000, Stephane Chazelas wrote:
> Hello,
> 
> ash/dash have a nice feature that allows to have:
> 
> PATH=/bin:%builtin:/usr/bin:/some/dir%func:/sbin
> 
> To have commands in /bin take precedence over builtins and
> files in /some/dir being looked up for autoloaded functions (a
> bit like FPATH in ksh/zsh).
> 
> That's nice but the way it is implemented, that means that %
> characters in $PATH cause problems. See for instance:
> 
> http://unix.stackexchange.com/questions/126955/percent-in-path-environment-variable

I'm inclined to just kill this feature, or at least make it a
configuration option that's disabled by default.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
