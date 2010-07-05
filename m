From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: DASH regression
Date: Mon, 5 Jul 2010 16:55:42 +0800
Message-ID: <20100705085542.GA5091@gondor.apana.org.au>
References: <1276654454.16819.24.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:38955 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758212Ab0GEIzo (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 5 Jul 2010 04:55:44 -0400
Content-Disposition: inline
In-Reply-To: <1276654454.16819.24.camel@gemini>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Brian Koropoff <bkoropoff@gmail.com>
Cc: dash@vger.kernel.org

Brian Koropoff <bkoropoff@gmail.com> wrote:
> Hello,
>    I encountered a regression in DASH from git while attempting to get
> it working on Solaris.  I got it to build and run, but my scripts were
> mysteriously failing.  I tracked it down to a logic bug in setvareq()
> that caused it to assign through the wrong pointer when attempting to
> remove a variable from its hash bucket.  The following test case
> reproduces the bug for me:

Thanks for the report.  I'll apply your patch.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
