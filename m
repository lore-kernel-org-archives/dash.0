From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Set LC_ALL instead LC_COLLATE in mkbuiltins
Date: Fri, 22 May 2015 12:45:15 +0800
Message-ID: <20150522044515.GA32740@gondor.apana.org.au>
References: <20150522042531.GA30829@gondor.apana.org.au>
 <555EB333.6000201@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:40011 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbbEVEp0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 22 May 2015 00:45:26 -0400
Content-Disposition: inline
In-Reply-To: <555EB333.6000201@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Fredrik Fornwall <fredrik@fornwall.net>, dash@vger.kernel.org

On Thu, May 21, 2015 at 10:40:19PM -0600, Eric Blake wrote:
>
> Why do you care whether any errors printed by sort are in the "C" locale
> (in English) rather than localized?  Ideally, there won't be any sort
> errors in the first place, because this tool is run on controlled input
> as part of the build process.

Your /tmp could be full or sort could be out of memory.

> Setting LC_ALL has the nice property that LC_COLLATE and LC_CTYPE are
> guaranteed to be compatible; if you just set LC_COLLATE but leave
> LC_CTYPE unchanged and unset LC_ALL, it is possible to attempt a
> collation that assumes one character set while still living in a ctype
> that assumes another, and get garbled results.

Show me an actual pair of values for these two that produce
incorrect results for mkbuiltins and I'll happily change both.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
