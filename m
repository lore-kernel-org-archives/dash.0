Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D580C433EF
	for <linux-dash@archiver.kernel.org>; Tue, 29 Mar 2022 14:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiC2OZm (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 29 Mar 2022 10:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiC2OZl (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 29 Mar 2022 10:25:41 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607D721276
        for <dash@vger.kernel.org>; Tue, 29 Mar 2022 07:23:59 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id p25so14126649qkj.10
        for <dash@vger.kernel.org>; Tue, 29 Mar 2022 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=gg4Z52T21FuLyvpbstMDoJVEZFACjiYELYCU0C5FW58=;
        b=j/hfw/D4q3n/G9fMpMzUUkKXHWUs/aX/BfGlGNu6eefqppEgJKXnuC4zQ1EFqM2+u6
         ZK3//mgD0+u4Pse5IF9GGjnK41Y78XN7PSDXvJdZgV0dVh8xGzQglvw6bhijyRBoNhJr
         E4GenWG46poHYdIMccLo4DQpSBZsPuDvoAuTd7j3vT5KN9CWQBjZDnhA9O762jKT5u7e
         Tyo9xhNdLX0PS14FLkZN4LD4vFDPc6qDhB6+tsndfdQPH5EXXCNpoqd9ecNc/727CtbA
         gsHBwK5Y/DnU6sKmjzzpZ6R28pxVZnDCffX9DCHiQEbEFo3RyTO83ztoUDzTVHDjfGVI
         DxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=gg4Z52T21FuLyvpbstMDoJVEZFACjiYELYCU0C5FW58=;
        b=lcXtlFI89AVAGY3HkIQTJTp6mNYfG04CDyIquoMJNA5uQjNnZ5B3xhFug714hFQ1J6
         rMM+b5c8xKHzoAwxP+ON/zfTU5f6Hvt9uqKCHasThVzKqyfmb3ExRhz1KCOWeWzXQRNL
         6eSe78jqqt1YqVt39gi4L+NfmDm/OgL3jUbaWIbRf1Ox5rUX6szvJZd3U95GgZ7Yr5xt
         MnR3ohfH95FJlIcVvIhyR0hpJpbCmqLhOKMNF0+spdDGzp6XlWGAXOL2WuzufoQqlo8J
         mmI+9xzZFHoFPnaKE/0xA2kj70FFy88U5az/FaUc3t4ZAsuyklPeMRjxVF5qjQ/p5wwz
         Icqg==
X-Gm-Message-State: AOAM533owogwqX1JByImihEtu5GN9bCd0cKxkYSejU14odynm0FWazrP
        /GMcN5Cf1DiRwY7u0YVr/u0tYLAtSY3Y72mIXjk=
X-Google-Smtp-Source: ABdhPJziqFZwWS7QVwBuNILieZ2FI/gYvNwGp3YptbHQQ9yCCyPPcUTuMv2r6g/vRSNRkwP7hwO2dQ==
X-Received: by 2002:a37:6504:0:b0:67e:3194:db63 with SMTP id z4-20020a376504000000b0067e3194db63mr20248028qkb.127.1648563838344;
        Tue, 29 Mar 2022 07:23:58 -0700 (PDT)
Received: from smtpclient.apple (pool-100-18-7-42.bltmmd.fios.verizon.net. [100.18.7.42])
        by smtp.gmail.com with ESMTPSA id p16-20020a05622a13d000b002e227782e9asm14853568qtk.14.2022.03.29.07.23.58
        for <dash@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Mar 2022 07:23:58 -0700 (PDT)
From:   Al g <algore3698@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Question about vulnerabilities
Message-Id: <B064A5CF-9B1D-4D9A-BB2D-F074BC4D2AD4@gmail.com>
Date:   Tue, 29 Mar 2022 10:23:57 -0400
To:     dash@vger.kernel.org
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello,
I had a quick question, where should I got to post vulnerability details =
that I discovered in dash?

Alex=
