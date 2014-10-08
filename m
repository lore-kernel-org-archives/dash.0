From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Failure of nested substring processing inside double-quotes
Date: Wed, 8 Oct 2014 10:28:56 +0800
Message-ID: <20141008022856.GA5783@gondor.apana.org.au>
References: <1412625793.29340.94.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:38589 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbaJHC3B (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 7 Oct 2014 22:29:01 -0400
Content-Disposition: inline
In-Reply-To: <1412625793.29340.94.camel@mad-scientist.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Paul Smith <paul@mad-scientist.net>
Cc: dash@vger.kernel.org

On Mon, Oct 06, 2014 at 08:03:13PM +0000, Paul Smith wrote:
> Hi all.  I recently found a bug in dash's handling of substring
> processing, when the variable is contained within quotes.
> 
> In bash, this works:
> 
>   bash$ echo $PWD
>   /home/psmith
> 
>   bash$ echo ${PWD%${PWD##*/}}.
>   /home/.
> 
>   bash$ echo "${PWD%${PWD##*/}}."
>   /home/.
> 
> which is what I expect.  However, in dash we get:
> 
>   dash$ echo $PWD
>   /home/psmith
> 
>   dash$ echo ${PWD%${PWD##*/}}.
>   /home/.
> 
>   dash$ echo "${PWD%${PWD##*/}}."
>   .
> 
> Whoops!  Inside double-quotes dash is mishandling the nested string
> substitution.  If I break it up into two steps it works OK, regardless
> of whether or not it's quoted.
> 
> This is dash 0.5.7-4ubuntu1 (from Ubuntu GNOME 14.04).

This is already fixed in the current git tree, by the commit:

commit a7c21a6f4cb42d967854cae954efd4ee66bdea9c
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri Aug 23 20:04:12 2013 +1000

    [EXPAND] Propagate EXP_QPAT in subevalvar

So please report this to Ubuntu.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
