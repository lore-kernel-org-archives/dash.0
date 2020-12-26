Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD4CC433DB
	for <linux-dash@archiver.kernel.org>; Sat, 26 Dec 2020 11:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994BA206CB
	for <linux-dash@archiver.kernel.org>; Sat, 26 Dec 2020 11:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgLZLLN (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 26 Dec 2020 06:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgLZLLM (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 26 Dec 2020 06:11:12 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E49C0613C1
        for <dash@vger.kernel.org>; Sat, 26 Dec 2020 03:10:32 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id q205so6775655oig.13
        for <dash@vger.kernel.org>; Sat, 26 Dec 2020 03:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=WO+9C/FEhmUaenTk67u0XMXp9oz8ipXup+ly8128uvc36DcoYBpzpLLePiBSB9Qsf3
         IN+3hRpDScZO1/RdJeziUOovTLhaBDolYzrqFxOftk8BF/4AeBJR/wybV4VAYleLo6cx
         roCvGfzwzL6M40siysTbWaVZPZbD4h3SeZ0+jmMEBVTYGV0j6ilmXi2BEG6EHwAFPOSX
         5okOQpUJVz4OU8YNHRDiqsx1d8b44UeHo/+JipdxPB2eeSSq9olPRPLqBJoJ/4dLS8H0
         4KnUakz29GNyFj+tRhaqqtOTghVW2VPCrCudRYBR5DmcQ4Zx+4rVBZRgWY1yNgqeVMBP
         aS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=qxJArTrDw/FyjlnVBtXD8netgp2ytkISe5YWHRMIOtb38pZrr533J+9ZR7miT+1cjR
         k4xXId2yVwp7L+BnrSBUxSat4vTNRNuQS24PbKz+sfwosB3C0g5vBcy5Yz5LFFr1Vh76
         67bkR0BIavtQFgZnqzS6wELuyH8H95//J+Dq5Mnn8DFXsB2boJFEtDxxppEpSAlMU+bx
         bACQ7NWyEeArbGbOn6q+u8wwUFnU+hXQpx84WBjrKda6G1gMD2M+bSiYcu+mhrGmBmFa
         D6xFUlXaRjcg1ThsyfSlWdFr5c2kC2xyRcLH6jFqq9qCb8BCUiL1RHEvIYq/57ECgARz
         41Bg==
X-Gm-Message-State: AOAM532IVAXj5a3iWZh7wZvHRkqWZR/4wWoMsS266qV4ACJnanltUiXy
        WbE62X3UB7YC4dfaECMxR5lHj/vVd3C05Q==
X-Google-Smtp-Source: ABdhPJzIjuamytF9YIMi7Osu6gAcGw0MwBI+2AF9vf10IGOwda/Obd6PnbUkrL1lGtd6JtL0lKfk3w==
X-Received: by 2002:aca:eb44:: with SMTP id j65mr7134963oih.19.1608981031766;
        Sat, 26 Dec 2020 03:10:31 -0800 (PST)
Received: from [172.24.58.28] ([162.71.236.115])
        by smtp.gmail.com with ESMTPSA id t24sm7968102oou.4.2020.12.26.03.10.31
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Dec 2020 03:10:31 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Karado Johnson <johnsonkarado9@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 26 Dec 2020 05:10:30 -0600
Subject: johnsonkarado9@icloud.com
Message-Id: <6603F304-CDFF-4685-B43A-E9148D43AB6C@gmail.com>
To:     dash@vger.kernel.org
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org



Sent from my iPhone
