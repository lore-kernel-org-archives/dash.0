Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48925C433E0
	for <linux-dash@archiver.kernel.org>; Fri, 29 Jan 2021 18:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF97D64DEB
	for <linux-dash@archiver.kernel.org>; Fri, 29 Jan 2021 18:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhA2S1q (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 29 Jan 2021 13:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhA2S0Z (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 29 Jan 2021 13:26:25 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D929DC0613D6
        for <dash@vger.kernel.org>; Fri, 29 Jan 2021 10:25:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j18so7548936wmi.3
        for <dash@vger.kernel.org>; Fri, 29 Jan 2021 10:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=WdSpUQ5vKKEdsFn7nK61XD28FxwLhBJF+DURL0xed2g=;
        b=X+l1S3U9ObMb10VpRR1ADmkIplffQNKhtR5TRTYI80t07xKnLMc6bqMX15TZFpD86B
         rMRurTFS2qTMgFpc/LKozTLDrGBDvrIOw1a8tPqJMrooZ4ZCn3Fzy1NOoEUcjJB1dZJ2
         V6NY4ulmINCbDXStK4eZC1d7LuhCj8cuIynkI65QH7e1ejBcAWrLmklbg6eFkcFO/MAY
         jQ1IWLFtHfrRSnnToEb/YYPiAyps/mwmKo9EqZtx4M2oDq0z/iVqirhBEkChWUD6r/tU
         qgcLHbcW2Q+d+U7ovzONbRb3DzENz9xWbtXEx7yj4KfqXPYhHJe5q06Yk6B+wVfRNSO1
         r43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=WdSpUQ5vKKEdsFn7nK61XD28FxwLhBJF+DURL0xed2g=;
        b=aDX/Gdmh6fuOA3IXYwTzvxv58F+FeDWy1CEbCbl9bfArK+0PfovOiiVaVHCg13srMA
         4GJS7M8S5RlP6USchIzOXISdKzEFW2kllL8nOxWwJckLlDAWtgGap9ykDRcnoe+FFiF5
         dPsWp/bYiSU2bJGbDCyXi7+qCaqYP9r5Xvr9NbsMR6RYejshxU3S/c5/tckEf7D45Rmn
         lHwkkt7gQo1B53/vUc0SVEnVlk2/tjLxbv4PNOBpyNuqqNdLuaKrmFUqrGdq42cwX/u1
         OsNb4jV3Sfs2rx8i3xCatCH9gomPzMEDE65ueZorFLMnsSD2Ske7c0AYt49t9rUZa0p1
         uO9g==
X-Gm-Message-State: AOAM533L7xmsYB2KwZa1uiB240fEpRIHTgM7juFUtHEgHrfNnuHZP7PF
        fMY+ujSDgBnBz6ry+Dregw==
X-Google-Smtp-Source: ABdhPJwBXAZoMXQQFA9/nEBqrtwSxuLobws/GHRLpz5cwtSCbUwNSPtfXS5xKtGw+sJ83bMhaI8mFw==
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr5255266wmj.48.1611944737112;
        Fri, 29 Jan 2021 10:25:37 -0800 (PST)
Received: from teapot ([78.143.195.205])
        by smtp.gmail.com with ESMTPSA id r10sm10630065wmd.15.2021.01.29.10.25.36
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 10:25:36 -0800 (PST)
From:   earnestly <zibeon@googlemail.com>
X-Google-Original-From: earnestly <zibeon@gmail.com>
Date:   Fri, 29 Jan 2021 18:25:25 +0000
To:     dash@vger.kernel.org
Subject: getopts appears to not be shifting $@ when consuming options
Message-ID: <YBRTFXGM6pLwR5hg@teapot>
Mail-Followup-To: earnestly <zibeon@gmail.com>, dash@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

In this example dash will repeatedly append 'attr=foo' to the list of
parameters in an infinite loop:

    #!/bin/dash -x

    while getopts :a: arg -a foo -a bar; do
        case $arg in
            a) set -- "$@" attr="$OPTARG"
        esac
    done
    shift "$((OPTIND - 1))"

Instead I expected this to result in parameter list containing
'attr=foo' and 'attr=bar'.

This works in all shells I have been able to test with the exception of
busybox sh:

    * sh   (bash)
    * bash (All versions from 1.14 through 5.1.4)
    * mksh (MIRBSD KSH R59 2020/05/16)
    * ksh  (93u+)
    * zsh  (5.8)
    * zsh --emulate sh
    * heirloom-sh (bourne)

The only workaround I've found is to explicitly use `shift 2` in the a)
case and obviate the final shift using OPTIND.  This will unfortunately
break every other shell.
