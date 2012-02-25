From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] var.c: check for valid variable name before printing
	in "export -p"
Date: Sun, 26 Feb 2012 01:54:58 +1100
Message-ID: <20120225145458.GA22171@gondor.apana.org.au>
References: <1329216528-8462-1-git-send-email-harald@redhat.com> <20120225073636.GA19041@gondor.apana.org.au> <20120225143004.GA8575@stack.nl> <20120225143155.GA31891@gondor.apana.org.au> <4F48F5E4.2010109@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from sting.hengli.com.au ([178.18.18.71]:56550 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756699Ab2BYOzD (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 25 Feb 2012 09:55:03 -0500
Content-Disposition: inline
In-Reply-To: <4F48F5E4.2010109@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Jilles Tjoelker <jilles@stack.nl>, harald@redhat.com, dash@vger.kernel.org

On Sat, Feb 25, 2012 at 07:53:24AM -0700, Eric Blake wrote:
>
> POSIX states that applications must not rely on such pass-through:
> http://austingroupbugs.net/view.php?id=168
> 
> So while it might indeed be useful to pass through invalid names, such
> an application is broken for expecting it to work, and I'm okay with
> this patch as-is.

Great.  From a security point of view I'd rather not pass them
through.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
