Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5CDC761A6
	for <linux-dash@archiver.kernel.org>; Fri, 31 Mar 2023 14:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjCaOr3 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 31 Mar 2023 10:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjCaOr2 (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 31 Mar 2023 10:47:28 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52531E726
        for <dash@vger.kernel.org>; Fri, 31 Mar 2023 07:47:09 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id b19so16819565oib.7
        for <dash@vger.kernel.org>; Fri, 31 Mar 2023 07:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1680274029;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tRrtGTk5s3jJozUOcdPSSY3iyFN8MEUKpaIM1oEmDdU=;
        b=W7aS9nw5cCj4bCV2eVZCKT/pgitwQ2b0Hz3+DZCrZk77S9wtt2mRsvdCoNBgwhQvDT
         Tr3AkEJfN6L3aWFB8Am4V1hVsAuhVDvonGecopcudSDCtcYyTp/jJpaYchiE4MOqAcxV
         BMQPjMlj/4gaQNNRlMFZWehGs6HCcypWxtpwjMSJTG7vnvCGX+aTrmoOq1YKg0+RcjR3
         X7TF0ORv0/gxYuRK3YFgAhpa/0+AfSfsl4o9fG341xnVtqdD99xnOBEv8Xv3KoUoxYOI
         3M1rQOQE6poSvyWNtYQN1esZE5nKpAivKgkzyvDoTAGNEhEPv3634AajU/wJoPETdy2Z
         GawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680274029;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRrtGTk5s3jJozUOcdPSSY3iyFN8MEUKpaIM1oEmDdU=;
        b=Ty/ljlaa/N2o+vfZpw1YzEV0lQVPensZlh8vMJscwyt34AGdukPo3rvT8RGz7ItWnX
         +H/fw7Sk6nADTUe831dBGq3chnJSaNsAHt0uryVfzbm6sy74k1S6xqq5rrVi+d5XxNvT
         2GSMyG0tOFIjNlK57zATpiAWaKUy7bliTzpzcTmbmaRrU0FLTkoQUXiiUScbxDsnrt1F
         +mIa8lfd/235YNsWpbSFfQKrAY56GzhPtxTwUf/Fb/xhqqZ7sGtw4jHiZSKAeFvlQ8fo
         Pgy4xwwjyDSLY5T7A8cocTotxbYY+pYDSikPBS2uOVlSUmS91CABQklz4uWCG4nE459I
         CQeA==
X-Gm-Message-State: AO0yUKUo0jIyRlRzbhzX6D+e3mdeVdsUqLCDd8Y9pKuJSB4xj/wJQWE1
        QxnW44gBxfVbEklePjuqQf75oogAHMIeYJFfrnrqZvp6pIM=
X-Google-Smtp-Source: AK7set902+eVH+nt8hNeFe4mxN/VGBb/+rTNAn/dIA+0mLMV+gTusOL7wDZi8rb/efjvlemUb56JE8sf4cPKMmrc0L0=
X-Received: by 2002:a05:6808:4c7:b0:386:d50e:aa12 with SMTP id
 a7-20020a05680804c700b00386d50eaa12mr7300721oie.5.1680274028691; Fri, 31 Mar
 2023 07:47:08 -0700 (PDT)
MIME-Version: 1.0
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Fri, 31 Mar 2023 16:46:57 +0200
Message-ID: <CAK1hOcPzt0+SOct3LZ1-go6zzKUVkceoAtS0bZ5=Pqb363cjXQ@mail.gmail.com>
Subject: Bug: cd BOGUSDIR/.. always works
To:     DASH shell mailing list <dash@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

cd DIR

does the foillowing: cdcmd() -> docd() -> updatepwd(), and updatepwd
has the code which "normalizes" the DIR: prepends current dir if DIR
is not absolute, then eliminates "SUBDIR/.." sections.

The bug is, it does not care whether SUBDIR exists.

cd BOGUSDIR/..

always works - it chdir's into current directory.
