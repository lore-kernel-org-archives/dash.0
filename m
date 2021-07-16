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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD346C12002
	for <linux-dash@archiver.kernel.org>; Fri, 16 Jul 2021 12:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B657E613F5
	for <linux-dash@archiver.kernel.org>; Fri, 16 Jul 2021 12:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhGPMyJ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 16 Jul 2021 08:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbhGPMyJ (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 16 Jul 2021 08:54:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470F6C06175F
        for <dash@vger.kernel.org>; Fri, 16 Jul 2021 05:51:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id nd37so14999354ejc.3
        for <dash@vger.kernel.org>; Fri, 16 Jul 2021 05:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IF2erTBuThAxnlms2z3SaNnl4J1SNyPFdU2gnjRUKsI=;
        b=HyUFs/GfzyqDhOEXaR9DyNGZ3OyiHxo2sZ2fz/IGHYKzxH8YFrayNMSwqCmZklzXNM
         JbC3ezbZOpio+RN7bl7BMJKlakhBrIqTKdhcF+IeNg1x/cM1l6ccTO8uv+3FbMCE/K1y
         8Gxf6puMYRDXCEh9+OIXWWpiBZzYC7Zja13NsvJl2UTlcOcLvtAsnlqZDOCNzXE/y7wd
         fKPy1OZYNO5AmtI8L8YWPdJFCM84BvV0N7xlDKWsGQ86MOPTRBkGOiMgPWRX73JDU+D1
         n1581OFHeFAI/BzCkuJCv34X6W3YFLkUgONuMyQft7zARp9s7NuZS0gGLu4OuvLx95FS
         /ajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IF2erTBuThAxnlms2z3SaNnl4J1SNyPFdU2gnjRUKsI=;
        b=oHER0HG4g/4mWivudzL2kyQ3RiLWK9bSEi0jPjsIdizK8SPYuzYHoAhcsywLqUMIp/
         LskpflxMX7bEOY3zhGP9SjqRj9py4kixiek4QFrgTyZrWnJJUbQlA9xMZgF1FS9ue+ia
         8wZUTlsvzY486M0WFO+yZUDs5VF8W7bNfJg4KXQTUCGcPXvgKeF5t8IkPN1k2ST5FuHG
         1bmIvbFa4QP1gzs3T3lNDPh+2lImn3OceRtP5ss7+AB8I8HeUCRCNAsah30fgeo3EhoS
         wv7qbelQElAmmjboyKGGXTgxaxD3qlqZO5Sfut6DG0+5Ppco5aJVFDqGES80waV99tsI
         Qi/w==
X-Gm-Message-State: AOAM5304kAGbb/irfqMqKHKEnAzaOlHgl6Xt/QYdNtAjox4zhWTD7+0A
        UHULX9M8U7cmf/uCEhYHTE0=
X-Google-Smtp-Source: ABdhPJzv7/vtn6jZiGLZQz/DNj6ud7wteSw03qN4XQ5YMRLPaikTj1Vw6/+QcR7V/pWybeM+JiOnqA==
X-Received: by 2002:a17:906:31c6:: with SMTP id f6mr11278664ejf.386.1626439872821;
        Fri, 16 Jul 2021 05:51:12 -0700 (PDT)
Received: from m553ia.mscalindt.qq ([213.149.150.118])
        by smtp.gmail.com with ESMTPSA id c28sm2893854ejc.102.2021.07.16.05.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 05:51:12 -0700 (PDT)
From:   Dimitar Yurukov <mscalindt@gmail.com>
To:     mscalindt@gmail.com
Cc:     dash@vger.kernel.org, harald@gigawatt.nl
Subject: [PATCH v2] expand: Recognize '^' as a negation character in BE
Date:   Fri, 16 Jul 2021 15:50:27 +0300
Message-Id: <20210716125027.18824-1-mscalindt@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716094227.15177-1-mscalindt@gmail.com>
References: <20210716094227.15177-1-mscalindt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

While performing bracket expression ('[...]'), DASH recognizes only '!'
as a special character for negation/inversion, but POSIX specifies '^'.

The specification (2018 edition):
"
9.3.3 BRE Special Characters

^ The <circumflex> shall signify a non-matching list expression when it
  occurs first in a list, immediately following a <left-square-bracket>
  (see RE Bracket Expression).
"

DASH:
  $ i='123 asd' && printf "%s\n" "${i##*[!a-z]}"
  asd
  $ i='123 asd' && printf "%s\n" "${i##*[^a-z]}"

  $

BASH (with --posix):
  $ i='123 asd' && printf "%s\n" "${i##*[!a-z]}"
  asd
  $ i='123 asd' && printf "%s\n" "${i##*[^a-z]}"
  asd
  $

This patch makes <circumflex> ('^') a special character used to specify
negation/inversion.

Signed-off-by: Dimitar Yurukov <mscalindt@gmail.com>
---
Changes in v2:
  - Fixed the patch (patched expmeta())

 src/expand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 1730670..32a1b5a 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1296,7 +1296,7 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 			metaflag = 1;
 		else if (*p == '[') {
 			char *q = p + 1;
-			if (*q == '!')
+			if (*q == '!' || *q == '^')
 				q++;
 			for (;;) {
 				if (*q == '\\')
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

