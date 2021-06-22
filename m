Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A135C2B9F4
	for <linux-dash@archiver.kernel.org>; Tue, 22 Jun 2021 08:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C00661352
	for <linux-dash@archiver.kernel.org>; Tue, 22 Jun 2021 08:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhFVIhQ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhFVIhP (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 22 Jun 2021 04:37:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88803C061574
        for <dash@vger.kernel.org>; Tue, 22 Jun 2021 01:35:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t19-20020a17090ae513b029016f66a73701so1289974pjy.3
        for <dash@vger.kernel.org>; Tue, 22 Jun 2021 01:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/EVXx1cPsAT5NV0A2RbEIS4HpItEzJxr5Oh7fXp8vQ=;
        b=fytzorNsbqE1xnBOs36Luumjwem2VkPr9IWsNelwnDaRNX2tNIqFUu3jnJN7FS2R0t
         EhiWBje3D+/WIcwcT2Z4SllmNhwz+lmd8TL4gDO35Dd5B0TyC8ypB+S+NA9+1Qqn8DNr
         gkmOmELoqB8sURlJmF2LaUvyJrttalFN0rzAdDhhA42dmAXS5XvD8kqkZgcMOxfv0zW0
         9ksyKETGCiny9Tvm6G0Ng3gAO5TnwJiCAh3RYY1NDzvRU2OAPYfZts6KB+Ez1JfynFR3
         S7d2ZEWtiVRsAouFo78c20W656WnMqDe9+Lt0dzTtyYoovR5SfJ4pzPFKckEcXAVMnbn
         qNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/EVXx1cPsAT5NV0A2RbEIS4HpItEzJxr5Oh7fXp8vQ=;
        b=NmbQAphfQEESwheLV5sh05TyhiNMyA5Hgc/vRX8N2vjmkSrsdYic+UefRpUZceKQ6t
         YDCe1+4PVbIyjEMSjZaWWwO/8663YgisgbL2poArlDuF6IHBjacT/D7n4TWsBcvwfQjb
         8jmZjEfE1vHYzZrLBQCV7prFRXFP189KCS110cy80cwljqk2CoH9+6b7N7za6ip6ScBy
         B+8L3OdG/yI4bKvJKPx6oIltwkMP+pZfUhnpCStNSpjOV2iYmsGgJqke/dEDI4lG7pE7
         1P7fHPWcOsewKY0YqGPv5a95mE4JF+r4ZStmKb41iNEab/QmldnlB+aCMthhR6IjuBdA
         JSow==
X-Gm-Message-State: AOAM532YxUwP9S8pw3tHN9P4VMMQaeNWwXd7Etr2h/L/cfqaHFelLUY0
        qVNs9XwGGlppHCIFaTP+OuD8kp38rF83aDQDLpfMO9efiaA=
X-Google-Smtp-Source: ABdhPJyaOnP9XMZQyVENikz/gvT1tuR9Y+6Hsd7p+klG3/znbKSbbAd0xvBDCpn/f54efvnUtmQQDs8cH9wK1yPnY/o=
X-Received: by 2002:a17:90a:1d0a:: with SMTP id c10mr2881719pjd.39.1624350900054;
 Tue, 22 Jun 2021 01:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAK1hOcNX1K_o0E7eFDAD2FYE8WCTpj1hUfzyvQstEQ5S=6onHg@mail.gmail.com>
 <20210621095719.GA9287@gondor.apana.org.au> <CAK1hOcNdGJNyCLiRwnw1N0wj6F+CZnFL9VNVQ2v0=YeGwCpQsw@mail.gmail.com>
 <20210622001910.GA11745@gondor.apana.org.au>
In-Reply-To: <20210622001910.GA11745@gondor.apana.org.au>
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Tue, 22 Jun 2021 10:34:49 +0200
Message-ID: <CAK1hOcOZv1Ze3YAv15oF6J9=i5BDhaADRbdWgabrho7OyS==2Q@mail.gmail.com>
Subject: Re: [PATCH] parser: Fix VSLENGTH parsing with trailing garbage
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Jun 22, 2021 at 2:19 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Mon, Jun 21, 2021 at 04:21:40PM +0200, Denys Vlasenko wrote:
> > > -                       } while (!subtype && is_digit(c));
> > > +                       } while ((subtype <= 0 || subtype >= VSLENGTH) &&
> > > +                                is_digit(c));
> >
> > ... you use (subtype == 0 || subtype == VSLENGTH) here.
> > Also, (subtype == 0 || subtype == VSLENGTH) is less confusing:
> > it says "loop if ${VAR} or ${#VAR} syntax", whereas <= >=
> > are a bit misleading.
>
> Yes it looks a bit confusing, but it turns into a single branch
> instead of two.

Yes, I know that. Compiler turns it into "(unsigned)(x-1) >= VSLENGTH-1"
expression.

But is it worth the obfuscation? Especially that it also has another
downside (it requires an additional free CPU register to hold (x-1)
result, which can force compiler to spill other values to stack).
