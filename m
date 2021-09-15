Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CA3C433FE
	for <linux-dash@archiver.kernel.org>; Wed, 15 Sep 2021 20:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57C861178
	for <linux-dash@archiver.kernel.org>; Wed, 15 Sep 2021 20:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhIOUI5 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhIOUI5 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 15 Sep 2021 16:08:57 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A83C061574
        for <dash@vger.kernel.org>; Wed, 15 Sep 2021 13:07:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g184so3840672pgc.6
        for <dash@vger.kernel.org>; Wed, 15 Sep 2021 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqrFKfavY6+IUoBlzbpR1I4vleBBE8IxMhEbCUru0aU=;
        b=eawWq02jwhQoHi5efjKpHenX0dXWzPpgKYAWPpWVPNJHp+4CNWvxOl4XWZoKK3Q1G8
         FVgUsExFxj0tzPBN31fD0HRaPcrulArDCwsrEjrHFKCRf48bbyr8LjawhGR0K95uV0tW
         giw6MNya677EhjoQDIpt8NFCiytujJ/IdzI1Zl7bwvRBkR5e0ggA7ZM9Q7dYMKKhV6K8
         7vRo5SkdXpqmPbPwzktumXjAiprpFap5hcCjTWuXcvHoX4MWC+JlJtjMjRusP4qaQ+Ru
         KBBSznGvXZ2ZdWDRkVQI31JPEi6dPQzQnEJnnaew+eisDTDmzw3fvaAEU+Gx0totnpAe
         cFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqrFKfavY6+IUoBlzbpR1I4vleBBE8IxMhEbCUru0aU=;
        b=ZGWodUpfSOrJbthsz9N1Ogh0t4rhLJ0YeHUonDTs0vKAw74/gLa0IonhN8F1KTMCZC
         KYecRqPpiXsQDmbh5JB91j6bzmIU1GY8RM2qFPUGaNdPUASxG/clepkcAPctIcqbmEGd
         HVbnSgPijw8xQKa/NuT0h7AsuHSH/zj8RfwD7B98SK66lbIM/4DaQAM9BwhYwj3/IUeA
         ZAuh632qEfhLobHmW21dUfur0GOn9++5hDsTWw2AXwWeocF+ZTBy6swQrgDR6F/WaT0w
         N+m/KHnyLusUwnczsBmdNoH31dfguGiKYnmFAl3QPAtt1WNLJ+5ijdma/aGLQaERa5sT
         PfGg==
X-Gm-Message-State: AOAM530RUJvIlzVHIJllSt0sx5f0UDEfaoPEk3QQL4Hr20W+45qFT47L
        0A9gmKSlGhNjuViWHOe0TD2G893sU+XvDer7BGc=
X-Google-Smtp-Source: ABdhPJyk7LcMdqYuN2Hm2udZ8RyVg3p3z1U3dMHJb+TWnBTycOelk1XK/nQp6bcHoZtjPXL4lKmCCUw3VKrE05pjQXc=
X-Received: by 2002:a63:dd56:: with SMTP id g22mr1410300pgj.38.1631736457570;
 Wed, 15 Sep 2021 13:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJGKYO4i85vGboyucxhJ948xZYxrBjoj5PtAO0eB3TEWW8QpzA@mail.gmail.com>
 <CAK1hOcOVuR4i0FgEOF1AdTA-EbdJyOTLNbViGxT0zwHceZGt-g@mail.gmail.com> <4dfc717b-93dc-7e63-3ede-f8a8cd977413@gigawatt.nl>
In-Reply-To: <4dfc717b-93dc-7e63-3ede-f8a8cd977413@gigawatt.nl>
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Wed, 15 Sep 2021 22:07:26 +0200
Message-ID: <CAK1hOcMNcgRVm7aqYay22dKAkVMOmWJiDrp2MTmYw+k+ez=GoA@mail.gmail.com>
Subject: Re: shell script error management in busybox ash
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     "Roberto A. Foglietta" <roberto.foglietta@gmail.com>,
        DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Sep 15, 2021 at 9:59 PM Harald van Dijk <harald@gigawatt.nl> wrote:
> On 15/09/2021 20:47, Denys Vlasenko wrote:
> > On Wed, Sep 15, 2021 at 7:48 PM Roberto A. Foglietta
> > <roberto.foglietta@gmail.com> wrote:
> >> Moreover,
> >> the code that these exceptions trigger (everywhere the setjmp()
> >> returns true) restores some values and frees some memory but the traps
> >> need the information before the restore, not the restored values.
> >
> > Yes, _this_ is the problem we are having.
> >
> > E.g. $FUNCNAME in EXIT trap needs to be current function's name.
>
> Important to also mention that although FUNCNAME is not part of POSIX,
> and there is no spec to compare to, in bash and ksh it does not behave
> that way

In my testing, it does.

> so you're talking about implementing FUNCNAME in a way that is
> incompatible with existing shells.

Try this in bash:

  trap 'echo trap:$FUNCNAME' EXIT
  f() { exit; }
  f

I'm getting:
  trap:f

IOW: in EXIT trap, $FUNCNAME is the name of the function where "exit"
was invoked.

$ bash --version
GNU bash, version 5.0.17(1)-release (x86_64-redhat-linux-gnu)
