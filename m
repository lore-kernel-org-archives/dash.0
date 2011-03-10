From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [PARSER] Remove backslash before } in double-quotes in
	variable
Date: Thu, 10 Mar 2011 16:59:27 +0800
Message-ID: <20110310085927.GA10824@gondor.apana.org.au>
References: <20101119135406.GA24391@gondor.apana.org.au> <4CE71991.3020108@gigawatt.nl> <20101121134222.GC17293@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:38845 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab1CJI7d (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 10 Mar 2011 03:59:33 -0500
Content-Disposition: inline
In-Reply-To: <20101121134222.GC17293@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org, jrnieder@gmail.com

On Sun, Nov 21, 2010 at 02:42:22PM +0100, Jilles Tjoelker wrote:
> The backslash prevents the closing brace from terminating the
> substitution, therefore it should be removed.
> 
> FreeBSD sh test expansion/plus-minus2.0 starts working, no other tests
> are affected.
> 
> Example:
>   printf "%s\n" ${$+\}} ${$+"\}"} "${$+\}}"
> should print } three times, without backslashes.

I agree with respect to the last one, but not the middle one.

${$+"\}"} should be identical in behaviour to "\}", which with
all shells I have access to produces a brace with a backslash.

So please update your patch so that we do not regress on the
second one.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
