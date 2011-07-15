From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [SHELL] Fix klibc DEBUG compilation v3
Date: Fri, 15 Jul 2011 11:20:51 +0800
Message-ID: <20110715032051.GA27809@gondor.apana.org.au>
References: <1310119538-25514-1-git-send-email-max@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:56078 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109Ab1GODU5 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 14 Jul 2011 23:20:57 -0400
Content-Disposition: inline
In-Reply-To: <1310119538-25514-1-git-send-email-max@stro.at>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: dash@vger.kernel.org, klibc@zytor.com

On Fri, Jul 08, 2011 at 10:05:38AM +0000, maximilian attems wrote:
> dash didn't compile in DEBUG mode against klibc for all long time.
> Now it only fails at link stage for not having setlinebuf(3) and
> freopen(3).

Applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
