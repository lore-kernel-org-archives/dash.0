From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [SHELL] Fix klibc DEBUG compilation v2
Date: Fri, 8 Jul 2011 16:55:01 +0800
Message-ID: <20110708085501.GD28449@gondor.apana.org.au>
References: <1307171749-16260-1-git-send-email-max@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:44295 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab1GHIzM (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 8 Jul 2011 04:55:12 -0400
Content-Disposition: inline
In-Reply-To: <1307171749-16260-1-git-send-email-max@stro.at>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: klibc@zytor.com, dash@vger.kernel.org

On Sat, Jun 04, 2011 at 09:15:49AM +0200, maximilian attems wrote:
> dash didn't compile in DEBUG mode against klibc for all long time.
> Now it only fails at link stage for not having setlinebuf(3) and
> freopen(3).
> 
> Fixes:
> 
> usr/dash/show.o: In function `opentrace':
> show.c:(.text+0x36): undefined reference to `freopen'
> show.c:(.text+0x86): undefined reference to `setlinebuf'
> 
> Skip setlinebuf and use fclose/fopen inside SMALL.
> 
> Signed-off-by: maximilian attems <max@stro.at>

Please change this to use a klibc-specific ifdef instead of everyone
that uses SMALL.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
