From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Inconsistent parameter expansion
Date: Mon, 19 May 2008 10:46:44 +0800
Message-ID: <E1JxvOe-0007kT-00@gondolin.me.apana.org.au>
References: <20080518181151.GF21428@flower.upol.cz>
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:57533 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750968AbYESCqs (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 18 May 2008 22:46:48 -0400
In-Reply-To: <20080518181151.GF21428@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Oleg Verych <olecom@flower.upol.cz>
Cc: dash@vger.kernel.org, romain.tartiere@healthgrid.org, baptiste.grenier@healthgrid.org

Oleg Verych <olecom@flower.upol.cz> wrote:
>
>> This is a bug in dash.  The following patch should fix the problem,
>> provided that Ubuntu hasn't built dash with glob(3) enabled because
>> glob(3) has a similar bug and that needs to be fixed in glibc.
> 
> What was/is whole story? What are FNMATCH_BROKEN GLOB_BROKEN?

I added fnmatch(3) and glob(3) support to dash in order to tap
into existing libc functions rather than duplicating them.  However
at the time it turned out that both were broken which is why these
macros were added until such a time when they were fixed.

The fnmatch(3) function is now correct as far as I know but
glob(3) still seems to be broken.

In any case you may enable them with --enable-fnmatch and --enable-glob
when running configure to see their effect on dash.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
