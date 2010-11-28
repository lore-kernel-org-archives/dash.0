From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: read() builtin doesn't read integer value /proc files (but
	bash's does)
Date: Sun, 28 Nov 2010 16:42:19 +0800
Message-ID: <20101128084219.GC8818@gondor.apana.org.au>
References: <AANLkTinTd+29=8EkiTKptoE8nnVphcQ_TW=ezS99LmWw@mail.gmail.com> <AANLkTi=ZcNYJKCO_FM0RpJndwAgtzTU_C8J=9BsfmdAk@mail.gmail.com> <20100903212504.GA86276@stack.nl> <AANLkTi=d_13RCDhJHE_23BXN5Tf2RY_2e3rED7JwtFOK@mail.gmail.com> <20100904193504.GA3357@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:42212 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab0K1ImZ (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Nov 2010 03:42:25 -0500
Content-Disposition: inline
In-Reply-To: <20100904193504.GA3357@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: Steve Schnepp <steve.schnepp@gmail.com>, dash@vger.kernel.org, 595063@bugs.debian.org

On Sat, Sep 04, 2010 at 07:35:04PM +0000, Jilles Tjoelker wrote:
> 
> > I attached an updated patch that corrects this pb by discarding the
> > buffer when opening a new file.
> 
> This discarding is still bad as it throws away valid data if the open
> file description is shared. This happens if stdin is redirected inside a

I'm with Jilles on this.  I also don't particularly feel like
bloating dash just because of the borked /proc interface when
there is a perfectly adequate work-around in "cat".

	value=$(cat /proc/file)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
