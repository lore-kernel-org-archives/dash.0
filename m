Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D93FC433F5
	for <linux-dash@archiver.kernel.org>; Thu, 17 Feb 2022 16:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242914AbiBQQP4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:15:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243032AbiBQQPx (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 17 Feb 2022 11:15:53 -0500
X-Greylist: delayed 350 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 08:15:38 PST
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96DD170D6F
        for <dash@vger.kernel.org>; Thu, 17 Feb 2022 08:15:38 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 793DC461BFF;
        Thu, 17 Feb 2022 16:09:46 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3468D460C2B;
        Thu, 17 Feb 2022 16:09:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1645114185; a=rsa-sha256;
        cv=none;
        b=aOsqLmNB/dZJ0Fs9hc8QyoAbC2xDykcL8JtO1lSdMc8LQ5THAX3EmNP/ibGCNECsqmJTjj
        t5Xr/84CYROeMp1FYXrHn7gP3TVAOgJO2Hhsr9jvkluuHcpkvfYn7Cl+OY+5cGjsYq18OJ
        FZ9IrNnJxuX4yn3/NkxZ84yw/NfZ3pJa6lIHkbSXjYL6YEwnT5pvRorD6jFw1gs1b5PsuG
        w+qH3iX9IkuwmZDKw5Q3gwu5HEGarvsB3XnrLef1hL1SMrpoNGG9kdUWPn2gjjWdx1wtxF
        Xvdfc6CTURZM2yBhkXZyX7+LOUTwJBVUpo1IISZJF+Mw+7WL2fBvNU2IyV+fHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1645114185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CU+ttQHQ/r1GcULIsp4eysn1Y/NHvNc6Kk9eCv6osL8=;
        b=UVfD+xY7uuY7PeqfRDcp7FL2F3NqL9ePL0F2B3MYBuD10/UaXjur3KuZEA3/Zuxgaq5AEh
        DcqAkIvJGDmHOpdNtGlQSdukY8HA+P7Fm1Opz4AUvwzvUlU5tPqDSn+02O/D6wGAiWGWXT
        jXPVPNYiLkYk1Zk/xPJEuzICTbp5oGlsr12SJYrzFmkTa2VoZfkyF6MCE8RXkmbFXd+SWM
        y9BFF9gF+A0MfrgjifI0gh//58njysplAEMk08TdEh0VgpE+easzs8NoPlIlfzMrqPk5sN
        zunR5fh8YeQUqjc3kws3w/0ilhTXLZb3+yQtpLQVEBMS63wULYuFMQWboBTa6A==
ARC-Authentication-Results: i=1;
        rspamd-6454cf6474-bd9hm;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.103.158.96 (trex/6.5.3);
        Thu, 17 Feb 2022 16:09:46 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Stretch-Towering: 71769ad35fe2786f_1645114186263_4063947097
X-MC-Loop-Signature: 1645114186263:722669127
X-MC-Ingress-Time: 1645114186262
Received: from ppp-88-217-35-91.dynamic.mnet-online.de ([88.217.35.91]:51232 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nKjLh-0008By-NC; Thu, 17 Feb 2022 16:09:43 +0000
Message-ID: <53c982b79d7d9b29cb5c9183f6d03b1f4f48103e.camel@scientia.org>
Subject: Re: dash doesn't support switching LC_* during a script/session
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu, 17 Feb 2022 17:09:37 +0100
In-Reply-To: <13f96ba3-7d6f-fdb2-1cd8-b010465567f8@gigawatt.nl>
References: <e312d45e17b49c418c3a62a56da758977067b563.camel@scientia.org>
         <13f96ba3-7d6f-fdb2-1cd8-b010465567f8@gigawatt.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.43.2-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hey.


On Wed, 2022-02-16 at 23:28 +0000, Harald van Dijk wrote:
> You were right to guess that POSIX does mandate that shells support 
> locales. The lack thereof is a longstanding area of nonconformance in
> dash.

Well actually it is conforming then, since POSIX indeed doesn't demand
support for any locales other than C/POSIX.

My testing back then was a bit flawed, and I had thought that dash
would support locales and that just the switching fails.
But AFAIU now, it simply doesn't support them at all, and always runs
in C.

Which is btw. also ok for my purposes ;-)


Thanks,
Chris.
