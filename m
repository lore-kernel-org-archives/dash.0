Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E637AC43381
	for <linux-dash@archiver.kernel.org>; Mon,  4 Jan 2021 12:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB472225E
	for <linux-dash@archiver.kernel.org>; Mon,  4 Jan 2021 12:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbhADMXW (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 4 Jan 2021 07:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhADMXW (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 4 Jan 2021 07:23:22 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F138C061794
        for <dash@vger.kernel.org>; Mon,  4 Jan 2021 04:22:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v1so9983597pjr.2
        for <dash@vger.kernel.org>; Mon, 04 Jan 2021 04:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dZ1lu5D4fvh28U+nR5PqDfPb1L4u0HE/WwZNWcjNz2Y=;
        b=BeqxEYMojX9tpsWn4e0jtLG6T97Vg/Rf+VyOCtsdykQEc6iCz9Va5QBOvGm3FBuyAz
         JGvXjyuTmh7Yqv/sWUMZaNH3Z9hoWHuS39ZYmMcG7viSRFL++8ylHO5tfTkhjypjkm+Q
         1fTpTvzIRz2psN81StSy1uunkj7RnZvtGOSaoPeKhEU6tS2ErUGcv/BFdpvrtbXn7Blz
         Pb2bceVnzIaFknZM3kH/j5hUu/eGORlInMD7LQCXp6VhHHjsQOBPhOluXUeJJ6Y7jGHr
         kIAl8maVaYMsxpokqwcxj/XopCm1Q0ZqfJaIUjajn47tdr9CgQdNcQyqOFM0YZRJQzDC
         09fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dZ1lu5D4fvh28U+nR5PqDfPb1L4u0HE/WwZNWcjNz2Y=;
        b=YRHVPFHLWtgpp0H9oPYboygsKlXdFEsSg3G4sws8ZTru78HKjPTRGpSH6eN6mUeE+L
         k0VkOu0hlfN+IrXq8uhYOEuXYjvgVXLjH4FbQuBELq4Ze4GeNUQUCpJETHCUBCb68mpU
         ziEkHDDt2AvSBqtLeHJhz0bdsAJcP3xiw7SNYw4cvbMH8XeNaLgxHMzREWERNQqY18o6
         tk+ErllgSqYw5haExVxb68aIUEnJotJvQiEp/c1B6kHELBekePV2SpkSoIwR5Ag7QzAB
         kDskM7ygVrV2s8L97vhd0/7R+3y/ARiFHuiSJ0f3rvJnKPE2hUPGwasZ73stXcUcmyVz
         OG8g==
X-Gm-Message-State: AOAM533ZKj8ocwKjGW8ioOBTq1R7+jT/1IXSIMD0GlQGo56GQcNVx42k
        qAlMvYZ3Vp8uaK5/9qFsXPQpicyVf8XX2VMpkIbQmb/+cu4=
X-Google-Smtp-Source: ABdhPJzLARUVAyecS2l1PuXrIUa7/gFagJY2Muk/ad/tIr/TVxjfhXmNCAskEQRGSaAGmL+vt0YKefz+ePFr/CSBtjg=
X-Received: by 2002:a17:90a:ca93:: with SMTP id y19mr30156506pjt.71.1609762961679;
 Mon, 04 Jan 2021 04:22:41 -0800 (PST)
MIME-Version: 1.0
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Mon, 4 Jan 2021 13:22:30 +0100
Message-ID: <CAK1hOcPjYpXa8GQsD5dmYnkUHqc_KC2BXj0NC6d49qi10Qt4kA@mail.gmail.com>
Subject: set -I is not required by standard, and does not match bash
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello,

In dash, set -I is a short-option alias to set -o ignoreeof.

However, bash does not have such alias, it has an undocumented
set -I which switches off "invisible variables"
(I don't know what that is).

Standards do not mention any -I option.

I propose, in the interests of keeping things less disparate,
to remove set -I support from dash: make "ignoreeof" to be
only an -o long option.
