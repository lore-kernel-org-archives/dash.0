From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Set LC_ALL instead LC_COLLATE in mkbuiltins
Date: Tue, 26 May 2015 10:49:33 +0800
Message-ID: <20150526024932.GA4351@gondor.apana.org.au>
References: <CAOhdH0uf7Kj2noz4vnuLo_06W2HZ4Xwh_Bm5vKC71VHfeswD_Q@mail.gmail.com>
 <20150522042531.GA30829@gondor.apana.org.au>
 <CAOhdH0uPNu3DN-iDRiiCvjpU6FPvK_4AvdEuZE3bQ8F3j9DuCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:60981 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbbEZCth (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 25 May 2015 22:49:37 -0400
Content-Disposition: inline
In-Reply-To: <CAOhdH0uPNu3DN-iDRiiCvjpU6FPvK_4AvdEuZE3bQ8F3j9DuCg@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Fredrik Fornwall <fredrik@fornwall.net>
Cc: dash@vger.kernel.org

On Sun, May 24, 2015 at 11:05:48PM +0200, Fredrik Fornwall wrote:
> On Fri, May 22, 2015 at 6:25 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > This causes any errors printed by sort to come out in English.
> >
> > Please fix this by simply setting LC_ALL to empty alongside
> > LC_COLLATE=C.
> 
> A version with LC_ALL= follows:

Patch applied.  Though I had to do it by hand because your patch
has been mangled by your mailer.  I also fixed up the indentation.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
