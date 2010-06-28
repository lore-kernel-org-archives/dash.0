From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [EVAL] with set -e exit the shell if a subshell exits
	non-zero
Date: Mon, 28 Jun 2010 17:02:31 +1000
Message-ID: <20100628070231.GA26558@gondor.apana.org.au>
References: <20100614095603.27834.qmail@728ec0bb900c60.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:41305 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab0F1HCe (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 28 Jun 2010 03:02:34 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by fornost.hengli.com.au with esmtp (Exim 4.69 #1 (Debian))
	id 1OT8MS-0005LJ-S3
	for <dash@vger.kernel.org>; Mon, 28 Jun 2010 17:02:32 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>)
	id 1OT8MS-0006uw-Jo
	for dash@vger.kernel.org; Mon, 28 Jun 2010 17:02:32 +1000
Content-Disposition: inline
In-Reply-To: <20100614095603.27834.qmail@728ec0bb900c60.315fe32.mid.smarden.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Mon, Jun 14, 2010 at 09:56:03AM +0000, Gerrit Pape wrote:
> Example:
> 
> $ dash -c 'set -e; (false); echo here'
> here
> 
> With this commit, dash exits 1 before echo.
> 
> The bug was reported by Stefan Fritsch through
>  http://bugs.debian.org/514863
> 
> Signed-off-by: Gerrit Pape <pape@smarden.org>

I'm not convinced that this change is necessary.  I've run some
tests and bash/pdksh both behave like dash, while ksh93 behaves
in the way you suggest.

Has bash's behaviour changed recently (I'm using an ancient
version)?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
