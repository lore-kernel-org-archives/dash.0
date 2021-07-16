Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267F5C12002
	for <linux-dash@archiver.kernel.org>; Fri, 16 Jul 2021 09:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02549613E3
	for <linux-dash@archiver.kernel.org>; Fri, 16 Jul 2021 09:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhGPJvA (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 16 Jul 2021 05:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbhGPJvA (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 16 Jul 2021 05:51:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867D2C06175F
        for <dash@vger.kernel.org>; Fri, 16 Jul 2021 02:48:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id go30so14242216ejc.8
        for <dash@vger.kernel.org>; Fri, 16 Jul 2021 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xI/Z+QgJbZb2/oQku7JJh92+fYfLUH4lBW8R5JZmDI=;
        b=ugPmKRGUUixx+577GTH2/YKOIuCFc0MoxZRme9+L8jxtfr+2MxJ1iPYsW5NcB/vJNu
         Zm1GvF8tZQXkEhfWYUvWHadjheTMA3rvK8EgO1Q7kSukJqQIAk0kgM/9jCDpNnmvSRtE
         CvtJw4tqgmmdL4TTCwMcBvtkbvTjBHkE3mSEowHqUSSuztXDk7pah30V/4DZMj/iVZgl
         U2plpAskblVvj9R34lN9GTfJLjDGICQZOEPpduHT3b+o6xZdXaqYLZm3mAsRqVBmx4OK
         UZ1SYBAgpZDaSUfWrHGALiaBpeiNsw4ZsnprrPjDC3TepYvbPAhoYGI7PF8BN7HfvDhj
         lnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xI/Z+QgJbZb2/oQku7JJh92+fYfLUH4lBW8R5JZmDI=;
        b=La0kJYZyt/KMtyJdBwPzWZ4K4VTA7ngOYyd/bJ2i/dpo3nk6XSKWNm/e1HW9nF36+E
         jfeJeIFwgqAMINTc/glVAjqcFSMfwHV/cp+dqVeHLW+nZmiIvqmEPddha4nMGDqrAPVY
         qmXl85dvjqCt1c87xRGwhEZQasgyn0ivKHPglectU6oztjhVSQzA0usIuYH9/OPxS5On
         uqrjUjTFXFwVLEekigZ6xUyEH2uBXv6q/D6gW/dAp6SWZ24w37hkgNeSHRMYqM7IZCbC
         zr1icX4TTmia40U/zuIRQWKTNj7lcVlHqeZcU28lUswwD2ewjQx+LhEVRZ7EfhuRPIQX
         6YDA==
X-Gm-Message-State: AOAM532TNJoBzChUL50OUCCz64tuu7Gs4nS/yXHDyeNbJLZ0a5cKlRhU
        w82l4YJ2sGw9O72wD2Z+0KGG86T7q27ljQyO
X-Google-Smtp-Source: ABdhPJzLzxBItFHrAkedZsgSW86sqEPnHNKNUFFB+zNBqyp+QkpVZN+6vVauNqmUSHTP6vRNmFeO6g==
X-Received: by 2002:a17:906:4784:: with SMTP id cw4mr10777806ejc.160.1626428883156;
        Fri, 16 Jul 2021 02:48:03 -0700 (PDT)
Received: from m553ia.mscalindt.qq ([213.149.150.118])
        by smtp.gmail.com with ESMTPSA id y6sm3470852edv.88.2021.07.16.02.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 02:48:02 -0700 (PDT)
From:   Dimitar Yurukov <mscalindt@gmail.com>
To:     dash@vger.kernel.org
Cc:     Dimitar Yurukov <mscalindt@gmail.com>
Subject: [PATCH] expand: Recognize '^' as a negation character in BE
Date:   Fri, 16 Jul 2021 12:42:27 +0300
Message-Id: <20210716094227.15177-1-mscalindt@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

While parsing bracket expression ('[...]'), DASH recognizes only '!' as
a special character for negation/inversion, but POSIX specifies '^'.

The POSIX specification (2018 edition) states:

  ^ The <circumflex> shall signify a non-matching list expression when
    it occurs first in a list, immediately following a
    <left-square-bracket> (see RE Bracket Expression).

DASH:
    $ i='123 asd' && printf "%s\n" "${i##*[!a-z]}"
    asd
    $ i='123 asd' && printf "%s\n" "${i##*[^a-z]}"
    <empty expansion>

BASH (with --posix):
    $ i='123 asd' && printf "%s\n" "${i##*[!a-z]}"
    asd
    $ i='123 asd' && printf "%s\n" "${i##*[^a-z]}"
    asd

Make <circumflex> ('^') a special character used to specify
negation/inversion in bracket expressions:

    $ i='123 asd' && printf "%s\n" "${i##*[^a-z]}"
    asd

Signed-off-by: Dimitar Yurukov <mscalindt@gmail.com>
---
 src/expand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/expand.c b/src/expand.c
index 1730670..06392ff 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1565,7 +1565,7 @@ pmatch(const char *pattern, const char *string)
 
 			startp = p;
 			invert = 0;
-			if (*p == '!') {
+			if (*p == '!' || *p == '^') {
 				invert++;
 				p++;
 			}
-- 
2.32.0

