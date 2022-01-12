Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9D4C433F5
	for <linux-dash@archiver.kernel.org>; Wed, 12 Jan 2022 17:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbiALRrt (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 12 Jan 2022 12:47:49 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:47085 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355962AbiALRrb (ORCPT
        <rfc822;dash@vger.kernel.org>); Wed, 12 Jan 2022 12:47:31 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 28E4B2C1CED;
        Wed, 12 Jan 2022 17:47:24 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id F1BB02C11EB;
        Wed, 12 Jan 2022 17:47:22 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.124.238.86 (trex/6.4.3);
        Wed, 12 Jan 2022 17:47:23 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Shelf-Snatch: 622dc23279a102f6_1642009643779_1989612621
X-MC-Loop-Signature: 1642009643779:2338982274
X-MC-Ingress-Time: 1642009643778
Received: from ppp-88-217-46-204.dynamic.mnet-online.de ([88.217.46.204]:32800 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1n7hiN-0006rT-Bt; Wed, 12 Jan 2022 17:47:18 +0000
Message-ID: <4a139aa29e7ccaf561d93cd400e37d60feb7bebc.camel@scientia.org>
Subject: Re: possible wrong behaviour with patterns using a quoted ^ at the
 start of a bracket expression
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Date:   Wed, 12 Jan 2022 18:47:13 +0100
In-Reply-To: <e341e41f-8c32-b6e4-8be3-8f94fae2677c@gigawatt.nl>
References: <09fd70edcf08c75b4f9f2e158e3e6c0832d35d90.camel@scientia.org>
         <e341e41f-8c32-b6e4-8be3-8f94fae2677c@gigawatt.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, 2022-01-12 at 17:20 +0000, Harald van Dijk wrote:
> However, whether this is the correct approach is a matter of opinion:
> dash could alternatively choose to always take ^ as a literal and
> always 
> escape it before passing it on to fnmatch()

Well I personally think the best would to *always* take ^ literally,
whether quoted or not.

That would match the behaviour of bash and klibc sh, and also seems
more in the spirit of POSIX (which, while saying that an unquoted ^
produces undefined behaviour, also says that:
"( '!' ) shall replace the <circumflex> character ( '^' )""

... "replace", not complement.


Cheers,
Chris.
