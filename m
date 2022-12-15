Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D52AC4332F
	for <linux-dash@archiver.kernel.org>; Thu, 15 Dec 2022 18:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiLOSjk (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 15 Dec 2022 13:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiLOSjh (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 15 Dec 2022 13:39:37 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABD655AF
        for <dash@vger.kernel.org>; Thu, 15 Dec 2022 10:39:33 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E01E85C0085;
        Thu, 15 Dec 2022 13:39:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Dec 2022 13:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        greenberg.science; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1671129570; x=1671215970; bh=PfrTA4zFLq
        4u9TnjR4p5y2Q46TZDspKkwUYVEBhx3pQ=; b=HxBdti9bqCQQ1fvirLHxdr+5fx
        eNWlqW2tNdaeW0NdHHVCBan3D7f00kU+aLraWS1MVqx8rUImHi7zK/EUwqVhpgN1
        VNGkhUp/z2W0Jdwdp2oc2KJSvawtJOAjkftX2tHLXAoG7YpHtCij2nhh3JIenys5
        PBO6YM6oTUxViQGHYk3Wub7x/YPcLfCD4xBzOz7G9rdopwB2u6xEg5DYcMmA7SnT
        1BI47trUOK144PxOQaseaDsnlUuYh1PO11F6WBuM1OsAdcbHl5i3sgQfeFY+k49/
        RQUm2gm7ReX8XnPOcl/3JlP4tCjtkhMtNrcqhxeDOoS1XCDIruAgCAQ34/OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1671129570; x=
        1671215970; bh=PfrTA4zFLq4u9TnjR4p5y2Q46TZDspKkwUYVEBhx3pQ=; b=R
        1w0hS9kPDzl5rDFTEFhesxLBWDPNMfa4AP55jN9EB9udyxZFgOCqZ4HApa83IfIm
        XYBKufSS0PV+Tq6pzvqxHSC2JvCSAKivj3beROrxse0ooRJv36K9AGtGdTeBQMUX
        vNK4IPZxYLvv9fRDatxa6UGgjeFLZbxTnKFURaQZN/SZc03xnh90eH+2CLts+9bU
        hwfedAl4LN85TiJjoHS6uxm/PBKhKgOWvD30f8bEQjPV3R1iRfTwY45tJwBm+8Qg
        9VUyYt+9XGPoxseV/rTZH4lujEYyl81smXOzEbQmM80Z0NL1Nm/awO7KlbjdVJjM
        IEauRnJvoFi31U2FbNBgA==
X-ME-Sender: <xms:4mmbYzK7-QcPh6HCnhymzp5cT9N7M_jVaxaVVL45V0ZkRxZh-NMavw>
    <xme:4mmbY3K8kfntQWCQkJPw2TcUQk97S3vpufOEhxYRmQAxMjv1jlrTTTnX1SZ3gMnWc
    LwnGZ5YZrEJ7gGv3Hw>
X-ME-Received: <xmr:4mmbY7sA1L7otXbWZkMHi3DRNIl9KxfcL4Zg-67YkMcnQ9a_cMMo43Wqfw0b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefujghffffkgggtgfesthhqredttddtjeenucfhrhhomhepofhitghh
    rggvlhcuifhrvggvnhgsvghrghcuoehmihgthhgrvghlsehgrhgvvghnsggvrhhgrdhstg
    hivghntggvqeenucggtffrrghtthgvrhhnpeeiteeguedukeeiueduteevfeduveeigfdv
    hfdtleffueffudfftdfgteeuueejjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmihgthhgrvghlsehgrhgvvghnsggvrhhgrdhstghivghn
    tggv
X-ME-Proxy: <xmx:4mmbY8a9M9TgMXAm__5Q4TsP2ktlJ_la1GOh6CXkErc3XvUOPCKcUQ>
    <xmx:4mmbY6Z1U7mzbziuYT7_HA8QuSaucgRXTrftfoBx-GiNMWczKrD6rA>
    <xmx:4mmbYwDYKs5f3u-HoNr4AXHe2HC3Acqyhvo-bdmLZxFLReZtQcnMYg>
    <xmx:4mmbY9x7fgD4ZPE9IsJV5fSwoiP_bltubwBf125rQqW7KKiZgvvjCg>
Feedback-ID: ib2794684:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Dec 2022 13:39:30 -0500 (EST)
From:   Michael Greenberg <michael@greenberg.science>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>, dash@vger.kernel.org
Subject: Re: [PATCH] options: don't error when unsetting OPTIND
In-Reply-To: <20221214230738.kedln32yfzcgdovd@tarta.nabijaczleweli.xyz>
References: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
 <m2edt2nk5q.fsf@greenberg.science>
 <20221214174946.yISP5%steffen@sdaoden.eu>
 <m2bko5obo9.fsf@greenberg.science>
 <20221214230738.kedln32yfzcgdovd@tarta.nabijaczleweli.xyz>
Date:   Thu, 15 Dec 2022 13:39:29 -0500
Message-ID: <m25yeco6ji.fsf@greenberg.science>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 2022-12-15 at 12:07:38 AM, =D0=BD=D0=B0=D0=B1 wrote:

> Hi!
>
> On Wed, Dec 14, 2022 at 05:36:22PM -0500, Michael Greenberg wrote:
>> On 2022-12-14 at 06:49:46 PM, Steffen Nurpmeso wrote:
>>=20
>> > Michael Greenberg wrote in
>> >  <m2edt2nk5q.fsf@greenberg.science>:
>> >  ...
>> >  |Bafflingly, the POSIX spec gives the example `readonly HOME PWD`, but
>> >  |with no explanation about why one might want to do that. (I get maki=
ng
>> >  |`HOME` readonly, but `PWD`? Is that supposed to stop `cd` from worki=
ng?)
>> >
>> > PWD is a beast with lots of "behaviors of the cd and pwd utilities
>> > are unspecified" in case of user edits, see "2.5.3 Shell Variables".
>>=20
>> Is running `readonly PWD` the same as setting `PWD`?
>>=20
>> The language in the documentation for `cd` and in 2.5.3 only talks about=
 setting or
>> unsetting `PWD`, but not the export/readonly bits.
>
> Isssue 8 Draft 2.1, XBD, 8.1 Environment Variable Definition para. 11
> (p. 156, ll. 5381-5390) says:

Thank you for finding this! I didn't think to check the current draft.

Cheers,
Michael
