From: maximilian attems <max@stro.at>
Subject: Re: [PATCH] [SHELL] Fix klibc DEBUG compilation v2
Date: Sun, 10 Jul 2011 18:35:18 +0200
Message-ID: <20110710163518.GA31095@stro.at>
References: <1307171749-16260-1-git-send-email-max@stro.at>
 <20110708085501.GD28449@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from vostochny.stro.at ([78.47.22.85]:53260 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150Ab1GJQfL (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 10 Jul 2011 12:35:11 -0400
Content-Disposition: inline
In-Reply-To: <20110708085501.GD28449@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: klibc@zytor.com, dash@vger.kernel.org

On Fri, 08 Jul 2011, Herbert Xu wrote:

> On Sat, Jun 04, 2011 at 09:15:49AM +0200, maximilian attems wrote:
> > dash didn't compile in DEBUG mode against klibc for all long time.
> > Now it only fails at link stage for not having setlinebuf(3) and
> > freopen(3).
> > 
> > Fixes:
> > 
> > usr/dash/show.o: In function `opentrace':
> > show.c:(.text+0x36): undefined reference to `freopen'
> > show.c:(.text+0x86): undefined reference to `setlinebuf'
> > 
> > Skip setlinebuf and use fclose/fopen inside SMALL.
> > 
> > Signed-off-by: maximilian attems <max@stro.at>
> 
> Please change this to use a klibc-specific ifdef instead of everyone
> that uses SMALL.
> 

ok, sent patch with klibc specific '__KLIBC__`.

noticed latest dash release, will sync soon. 
unfortunately ee5cbe9fd6bc02f31b4d955606288de36c3d4eab complicates
a bit klibc sync, because mktokens now generates a third file
(we already have Kbuild hacks for the 2 generated files).

thank you.

-- 
maks
