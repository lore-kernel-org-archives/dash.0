From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: test -nt/-ot behavior
Date: Tue, 23 Feb 2010 10:32:41 +0800
Message-ID: <20100223023241.GA10821@gondor.apana.org.au>
References: <20100221122100.GA9005@wopr.local.invalid> <20100222065043.GA28401@gondor.apana.org.au> <20100222103353.GA9924@wopr.local.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:57534 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752823Ab0BWCco (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 22 Feb 2010 21:32:44 -0500
Content-Disposition: inline
In-Reply-To: <20100222103353.GA9924@wopr.local.invalid>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Guido Berhoerster <guido+kernel.org@berhoerster.name>
Cc: dash@vger.kernel.org

On Mon, Feb 22, 2010 at 11:33:53AM +0100, Guido Berhoerster wrote:
>
> It is not doing something "wrong", but my point (and that of the
> original reporter of
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=558989) is that
> it is diverging from established behavior in widely used shells
> such a ksh88, ksh93, bash, pdksh, and GNU userland, as I said
> this was even fixed in pdksh where it originally came from.  I
> don't know how many /bin/dash scripts there are which rely on
> this behavior from test -nt/-ot but it can't be that many and
> dash has only been called das since 2002.  On the other hand dash
> is being widely used as /bin/sh, e.g. in Ubuntu, Debian, and
> hopefully soon openSUSE.

Actually dash has been around since 1997, prior to 2002 it was
known in Debian as ash.  So this behaviour has been around for
more than a decade.
 
> If dash aims to be a POSIX compliant /bin/sh which is "as small
> as possible", why does it need test -nt/-ot/-ef at all?  BTW, why
> did you go with pdksh's test instead of the one coming with ash?

While dash does try to be minimal, existing features are not removed
unless there is a very good reason.

As to your second question, this behaviour is inherited from BSD
which is where dash came from originally.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
