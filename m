Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9B2C433F5
	for <linux-dash@archiver.kernel.org>; Mon, 24 Jan 2022 16:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243679AbiAXQ02 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 24 Jan 2022 11:26:28 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:57260 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241096AbiAXQ01 (ORCPT
        <rfc822;dash@vger.kernel.org>); Mon, 24 Jan 2022 11:26:27 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3B74380022F;
        Mon, 24 Jan 2022 16:26:25 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 304DB8008A3;
        Mon, 24 Jan 2022 16:26:24 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.112.55.234 (trex/6.4.3);
        Mon, 24 Jan 2022 16:26:25 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Tank-Glossy: 5ec462450e13d6a8_1643041584855_2906395748
X-MC-Loop-Signature: 1643041584855:3219217023
X-MC-Ingress-Time: 1643041584855
Received: from ppp-88-217-33-146.dynamic.mnet-online.de ([88.217.33.146]:44756 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nC2Ab-0000xq-Rn; Mon, 24 Jan 2022 16:26:22 +0000
Message-ID: <7cdd1179822902ab5f9c565c35ac8d45dec51d04.camel@scientia.org>
Subject: Re: possible wrong behaviour with patterns double [ with no closing
 ]
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
Date:   Mon, 24 Jan 2022 17:26:16 +0100
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

FYI:

Was apparently fixed in git:
https://sourceware.org/git/?p=glibc.git;a=commit;h=8442f0d966da5a9333e961af9e98b41aabdd9f1b


Cheers,
Chris.
