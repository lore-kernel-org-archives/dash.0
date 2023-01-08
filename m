Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C096C46467
	for <linux-dash@archiver.kernel.org>; Sun,  8 Jan 2023 01:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjAHBUm (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 7 Jan 2023 20:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHBUl (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 7 Jan 2023 20:20:41 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705C11DF11
        for <dash@vger.kernel.org>; Sat,  7 Jan 2023 17:20:40 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 11EB05C00E0;
        Sat,  7 Jan 2023 20:20:37 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute1.internal (MEProxy); Sat, 07 Jan 2023 20:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=larryv.me; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1673140837; x=1673227237; bh=IJEiEN3RSG
        ypZ+75LsbxTn7mJG0ao5qgYriyquCeOS0=; b=E67HXZeLVtmyY2sTpst+P2A6Db
        JsqY01fk7gxDw5dEl3svdS+K03UoaNAGw+esIXSSuOV2Au2JtmrKfwsOP4ci3z0n
        jx4RSZC/rAtqzmZE9yrCUNgzoW/2mfOf/QPJTXREUuNut1gM8zxoLjYVZSoNuQEA
        P+kjaroTjeaACz1n72nGjpNjnpO4eP4HNWiIQdppIxThZ0YEsH/fvkuBPYbsfxjb
        QF0rcYPLBztTsMh3CV1wkOtu1pcCdNdeXMffkbtqIMDTpM2v89DWkyh5YIocAXm4
        DSNLroq6l1Q02kFt9ZDFqJoY/0XbxO3QzWnmHgbKhXMqZBGchIjZVW68Jgfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1673140837; x=1673227237; bh=IJEiEN3RSGypZ+75LsbxTn7mJG0a
        o5qgYriyquCeOS0=; b=lalAjxCkiWIYeFFZeaXiKrrHVOByHcvj7Co6KakaMvDG
        V1sTbDPTqn04D2HLM6XTEYmOzP2IkStnM78bULAROMJk4hLcay4JcdUMMoJJCpB6
        kbKOhoBT7CxXZqBMFhBg9kPfB/Auq6DL/hghfVH3S+QtlSxtoiEbSyA3HFrt9Q9C
        HowWTiDmcvqg4rdPsFW/shyLtA9LiDbRJ6sdfV8Fjrt30a7i+C6VBm5VKKe+JDiD
        2JSVUhulrP6T7Jdng0mBoxRjoNLKHnMY/0UU+jnklI6G2Xv4ZxkXYZU2gn6dFsJG
        0PgFDZANkD9SILsLK4aB10a7SIP7rBEeTgAiJeTz9w==
X-ME-Sender: <xms:ZBq6Y84nI6kwHe3eL87ETTn9xMEaBQJCzhM0YjPXWEf89HsTkYod5w>
    <xme:ZBq6Y94imTdmYsAx8JfZf-st3E3vzzdkCWL6SQr8X7zh8BXdCNcfM9lwK_2KMGV-3
    L1AKqH51AbJFspf7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkeefgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreerjeenucfhrhhomhepnfgrfihr
    vghntggvucggvghljoiiqhhuvgiiuceovhhqsehlrghrrhihvhdrmhgvqeenucggtffrrg
    htthgvrhhnpeffhfehueejudduleefueevheetkefggedvgfdvuefhieduieetffehleej
    veeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hvqheslhgrrhhrhihvrdhmvg
X-ME-Proxy: <xmx:ZBq6Y7ekj-F9CjN-S0qJYi0rnP4TMWxGanV-rnEYNilrXMWTsurFpg>
    <xmx:ZBq6YxL4vOdKDsewRXpPjDtVewi6dKLP4ECjWcR-M4O0cdfVkSroJA>
    <xmx:ZBq6YwKQMfuEAriGA6kb2GgzKcRsTb5OyBhLzpZSVp4XblLfvi9gAQ>
    <xmx:ZRq6Y6wBkupEJqRMSL3cji-PANiaFc7BbuX2BGfLNoADknxyRAxH9w>
Feedback-ID: i0b2842c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BE06031A03FB; Sat,  7 Jan 2023 20:20:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <0144b8ba-5c5c-41f7-b1de-a207a384b9c8@app.fastmail.com>
In-Reply-To: <20230108003402.73287-1-tmgross@umich.edu>
References: <20220422211013.18195-1-chris@chrisn.me.uk>
 <20230108003402.73287-1-tmgross@umich.edu>
Date:   Sat, 07 Jan 2023 20:20:15 -0500
From:   =?UTF-8?Q?Lawrence_Vel=C3=A1zquez?= <vq@larryv.me>
To:     "Trevor Gross" <tmgross@umich.edu>, chris@chrisn.me.uk
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] jobs: Implement pipefail option
Content-Type: text/plain
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Sat, Jan 7, 2023, at 7:34 PM, Trevor Gross wrote:
> POSIX 2022 must be nearing release (or already released?)

Issue 8 has not been released.

-- 
vq
