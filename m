From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash klibc DEBUG compile question
Date: Thu, 9 Sep 2010 16:22:17 +0800
Message-ID: <20100909082217.GA26402@gondor.apana.org.au>
References: <20100909081611.GF2919@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:57122 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab0IIIWU (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 9 Sep 2010 04:22:20 -0400
Content-Disposition: inline
In-Reply-To: <20100909081611.GF2919@stro.at>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: dash@vger.kernel.org, klibc@zytor.com

On Thu, Sep 09, 2010 at 10:16:11AM +0200, maximilian attems wrote:
> now with the proper flags passed and the jobs.c fix dash
> allmost compiles in DEBUG mode, the last two failures happen
> in show.c, which assumes some buffering functions that klibc
> doesn't provide:
> usr/dash/show.o: In function `opentrace':
> show.c:(.text+0x36): undefined reference to `freopen'
> show.c:(.text+0x86): undefined reference to `setlinebuf'
> 
> afais this code dates from the initial git import.
> any preferences on how to fix those Herbert?

setlinebuf is easy I guess if klibc doesn't do buffering.  You
can just skip it.

freopen is trickier.  However, it's only needed if you enable
history.  So I guess you could put it inside ifndef SMALL and
use fclose/fopen when not using history support.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
