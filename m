From: Edward Lam <edward@sidefx.com>
Subject: Re: [PATCH] Support DOS paths in dash
Date: Wed, 1 Oct 2014 23:18:20 -0400
Message-ID: <B904167A-6AC6-4220-BA35-AF2581929FFE@sidefx.com>
References: <20141002004137.GA23830@gondor.apana.org.au>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.sidefx.com ([206.223.178.163]:38165 "EHLO mail.sidefx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbaJBDZj (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 1 Oct 2014 23:25:39 -0400
In-Reply-To: <20141002004137.GA23830@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Blake <eblake@redhat.com>, "dash@vger.kernel.org" <dash@vger.kernel.org>



> On Oct 1, 2014, at 8:41 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
> Eric Blake <eblake@redhat.com> wrote:
>> 
>> I'm not interested in burdening the cygwin build of dash with a one-off
>> patch, so I'd like to gauge the upstream thoughts - is it worth
>> including platform-specific patches like this (no penalty to build size
>> of non-cygwin platforms, and on cygwin, it allows 'cd c:/' to behave as
>> shorthand for 'cd /cygdrive/c/')?  If the patch lands in dash.git, then
>> I'll rebuild the cygwin port of dash to include a backport (rather than
>> waiting for 0.5.9 to be released).  If there is no interest, I'd rather
>> just drop the patch.  The cygwin community already states that
>> /cygdrive/c notation is the official way to access drive letters, and
>> that if 'c:/' works it is nice, but it is not a design goal to always
>> have it work.
> 
> It's fine by me.
> 

Is that a yes to allow platform-specific patches into dash?

Thanks,
-Edward
