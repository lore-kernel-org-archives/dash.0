From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: test incorrectly rejecting valid expression with confusing !
 placement
Date: Wed, 4 Sep 2013 13:20:00 +1000
Message-ID: <20130904032000.GA19583@gondor.apana.org.au>
References: <20130904015629.GA19007@gondor.apana.org.au>
 <52269D18.3090200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([178.18.16.133]:48991 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752626Ab3IDDUM (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 3 Sep 2013 23:20:12 -0400
Content-Disposition: inline
In-Reply-To: <52269D18.3090200@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org

On Tue, Sep 03, 2013 at 08:38:16PM -0600, Eric Blake wrote:
>
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html
> states that there are only two operators "!" and "()", and specifically
> mentions that -a and -o are binary primaries:

Well, a primary is usually something that cannot be reduced
further when discussing syntax.  As both -a and -o take expressions
on either side, it is highly unusual to designate them as primaries
instead of operators.

Also, in the rationale it clearly states that -a/-o are operators
and not primaries.

In any case, dash does not claim XSI conformance, so we're at
liberty to choose the most suitable implementation of an existing
feature that we inherited from BSD.
 
> "test ! -o !" is a three-argument test, where $2 (-o) is a binary
> primary, so it is the binary test of $1 and $3, and the end result is an
> exit status of 0.  Bash and ksh get it right, dash fails.

Both zsh and posh do it like dash:

$ zsh -c 'test ! -o !'; echo $?
zsh:test:1: too many arguments
1
$ zsh -c 'test ! = !'; echo $?
0
$

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
