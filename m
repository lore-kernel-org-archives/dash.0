From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: avoid compiler warning
Date: Tue, 11 Aug 2009 14:03:30 +1000
Message-ID: <20090811040330.GE10700@gondor.apana.org.au>
References: <4A55E8BD.1090809@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:34132 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753703AbZHKQHC (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Aug 2009 12:07:02 -0400
Content-Disposition: inline
In-Reply-To: <4A55E8BD.1090809@byu.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
Cc: dash@vger.kernel.org

On Thu, Jul 09, 2009 at 12:55:25PM +0000, Eric Blake wrote:
> ccache gcc -DHAVE_CONFIG_H -I. -I..  -include ../config.h -DBSD=1 -DSHELL
> -DIFS_BROKEN  -Wall -gdwarf-2 -Wall -Werror -MT mystring.o -MD -MP -MF
> .deps/mystring.Tpo -c -o mystring.o mystring.c
> miscbltin.c: In function `umaskcmd':
> miscbltin.c:201: warning: subscript has type `char'
> 
> isdigit is only defined over EOF and unsigned char values, so without this
> patch, you can trigger undefined behavior.

What compiler and what libc was this? isdigit is supposed to
be a function that takes an int argument according to POSIX.
If libc implements it as a macro then it's up to it to cast
the parameter to (int).

So I think you should fix this in your libc instead.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
