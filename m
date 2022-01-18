Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731BAC433F5
	for <linux-dash@archiver.kernel.org>; Tue, 18 Jan 2022 14:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiAROjl (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 18 Jan 2022 09:39:41 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:2933 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237971AbiAROjj (ORCPT
        <rfc822;dash@vger.kernel.org>); Tue, 18 Jan 2022 09:39:39 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 195D2821B59;
        Tue, 18 Jan 2022 14:30:00 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 062F5820863;
        Tue, 18 Jan 2022 14:29:58 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.126.0.19 (trex/6.4.3);
        Tue, 18 Jan 2022 14:30:00 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Macabre-Exultant: 0dab7b8c6e22dfd5_1642516199667_1148452857
X-MC-Loop-Signature: 1642516199667:4224456486
X-MC-Ingress-Time: 1642516199667
Received: from ppp-88-217-46-204.dynamic.mnet-online.de ([88.217.46.204]:38180 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1n9pUg-00058m-0l; Tue, 18 Jan 2022 14:29:57 +0000
Message-ID: <00db46ee5ab57e1282f4808e2103e74699083db3.camel@scientia.org>
Subject: Re: [PATCH] expand: Always quote caret when using fnmatch
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Harald van Dijk <harald@gigawatt.nl>
Cc:     dash@vger.kernel.org
Date:   Tue, 18 Jan 2022 15:29:51 +0100
In-Reply-To: <YeZadfOkUDdN7JqS@gondor.apana.org.au>
References: <YeZadfOkUDdN7JqS@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hey.

Just for confirmation:

Would that also be an issue in fnmatch() (i.e. should it be forwarded?)
or really just something in dash?

Cheers,
Chris.
