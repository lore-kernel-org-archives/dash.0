From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH/RFC dash 0/4] Avoid a fork before running last command
	given to -c
Date: Fri, 15 Apr 2011 21:07:09 +0800
Message-ID: <20110415130709.GA3735@gondor.apana.org.au>
References: <20110410071734.GA16736@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:45841 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948Ab1DONHQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 15 Apr 2011 09:07:16 -0400
Content-Disposition: inline
In-Reply-To: <20110410071734.GA16736@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org, Jilles Tjoelker <jilles@stack.nl>, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

On Sun, Apr 10, 2011 at 07:18:17AM +0000, Jonathan Nieder wrote:
> Hi,
> 
> Jilles Tjoelker wrote[0]:
> 
> > Regarding sh -c optimization, I am in favour of this. Uselessly waiting
> > 'sh -c' processes annoy me. I made the change for FreeBSD 8.0 sh, which
> > is very similar to dash. The SVN changeset is r194128.
> 
> So I grabbed that changeset with
> 
> 	svn log -v svn://svn.freebsd.org/base/head/bin/sh -r 194128
> 	svn diff -r 194127:194128 svn://svn.freebsd.org/base/head/bin/sh
> 
> and made it a tiny bit smaller.   Here's the result.
> 
>    text    data     bss     dec     hex filename
>   83994    1784   11128   96906   17a8a dash.before-O2
>   83994    1784   11128   96906   17a8a dash.before-Os
>   84146    1784   11128   97058   17b22 dash.after-O2
>   84146    1784   11128   97058   17b22 dash.after-Os
> 
> On this amd64 the cost is 152 bytes of text.  Thoughts?

I must say that I don't see much value in this feature.  Adding
exec to the invocation is trivial.

Having said that, I will review the patches to see if they make
sense individually.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
