From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash klibc DEBUG compile trouble
Date: Thu, 8 Jul 2010 21:51:14 +0800
Message-ID: <20100708135114.GA20673@gondor.apana.org.au>
References: <20100708084834.GB6829@stro.at> <20100708130401.GA20383@gondor.apana.org.au> <20100708131753.GE9869@baikonur.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:53604 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756052Ab0GHNvQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 8 Jul 2010 09:51:16 -0400
Content-Disposition: inline
In-Reply-To: <20100708131753.GE9869@baikonur.stro.at>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: dash@vger.kernel.org, klibc@zytor.com

On Thu, Jul 08, 2010 at 03:17:53PM +0200, maximilian attems wrote:
> 
> It says that the 64 bit operations are the same as the 32 bit ones,
> that's why I'm confused.

Ah, klibc must be undefining stat64, which then causes struct
stat64 to be undeclared.

I'll look into it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
