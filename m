From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [BUILTIN] Make "test -x" sane again when run as root
Date: Tue, 27 Sep 2011 23:45:17 +1000
Message-ID: <20110927134517.GA30958@gondor.apana.org.au>
References: <20110926211636.GA6645@elie> <20110926221648.GF5629@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:50739 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab1I0Npn (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 27 Sep 2011 09:45:43 -0400
Content-Disposition: inline
In-Reply-To: <20110926221648.GF5629@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org, Christoph Egger <christoph@debian.org>, Petr Salinger <Petr.Salinger@seznam.cz>

On Mon, Sep 26, 2011 at 05:16:49PM -0500, Jonathan Nieder wrote:
> Jonathan Nieder wrote:
> 
> > [PATCH] [BUILTIN] Make "test -x" sane again when run as root
> 
> Quick correction: a better title would be
> 
> 	[BUILTIN] Fix "test -x" as root on platforms with old-fashioned faccessat
> 
> for brevity ("fix" contains just as much information as "make sane")
> and to make it more obvious that this is supposed to have no effect on
> platforms like Linux.  Sorry for the lack of clarity.

So pleas exclude the changes on Linux.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
