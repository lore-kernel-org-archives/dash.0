Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307E0C433F5
	for <linux-dash@archiver.kernel.org>; Wed, 15 Sep 2021 20:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A1160FDA
	for <linux-dash@archiver.kernel.org>; Wed, 15 Sep 2021 20:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhIOUYM (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhIOUYM (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 15 Sep 2021 16:24:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB55C061574
        for <dash@vger.kernel.org>; Wed, 15 Sep 2021 13:22:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so5839202pjr.1
        for <dash@vger.kernel.org>; Wed, 15 Sep 2021 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtZ3paUFT88HFBMNSuIhg1ry8xVKW/uGFBo64E9W9p4=;
        b=frqNLsHaH2ZrhHHK1rsMYnpq4v/2RnC9XIHjO2b6BEPWhyxsPYLt/6prDPqTqGOvdE
         u/jJpCfV/CT9BmKyoYmc3zUz7heOVlVDvrZjg/0tev+DPCLnMK92UdRlk1Rgg3QwRpmI
         VSBCuojPfcJtxCpjGRefYMe+U5IhUB/tO6Dqb6wTrLFK+vg9toeJm0gF/ji7deekf8em
         unQtEKxWEFFJp/DgSfeIivbMv7TOkh1go53LNEp7GWh5uTwK1x8T4c/F/7T5Ublzu3ta
         rlJk8k5kfejDipDem2e1XpmxKoKUremKXJrSQ3M9rM+CFo7uMJmT2anq9LYuk9xBg3BZ
         a4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtZ3paUFT88HFBMNSuIhg1ry8xVKW/uGFBo64E9W9p4=;
        b=Jefi3A7siOYh8eJNBqsryqXpcqgnx4C1yDLk6boJbX4Bh0KE36Wj07VbkD5jSEEhyG
         OrZ//15E+OC/r9ktEOTE5cffSDxIRL5k8G/utcl79JvYHCVsXnRBsc4cY8rHOQsL4J+D
         9BltS1LmYFa9ZLE2Jc5jRahmRvt51lYm7KiEQDFZsozY4rcHkOIrD5zRHzYGvFycN2BG
         TNirgrzwPM+8O9scGiR3g2gF4rVaSFuFT6qf3uQZsC3AxxH9q8t+LpEshLNNRB36nFXg
         3lLwGPGeJQ1cD40XJ+TrjCV6CdcFimuRTkEJswxujnmDcLtV8yodTifCUEtD2k0/QtOA
         EJtg==
X-Gm-Message-State: AOAM533KBUYbk26pZj+8rketz3YA0WWg7AIWmo9FIEik7YMxMqrG81q7
        Hkb8ly1JDNsbKpC5zt7sjGnXsqkT5uy0nfJPL3U=
X-Google-Smtp-Source: ABdhPJzjmxTkMI3liHxdzNvGwielu27QQCe66MtMCJcQ/fidqLjHOQb6KDBUIsS9szBw3CopoHFvLLS5mtL7iwBAQzA=
X-Received: by 2002:a17:90b:1b45:: with SMTP id nv5mr10383946pjb.222.1631737372706;
 Wed, 15 Sep 2021 13:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAJGKYO4i85vGboyucxhJ948xZYxrBjoj5PtAO0eB3TEWW8QpzA@mail.gmail.com>
 <CAK1hOcOVuR4i0FgEOF1AdTA-EbdJyOTLNbViGxT0zwHceZGt-g@mail.gmail.com>
 <4dfc717b-93dc-7e63-3ede-f8a8cd977413@gigawatt.nl> <CAK1hOcMNcgRVm7aqYay22dKAkVMOmWJiDrp2MTmYw+k+ez=GoA@mail.gmail.com>
 <6f4b5c87-a7ef-a80b-2230-de4c7d540318@gigawatt.nl>
In-Reply-To: <6f4b5c87-a7ef-a80b-2230-de4c7d540318@gigawatt.nl>
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Wed, 15 Sep 2021 22:22:41 +0200
Message-ID: <CAK1hOcPMDnxZZ=cpSR-sVnfA8Cdno_QFO=OT6QXRjOKOOEPSQA@mail.gmail.com>
Subject: Re: shell script error management in busybox ash
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     "Roberto A. Foglietta" <roberto.foglietta@gmail.com>,
        DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Sep 15, 2021 at 10:16 PM Harald van Dijk <harald@gigawatt.nl> wrote:
> >>> Yes, _this_ is the problem we are having.
> >>>
> >>> E.g. $FUNCNAME in EXIT trap needs to be current function's name.
> >>
> >> Important to also mention that although FUNCNAME is not part of POSIX,
> >> and there is no spec to compare to, in bash and ksh it does not behave
> >> that way
> >
> > In my testing, it does.
> >
> >> so you're talking about implementing FUNCNAME in a way that is
> >> incompatible with existing shells.
> >
> > Try this in bash:
> >
> >    trap 'echo trap:$FUNCNAME' EXIT
> >    f() { exit; }
> >    f
> >
> > I'm getting:
> >    trap:f
>
> For bash, it depends on how the shell is invoked. When bash reads
> commands from stdin, it prints trap:f. When bash is called with that
> exact same script passed as -c, it prints trap:. There may be a more
> specific option that can control this.

Indeed. In -c, it prints "trap:"

In a script, it prints "trap:f"

Looks quite inconsistent.

Well, in this case I'd fall back to "what would be the most _useful_
behavior". Losing information in which function "exit" was is less useful.
I prefer passing it to EXIT trap.
