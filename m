From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [0/9] Handle embedded NULs correctly in printf
Date: Mon, 27 Oct 2014 16:25:46 +0800
Message-ID: <20141027082546.GA6447@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:47755 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbaJ0IZu (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 27 Oct 2014 04:25:50 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi:

This series adds embedded NUL handling to printf, and then tries
to squeeze out some fat so we don't end up bloating it up too much.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
