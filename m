From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] avoid clang warning about dead store to "size"
Date: Fri, 8 Jul 2011 16:16:24 +0800
Message-ID: <20110708081624.GA28449@gondor.apana.org.au>
References: <878vtxrf68.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:39342 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab1GHIQ1 (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 8 Jul 2011 04:16:27 -0400
Content-Disposition: inline
In-Reply-To: <878vtxrf68.fsf@rho.meyering.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
Cc: dash@vger.kernel.org

On Mon, May 23, 2011 at 08:31:43AM +0000, Jim Meyering wrote:
> I ran clang's scan-build on dash and it reported one nit:
> 
> ANALYZE: memalloc.c makestrspace
> memalloc.c:276:9: warning: Value stored to 'size' during its initialization is never read
>         size_t size = stackblocksize();
>                ^      ~~~~~~~~~~~~~~~~

Also applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
