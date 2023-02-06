Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D554C636D3
	for <linux-dash@archiver.kernel.org>; Mon,  6 Feb 2023 15:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBFPJB (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 6 Feb 2023 10:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBFPJA (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 6 Feb 2023 10:09:00 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C87A8A56
        for <dash@vger.kernel.org>; Mon,  6 Feb 2023 07:08:59 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id w24so4532158iow.13
        for <dash@vger.kernel.org>; Mon, 06 Feb 2023 07:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=043nUayq0buKFMqxR1rr0n0jqgZbJQGRW/CO/pY9wKI=;
        b=nHOB+mh3BFFzN/C/vPCRVLHlMP0ZKLpHlBJsSMdo8LByLrg2Sz5bBbQ0KWpt7N7fG9
         tW4mHkjr9J1YAguNU6+hbvtOib7B/OwIWr9D/imz9FFl0PxNDs3qF4IwP9x6/2Z23lZo
         da8sL16ZxB0Ah0osxjpjxa+sCJU0H7vKKHrxlR5BDzxNIe7FVlAdr4cdRSL/WA3CprVF
         L+gVJMSjDws6o9TalaqqmXMi79ub6Dje/FglszehxzeXBFsqgbvAz04urSwoQUasC7Zv
         WFiUh/SgNueWtErPeHSdXL1+tl3Cmxg6wdP0obJrl/Yo+a0TL8NOL7HG+wYvxi04JtjK
         fBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=043nUayq0buKFMqxR1rr0n0jqgZbJQGRW/CO/pY9wKI=;
        b=IJSDXXMmwYHH1xjwm9dhrN8azAbEDPM9NsWgEwRe7AjawYTxjiHFCCnYNZxJjlsMxS
         tfs0xDO7BjF0jN2Aj+EOQDV2xgFVStSgbYno1oZi7QtDe5Lz18nLaVCf1hGAnIxL2Rdn
         LDWMRe6lFwoSoR8Yhvb1Zap/uu1zwV8tDg8LKid1dYVKgbKOMj8qFe7HmWU7IOCpR4Rs
         6uWohmfqx36J27oWp6eeptJO/Ba1diY41NKOsiFPn2ghMnJcL6Ums3CaZrSebCMiKMLH
         TdTnTLLmYN4Tgzw4EkqTo9uJGsuEb0Vjxy71+iezKZYkeBFBZgxUDf6MQ5kaybYGJUUw
         IP8g==
X-Gm-Message-State: AO0yUKX8MOmjTDc4HJuMKnOI7Glj2Ese/kA8Fjc0KxhSGAQXPSCc5P6E
        kHFxKKS3LRRWcbK/aPsYv8S1UB25Vyw4fC2zkuOBdraShPRbBQ==
X-Google-Smtp-Source: AK7set+ChvPUgnLncySCJrRhcmb/Iez6qSPvFsixJg8uDVt7kMBl4CGLKSwaoTMtLdI/v6vI90ORCmp8gnkRtOpkDYE=
X-Received: by 2002:a02:a40a:0:b0:38a:4b1f:f69b with SMTP id
 c10-20020a02a40a000000b0038a4b1ff69bmr5196240jal.4.1675696138592; Mon, 06 Feb
 2023 07:08:58 -0800 (PST)
MIME-Version: 1.0
From:   Subhaditya Nath <sn03.general@gmail.com>
Date:   Mon, 6 Feb 2023 20:38:47 +0530
Message-ID: <CAPHxB8twYdk0v_m-kwQw3crRdNTditd5U10mk7SR8WTdt2vhcw@mail.gmail.com>
Subject: [PATCH] options: Fix getopts handling of colon in optstr
To:     dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Putting a colon at the beginning of optstring to silence errors doesn't
mean that the colon is a valid option. Before this patch, dash treated
-: as a valid option if the optstring started with a colon. This patch
fixes that problem.

Test:

    getopts :a opt -:
    echo $opt$OPTARG

Correct output - ?:
Invalid output - :
---
 src/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/options.c b/src/options.c
index 2d4bd3b..8593710 100644
--- a/src/options.c
+++ b/src/options.c
@@ -465,7 +465,7 @@ atend:
     }

     c = *p++;
-    for (q = optstr; *q != c; ) {
+    for (q = optstr[0] == ':' ? optstr + 1 : optstr; *q != c; ) {
         if (*q == '\0') {
             if (optstr[0] == ':') {
                 s[0] = c;
-- 
2.39.1
