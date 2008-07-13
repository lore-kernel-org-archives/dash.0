From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: restricted dash shell?
Date: Sun, 13 Jul 2008 19:26:22 +0800
Message-ID: <E1KHzig-0005Kr-00@gondolin.me.apana.org.au>
References: <6cd6de210807121843v72403139x52e30b7709957b22@mail.gmail.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:41531 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752188AbYGML0Y (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 13 Jul 2008 07:26:24 -0400
In-Reply-To: <6cd6de210807121843v72403139x52e30b7709957b22@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Rocky Bernstein <rocky.bernstein@gmail.com>
Cc: dash@vger.kernel.org

Rocky Bernstein <rocky.bernstein@gmail.com> wrote:
> I notice dash doesn't seem to have a --restricted option like bash or
> come as a restricted shell like ksh (rksh).
> 
> Thought and comments?

POSIX rationale says:

	The options associated with a restricted shell (command name rsh
	and the -r option) were excluded because the standard developers
	considered that the implied level of security could not be
	achieved and they did not want to raise false expectations.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
