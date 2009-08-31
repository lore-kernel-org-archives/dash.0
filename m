From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: avoid compiler warning
Date: Mon, 31 Aug 2009 21:31:59 +1000
Message-ID: <20090831113158.GA6896@gondor.apana.org.au>
References: <4A55E8BD.1090809@byu.net> <20090811040330.GE10700@gondor.apana.org.au> <4A819D67.7060301@zytor.com> <20090811215615.GA31592@gondor.apana.org.au> <4A9BB44A.2010103@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:60900 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751101AbZHaLcI (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Aug 2009 07:32:08 -0400
Content-Disposition: inline
In-Reply-To: <4A9BB44A.2010103@byu.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, dash@vger.kernel.org

On Mon, Aug 31, 2009 at 05:30:18AM -0600, Eric Blake wrote:
> 
> Ping.  Or do we want to go with an alternate patch of defining our own
> version of ISDIGIT that handles the entire range of int and avoids
> checking the current locale, since POSIX guarantees that isdigit can only
> return true for the ten bytes '0' through '9'?

It's still in my queue.  I'll get to it next.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
