Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115FAC433FE
	for <linux-dash@archiver.kernel.org>; Mon,  7 Feb 2022 15:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiBGPqN (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 7 Feb 2022 10:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbiBGPgS (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 7 Feb 2022 10:36:18 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD66EC0401CA
        for <dash@vger.kernel.org>; Mon,  7 Feb 2022 07:36:16 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a8so43187882ejc.8
        for <dash@vger.kernel.org>; Mon, 07 Feb 2022 07:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=kNxENo51WeMkYgm4PDe/UFL1PIFo9C9ymFl2C6gNL3Y=;
        b=Q7ZIyQyG9jTPNGk5f1vzgozdtK38UN9Cg+rbT3DjsczRt9pZe6GBKmffNa5BrLro7c
         yNIBQDwSeFv12ZV51lcHLQ2NxfLmDBAwMq2/cY27A4/eerF0fdlm58ulwaJu6qfsVwVl
         74Cb+GLENDOaZGivWJnseyoh+7GhXQAkZEkI5MewjwfBd6wcWZwOboTHhxiIEwZm2FvT
         UcUVW6atZilkoaDFoMjOQWCBAhJLF8o0Xs4yaK4ewqHofWKwk4/nyFh2XSWkPLT0vRCN
         zT7dxovnKTDHuQoWmznwYKjGIo+KY1s5UCBWD52+KYJHt4ncIa7jNSmIXUJSHr8fGLkw
         iZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kNxENo51WeMkYgm4PDe/UFL1PIFo9C9ymFl2C6gNL3Y=;
        b=kxZEGkPeAFRJbhdTMCNvwaD/wFp7xv2L/uDYCqsJZ+yowSVQYevfEvwBkSXiL4XZCh
         OvBn6w3hADHmlfp+8zTHP5uGcrwiL4fvu/ez3Ids9xSpu3H/8LyUicvV+ZbxDJVSJzWQ
         F/5wRdyBpDR2N4KMCCh8OOEFQpAtkx5vf+E0W9cVcUJl2BVR324ikwPmviw4rxDUbgmM
         vcrgyACDP9lbZrFQb9U64PQdQEtv4eMCRa3zqs2q/fgtqlYPMEkua66xABfMSJUYgnkI
         cbhNCz5O3SykgpS8+qvGtAb4sPxIsUHiR8hsUHVMiTggz4Ns/Q/krSIXjquUK6e6K4dd
         zBvQ==
X-Gm-Message-State: AOAM533gIyVBU6dECHugDqAz8ynV8t/Qyw5euMJP5q79zwfExN+BxV/w
        aJMZhrDbuPkTrPopld5JUXO3dzWelLcgz9vr+zpGyBpqKlc=
X-Google-Smtp-Source: ABdhPJw79y1cpSlgj76II3rUx1CxOjddqU27AyOuIQq3zYEGE0AsIgcE5OPu5jq9cgg4h6tN4Am3igj94mgkZ6RmgUE=
X-Received: by 2002:a17:907:3f93:: with SMTP id hr19mr246305ejc.594.1644248175044;
 Mon, 07 Feb 2022 07:36:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:9815:0:0:0:0 with HTTP; Mon, 7 Feb 2022 07:36:13
 -0800 (PST)
From:   Subhaditya Nath <sn03.general@gmail.com>
Date:   Mon, 7 Feb 2022 21:06:13 +0530
Message-ID: <CAPHxB8tN-aCb1vUTPPWqakyA5wVJfzXXQrr97fPE00fTQPuwkg@mail.gmail.com>
Subject: ANSI escape codes in printf don't work
To:     dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Run this -

    /usr/bin/printf '\x1b[31m%s\x1b[m\n' FAIL

It should print FAIL in red foreground color.
It does, on other shells.
In dash, it doesn't.
