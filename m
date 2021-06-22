Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65611C4743C
	for <linux-dash@archiver.kernel.org>; Tue, 22 Jun 2021 00:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3777D6120D
	for <linux-dash@archiver.kernel.org>; Tue, 22 Jun 2021 00:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhFVAV1 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:21:27 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50792 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhFVAV1 (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 21 Jun 2021 20:21:27 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lvU8F-0001c0-DZ; Tue, 22 Jun 2021 08:19:11 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lvU8E-000345-8k; Tue, 22 Jun 2021 08:19:10 +0800
Date:   Tue, 22 Jun 2021 08:19:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Denys Vlasenko <vda.linux@googlemail.com>
Cc:     DASH shell mailing list <dash@vger.kernel.org>
Subject: Re: [PATCH] parser: Fix VSLENGTH parsing with trailing garbage
Message-ID: <20210622001910.GA11745@gondor.apana.org.au>
References: <CAK1hOcNX1K_o0E7eFDAD2FYE8WCTpj1hUfzyvQstEQ5S=6onHg@mail.gmail.com>
 <20210621095719.GA9287@gondor.apana.org.au>
 <CAK1hOcNdGJNyCLiRwnw1N0wj6F+CZnFL9VNVQ2v0=YeGwCpQsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1hOcNdGJNyCLiRwnw1N0wj6F+CZnFL9VNVQ2v0=YeGwCpQsw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Mon, Jun 21, 2021 at 04:21:40PM +0200, Denys Vlasenko wrote:
>
> > diff --git a/src/parser.c b/src/parser.c
> > index 3c80d17..13c2df5 100644
> > --- a/src/parser.c
> > +++ b/src/parser.c
> > @@ -1252,7 +1252,8 @@ varname:
> >                         do {
> >                                 STPUTC(c, out);
> >                                 c = pgetc_eatbnl();
> > -                       } while (!subtype && is_digit(c));
> > +                       } while ((subtype <= 0 || subtype >= VSLENGTH) &&
> > +                                is_digit(c));
> 
> ... you use (subtype == 0 || subtype == VSLENGTH) here.
> Also, (subtype == 0 || subtype == VSLENGTH) is less confusing:
> it says "loop if ${VAR} or ${#VAR} syntax", whereas <= >=
> are a bit misleading.

Yes it looks a bit confusing, but it turns into a single branch
instead of two.  Perhaps I should add a helper function for it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
