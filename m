Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84781C433FE
	for <linux-dash@archiver.kernel.org>; Sun, 20 Nov 2022 05:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKTFQX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 20 Nov 2022 00:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTFQW (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 20 Nov 2022 00:16:22 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E654E9E969
        for <dash@vger.kernel.org>; Sat, 19 Nov 2022 21:16:21 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B31D0201834
        for <dash@vger.kernel.org>; Sun, 20 Nov 2022 05:16:20 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id EFF602017BE
        for <dash@vger.kernel.org>; Sun, 20 Nov 2022 05:16:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668921380; a=rsa-sha256;
        cv=none;
        b=gSIsLvzVmhE/aFzOcLEJd3yaq7H0QvqY1JHdvPD7etZ/1XIH/XD3etP50C5sJUpUYY620N
        BLnZuV8xobCmubok7fDT2+QMxx1p4GhWTaLONndYii/5K0DYTbB/sIqEkhIhnd1aMINvvq
        S2Z9dts/U9Y+SVwApLB0BQIdDEKKbnzoWAxveoZ3NmaVG+g/O+vGo+BC3EOc/M1drpWjzL
        +ekb9fYC0Ac2sf/O2aeFRlk5s4jHHT72J+Hx5nLON2ia0RXOICQJmpNV6cHgzhdgN5Etno
        fHIX5gqRJ6z1Vv9LJU0tGcMWBoXxLg/QGDS5ESQNnGR0ICj3qY+Q4YuSQLVr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668921380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RthXih5TTuOFmIdCLH7NOqE0n33MoCjG2Co/qjb76o0=;
        b=McHplvP+Q4+aC1N2iOK+X0jYJi1wpAh6owbeeroCwgMT/qA7aK+ZP0NGbbaZlmk92i1R8K
        KlZ2A1yqrei61PfyHsr+DykJXOD/0CY+RVibiikg7jG2VCZRrvhmtJCaO1zqniHisQcqdF
        9ZQg1AgUuGtvX3qY7G4Vt9uqH52bt9fSBqD4nmkBL/ydpco/kNMbSn+eR3NPu/VlhurUpX
        x7lau27N7d6JV2PFuYiZSrcW9RDHpYi5j6u3KfXeeZgmAqsbqEAHI2JCXN8tqkct1chSfQ
        HSg3OJJmk/7a+KL0zIedyUg9C7lobUufmkfsMvGqsxhDaXbSQ7Ll/e/So6kuJw==
ARC-Authentication-Results: i=1;
        rspamd-64c57ffbcf-ktbzv;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Robust-Shelf: 087d021672f17abc_1668921380463_3235498624
X-MC-Loop-Signature: 1668921380463:629761988
X-MC-Ingress-Time: 1668921380463
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.123.200.113 (trex/6.7.1);
        Sun, 20 Nov 2022 05:16:20 +0000
Received: from p57b04dfc.dip0.t-ipconnect.de ([87.176.77.252]:59638 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1owcgg-0008Ku-BJ
        for dash@vger.kernel.org;
        Sun, 20 Nov 2022 05:16:18 +0000
Message-ID: <e1605c8af663d4b254904609713a8dd9e7733bfb.camel@scientia.org>
Subject: Re: incomplete documentation of local?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     dash@vger.kernel.org
Date:   Sun, 20 Nov 2022 06:16:13 +0100
In-Reply-To: <3c3c3df0f7b172a9a1befceccd18c7e71fa91ee9.camel@scientia.org>
References: <3c3c3df0f7b172a9a1befceccd18c7e71fa91ee9.camel@scientia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Oh and this obviously also affects e.g. set -e:
$ set -e
$ foo=$(false)
  => exit

$ local foo=$(false)
  => NO exit

In principle that's already clear once it's documented what "local"
returns, but it may be a common miss-assumption, so not sure whether it
should be specifically mentioned.


Thanks,
Chris.
