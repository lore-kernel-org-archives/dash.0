From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: man: Document ulimit -v
Date: Mon, 6 Jun 2016 22:45:55 +0800
Message-ID: <20160606144555.GA23711@gondor.apana.org.au>
References: <56938FD6.3010600@svario.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:56706 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbcFFOp6 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 6 Jun 2016 10:45:58 -0400
Content-Disposition: inline
In-Reply-To: <56938FD6.3010600@svario.it>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
Cc: dash@vger.kernel.org

On Mon, Jan 11, 2016 at 08:12:35PM +0100, Gioele Barabucci wrote:
> Document that `ulimit` can set the `RLIMIT_AS` limit (virtual memory) with
> the `-v` flag.
> 
> Fixes: https://bugs.debian.org/78556
> Reported-by: Vincent Lefevre <vincent@vinc17.net>
> Signed-off-by: Gioele Barabucci <gioele@svario.it>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
