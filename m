From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: test incorrectly rejecting valid expression with confusing !
 placement
Date: Wed, 4 Sep 2013 11:56:30 +1000
Message-ID: <20130904015629.GA19007@gondor.apana.org.au>
References: <5218BCAD.2010107@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([178.18.16.133]:58472 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934205Ab3IDB4e (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 3 Sep 2013 21:56:34 -0400
Content-Disposition: inline
In-Reply-To: <5218BCAD.2010107@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org

Harald van Dijk <harald@gigawatt.nl> wrote:
> Hi,
> 
> Now that Herbert fixed the reported crash in test (in a far simpler
> manner than I had suggested, which I like), I did some more testing, and
> came across one case that does not currently work, and did not work in
> the past, but is perfectly valid:
> 
> $ src/dash -c 'test ! ! = !'
> src/dash: 1: test: =: unexpected operator

Agreed.
 
> $ src/dash -c 'test ! -o !'
> src/dash: 1: test: -o: unexpected operator

Nope, the rule is quite clear that it only applies to binary
primaries, not operators.  -o is an operator.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
