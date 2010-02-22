From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: test -nt/-ot behavior
Date: Mon, 22 Feb 2010 14:50:43 +0800
Message-ID: <20100222065043.GA28401@gondor.apana.org.au>
References: <20100221122100.GA9005@wopr.local.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:35326 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754454Ab0BVGus (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 22 Feb 2010 01:50:48 -0500
Content-Disposition: inline
In-Reply-To: <20100221122100.GA9005@wopr.local.invalid>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Guido Berhoerster <guido+kernel.org@berhoerster.name>
Cc: dash@vger.kernel.org

Guido Berhoerster <guido+kernel.org@berhoerster.name> wrote:
> 
> It should be noted that pdksh contains many other subtle
> differences and is not really compatible to either ksh88 or
> ksh93, the behavior introduced by the test builtin of earlier
> pdksh versions is likely due to a misunderstanding of ksh88's
> specified behavior which was later fixed.  So IMHO the
> consequence for ash should be to either merge the fix from pdksh
> or to drop -nt, -ot, and -ef altogether, I would prefer that
> latter since I think silently changing the behavior in an
> incompatible way is bad practice and these features are not
> specified in POSIX anyway.

Well, as you say the behaviour is not specified by POSIX so dash
isn't doing anything wrong per se.  As this has been the documented
behaviour within dash since forever I'm reluctant to change it or
for that matter, removing the feature entirely.

I think fixing scripts that rely on this for files that do not exist
would be the best option.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
