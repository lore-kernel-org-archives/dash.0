From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [REDIR] Replace GPL noclobberopen code with the
	FreeBSD version.
Date: Thu, 10 Mar 2011 16:53:31 +0800
Message-ID: <20110310085331.GB10360@gondor.apana.org.au>
References: <20101120144733.GA17293@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:50895 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab1CJIxe (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 10 Mar 2011 03:53:34 -0500
Content-Disposition: inline
In-Reply-To: <20101120144733.GA17293@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

On Sat, Nov 20, 2010 at 02:47:33PM +0000, Jilles Tjoelker wrote:
> Replace noclobberopen() from bash with the FreeBSD code for noclobber
> opens.
> 
> This also reduces code size by eliminating an unnecessary check.

Patch applied.  Thanks a lot!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
