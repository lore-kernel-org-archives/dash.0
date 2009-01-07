From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: look up functions per PATH (%func)
Date: Wed, 07 Jan 2009 13:44:43 +1100
Message-ID: <E1LKOPT-0001pM-G1@gondolin.me.apana.org.au>
References: <20090105165358.GB28083@lisa.in-ulm.de>
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:52981 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752919AbZAGCot (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 6 Jan 2009 21:44:49 -0500
In-Reply-To: <20090105165358.GB28083@lisa.in-ulm.de>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: mascheck@in-ulm.de
Cc: dash@vger.kernel.org

Sven Mascheck <mascheck@in-ulm.de> wrote:
> 
> Has anybody ever met scripts making use of this?

Back in the nineties I had plans to replace some built-ins with
shell functions using this mechanism, but it never went anywhere.
There are still functions in the ash source for some standard
(and some non-standard) built-ins.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
