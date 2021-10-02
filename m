Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09060C433EF
	for <linux-dash@archiver.kernel.org>; Sat,  2 Oct 2021 21:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE16861B46
	for <linux-dash@archiver.kernel.org>; Sat,  2 Oct 2021 21:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhJBVYT (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 2 Oct 2021 17:24:19 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50313 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhJBVYS (ORCPT
        <rfc822;dash@vger.kernel.org>); Sat, 2 Oct 2021 17:24:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 22AC75C007A
        for <dash@vger.kernel.org>; Sat,  2 Oct 2021 17:22:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 02 Oct 2021 17:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=causal.agency;
         h=from:content-type:content-transfer-encoding:mime-version
        :subject:date:references:to:in-reply-to:message-id; s=fm2; bh=Hm
        1y+u1gunQZzEKYpG0/c+f7psPLHQ2ImYpOgQfsO08=; b=a5vDHJGDlQFw6fkM6d
        XbAYHaWPja4VBAn0dsmIbLeTt7FF0imxOnYjyEOXT+tVc+BozvQBitSlek4sfitR
        cP+IzrLM2XBRvCkYlZH5jdb0NcH4RkbGcW7odY6UtGg7mJETCypWRzyrWaJYq1AT
        RTJuHNdZi24QvjTOq1SQcEYaEvB+MHUMt907WbOB/5iCn+JBk8Q4FjDOOHGgVX7H
        EVKIdNFcVpqyJhDvVdjmaxV6Vu/x/bToY2YNOVOwoHh89jc79DGVHOlFd800F2Uh
        3XlozwrAJ+naclLW/ai4jffgDz3fwlKKcA3kQ/sVo9CIZ89x7DPZ4o5ZUbj7gLan
        d8Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Hm1y+u1gunQZzEKYpG0/c+f7psPLHQ2ImYpOgQfsO
        08=; b=F4sI8RvRbRpxHZgRTB7GGwiVp7z4BMdwJhVMuRYoMDkWD0IKRlT5uo6DI
        7ko+5zdX0nsdkEZsL6LyVcxmEyyAUZb80rSqBL9kAmbgSnL+1dzC61pV9/Af9npD
        eu7LqGb/deVXojSr4Ft/XIWYVksIIADNQx2sCOT52POBe/jZytZOwyRmMUOfO5Yl
        Yl3awIvhHOWwOlJDe/apRL+2Qf9XjHp54q6zqRctZPDhbzvEixP0Q/rmyJWpqJPW
        CILptTinqJ6R3TI8Ug5cT/QdJzHiK15cTFc5MmhuV1i5Lsqj9Yx0hklIaDsVsz1A
        rNfzdQADzf6eQEcI+0O51B89oezxQ==
X-ME-Sender: <xms:l81YYfVSYGw1_oWuy4IIyU5wJU_5pL72lQ0NUXSMxTCmRFPZYvIplA>
    <xme:l81YYXmMXefIMGyZ7-D6f5F2YOj0mkhbgdZYS6xy3AVtGUr_zUDLNT7gzrNzZUphv
    xT92mRB45Zk-U9v6UE>
X-ME-Received: <xmr:l81YYbbd9fPCnlBKoxk6l5f3zYF813CVAQ2cge96bislzqnY9fKkQ8mMSJO8oos8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekkedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephfgtgfgguffffhfvjgfkofesth
    hqmhdthhdtjeenucfhrhhomhepjhhunhgvuceojhhunhgvsegtrghushgrlhdrrghgvghn
    tgihqeenucggtffrrghtthgvrhhnpedtleejkeehudevffffleehvdejfeevvdegffegud
    ehledtueduueekfeeujeeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehjuhhnvgestggruhhsrghlrdgrghgvnhgthi
X-ME-Proxy: <xmx:l81YYaVWjEH_DgAZ8PDCCqSLepFmv6RHFu-i2HvC25EJbbp82vawTw>
    <xmx:l81YYZnm-DB6IY1lfIBlZzMn6lXKnNK5Qu8I41LYaYPze4vGtebfeQ>
    <xmx:l81YYXdBGj2zh47kvRDxqP9aAM9UEfcLWwDt5sqXKpUvT6NRdD2_QA>
    <xmx:mM1YYXR1j9HCMS8LPCMUYJwhrzlJVesl6yEwiwmZVRZJypEftgFiVg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <dash@vger.kernel.org>; Sat, 2 Oct 2021 17:22:31 -0400 (EDT)
From:   june <june@causal.agency>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH] Fix chkmail loop break condition
Date:   Sat, 2 Oct 2021 17:22:30 -0400
References: <20211002203732.6175-1-june@causal.agency>
To:     dash@vger.kernel.org
In-Reply-To: <20211002203732.6175-1-june@causal.agency>
Message-Id: <16101B1E-904C-4B6E-B8A0-50B226C06A31@causal.agency>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

For some more context which you may want to add to the commit
message: I noticed dash would always print =E2=80=9Cyou have mail=E2=80=9D=
 three
times, and this fixes that. On further investigation, this loop was
taking the last path in MAILPATH (or the only string in MAIL) and
continuing to chop off the last character, so for MAIL=3D/var/mail/june,
it would stat:

/var/mail/june
/var/mail/jun
/var/mail/ju
/var/mail/j
/var/mail/
/var/mail
/var/mai
/var/ma
/var/m
/var/

And then stop because MAXMBOXES is 10. The three =E2=80=9Cyou have =
mail=E2=80=9D
messages were from /var/mail/june, /var/mail/ and /var/mail.

