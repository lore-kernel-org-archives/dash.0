From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] trap: Implement POSIX.1-2008 trap reset behaviour (#2)
Date: Tue, 8 Dec 2015 16:24:51 +0800
Message-ID: <20151208082451.GA17236@gondor.apana.org.au>
References: <20151207175047.GG735@joyent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:56980 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516AbbLHIY5 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 8 Dec 2015 03:24:57 -0500
Content-Disposition: inline
In-Reply-To: <20151207175047.GG735@joyent.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Perkin <jperkin@joyent.com>
Cc: dash@vger.kernel.org

Jonathan Perkin <jperkin@joyent.com> wrote:
> Clarifies a couple of issues with the previous patch, and expands on
> the rationale in the commit message.  Sorry for the noise -- jperkin
> 
> POSIX.1-2008 for trap adds the following behaviour:
> 
>    If the first operand is an unsigned decimal integer, the shell shall
>    treat all operands as conditions, and shall reset each condition to
>    the default value.
> 
> The interpretation of this behaviour differs among other shells.  In the
> case where the first operand is an invalid signo:
> 
>  bash-4.3.39(1), zsh-5.1.1:
> 
>    $ trap echo 1 2 3
>    $ trap 100 1 2
>    $ trap
>    trap -- '100' SIGHUP
>    trap -- '100' SIGINT
>    trap -- 'echo' SIGQUIT

So dash's behaviour is the same as bash.  I'm not changing this.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
