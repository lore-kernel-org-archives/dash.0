From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [Partial patch] IFS and read builtin
Date: Wed, 8 Sep 2010 17:10:46 +0800
Message-ID: <20100908091046.GA15975@gondor.apana.org.au>
References: <20100824225138.GB79263@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:42617 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758424Ab0IHJKx (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 8 Sep 2010 05:10:53 -0400
Content-Disposition: inline
In-Reply-To: <20100824225138.GB79263@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: harald@gigawatt.nl, dash@vger.kernel.org

Jilles Tjoelker <jilles@stack.nl> wrote:
>
> The intention is that if there are more fields than variables, the final
> variable receive the exact text after the already assigned fields and
> their delimiters (apart from trailing IFS whitespace). The POSIX.1-2008
> text achieves this if used with the POSIX.1-2008 field splitting rules,
> and so does the text you cited if used with the old field splitting
> rules (which result in five fields for " 1 ,2 3,,").

I agree that dash is wrong here.  However, the underlying logic is
correct as you can see from:

$ echo "1,2,3,"         | { read a; IFS=','; set -- $a; echo $#; }
3
$

So it's just the use in read that needs to be fixed.

FWIW I tried your patch but it grew the binary by about 0.5%.
This coupled with the fact that we'll now need to maintain two
copies of IFS logic (should it ever change again god forbid) means
that I'd like to stay with the current implementation if possible.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
