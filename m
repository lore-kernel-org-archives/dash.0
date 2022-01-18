Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DDCC433F5
	for <linux-dash@archiver.kernel.org>; Tue, 18 Jan 2022 14:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245222AbiARO3C (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 18 Jan 2022 09:29:02 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:55301 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245580AbiARO27 (ORCPT
        <rfc822;dash@vger.kernel.org>); Tue, 18 Jan 2022 09:28:59 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 413E01220CC;
        Tue, 18 Jan 2022 14:28:55 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4AB6C1221B7;
        Tue, 18 Jan 2022 14:28:50 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.124.238.86 (trex/6.4.3);
        Tue, 18 Jan 2022 14:28:55 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Little-Cooperative: 1f3abb334619914d_1642516134638_1113433862
X-MC-Loop-Signature: 1642516134638:1523214958
X-MC-Ingress-Time: 1642516134637
Received: from ppp-88-217-46-204.dynamic.mnet-online.de ([88.217.46.204]:38178 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1n9pTX-0004yi-6q; Tue, 18 Jan 2022 14:28:47 +0000
Message-ID: <5b9b3eb1a98d35e5edcb4fe1ce845945d0c9bb36.camel@scientia.org>
Subject: Re: possible wrong behaviour with patterns double [ with no closing
 ]
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
Date:   Tue, 18 Jan 2022 15:28:40 +0100
In-Reply-To: <YeZbt7nhvODBSL0I@gondor.apana.org.au>
References: <YeZbt7nhvODBSL0I@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, 2022-01-18 at 17:18 +1100, Herbert Xu wrote:
> This happens only with fnmatch.  So I would presume that it's
> a bug in glibc and you can take it up with them.

Forwarded to:

https://sourceware.org/bugzilla/show_bug.cgi?id=28792


Cheers,
Chris.
