Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11909C4332F
	for <linux-dash@archiver.kernel.org>; Wed, 14 Dec 2022 22:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiLNWg1 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 14 Dec 2022 17:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLNWgY (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 14 Dec 2022 17:36:24 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A38A36C6C
        for <dash@vger.kernel.org>; Wed, 14 Dec 2022 14:36:24 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C038A5C0072;
        Wed, 14 Dec 2022 17:36:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 14 Dec 2022 17:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        greenberg.science; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1671057383; x=
        1671143783; bh=dKmQN4Ce7TyAGnosOqnVy/1+d/2uOViBoVFi3bwJddk=; b=N
        SBknDzcrBbwVCm8eAe9AGaTC3hyz8PEcx48Z3kX+QCxhCIQ2SpHkciJp0dCKxVt1
        oZDUY53+qrGy5xmg6YZ20KrvbSLL9uQKLVpyaj+yrviJ4pJQdaUDwLBWlh1G91uC
        RoA7IWLu8iNnsXN6hUmE2VhiEHFmj641qyXZ3GZ+PF4R9i6vDfkI1ViS8oHzrI7g
        0X2zCofojkjehAC+C1YHNbQvE1kE73sbPCi2SJyVEh5ZB7MYoWf7LMkRcM10G4Xa
        76MkaOPCNvvo20x90JJ4aloECxfcT2AHs/XBONABTXCQo08TIwbW1yS9TWGpKstE
        4ulTy5bJsP/kgYcuXaehQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671057383; x=1671143783; bh=dKmQN4Ce7TyAGnosOqnVy/1+d/2u
        OViBoVFi3bwJddk=; b=i3T6tmBvVMQxlv6Uyp7w1aCKY5iv3JRhP9i7tYGDmmK6
        kNL+t5AbIRtdJ07dyDyWqWyvbOQqeP5FENbv9m5Lt6LkQTlzXnEqJyNLGP5E+0ho
        1LFZIHUHc0ssYccA3MX4zCg8643uChZV18mKBANgzEJMI9YGlhI4n3A+z9eC7iCA
        hkX1nnbfEFmqcO5fRhewXIsz2GYfrc3QnN0qQWu/7VHWaNh8UtCBQlqFtGoApRF7
        7qBvlF74YqtGzpg6B7dVuU70nCEtmJCva+4jrPYIPBhBecHf+gSRpoYlRbR0MkaK
        5UIvaceLVqNWZv7ATpR4Jq0tq9Y0wfO8Fhjxo23EVA==
X-ME-Sender: <xms:50-aY7_BVzUA2mqACXsZAX85dR3e88TkGRXuLDSx98VL3Sxduy828A>
    <xme:50-aY3s0eRRNJI7p0ZtHvQ0pp_oRLCYGF8irhT-MnySnNKgCmDp0WUpRaF2PcT-Lp
    3UkyTUxMM3XJGavEEU>
X-ME-Received: <xmr:50-aY5Ayhp8kaA51L8GrdUR-8fwrcKiB-r6qXL8unBu8xX2_MQiE8Ib7eXzW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefgdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefujghffffkgggtsehttdertddttddtnecuhfhrohhmpefoihgthhgr
    vghlucfirhgvvghnsggvrhhguceomhhitghhrggvlhesghhrvggvnhgsvghrghdrshgtih
    gvnhgtvgeqnecuggftrfgrthhtvghrnhepjedvheekueeuffeliedvjefftdfgleehffff
    udegvdegvdehgeevieelgfekteegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhitghhrggvlhesghhrvggvnhgsvghrghdrshgtihgvnhgt
    vg
X-ME-Proxy: <xmx:50-aY3dTND9c5n-4lxqKrzEE2LPoS0LUK-PmHyEZM-fjJSkXky1_6A>
    <xmx:50-aYwM4PEx1mKVw8h77kSp-9NHDIXOMh1XwHbca8KcZbm2X3Vb-SQ>
    <xmx:50-aY5knoU3MKn6exOZzTLgkpTXHUg273EEzsXQEEWRL2-8cNHejfw>
    <xmx:50-aY622H7pw9IZ-vDXeIiJcLUGkdQexFHeRBHKHy2K4FU5iceaA7A>
Feedback-ID: ib2794684:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Dec 2022 17:36:23 -0500 (EST)
From:   Michael Greenberg <michael@greenberg.science>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
Subject: Re: [PATCH] options: don't error when unsetting OPTIND
In-Reply-To: <20221214174946.yISP5%steffen@sdaoden.eu>
References: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
 <m2edt2nk5q.fsf@greenberg.science>
 <20221214174946.yISP5%steffen@sdaoden.eu>
Date:   Wed, 14 Dec 2022 17:36:22 -0500
Message-ID: <m2bko5obo9.fsf@greenberg.science>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 2022-12-14 at 06:49:46 PM, Steffen Nurpmeso wrote:

> Michael Greenberg wrote in
>  <m2edt2nk5q.fsf@greenberg.science>:
>  ...
>  |Bafflingly, the POSIX spec gives the example `readonly HOME PWD`, but
>  |with no explanation about why one might want to do that. (I get making
>  |`HOME` readonly, but `PWD`? Is that supposed to stop `cd` from working?)
>
> PWD is a beast with lots of "behaviors of the cd and pwd utilities
> are unspecified" in case of user edits, see "2.5.3 Shell Variables".

Is running `readonly PWD` the same as setting `PWD`?

The language in the documentation for `cd` and in 2.5.3 only talks about setting or
unsetting `PWD`, but not the export/readonly bits.
