Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFABC433F5
	for <linux-dash@archiver.kernel.org>; Wed, 13 Oct 2021 09:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE156109F
	for <linux-dash@archiver.kernel.org>; Wed, 13 Oct 2021 09:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhJMJle (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 13 Oct 2021 05:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbhJMJld (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 13 Oct 2021 05:41:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A855C061570
        for <dash@vger.kernel.org>; Wed, 13 Oct 2021 02:39:30 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id t184so1092239pfd.0
        for <dash@vger.kernel.org>; Wed, 13 Oct 2021 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=xwyZTSpylTGHF21jOgs+x40e+QAwAgz9pqfWSVR+n5k=;
        b=pfQBT/1nKQ2rBS85RLN3EnStoUzWXvlIyI2cxiZDEuoh3ZPXgnDWq6HmN5PJJBFsTI
         ddhKPdQlk7Z22PlsphrqoVSqqWcSih9XlGIAzwumEFpQS8KoYGvVooG6XeKAHOnlm8Sn
         vS11V+/89SLYewfYS6NdnTJuHyFi4VM0PKGYwGGje9rtxRMdo5J14PT2dW+Cygu8dZg5
         c+EwuqZQsq0kY5pVb0oEdVkNq0kWUijyJV7xQpG1Ex/cVFdWvmskIAEzR+hEtLTkvHD7
         Tkzqbu3G83rmRVLjcXwRfUe9PvPxY5jxurki+ADqhr64C0w1OdN6G+G4LWkoNnwgsf/K
         U3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xwyZTSpylTGHF21jOgs+x40e+QAwAgz9pqfWSVR+n5k=;
        b=0jb9x7ZF/+tQokE6WSURY7C27ONS+sdQyue0/BMjxiyu5c5vSmu76WjCEe0n8iqB+U
         3Q4BunKsO1anDniUlhFFWT9P0exa/D2TuWDWxT4svy1wkBjeqdrWBVxHYLWI8zprqAVp
         HeErfWshELzEnYKjCs00cLYAzxGFD2zpuIwRGqGHaZKNsLIS9nooMaNXHsKHHv1mjvOM
         GkuyjN40ut5+cv7zP21A4TqHMeE67iB1eX0lDMCBZkdRhgdZG8Drj80MvOpOOsiX2gsk
         QPwG/79duco7uoWKtEdcrGMyQ1YyRiwfZLceu/dyUICM9KRQ3kZhSIFjUi8z4h+gEDat
         zaJA==
X-Gm-Message-State: AOAM533MnAJziLr3hDnxUEVE4r6vi/X+HtTqiKaTSo4k/tj0bwJXdTiy
        b5W9xPDBbZu8/5qrWS7rsq/LpvlQ1o9GVZvCz6IhY6t1GuQ=
X-Google-Smtp-Source: ABdhPJwn06B6itNK/P28lxVw57RV+Z8U0cdtaHueErGbMzBwr8yaefZ7ecuvQ3lkV3Yp75xyCgZMtvGmhuiazzuOEN8=
X-Received: by 2002:a63:154:: with SMTP id 81mr17022481pgb.38.1634117969793;
 Wed, 13 Oct 2021 02:39:29 -0700 (PDT)
MIME-Version: 1.0
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Wed, 13 Oct 2021 11:39:18 +0200
Message-ID: <CAK1hOcNgTbRgWVjidA63NJqa4_+ExRuE5XpSM14s5VGw2eQT_A@mail.gmail.com>
Subject: $ENV handling depends on defined(linux), why??
To:     DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

I was looking at this bit:

        if (
#ifndef linux
                getuid() == geteuid() && getgid() == getegid() &&
#endif
                iflag
        ) {
                if ((shinit = lookupvar("ENV")) != NULL && *shinit != '\0') {
                        read_profile(shinit);
                }
        }

thinking "condition order is wrong, if !iflag, calling getuid()
is pointless, we waste 4 syscalls" but then I noticed
"#ifndef linux". So, the inefficiency is not biting me, a linux user...

...but wait. (1) this check says "if we are setuid and run by non-root,
do not source $ENV". Who in their right mind would have a *setuid*
shell executable on any system where security matters?
IOW: this code is pointless anyway even for non-linux users.
And
(2) If there is some sort of standard language somewhere which says
this logic has to exist, then why we don't do this on linux?

git history shows it was there in initial import.

I propose to delete entire #ifndef/#endif block. It's likely wrong.

Alternatively, move "iflag" above "getuid() == geteuid()" checks.
