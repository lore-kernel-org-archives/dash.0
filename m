From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [0/4] input: Allow two consecutive calls to pungetc
Date: Mon, 5 Jan 2015 23:00:30 +1100
Message-ID: <20150105120030.GA6101@gondor.apana.org.au>
References: <1554581409055304@web13g.yandex.ru>
 <53FC7EE2.7000309@redhat.com>
 <20140929145507.GA3670@gondor.apana.org.au>
 <20141029215230.GA48394@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:56177 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbbAEMAt (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 5 Jan 2015 07:00:49 -0500
Content-Disposition: inline
In-Reply-To: <20141029215230.GA48394@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: Eric Blake <eblake@redhat.com>, Oleg Bulatov <oleg@bulatov.me>, dash@vger.kernel.org, Juergen Daubert <jue@jue.li>

On Wed, Oct 29, 2014 at 10:52:30PM +0100, Jilles Tjoelker wrote:
>
> This implementation of pgetc_eatbnl() does not allow pushing back a
> backslash, since that would call pungetc() twice without an intervening
> pgetc(). However, some places do attempt to push back a backslash. As a
> result, a script file containing many repeated  ${w#\#}  will not be
> parsed correctly. There is a similar bug with repeated  $\#  but this is
> not specified by POSIX.

I finally got around to fixing this.  I've decided to do things
a little differently by making it possible to do two pungetc's in
a row.

When I get some spare time I would like to make the parser reentrant
so we can do PS4 properly and fix some other corner cases.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
