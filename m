From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: EXIT trap handling in subshells broken
Date: Fri, 17 Jan 2020 18:15:32 +0800
Message-ID: <20200117101532.jlddos2uctne5xk7@gondor.apana.org.au>
References: <c1a9c062-0917-d3f3-8826-811b5a4fd802@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:52642 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgAQKPe (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 17 Jan 2020 05:15:34 -0500
Content-Disposition: inline
In-Reply-To: <c1a9c062-0917-d3f3-8826-811b5a4fd802@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: DASH shell mailing list <dash@vger.kernel.org>

On Mon, Jan 06, 2020 at 09:57:20PM +0000, Harald van Dijk wrote:
> 
> The problem is not limited to redirections:
> 
>   f() { (trap "echo \$var" EXIT); }
>   var=bad
>   var=ok f
> 
> This prints "bad", when it should print "ok". Here, the local variable is
> dropped not in main(), but during the unwind process.

This works fine for me with the latest git tree.  This is because
reset has now been split into exitreset and reset and variables
are only reset in reset() which is only called if exitshell is
not happening.

As if we're in a subshell we will never take the reset() path
I don't think we need to do anything here at all.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
