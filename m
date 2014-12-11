From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Bug#501566: [MAN] Clarify two redirection mechanisms
Date: Thu, 11 Dec 2014 17:06:28 +1100
Message-ID: <20141211060628.GA8857@gondor.apana.org.au>
References: <20141209165431.GB5708@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:40515 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578AbaLKGGh (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 11 Dec 2014 01:06:37 -0500
Content-Disposition: inline
In-Reply-To: <20141209165431.GB5708@chaz.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Stephane CHAZELAS <stephane.chazelas@gmail.com>
Cc: saulery@free.fr, 501566@bugs.debian.org, dash@vger.kernel.org

Stephane CHAZELAS <stephane.chazelas@gmail.com> wrote:
>
> Let's make it:
> 
>  [n1]>&n2    Copy file descriptor n2 as stdout (or fd n1)
>  [n1]<&n2    Copy file descriptor n2 as stdin (or fd n1)
> 
> That's more or less the POSIX wording. It may not be as
> descriptive as other ones, but I can't imagine anyone
> complaining about the correctness or accuracy of it.

Yes this sounds good to me.  Someone please create a patch for
it.

BTW, one of you guys dropped me from the CC list again.  Please
don't do that.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
