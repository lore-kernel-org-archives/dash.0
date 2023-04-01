Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F86C6FD1D
	for <linux-dash@archiver.kernel.org>; Sat,  1 Apr 2023 21:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjDAVf7 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 1 Apr 2023 17:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAVf6 (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 1 Apr 2023 17:35:58 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC10DF
        for <dash@vger.kernel.org>; Sat,  1 Apr 2023 14:35:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 94130320093A;
        Sat,  1 Apr 2023 17:35:54 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute1.internal (MEProxy); Sat, 01 Apr 2023 17:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=larryv.me; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680384954; x=1680471354; bh=lA
        jVqQIjPARoEdT/lKPMGeR9DJnBIH+dRftCsxa9g54=; b=WNAuHt/Ozpe92QYFj+
        N2m4sg5yaRYln1FNREZQFVqRfNl2865v8ERhgcVspikdwNCXt6q4BVwrEf+zqXOS
        ARenKjXyQQu08ph9w6ElSL/j0Pdiea+Vas6UIoIE9bBa159f48GZsaZqwlMwqC7X
        9M9CtLwxmNLiTEgxoxpbIrPXXlUYrIdYdckzB0mlCYIqoq8cD8+vE+wYNR88CJKY
        k767kUzLG+cPRsN50+ea20qqsUhA5SZas3KHCKOfMRrjhgCHbxVbbBAgw4ehGFyc
        jzOphwNsck7Fk3rjQSrQm0Vpga8JFOfkW0jzVOupXYkcL+pWq3aKbJPNzYYk3BsH
        kNWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680384954; x=1680471354; bh=lAjVqQIjPARoE
        dT/lKPMGeR9DJnBIH+dRftCsxa9g54=; b=pbHg5+LReOJOBD7997Tl/SkDEZLx5
        dCDfQGxiiNqgMW0ydN5Ytz3j4LbG8kUTGyW+2bfn+9j2w9+z9Zc1yBcrKp3AJwGK
        zfz1nW/HPMvgZxzit8BmlXmWAwiLbS2DPK22n1Y4TY+7aX8u0ZENTfKmRGDrSueT
        y3j4yTXZiL00pN9hssO2X67jHudulnhIZ/h6/lVGwlLh16m76rRWspSZKL0B6uIR
        frRXj15vz2bMyV7LYpHnU0LuaVoddCwdB+k6/kRy/1wxbFpd2dPoHhQ47n98S/Rk
        CgXwFrsmM1djg0xgOkYTKCmIyk/p51Wtij2KfXxIoXwJTVt9pSOuA/Gcw==
X-ME-Sender: <xms:uaMoZFE9x9S2K_7tqJZHJXiCJuSH_JJIvfHOr5IHYsQQaRR76e2cGw>
    <xme:uaMoZKX9jaa3jPIgqmMvbH3dT6Gp5Kssd9NFw5bA0ALO7yJn2s0dXR5L30OXWGK77
    QjlW2JgS2fuBkgz-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeigedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderreejnecuhfhrohhmpefnrgif
    rhgvnhgtvgcugggvlhojiihquhgviicuoehvqheslhgrrhhrhihvrdhmvgeqnecuggftrf
    grthhtvghrnhepvdegudevtdehieeuvedviefhkeejteekhffhffekuefffefgudegiefg
    ieekudffnecuffhomhgrihhnpehinhdquhhlmhdruggvpdhophgvnhhgrhhouhhprdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvhhq
    sehlrghrrhihvhdrmhgv
X-ME-Proxy: <xmx:uqMoZHKV013_J0yJxq23sbisU5OQQOk6Ku8Mz_UY4jwOSwi81LVXtQ>
    <xmx:uqMoZLF5VvFuvJLgOsshTsYeav_6aldz1ZcL8lxVFHZ-MsveJIb6DQ>
    <xmx:uqMoZLWallxPyUTqHwzecAgo73RjDJeWSNtvWVfwQqHU4UrW_ryBzA>
    <xmx:uqMoZMcu3xEMVf3Bx15z8Z0Hg2Oq1cyHIZyRU8MTcqeF5ZV7oSL79w>
Feedback-ID: i0b2842c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EC1F931A0064; Sat,  1 Apr 2023 17:35:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <edae6167-59db-46bf-b655-76b9dc26ce96@app.fastmail.com>
In-Reply-To: <e57e26c4-a37f-37e8-90bf-6f19295eab59@redhat.com>
References: <aad32205-1e0a-fea6-0825-8eb45c6ae915@redhat.com>
 <e69d7554-6047-f527-9489-0d8e872643ae@gigawatt.nl>
 <e57e26c4-a37f-37e8-90bf-6f19295eab59@redhat.com>
Date:   Sat, 01 Apr 2023 17:35:32 -0400
From:   =?UTF-8?Q?Lawrence_Vel=C3=A1zquez?= <vq@larryv.me>
To:     "Denys Vlasenko" <dvlasenk@redhat.com>
Cc:     "Harald van Dijk" <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: Re: Are there users of ash's "pathopts"? Do other shells have such a thing?
Content-Type: text/plain
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Sat, Apr 1, 2023, at 4:49 PM, Denys Vlasenko wrote:
> Just now, I learned that CDPATH is a thing... oh god.
> Yet another danger of subtle bugs in scripts when one
> of their innocuous "mkdir subdir; cd subdir" suddenly
> cd's somewhere else...
> ..and this "feature" seems to be in bash too,
> and who knows where else.

At a minimum:
- traditional Bourne shells since 1983 [1]
- POSIX [2]
- busybox
- ksh and friends
- yash
- zsh

[1]: https://www.in-ulm.de/~mascheck/bourne/#svr1
[2]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/cd.html

-- 
vq
