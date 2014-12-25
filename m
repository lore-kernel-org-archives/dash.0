From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] create builtins.c properly on old cpp
Date: Fri, 26 Dec 2014 09:52:28 +1100
Message-ID: <20141225225228.GA20145@gondor.apana.org.au>
References: <2410222201414.mjQV5WR4491251$@sra-tohoku.co.jp.msg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:49827 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbaLYWwc (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 25 Dec 2014 17:52:32 -0500
Content-Disposition: inline
In-Reply-To: <2410222201414.mjQV5WR4491251$@sra-tohoku.co.jp.msg>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
Cc: dash@vger.kernel.org, kabe@sra-tohoku.co.jp

kabe@sra-tohoku.co.jp wrote:
> Encontered this on ancient gcc-2.95.3 environment;
> src/builtins.def.in -> src/builtins.def generation emitted
> ^ $
> lines (likely by /* */), which where NOT ignored by 
> src/mkbuiltins and generating bogus builtins.c.

Patch applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
