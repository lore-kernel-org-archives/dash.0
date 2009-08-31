From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: bugs in cd
Date: Mon, 31 Aug 2009 22:18:22 +1000
Message-ID: <20090831121822.GC7311@gondor.apana.org.au>
References: <loom.20090714T212706-910@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:33826 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751935AbZHaMSW (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Aug 2009 08:18:22 -0400
Content-Disposition: inline
In-Reply-To: <loom.20090714T212706-910@post.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
Cc: dash@vger.kernel.org

On Tue, Jul 14, 2009 at 09:39:03PM +0000, Eric Blake wrote:
> 
> Furthermore, POSIX requires that if the element in CDPATH ends in slash, that 
> no additional slashes are added while forming the candidate curpath.  In light 
> of the fact that //home need not be the same directory as /home (and indeed, on 
> cygwin, they are distinct entities), this is also a bug:

Can you quote where POSIX says this? I can't find anything that
stipulates this in my copy.  In fact, I can't even find anything
that allows it (only 3 or more leading slashes may be removed).

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
