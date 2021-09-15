Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB65C433F5
	for <linux-dash@archiver.kernel.org>; Wed, 15 Sep 2021 19:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9788760F13
	for <linux-dash@archiver.kernel.org>; Wed, 15 Sep 2021 19:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhIOTss (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 15 Sep 2021 15:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhIOTss (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 15 Sep 2021 15:48:48 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73B5C061574
        for <dash@vger.kernel.org>; Wed, 15 Sep 2021 12:47:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id i19so2884682pjv.4
        for <dash@vger.kernel.org>; Wed, 15 Sep 2021 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2oKhRnwwlo3AWUS2/juTrw/tRRl0nGbLW4DQhGo3yjc=;
        b=aW9fbPp0RBreCLHajl0imcHjgJ9oBP8dcgW/HOFig1yeDXuNtgxWwnUEjUbltNd9Hn
         ukesdH8/oE+Ttl2d55Y2fR78zQh7upZRVaLrsfNQiJHRRLZsR2Blzydi+z+f/G9GzhaI
         gfe1pjdduBNejCS5qtoqN+GvpEzu1cmtaTQ7IRzDrrVfumijSw1vp+SyTc930CzcAfpa
         zhfzA3Ktx/tHGEaX0M5XmQChNXGiDRrT5OD7aarw3N1nHTQd5poTwu4yV/cEsDpzFYO8
         Nn1mOrC+4w8Wxqq0b7L2J4mYzFYz7fmcTD5PuA+JDul0L8/FyEMrpQmbL6cXdzkl7g9v
         oyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oKhRnwwlo3AWUS2/juTrw/tRRl0nGbLW4DQhGo3yjc=;
        b=bnw+muVdcQRc+Kjvpjqux6vIh8AprvE65AgjPSr/upA53OmFDk3EN1h3xEOHAAdwT9
         qqzNiHJdfKSsZLqjoC40WVLL2CK51ApOehBHqVt6W6Q/wRM645p1R1+esWXfOcme/qOF
         Nvf7WI1uL4cxKOucmwX5gOfwMgrOBMVqvxXmNnEdvIF70OC7IIjBX3SA85CtZTkSgDnY
         Lln3bzgnYhxVUYBC1mTYtIDECf3kAls7/yNeaRCNflT8kWJZDI0h8xvP8yHjQyTy9OOV
         9E5cFyPhIMaWmRxAxnxpcDgUehJvCJSosMPCxE0Fuf8XlDx6LOpsKFu++hBvBw49q9ex
         rxeA==
X-Gm-Message-State: AOAM533zJE4FeIqxrV9rNY7PzaXS8VivoTW012Na1ck6D1CzB5DjKHiE
        p05BAjETbqi6vuDIQoVrKXy7Q28d7CVJDQ/bT2xwf0qo1kwHtg==
X-Google-Smtp-Source: ABdhPJzL0Xyb9vEeDi8yrVBXUdSGDSzQVPSF5gxmtMzMwoTS8/T8F7ph+I34zNX4rTRWNm3CfUTnLqxU9RrrTwczk54=
X-Received: by 2002:a17:90b:1b45:: with SMTP id nv5mr10241529pjb.222.1631735247969;
 Wed, 15 Sep 2021 12:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJGKYO4i85vGboyucxhJ948xZYxrBjoj5PtAO0eB3TEWW8QpzA@mail.gmail.com>
In-Reply-To: <CAJGKYO4i85vGboyucxhJ948xZYxrBjoj5PtAO0eB3TEWW8QpzA@mail.gmail.com>
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Wed, 15 Sep 2021 21:47:17 +0200
Message-ID: <CAK1hOcOVuR4i0FgEOF1AdTA-EbdJyOTLNbViGxT0zwHceZGt-g@mail.gmail.com>
Subject: Re: shell script error management in busybox ash
To:     "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Cc:     DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Sep 15, 2021 at 7:48 PM Roberto A. Foglietta
<roberto.foglietta@gmail.com> wrote:
> Dear all,
>
>  Denys Vlasenko, the maintainer of BusyBox, asked me to organise a
> task to synchronise busybox ash and dash in such a way the future
> developments could benefit from each other's contributions. In
> particular this need raised after these patches has been applied:
...
>  Developing these patches we realised that the use of EXEXIT and EXEND
> exceptions complicates the code and do not add any value.

Actually there was no discussion with me to agree on such an opinion.
There may be value in it.

I didn't look too closely, but backpropagating of fatal exceptions
might be necessary to restore foreground process group on exit?
(grep for tcsetpgrp). Maybe something else too. Need to take
a very good look before deciding on "it's useless".


> Moreover,
> the code that these exceptions trigger (everywhere the setjmp()
> returns true) restores some values and frees some memory but the traps
> need the information before the restore, not the restored values.

Yes, _this_ is the problem we are having.

E.g. $FUNCNAME in EXIT trap needs to be current function's name.
With how EXEXIT exception is propagating back in current dash,
it's difficult to arrange for that: the trap is run well after
we leave the "execute this function" dash code.

The solution may be to change exit builtin handling from
"throw exraise(EXEXIT) exception, it will run EXIT trap (among other things)"
to
"run EXIT trap, then throw exraise(EXEXIT) exception
(which _will not_ run EXIT trap)"

> For
> these reason I developed three patches here in attachment:
>
>  1. get rid of EXEXIT in exitcmd() and fix a bug about return value
>  2. get rid of EXEND at the end of evaltree()
>  3. remove the EXEXIT and EXEND altogether

I would imagine if you propose changes to dash,
the patches should be against dash?


>  The description of these patches are simply arbitrary and temporary.

In other words, "my patches are not ready"... why posting them then?


> I hope we will agree on these details once we are going to port them
> to dash.
>
>  Applying these patches the output printed by trap ERR and trap EXIT
> is what was expected to be demonstrating that to avoid these
> exceptions the code became straightforward. We are here to check your
> interest in porting these patches to dash and your will to apply.
>
>  Our focus is related to the patches listed above but in the long run
> it is not limited to them but also includes the following patches.
> These patches have been applied in the meantime that others made
> changes to ash.c as well. The full list of patches and their order is
> listed here:
>
> https://git.busybox.net/busybox/log/
>
>  Other patches that have been applied that might be a convenience to
> port in dash are the following:
>
> ash: eval: Check nflag in evaltree instead of cmdloop
> https://git.busybox.net/busybox/commit/?id=41beb53787ec798a27f336c4758cb5ebd8f0c75a
>
> ash: eval: Do not cache value of eflag in evaltree
> https://git.busybox.net/busybox/commit/?id=f415e21a7dce1d4f4b760fddfaba85c551681e11
>
> ash: parser: Fix handling of empty aliases
> https://git.busybox.net/busybox/commit/?id=30af5938afad076e12b8ece123cab0b8bc92a596
>
> ash: parser: Save and restore heredoclist in expandstr
> https://git.busybox.net/busybox/commit/?id=1c06ddd8bbbd6906e5bf00ec93e04d5090718be9
>
> ash: use pgetc_eatbnl() in more places, take 3
> https://git.busybox.net/busybox/commit/?id=c54025612711a6b1997efd99206b9fbcaa5a29cf
>
> ash: parser: Fix alias expansion after heredoc or newlines
> https://git.busybox.net/busybox/commit/?id=8c68ae8416c8b54222eb3cd1d4908a570147e134
>
> ash: parser: Get rid of PEOA
> https://git.busybox.net/busybox/commit/?id=48cb983b136fb74c61db594a30e18bdc42b7264c
>
> ash: eval: Prevent recursive PS4 expansion
> https://git.busybox.net/busybox/commit/?id=eb607777697f4c5eb2dfd86e5837a8c379f65979

None of the above needs porting to dash as it already came from dash.


> ash: fix ignoreeof option
> https://git.busybox.net/busybox/commit/?id=0beee209778870888c3a80a9ae57e74888bc8e7b
>
> ash: stopped jobs should only prevent exit from interactive shell
> https://git.busybox.net/busybox/commit/?id=50239a665c88f5a95ce41146804500f5da90b19e
>
> ash: let ignoreeof only affect interactive shells
> https://git.busybox.net/busybox/commit/?id=5726df5f94f973eaa097d9853ceff2bd6b748d97
