From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [OPTIONS] Use exit status 127 when the script to run
	does not exist
Date: Sun, 28 Nov 2010 20:06:27 +0800
Message-ID: <20101128120627.GA10839@gondor.apana.org.au>
References: <20100605160651.GA60028@stack.nl> <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org> <20100628065326.GA25667@gondor.apana.org.au> <20101006100420.GA361@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:34139 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab0K1MGb (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Nov 2010 07:06:31 -0500
Content-Disposition: inline
In-Reply-To: <20101006100420.GA361@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>

On Wed, Oct 06, 2010 at 05:04:20AM -0500, Jonathan Nieder wrote:
>
> Herbert Xu wrote:
> 
> > This is wrong.  You're creating exactly the problem that Jilles
> > was talking about where dot(1) is returning 127.  This code should
> > be moved to procargs, which runs only for the "sh script" case.
> 
> Makes sense.  How does this look?
> 
> It still ignores attempts to run "sh directory"; see the next
> patch for that.

Actually I was wrong.  I had misunderstood Jilles' report and
thought that the problem is with 127 coming from dotcmd.  His
problem is actually with dotcmd bailing out which your (or was
it Gerrit's?) EXFILE patch already addressed.

However, instead of adding an ad-hoc exception for EXFILE, I'm
simply going to move the exit status setting for EXERROR out of
main.c and into error.c which should let you get what you want.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
