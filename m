From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] var.c: check for valid variable name before printing
	in "export -p"
Date: Sun, 26 Feb 2012 01:31:55 +1100
Message-ID: <20120225143155.GA31891@gondor.apana.org.au>
References: <1329216528-8462-1-git-send-email-harald@redhat.com> <20120225073636.GA19041@gondor.apana.org.au> <20120225143004.GA8575@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from sting.hengli.com.au ([178.18.18.71]:50887 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756651Ab2BYOcC (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 25 Feb 2012 09:32:02 -0500
Content-Disposition: inline
In-Reply-To: <20120225143004.GA8575@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: harald@redhat.com, dash@vger.kernel.org

On Sat, Feb 25, 2012 at 03:30:04PM +0100, Jilles Tjoelker wrote:
>
> Most shells pass the environment variable through, such as bash, zsh,
> ksh93 and most ash derivatives. However, the original Bourne shell and
> pdksh/mksh do not.

Do you know of any genuine uses of such environment variables?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
