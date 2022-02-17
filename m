Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C981AC433EF
	for <linux-dash@archiver.kernel.org>; Thu, 17 Feb 2022 16:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243374AbiBQQko convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:40:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiBQQkn (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 17 Feb 2022 11:40:43 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FB42B31AA
        for <dash@vger.kernel.org>; Thu, 17 Feb 2022 08:40:27 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 53C50800F6C;
        Thu, 17 Feb 2022 16:30:27 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 510F28009FB;
        Thu, 17 Feb 2022 16:30:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1645115426; a=rsa-sha256;
        cv=none;
        b=xuRArmLTVOTcvRlMUndMG5bTF9qv2mpxvfMOQ4i0K1CvjWFI0A1KhM8DTkGcUuKlEMVSSD
        4i7oSX77jydQVGmQ89+WtfrWDx6EdmxxH8LOoHUW6EVSC6UHkTJn+SEevaQO+GNGmj67Q1
        QoRzZk+uC48zmyRDmIGmOTifXdQy1kWUf+ku1+Ay3qXT1U0dZ3RhHkk+xVWFsz7JmH3+d/
        arksYot/LYpfcgEl8hhukYmZp4PKdS5xCJdoffdrXp/OWUQhbaNODSu7ZSIF1e7BwRn6Md
        Xqd5TmtR4Yg2QEzYQafXW5ePHwe56Iamrstlg9SI9l25PuuDRKD52z4F4x9sLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1645115426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8P+N/x8zcrh2HwubX1UZtQMlqIalbPdhIggoegzu2ak=;
        b=SBdVjdDkshCmySTvPUGLTXy3CAaxXRrNEhs20yyEs+gR5LKKblg9QfuPO0XLQrJBYdNIXH
        +JN2APbCotRoU6IjLxRVKRFkXqlHvUo0sIDavwu8x+RIjk/TqRLFy5z8s/arbhgElAZ3Rd
        az/xd2sNMrQfepq+f67k4/8G/wgqLUkqMNYSp8a68qAJkj7b827nbT1Kvh/0LmY1hzhRPM
        +yu0/p20zUxERG7g6WVsmE6Htk0Tk098VcBRV/DgvkE86xYR1pxfOBqOJdal+U4M8jUWZG
        rtMCcoVHursAFYZfs7OKRquXm+mMFVnU8ic/HCso4uDw+6cBtP3xoEmCRxEzcA==
ARC-Authentication-Results: i=1;
        rspamd-745697bdc7-4djzj;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.115.218.34 (trex/6.5.3);
        Thu, 17 Feb 2022 16:30:27 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Trade-Decisive: 67a2d3942a692d1f_1645115427034_2639260098
X-MC-Loop-Signature: 1645115427034:605166937
X-MC-Ingress-Time: 1645115427033
Received: from ppp-88-217-35-91.dynamic.mnet-online.de ([88.217.35.91]:51234 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nKjfi-00031n-Fr; Thu, 17 Feb 2022 16:30:24 +0000
Message-ID: <5f99f880be7c4efa5e88d21ef6699c79288ad5ad.camel@scientia.org>
Subject: Re: dash doesn't support switching LC_* during a script/session
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu, 17 Feb 2022 17:30:18 +0100
In-Reply-To: <39a80930-6890-9a09-c1d4-8da335d967f8@gigawatt.nl>
References: <e312d45e17b49c418c3a62a56da758977067b563.camel@scientia.org>
         <13f96ba3-7d6f-fdb2-1cd8-b010465567f8@gigawatt.nl>
         <53c982b79d7d9b29cb5c9183f6d03b1f4f48103e.camel@scientia.org>
         <39a80930-6890-9a09-c1d4-8da335d967f8@gigawatt.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.43.2-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thu, 2022-02-17 at 16:17 +0000, Harald van Dijk wrote:
> ...if you don't need that, that's good news for you. :)

As long as it *always* works in 'C' mode then,... I'm fine :-)

Thanks,
Chris.
