From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: bugs in cd
Date: Mon, 31 Aug 2009 22:56:53 +1000
Message-ID: <20090831125653.GA8262@gondor.apana.org.au>
References: <loom.20090714T212706-910@post.gmane.org> <20090831121822.GC7311@gondor.apana.org.au> <4A9BC0BF.30608@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:48820 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750718AbZHaM4x (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Aug 2009 08:56:53 -0400
Content-Disposition: inline
In-Reply-To: <4A9BC0BF.30608@byu.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
Cc: dash@vger.kernel.org

On Mon, Aug 31, 2009 at 06:23:27AM -0600, Eric Blake wrote:
>
> Which version of POSIX are you looking at?  POSIX 2008 added quite a few
> clarifications about the handling of // that were not listed in POSIX 2001.
> 
> http://www.opengroup.org/onlinepubs/9699919799/utilities/cd.html
> 
> "5. Starting with the first pathname in the <colon>-separated pathnames of
> CDPATH (see the ENVIRONMENT VARIABLES section) if the pathname is
> non-null, test if the concatenation of that pathname, a <slash> character
> if that pathname did not end with a <slash> character, and the directory
> operand names a directory."...
> 
> In other words, if CDPATH is "/", then you should not append any
> additional <slash> characters, such that you end up checking for the
> existence of "/foo", not "//foo".

Fair enough.  However, I noticed that they haven't fixed up PATH
to do the same thing.

Since we use the same function for PATH and CDPATH, I'm not going
to make any changes until POSIX becomes consistent in this respect.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
