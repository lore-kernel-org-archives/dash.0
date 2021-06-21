Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3EAC4743C
	for <linux-dash@archiver.kernel.org>; Mon, 21 Jun 2021 14:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4139160FF2
	for <linux-dash@archiver.kernel.org>; Mon, 21 Jun 2021 14:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFUOYH (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 21 Jun 2021 10:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhFUOYH (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 21 Jun 2021 10:24:07 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1CCC061574
        for <dash@vger.kernel.org>; Mon, 21 Jun 2021 07:21:52 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t13so2487123pgu.11
        for <dash@vger.kernel.org>; Mon, 21 Jun 2021 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7edJe6mQj2jlmDf9siVItgKGFA6mCxaka/SdTkcBeg=;
        b=ajdhDaAwlDDh7UOnubIlR5GuF3hLPX1iCZPSP+ly0awrOKRYE4Kf8W6JtoqZ0uOkBI
         ZU47CdmJ0kVkfxNRlV/GmYfuyYkwFhMR7BmdUU0Ih8maqwnW8wVvNE1tEZlCJBXEXPb/
         yNr5gMp8p+QU7bOXu+K7M4+0wp3EduNdG4KgbMb2TLr5xkC6/5ddOlQCPDEBCBjh+8la
         46yzx1qMX3KiRe6UYtZQ+7ZFToq1RxengVOp7tA7Ca3oDsIcKlFClAKGFua1CVGlAwYQ
         MDWVg02Off3vEUURB/knegLdkvJwzsiQHGG+RXQhz3cuF5FzxYeg7nr8TxlUYq1tBG4y
         37sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7edJe6mQj2jlmDf9siVItgKGFA6mCxaka/SdTkcBeg=;
        b=sIfKdwvxij87LBGW8UM4IFiLJtHppVZgq05ow9NMR1BoPtkv7s9iWCyW+9MnGXORPD
         xWvGISixGsNEdWZOOUSKGwWE7qoCu902xjuRdQcrjJ4WItmRJUNaB3NVVirSvSowNLms
         k4pyrUjdET+Arc+XlJTKjDvJhbo0WTdU1QXSt1nEvB8PrW3vOubtZo5/nAr/4WvMz7Mh
         zuemSTKmkhW9/ea3OrUrpEq+9oPvOnnS+d+C6VjFcPKXw4A+Sm8jjiJPiKzeYkOX8Xz2
         EzqDa0y1NJs9CB9C3DreS5OD//n5u2sXQmgjc+Sstu8EJ3SiQnXhD93l3ZI9hFr3RU2D
         J+0Q==
X-Gm-Message-State: AOAM5320wCWq2oC1AWC0KB401XpovUiUYBIM/uaNZsVQ9iMffn4rRYTf
        LUhIsXCMgtsPas9+3DWc48SpZfCi8l8n+U9FmvfP7idzr6s=
X-Google-Smtp-Source: ABdhPJzWbD05+C7mlGY9TRPoex15oZ4M73ZdtzBmbKipdLd24fugAEUsMYzDCPo1w7ZCPMthnaGJnJKu6lXJeFwpzDQ=
X-Received: by 2002:a63:ff22:: with SMTP id k34mr24065925pgi.336.1624285311842;
 Mon, 21 Jun 2021 07:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAK1hOcNX1K_o0E7eFDAD2FYE8WCTpj1hUfzyvQstEQ5S=6onHg@mail.gmail.com>
 <20210621095719.GA9287@gondor.apana.org.au>
In-Reply-To: <20210621095719.GA9287@gondor.apana.org.au>
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Mon, 21 Jun 2021 16:21:40 +0200
Message-ID: <CAK1hOcNdGJNyCLiRwnw1N0wj6F+CZnFL9VNVQ2v0=YeGwCpQsw@mail.gmail.com>
Subject: Re: [PATCH] parser: Fix VSLENGTH parsing with trailing garbage
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Mon, Jun 21, 2021 at 11:57 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Sat, Jun 19, 2021 at 02:44:46PM +0200, Denys Vlasenko wrote:
> > CTLVAR and CTLBACKQ are not properly handled if encountered
> > inside {$#...}. Testcase:
> >
> > dash -c "`printf 'echo ${#1\x82}'`" 00 111 222
...
> In fact these two bugs are one and the same.  This patch fixes
> both by detecting the invalid substitution and not emitting it
> into the node tree.
>
> Incidentally this reveals a bug in how we parse ${#10} that got
> introduced recently, which is also fixed here.
...
> --- a/src/parser.h
> +++ b/src/parser.h
> @@ -62,6 +62,7 @@
>  #define VSTRIMLEFT     0x8             /* ${var#pattern} */
>  #define VSTRIMLEFTMAX  0x9             /* ${var##pattern} */
>  #define VSLENGTH       0xa             /* ${#var} */
> +/* VSLENGTH must come last. */

The above assumption is not necessary if...


> diff --git a/src/parser.c b/src/parser.c
> index 3c80d17..13c2df5 100644
> --- a/src/parser.c
> +++ b/src/parser.c
> @@ -1252,7 +1252,8 @@ varname:
>                         do {
>                                 STPUTC(c, out);
>                                 c = pgetc_eatbnl();
> -                       } while (!subtype && is_digit(c));
> +                       } while ((subtype <= 0 || subtype >= VSLENGTH) &&
> +                                is_digit(c));

... you use (subtype == 0 || subtype == VSLENGTH) here.
Also, (subtype == 0 || subtype == VSLENGTH) is less confusing:
it says "loop if ${VAR} or ${#VAR} syntax", whereas <= >=
are a bit misleading.
