From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] support ulimit -r
Date: Tue, 3 Jul 2012 17:38:15 +0800
Message-ID: <20120703093815.GA16929@gondor.apana.org.au>
References: <CALqGcGo3ncBKBE6Z5fUHS8aDJ0QuKRV=8+HpczQbN4CBfo8=PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from sting.hengli.com.au ([178.18.18.71]:45134 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754616Ab2GCJiS (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 3 Jul 2012 05:38:18 -0400
Content-Disposition: inline
In-Reply-To: <CALqGcGo3ncBKBE6Z5fUHS8aDJ0QuKRV=8+HpczQbN4CBfo8=PA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Christoph Mathys <eraserix@gmail.com>
Cc: dash@vger.kernel.org

On Sat, Jun 09, 2012 at 09:00:30PM +0000, Christoph Mathys wrote:
> I recently found myself in need to have dash support 'ulimit -r' to
> set maximum realtime priority. Attached is a patch that adds the
> parameter to the builtin ulimit command and updates the manpage.

Patch applied.  Thanks a lot!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
