Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0409FC433E0
	for <linux-dash@archiver.kernel.org>; Wed,  6 Jan 2021 13:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C191A2311C
	for <linux-dash@archiver.kernel.org>; Wed,  6 Jan 2021 13:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbhAFN0Z (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 6 Jan 2021 08:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbhAFN0Z (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 6 Jan 2021 08:26:25 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAEEC06134D
        for <dash@vger.kernel.org>; Wed,  6 Jan 2021 05:25:44 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 30so2224720pgr.6
        for <dash@vger.kernel.org>; Wed, 06 Jan 2021 05:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tRl7MRozyniAf9Q7pC0gl6WcdPSMYLASFf8ddbtMnvg=;
        b=RbWkU7lfIAz6JIrId16cJZCcsoT8EHViA57Vcdng5gwzhEI2Z6gWok2QqS2gxhlO8r
         ipuw9fKkvbNfLbyN0dNseXW2aNlzFxTE/Qilu2ThaR50J02SFj5pRjbDJxSdPbPc/cYO
         D34g4nhOZUotgRXjzz7UCu6Jjj/oJQIIrQYu69786mBmjr53YCLunYY1jUVaLbGtQQ1Y
         C/GkemunA8iR2Rsw5hT7VTnVeRcqMo47i1q8Z7hlbhIEzczs+YP3gjVd/k8cQEWwHHe9
         yOgjY/roXcJvqmM4e+cyobjpBRQXsN9fiOIKMjHI1vDGnHqPryDhI2HIIIuWdj3celH+
         ISCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tRl7MRozyniAf9Q7pC0gl6WcdPSMYLASFf8ddbtMnvg=;
        b=HN1U87bLsO1JKdDURaHDpdNTyalyx1ckPpFxchWbs6iEMjFP5VZZYmFd84K5er08If
         1HlkOIcreEOnYmiccklRPQvgUL8PfAnqBZveWsPTLSedCLgbzMsoUb/4ZTMdnGxqvZkS
         VMA7V+vE12xl3mz0T6N6jJrtNVOjexXFrg5bQkQ0k/KAGZzZDydU56x01pCJTOPrJXg8
         Egpvl1j8uThLboyK22gFxUPEJffpybqiGNl5otUC/ubf0+KYc3Nj5FYq1F+C6TobYU5U
         13DEJgZo+IRS761bd5wtqGf1cGPlkxHazeyXlHhPSsYu0r5bamZ4x+q0xPryormxhKnN
         fKOg==
X-Gm-Message-State: AOAM532AnlrxjJXsBszXwQ7k3RXoVJM0XoIV+1t68fdvtZ+jAJcT+2/P
        OCFwS010SN1X2Qh5IRKG3msGwk6IiAty1pQlEBM=
X-Google-Smtp-Source: ABdhPJxiGf7iBfQebAQ0o5TnfoqyJEivIznh6r2Ix8RaBcg6HEjx5iHek9HIMpEKwRFajpGXUz1CsC51kKShCb04u3k=
X-Received: by 2002:aa7:8d98:0:b029:1a5:929c:1bb2 with SMTP id
 i24-20020aa78d980000b02901a5929c1bb2mr4257824pfr.4.1609939544361; Wed, 06 Jan
 2021 05:25:44 -0800 (PST)
MIME-Version: 1.0
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Wed, 6 Jan 2021 14:25:33 +0100
Message-ID: <CAK1hOcPQzYeuMXViwVsfu27YYSBioWdK8hZQvin9Lxg_HJnw0w@mail.gmail.com>
Subject: set -i, -s do not make sense, bash does not accept them
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello,

dash accepts "set -i" and "set -s", and their +OPT forms.

The -s/+s does not seem to do anything except affecting
the value of $-.

The -i/+i does have some effects. In interactive shell,
"set +i" makes prompt disappear. In non-interactive shell,
"set -i" makes it possible to ^C break the script and
land user into interactive input prompt (!):

$ PS1='T>' dash -c 'set -i; echo $-; sleep 5; echo $-'
i
^C
T> _

From code inspection, this seems to be caused by
's' and 'i' being present in optletters[] array,
and parsing code treating them as "set" options,
not special-cased.

IOW: it does not appear to be intentional.

bash does not treat them as "set" options.
They are only valid in startup command line, not in
"set" command. dash does the same with -c option.

bash adds "i", "s" and "c" into the value of $-,
despite them not being "set" options.

dash does not do so, resulting in discrepancy of not showing
"c" if e.g. "dash -c 'echo $-'" is run.

I propose to mimic bash behavior more closely:
do not accept "set -i" and "set -s", show "c" in $-.
