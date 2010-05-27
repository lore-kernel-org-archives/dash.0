From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [EXPAND] Fix corruption of redirections with byte 0x81.
Date: Thu, 27 May 2010 20:07:52 +1000
Message-ID: <20100527100752.GA8721@gondor.apana.org.au>
References: <20100516225554.GA92724@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:56508 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757378Ab0E0KH4 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 27 May 2010 06:07:56 -0400
Content-Disposition: inline
In-Reply-To: <20100516225554.GA92724@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

Jilles Tjoelker <jilles@stack.nl> wrote:
> In other ash variants, a partial implementation of ksh-like cmd >file*
> adds and removes CTLESC bytes ('\x81') in redirection filenames,
> preserving 8-bit transparency. Long ago, dash removed the code to add
> the CTLESC bytes, but not the code to remove them, causing corruption of
> filenames containing CTLESC. This commit removes the code to remove the
> CTLESC bytes.
> 
> The CTLESC byte occurs frequently in UTF-8 encoded non-Latin text.
> 
> This bug has been reported various times to Ubuntu and Debian (e.g.
> Launchpad Ubuntu #422298). This patch is the same as the one submitted
> by Alexander Korolkov in Ubuntu #422298.
> 
> Signed-off-by: Jilles Tjoelker <jilles@stack.nl>

Patch applied.  Thanks a lot!
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
