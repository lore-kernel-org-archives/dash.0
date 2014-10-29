From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Line continuation and variables
Date: Wed, 29 Oct 2014 22:52:30 +0100
Message-ID: <20141029215230.GA48394@stack.nl>
References: <1554581409055304@web13g.yandex.ru>
 <53FC7EE2.7000309@redhat.com>
 <20140929145507.GA3670@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:60702 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757108AbaJ2Vwi (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 29 Oct 2014 17:52:38 -0400
Content-Disposition: inline
In-Reply-To: <20140929145507.GA3670@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Blake <eblake@redhat.com>, Oleg Bulatov <oleg@bulatov.me>, dash@vger.kernel.org

On Mon, Sep 29, 2014 at 10:55:07PM +0800, Herbert Xu wrote:
> On Tue, Aug 26, 2014 at 12:34:42PM +0000, Eric Blake wrote:
> [snip]
> > So the fact that dash is treating the elided backslash-newline as a
> > token separator, and parsing your input as if ${EDIT}OR instead of
> > ${EDITOR} is a bug in dash.

> I agree.  The following patch should fix this:

> commit ef91d3d6a4c39421fd3a391e02cd82f9f3aee4a8
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Mon Sep 29 22:52:41 2014 +0800

>     [PARSER] Handle backslash newlines properly after dollar sign
> [snip]

> diff --git a/ChangeLog b/ChangeLog
> index 0fbc514..398bd15 100644
> --- a/ChangeLog
> +++ b/ChangeLog
> @@ -1,6 +1,7 @@
>  2014-09-29  Herbert Xu <herbert@gondor.apana.org.au>
>  
>  	* Kill pgetc_macro.
> +	* Handle backslash newlines properly after dollar sign.
>  
>  2014-09-28  Herbert Xu <herbert@gondor.apana.org.au>
>  
> diff --git a/src/parser.c b/src/parser.c
> index c4eaae2..2b07437 100644
> --- a/src/parser.c
> +++ b/src/parser.c
> @@ -827,6 +827,24 @@ breakloop:
>  #undef RETURN
>  }
>  
> +static int pgetc_eatbnl(void)
> +{
> +	int c;
> +
> +	while ((c = pgetc()) == '\\') {
> +		if (pgetc() != '\n') {
> +			pungetc();
> +			break;
> +		}
> +
> +		plinno++;
> +		if (doprompt)
> +			setprompt(2);
> +	}
> +
> +	return c;
> +}
> +
>  
>  
>  /*

This implementation of pgetc_eatbnl() does not allow pushing back a
backslash, since that would call pungetc() twice without an intervening
pgetc(). However, some places do attempt to push back a backslash. As a
result, a script file containing many repeated  ${w#\#}  will not be
parsed correctly. There is a similar bug with repeated  $\#  but this is
not specified by POSIX.

-- 
Jilles Tjoelker
