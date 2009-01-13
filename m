From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Mac OS X support patch
Date: Tue, 13 Jan 2009 15:19:04 +1100
Message-ID: <20090113041904.GA17830@gondor.apana.org.au>
References: <4faa0b8b0807111420o36da862ahd17a4a7d06a781e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:47248 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751012AbZAMETI (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 12 Jan 2009 23:19:08 -0500
Content-Disposition: inline
In-Reply-To: <4faa0b8b0807111420o36da862ahd17a4a7d06a781e7@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Mark Mentovai <mmentovai@gmail.com>
Cc: dash@vger.kernel.org

On Fri, Jul 11, 2008 at 09:20:24PM +0000, Mark Mentovai wrote:
> Hi, Herbert and friends.  I've created a small patch that allows dash
> to be built on Mac OS X.  I'm contributing it here with the hope that
> it's suitable for inclusion in dash.

Sorry for the late response but please CC me next time on patches.

> The changes in this patch are:
> 
> - __attribute__((__alias__())) is not supported, add an autoconf check

Applied with the exraise changed to abort and formatting fixes.

> - open64 is not present although the stat64 family is, separate the
>   autoconf checks

Applied.

> - A syntax error had slipped into a non-glibc codepath

Already fixed.

> - mkbuiltins had a nonportable mktemp invocation for the case where
>   tempfile is not availalble

Already fixed.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
