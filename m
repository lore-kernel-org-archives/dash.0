Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED40C54EBD
	for <linux-dash@archiver.kernel.org>; Sun,  8 Jan 2023 17:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjAHRBq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 8 Jan 2023 12:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjAHRBo (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Jan 2023 12:01:44 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE40E8FD1
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 09:01:42 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CAE14540AC2
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 17:01:41 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 15AA8540DB7
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 17:01:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1673197301; a=rsa-sha256;
        cv=none;
        b=Ate5/sjI53wEUvC+I/eZ0HF2LZDxSQniJRqZKGwAbwzQHNcyJAAjNfQGhDaFSPOnyc+td/
        vRnfOPF7o6vRC5XKO/Wrl+crQucMxPtcRbZsYZe91a90iCtI/NzWtah234amT/Q6NNXpDu
        7lg1W10BFEEjBNaswjIl2RVAEauEq2Z5xvboHNBnHgDRMgkwW7wt9As6yzzpeSqckNvNGd
        6jKe/A0eMvzoAc3JJgiS+oy/vK0fNnSwrdZz7jYlcqb8DbkNh7xLZuxF958t8/6Z3ckKiI
        70IOp76LqGbpVn3tW3YFODJDHyYo1U46pI0zwJmy/2Kc70or7zQa3yUaTG841Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1673197301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/NPpoyjN61HTS56xpc5k6lHdXzP4IE+PNm29QvfjOZI=;
        b=+TrOzp/b9JT9oDqx1+eoSlKdxQwdScxCKaJyg1BrmOzWcm1IrZfhUZnRWNQ41zNpfAhnq4
        WyPJRnwoPtq4dtBIqibtpE6s+zV2Cu0A/QnwDqlrT+QjN3QVaSsWSfV/T+YXXrBG84LRY2
        ccaJDLnGOUYGkv8ElSfrpLWqA+a/ZaaKGFGTXqZSsxrALKcB+X7mKBVpnaYcol0MdS/NZc
        rUNJtGCu8H2p0BlYN3pb4yj2CfM3II44xdM7s5d+V2LDBz17RmkPHQwhAEHYd4B2PbW5zF
        AFxtzIZtZ4UpvLfycem4VIA0MPwJxeIkGp9rU6UYFvnxFmIOMK4n/Ly8naC4PQ==
ARC-Authentication-Results: i=1;
        rspamd-7cf955c847-x9f9p;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Illustrious-Army: 35478a0279bf3763_1673197301567_2254431803
X-MC-Loop-Signature: 1673197301567:3143877523
X-MC-Ingress-Time: 1673197301566
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.103.24.48 (trex/6.7.1);
        Sun, 08 Jan 2023 17:01:41 +0000
Received: from p5b071e4a.dip0.t-ipconnect.de ([91.7.30.74]:50964 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1pEZ38-0001eO-2l
        for dash@vger.kernel.org;
        Sun, 08 Jan 2023 17:01:39 +0000
Message-ID: <13868aad4c6f3c58fa62424b704bbf56cdd0e124.camel@scientia.org>
Subject: Re: dash repeats first line in history entry forever with fc -s
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     dash@vger.kernel.org
Date:   Sun, 08 Jan 2023 18:01:33 +0100
In-Reply-To: <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
References: <20230108160906.xf7w5vsd74kr22pc@tarta.nabijaczleweli.xyz>
         <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Sun, 2023-01-08 at 16:31 +0000, Harald van Dijk wrote:
> Indeed. This was reported also by Martijn Dekker, 
> <https://marc.info/?l=dash&m=154635285309187>, that thread lists some
> more related problems in the implementation of the fc command.

A bit off-topic, but was it ever considered to move dash development
into some gitforge (e.g. git lab) or at least give it a proper bug
tracker so that such things could be... well... properly tracked?

Cheers,
Chris.
