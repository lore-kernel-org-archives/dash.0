Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D99C433F5
	for <linux-dash@archiver.kernel.org>; Wed, 13 Oct 2021 19:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B0A611BD
	for <linux-dash@archiver.kernel.org>; Wed, 13 Oct 2021 19:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhJMTTk (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhJMTTj (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 13 Oct 2021 15:19:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14948C061570
        for <dash@vger.kernel.org>; Wed, 13 Oct 2021 12:17:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id m26so3366165pff.3
        for <dash@vger.kernel.org>; Wed, 13 Oct 2021 12:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LI+bbaE5k82cT/Dittuq0rCTKDK9ehvMb4sfHMW1ecM=;
        b=hXjxhUMMqfJJU7w21dcqH+f2b+NADrV/qGa4ZDGShQWojRRoB3fBuZtEFLLX0ISts/
         /fl3Ibj6HlhaNVWbtrGXcHY4qQ4B64DDOEpPAPXpL9Wkw17l+LTr4c3S/2cygvrfDPi/
         PzSX+9lWd/331B8ox91HVcEqPaNXQykgzcmLIX3hoqhEqjIzhLfbsdStApiJeKWTl4rB
         fqyH7Gn1DpquDQjEKth5YW1tTGetZSgEKIbUk2R0RoHZ7Gx9eKKzM0RcDP0XMDt4A/Dk
         qRgy64kZjk3KYjR3J4L0CM15+j+fXywUzQ+SG1IgZipCGzcvUNZTmVTOEBAkgkrl4YNs
         DZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LI+bbaE5k82cT/Dittuq0rCTKDK9ehvMb4sfHMW1ecM=;
        b=SD7ibzqNaqzYhFWJXsSRxmQ1wpI8P9K31khvn13W8koFnRJXBqa4t2XAylV8p9JtIP
         i0ZBWpoMgx0MC0aNcZjnRjVCuT3Jq4110nDdSNgzQXcnMfllK5IFdG/N2cWScxRHBdwf
         wRU0Sl6bjHNSlUjrBQxIcx+HG4u+38s0qp2h2U433GUVtwlXzAP66TYUea0tAvQlXwIZ
         WTHOQKWwfdLscBA0kmnQg6lByv7L7h8SlGae+lYZxkv1OluKBd0taBtKXDGYmDfktKVf
         3Gzc144KhYFLdbtARR5GSTIyV3QHfTOP6l44FBTtBbfMOb23lnfSuZvSI1lBsCr1Bta5
         duBw==
X-Gm-Message-State: AOAM530PlWBafF9Nkr9EOLDyOp759gdYym3F9GWdE+o/vjiakxSqqYSz
        Hk87HlzoOSMXjcZPi8caJ/j6Q9Tu/cLRyTNvqVDRb15xGs0=
X-Google-Smtp-Source: ABdhPJzfQ8160Aekl1+otUeuUMsgooz/QnTyL2WrQJ6zW1y+eGag+x+Y2LANSOJvoa6MBQySbV05GidbyQVGfKyoC7k=
X-Received: by 2002:a05:6a00:1a15:b0:44d:a80:a194 with SMTP id
 g21-20020a056a001a1500b0044d0a80a194mr831917pfv.78.1634152655556; Wed, 13 Oct
 2021 12:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAK1hOcNgTbRgWVjidA63NJqa4_+ExRuE5XpSM14s5VGw2eQT_A@mail.gmail.com>
 <61f9c77a-b8c9-d25d-c72d-34e342917f58@gigawatt.nl>
In-Reply-To: <61f9c77a-b8c9-d25d-c72d-34e342917f58@gigawatt.nl>
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Wed, 13 Oct 2021 21:17:24 +0200
Message-ID: <CAK1hOcM9mQnbsgGz47fYr+A059hr1SW++_25_cGCdVVFfnofUA@mail.gmail.com>
Subject: Re: $ENV handling depends on defined(linux), why??
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Oct 13, 2021 at 11:56 AM Harald van Dijk <harald@gigawatt.nl> wrote:
> On 13/10/2021 10:39, Denys Vlasenko wrote:
> >                      Who in their right mind would have a *setuid*
> > shell executable on any system where security matters?
>
> I suspect this was originally not for the benefit of setuid shell
> executables, but setuid shell scripts. Linux does not support those, so
> the check is considered unnecessary on Linux.
>
> However, actually, doing something along those lines is useful even on
> Linux when setuid applications can be tricked to launch shell processes
> in insecure ways.

Not sourcing $ENV is nowhere near enough to ploug this hole,
so doing it is still pointless.

> bash implements "privileged mode" which drops shell
> privileges except when the setuid application specifically requests
> keeping them

*That* would solve the problem. The code I talk about does not
solve that problem.

I propose to delete entire #ifndef/#endif block.
