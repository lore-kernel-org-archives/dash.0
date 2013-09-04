From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: test incorrectly rejecting valid expression with confusing !
 placement
Date: Wed, 4 Sep 2013 15:03:23 +1000
Message-ID: <20130904050323.GA20305@gondor.apana.org.au>
References: <20130904015629.GA19007@gondor.apana.org.au>
 <52269D18.3090200@redhat.com>
 <20130904032000.GA19583@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([178.18.16.133]:44709 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760504Ab3IDFDe (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 4 Sep 2013 01:03:34 -0400
Content-Disposition: inline
In-Reply-To: <20130904032000.GA19583@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org

On Wed, Sep 04, 2013 at 01:20:00PM +1000, Herbert Xu wrote:
>  
> > "test ! -o !" is a three-argument test, where $2 (-o) is a binary
> > primary, so it is the binary test of $1 and $3, and the end result is an
> > exit status of 0.  Bash and ksh get it right, dash fails.
> 
> Both zsh and posh do it like dash:
> 
> $ zsh -c 'test ! -o !'; echo $?
> zsh:test:1: too many arguments
> 1
> $ zsh -c 'test ! = !'; echo $?
> 0
> $

Another case in point is 'test ! = -o a', here bash differs with
every other shell installed on my system, which all return 0, just
like dash.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
