Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EECC433ED
	for <linux-dash@archiver.kernel.org>; Sun, 16 May 2021 08:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E789761183
	for <linux-dash@archiver.kernel.org>; Sun, 16 May 2021 08:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhEPIsj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 16 May 2021 04:48:39 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:33661 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEPIsi (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 16 May 2021 04:48:38 -0400
Received: by mail-pj1-f46.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so3172148pjo.0
        for <dash@vger.kernel.org>; Sun, 16 May 2021 01:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=EOjfmDSzZup7wsnpqhDN+WPqIZR+LSUTV9mxACAv8U8=;
        b=otMEyBDkDpgjj90jpawp29ucYEyjfyFslzGHjZiak9f04tmdxZJOjCSVdA/uepGo1e
         bSGjOyFwj7KIQ2pBEJGjv8g0FDKKOY4w31Hw3DVtnBy/FuIPH9fEPykPd5Jn1h0zRTkH
         WLqEETSATStgBRso5EByjhnPAb6GI5Me5++Y8wbjSE9COALUL63FQZJkWho4bNPqjKIs
         p2FYydHTnQkeDs0mm+3Q5BJ7O0kJRObVsnOY1i2Xfr7RCZBjuk49+XyryOO6Vq0PZlpe
         GSMbEQQi0pyt7ODg2z9fxKqHnOj+myuwHscO6obpNgtEGxrn7wAHdfZY8X7KxaDqFQWW
         fG5w==
X-Gm-Message-State: AOAM5339yG8yi/yeTi/YABV0lknOiM5SWqAF0LFvzIdymKqQCgJi+0TB
        qT0nJG2iSJa8WP5PMwcJr0CxZQIm53g=
X-Google-Smtp-Source: ABdhPJyPdjOil0PzIi0xIlURmcIXYZ7aThjn35IaYp6SYvu+k2/mX3hLMe4OH/fbHO2UCK31t2jl1w==
X-Received: by 2002:a17:90b:3118:: with SMTP id gc24mr10735759pjb.169.1621154842871;
        Sun, 16 May 2021 01:47:22 -0700 (PDT)
Received: from smtpclient.apple ([2601:647:5300:10fc:7558:1468:8ac7:fd86])
        by smtp.gmail.com with ESMTPSA id c4sm7316981pfn.48.2021.05.16.01.47.22
        for <dash@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 May 2021 01:47:22 -0700 (PDT)
From:   Saagar Jha <saagar@saagarjha.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Configure check for stat64 does not work on Apple silicon
Message-Id: <BAE642E9-DFE3-496D-8520-394443D0F24A@saagarjha.com>
Date:   Sun, 16 May 2021 01:47:20 -0700
To:     dash@vger.kernel.org
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

I’m working on getting dash building on macOS for Apple silicon. On this platform, stat64 is not available:

  CC       cd.o
cd.c:99:16: error: variable has incomplete type 'struct stat64'
        struct stat64 statb;
                      ^
cd.c:99:9: note: forward declaration of 'struct stat64'
        struct stat64 statb;
               ^
cd.c:135:7: error: implicit declaration of function 'stat64' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                if (stat64(p, &statb) >= 0 && S_ISDIR(statb.st_mode)) {
                    ^
cd.c:135:7: note: did you mean 'stat'?
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX11.3.sdk/usr/include/sys/stat.h:386:9: note: 'stat' declared here
int     stat(const char *, struct stat *) __DARWIN_INODE64(stat);
        ^
2 errors generated.

(If you happen to have access to an Intel Mac, you can reproduce this by running configure as CC="xcrun clang -arch arm64" ./configure --build=arm64-apple-darwin --host=x86_64-apple-darwin.)

Even though stat64 is not in the public headers, AC_CHECK_FUNC will “find” it because the symbol exists at link time for the test, even though it is not meant to be used. What do you think would be the best way to fix this check on this platform? Would it be preferred to check if the headers contain a declaration of the function?

Thanks,
Saagar Jha

