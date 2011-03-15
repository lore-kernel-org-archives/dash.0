From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2] [DEBUG] Use va_copy when reusing a va_list
Date: Tue, 15 Mar 2011 16:04:08 +0800
Message-ID: <20110315080408.GD8898@gondor.apana.org.au>
References: <20110313163259.GA24451@elie> <20110314062909.GA18712@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:38874 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab1COIEK (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 15 Mar 2011 04:04:10 -0400
Content-Disposition: inline
In-Reply-To: <20110314062909.GA18712@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org

On Mon, Mar 14, 2011 at 06:29:27AM +0000, Jonathan Nieder wrote:
> When tracing (with the DEBUG compile-time option set to 1 or 2),
> exverror calls TRACEV to print its arguments before passing them on.
> So the arguments are consumed by the time exvwarning looks for them,
> resulting in a segfault:
> 
>  $ sh -c '"'
>  sh: Syntax error: Unterminated quoted string
>  $ sh -o debug -c '"'
>  sh: Segmentation fault (core dumped)
> 
> Make a copy with va_copy to avoid this.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Also applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
