From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Support DOS paths in dash
Date: Sat, 4 Oct 2014 12:07:53 +0800
Message-ID: <20141004040752.GA8508@gondor.apana.org.au>
References: <B904167A-6AC6-4220-BA35-AF2581929FFE@sidefx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:37365 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbaJDEIB (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 4 Oct 2014 00:08:01 -0400
Content-Disposition: inline
In-Reply-To: <B904167A-6AC6-4220-BA35-AF2581929FFE@sidefx.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Edward Lam <edward@sidefx.com>
Cc: eblake@redhat.com, dash@vger.kernel.org

Edward Lam <edward@sidefx.com> wrote:
> 
> 
>> On Oct 1, 2014, at 8:41 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>> 
>> Eric Blake <eblake@redhat.com> wrote:
>>> 
>>> I'm not interested in burdening the cygwin build of dash with a one-off
>>> patch, so I'd like to gauge the upstream thoughts - is it worth
>>> including platform-specific patches like this (no penalty to build size
>>> of non-cygwin platforms, and on cygwin, it allows 'cd c:/' to behave as
>>> shorthand for 'cd /cygdrive/c/')?  If the patch lands in dash.git, then
>>> I'll rebuild the cygwin port of dash to include a backport (rather than
>>> waiting for 0.5.9 to be released).  If there is no interest, I'd rather
>>> just drop the patch.  The cygwin community already states that
>>> /cygdrive/c notation is the official way to access drive letters, and
>>> that if 'c:/' works it is nice, but it is not a design goal to always
>>> have it work.
>> 
>> It's fine by me.
>> 
> 
> Is that a yes to allow platform-specific patches into dash?

If there is zero impact on other platforms and it doesn't adversely
impact the maintainability then yes.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
