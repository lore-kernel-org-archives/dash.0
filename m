From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: shell and glibc (Re: Inconsistent parameter expansion)
Date: Mon, 19 May 2008 12:11:30 +0800
Message-ID: <E1Jxwig-0007sq-00@gondolin.me.apana.org.au>
References: <20080519033047.GI21428@flower.upol.cz>
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:54131 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751177AbYESELd (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 19 May 2008 00:11:33 -0400
In-Reply-To: <20080519033047.GI21428@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Oleg Verych <olecom@flower.upol.cz>
Cc: dash@vger.kernel.org

Oleg Verych <olecom@flower.upol.cz> wrote:
> 
> It seems, small glibc team cannot do much in areas without interest.

Unfortunately all the cool kids want to work on the kernel instead :)

> Very surprising for me was recent discovery of big performance penalty of
> the most simple '^$' regexp; it turned to be glibc RE library problem:
> 
> http://bugs.debian.org/475474
> (bonus: 4 ways of doing one thing with `sed`, not with `perl`:)

Have you seen http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=65458 ?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
