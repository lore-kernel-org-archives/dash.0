From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] parser: Catch errors in expandstr
Date: Fri, 28 Feb 2020 11:40:23 +1100
Message-ID: <20200228004023.GA9163@gondor.apana.org.au>
References: <SJhI_AW9YJmphaap5RzzVqYTGsA529iV7GOEBafT9ilDPGFpMRRJlNt3TrMBwh0uqKQltSvsH2P8x_2in6enHT5DzygjAtrRSvWl5xHofeY=@emersion.fr>
 <20200121063959.tel7ty76fkz33xpn@gondor.apana.org.au>
 <5e56df24.H24u7mxAPbLPL6fI%rmy@frippery.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:55620 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730144AbgB1Akd (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 27 Feb 2020 19:40:33 -0500
Content-Disposition: inline
In-Reply-To: <5e56df24.H24u7mxAPbLPL6fI%rmy@frippery.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Ron Yorston <rmy@frippery.org>
Cc: contact@emersion.fr, dash@vger.kernel.org

On Wed, Feb 26, 2020 at 09:12:04PM +0000, Ron Yorston wrote:
> Herbert Xu wrote:
> >This patch fixes it by using the literal value of PS1 should an
> >error occur during expansion.
> 
> There's another case that should be handled.  PS1='`xxx(`' causes the
> shell to exit because the old-style backquote leaves an additional file
> on the stack.
> 
> Signed-off-by: Ron Yorston <rmy@pobox.com>
> ---
>  src/parser.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

When you send a patch to an existing thread could you please change
the Subject line? Otherwise your patch will be silently dropped by
patchwork.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
