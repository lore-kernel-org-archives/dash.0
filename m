From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Parameter expansion fails when assigning a local variable
Date: Mon, 22 Jun 2009 16:57:29 +0800
Message-ID: <20090622085729.GA22431@gondor.apana.org.au>
References: <A612847CFE53224C91B23E3A5B48BAC73AEC8A9FE8@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:44601 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753620AbZFVI53 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 22 Jun 2009 04:57:29 -0400
Content-Disposition: inline
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC73AEC8A9FE8@xmail3.se.axis.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jesper Bengtsson <jesper.bengtsson@axis.com>
Cc: dash@vger.kernel.org

Jesper Bengtsson <jesper.bengtsson@axis.com> wrote:
> 
> I've found a problem with expanding $@.
> If I declare a local variable and assigns the expanded positional parameters:
>        local v="$@"
> It fails with something like:
>        local: 20: \/: bad variable name

This is expected behaviour.  local is just like any other utility
in how it handled parameters.  So "$@" will have been split before
it reaches local.  To get what you want, you should use "$*".
 
> I've tried this on dash 0.5.5.1 and 0.5.3 and both fail in the same way.
> I've also tried on bash and ash (Busybox) and both handles declaration and assignment on one line.

Bash and older versions of dash (like the one in Busybox) has a
hack that disables field splitting for local and certain other
commands.  This is not guaranteed by POSIX.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
