From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 'continue' does not work in files sourced with dotcmd
Date: Thu, 7 Jul 2011 11:37:49 +0800
Message-ID: <20110707033749.GB16157@gondor.apana.org.au>
References: <AANLkTimiFku8Uj9haYAxXWyJQOGSV7Uz3i2k75+aMvTU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:53927 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab1GGDhx (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Jul 2011 23:37:53 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimiFku8Uj9haYAxXWyJQOGSV7Uz3i2k75+aMvTU@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "Taylan Ulrich B." <taylanbayirli@gmail.com>
Cc: dash <dash@vger.kernel.org>

On Sat, Feb 26, 2011 at 06:23:54PM +0000, Taylan Ulrich B. wrote:
> Using latest dash from git.
> Transcript:
> 
> $ echo continue > foo
> $ for i in 1; do . ./foo; echo foobar; done
> foobar
> $

While this does look inconsistent, this behaviour is not confined
to dash.  pdksh also does the same thing.

So I'm not particularly keen on changing this.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
