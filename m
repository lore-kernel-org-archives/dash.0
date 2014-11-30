From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: command substitutions in $PS4
Date: Sun, 30 Nov 2014 21:42:18 +0100
Message-ID: <20141130204218.GB1103@stack.nl>
References: <20141117214931.GA4601@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:49312 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751650AbaK3UmX (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 30 Nov 2014 15:42:23 -0500
Content-Disposition: inline
In-Reply-To: <20141117214931.GA4601@chaz.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Stephane Chazelas <stephane.chazelas@gmail.com>
Cc: dash@vger.kernel.org

On Mon, Nov 17, 2014 at 09:49:32PM +0000, Stephane Chazelas wrote:
> [tested on current git head
> f6d4def4e27b13fab174e948b94cd10550d3e10e]

> Command substitution doesn't seem to work in $PS4 (used for
> xtrace prompt):

> $ PS4='$(date +%T)> ' dash -xc :
> dash: 1: Syntax error: end of file unexpected (expecting ")")

> And with the old syntax:

> $ PS4='`date +%T`> ' dash -xc :
> > :

> And with more than one command:

> $ PS4='`date +%T`> ' dash -xc ':;:'
> > :

> dash doesn't return and seems to go in a forking loop,
> presumably because the `date` there triggers another PS4
> expansion and so on recursively

> If I prevent the recursion with:

> --- a/src/eval.c
> +++ b/src/eval.c
> @@ -776,7 +776,15 @@ evalcommand(union node *cmd, int flags)
>  		int sep;
>  
>  		out = &preverrout;
> +
> +		/*
> +		 * reset xflag temporarily for command substitutions performed
> +		 * upon $PS4 expansion
> +		 */
> +		xflag = 0;
>  		outstr(expandstr(ps4val()), out);
> +		xflag = 1;
> +
>  		sep = 0;
>  		sep = eprintlist(out, varlist.list, sep);
>  		eprintlist(out, arglist.list, sep);

> $ PS4='`date +%T`> ' ./src/dash -xc ':;sleep 1; date'
> > :
> 21:43:47> sleep 1
> 21:43:48> date
> Mon Nov 17 21:43:48 GMT 2014

> The command substitution still fails upon the first expansion
> only. I quickly gave up trying to find out why as I found the
> code there hard to follow.

In FreeBSD sh, I have disabled command substitution in PS4 (POSIX does
not require it anyway). It is treated as a syntax error.

Talking about syntax errors, dash has a problem there as well. If there
is a syntax error in PS4 and set -x is enabled, it will not execute any
simple commands (assignments to PS4 cause an error and are subsequently
reverted). FreeBSD sh prints the error messages and subsequently uses
the raw unexpanded text.

-- 
Jilles Tjoelker
