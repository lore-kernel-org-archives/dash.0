Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74E4C433EF
	for <linux-dash@archiver.kernel.org>; Wed, 12 Jan 2022 18:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356240AbiALSVu (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:21:50 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:61976 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356242AbiALSVh (ORCPT
        <rfc822;dash@vger.kernel.org>); Wed, 12 Jan 2022 13:21:37 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 24FE26233E5;
        Wed, 12 Jan 2022 18:21:36 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2C0806233E1;
        Wed, 12 Jan 2022 18:21:35 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.106.113.21 (trex/6.4.3);
        Wed, 12 Jan 2022 18:21:35 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Gusty-Language: 27ca47745684d613_1642011695835_1073760685
X-MC-Loop-Signature: 1642011695835:1196087966
X-MC-Ingress-Time: 1642011695835
Received: from ppp-88-217-46-204.dynamic.mnet-online.de ([88.217.46.204]:32804 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1n7iFW-0003f8-2K; Wed, 12 Jan 2022 18:21:33 +0000
Message-ID: <5591608d42348f5cdc7ba061b8b44e80b71c2d36.camel@scientia.org>
Subject: Re: possible wrong behaviour with patterns using a quoted ^ at the
 start of a bracket expression
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Date:   Wed, 12 Jan 2022 19:21:28 +0100
In-Reply-To: <944ee473-9ad6-c13f-48cb-690086c2c902@gigawatt.nl>
References: <09fd70edcf08c75b4f9f2e158e3e6c0832d35d90.camel@scientia.org>
         <e341e41f-8c32-b6e4-8be3-8f94fae2677c@gigawatt.nl>
         <4a139aa29e7ccaf561d93cd400e37d60feb7bebc.camel@scientia.org>
         <944ee473-9ad6-c13f-48cb-690086c2c902@gigawatt.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, 2022-01-12 at 18:17 +0000, Harald van Dijk wrote:
> Actually, in bash, unquoted ^ does act as negation.

Oh, sure,... I event tested that half an hour before and still wrote it
wrong ^^.

Then I'd prefer if it would use an unquoted (only) ^ as negation. The
standard allows it, and it's better to have some homogeneity.


Cheers,
Chris.
