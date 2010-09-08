From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [VAR] Fix history (libedit only).
Date: Wed, 8 Sep 2010 16:17:49 +0800
Message-ID: <20100908081749.GA15336@gondor.apana.org.au>
References: <AANLkTi=7L7EC0xuBF4fqBksFAMAmjEiCc5VgAj75Hg=h@mail.gmail.com> <20100808131732.GB83966@stack.nl> <AANLkTimKQcUa=dpDVoO9TdiH3A5iW1_hJRsOdDE2LB9f@mail.gmail.com> <20100813135209.GB73073@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:57609 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758426Ab0IHIRz (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 8 Sep 2010 04:17:55 -0400
Content-Disposition: inline
In-Reply-To: <20100813135209.GB73073@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: Wez Furlong <kingwez@gmail.com>, dash@vger.kernel.org

On Fri, Aug 13, 2010 at 01:52:09PM +0000, Jilles Tjoelker wrote:
> Git commit 0df96793ef6aa103df228d7dfe56099b7d721a15 "[SHELL] Add
> preliminary LINENO support" added the LINENO variable in the middle of
> other initialized variables, causing some macros for TERM and HISTSIZE
> to break (both of these are only used if libedit support is compiled in,
> which is not the case by default).
> 
> The breakage is the same as can be seen by setting HISTSIZE=0.
> 
> Also add a comment warning about this.
> 
> The breakage was reported by Wez Furlong.

Patch applied.  Thanks Jilles!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
