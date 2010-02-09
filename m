From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Output redirection to block-defined filehandle
Date: Tue, 9 Feb 2010 17:23:08 +1100
Message-ID: <20100209062308.GA16998@gondor.apana.org.au>
References: <46a038f91001281410g54a000darc5b7c87e9012d53e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:43241 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751457Ab0BIGXM (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 9 Feb 2010 01:23:12 -0500
Content-Disposition: inline
In-Reply-To: <46a038f91001281410g54a000darc5b7c87e9012d53e@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
Cc: dash@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> The flock binary in modern linuxes (from util-linux-ng) supports
> flocking a filehandle that is handled by the shell. Combining this
> with per-code-block filehandles / io redirection, it is an incredibly
> useful construct to protect a code block with a lock.
> 
> The resulting code looks like this (from man flock on Fedora 11):
> 
>      (
>         flock -s 200
>         # ... commands executed under lock ...
>       ) 200>/var/lock/mylockfile
> 
> I am now discovering that this works in bash, but not in dash.
> 
> Is there a posixly correct way to do this? Can dash handle it? Is
> there a syntax for this that is both dash and bash friendly?
> 
> If the answer is not -- this codepath is conditional. Is there a way
> for me to test for which shell is running (and only attempt it under
> bash)?

POSIX only requires file descriptors 0-9 for shell redirections.
So if you replace 200 with 9 it should work assuming that nothing
within the block uses fd 9.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
