Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CABC433DB
	for <linux-dash@archiver.kernel.org>; Thu, 14 Jan 2021 15:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DBD23A7E
	for <linux-dash@archiver.kernel.org>; Thu, 14 Jan 2021 15:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbhANPok (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:44:40 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47427 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725849AbhANPoe (ORCPT
        <rfc822;dash@vger.kernel.org>); Thu, 14 Jan 2021 10:44:34 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3BDD05C0143;
        Thu, 14 Jan 2021 10:43:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 14 Jan 2021 10:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=causal.agency;
         h=content-type:mime-version:subject:from:in-reply-to:date:cc
        :content-transfer-encoding:message-id:references:to; s=fm3; bh=X
        LHwwUYqkzRGSf84u47C/vjnufh+NSmNbeMHMKh3cZ4=; b=EEB0nYMAM83J0redp
        fo53Z6AnDV96yTlGyWnnP0yB4h9LMuyL4vDE4ktq0CLDV8WwsSRyeLyA7o1fanf6
        fBbmMNNl+yL1LF/bujC6ldSagJVFdRM8RhXBATqDTWarz/SdapmJGStgVvJJxnjk
        8kG/IK470ldQX6Wh3K7N8mbGJhLrDpHqI3yGvjfCuAg9W3FMy7xEBBSnbJdEIvBG
        lI5suJolM7YrbvV3IE64h+wSU+uL9AT2diU5r4w2+MzTFtffOXAllzqet7G1xCdB
        AmknfOEpr+Ho5EAO9Zi/2LfmD2oD0VgnWziycjrxnICdNGnPRDiQph5KYu3sKyLN
        rUb8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=XLHwwUYqkzRGSf84u47C/vjnufh+NSmNbeMHMKh3c
        Z4=; b=Gg89mOASqfix4a+rBMTyc6m0YLY9A16EBg0UM7A13+IiO1MGRkWCfte5M
        pIVRV0tqe9Tgp2d0meXCPuUVjs465OGQSaAaJUYdD8n6tduLF0KwTbFpYBsp9SFh
        Lqw9aBp3ntTc1liEPW3V5YSFon+o+YK3lIXvT+nKTIn/6Fuzz9qCCLm1xdLWSW7J
        D20lzl67rfu4AsvIBrjypzL5TnH/tG2v2/LLRztHbq1syo5UAMtiu6eNKlLQV/3a
        j2d8s4tAHoIquMbcfk9jV7pOKAgtcj/bviX7MHay6xUgU20cd6rTV0JZ8qfY1ZEU
        T8JwbQRvU2GZUGC6SntzsKkXHhquQ==
X-ME-Sender: <xms:mmYAYEB3r-JtrOUvv1wTo7ItfJCHfnwoyfZJQdTeRnordzkiTswgIg>
    <xme:mmYAYHQVT__daaG6z7lYI5cOFvH4XHirWLQlSB97KoOAi5Yt106aFdeOoNKC2TH_x
    jnYNhigXxgmUqakJHM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddtgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegtggfuhfgjfffgkfhfvffosehtjehmtdhhtddvnecuhfhrohhmpefluhhnvgcu
    uehughcuoehjuhhnvgestggruhhsrghlrdgrghgvnhgthieqnecuggftrfgrthhtvghrnh
    epheevgfekhefhteejgeegkeejuddugeejkeeiffehtdfhudefuddtledvleffjeevnecu
    kfhppedutdegrdduieefrdduledtrddvvdelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhunhgvsegtrghushgrlhdrrghgvghntgih
X-ME-Proxy: <xmx:mmYAYDt5ErA77v7zoHsHfRSXk4TIsVhxOupjotBWFvjfcN-dnbFxXA>
    <xmx:mmYAYL0WNYv6PAM6iMmXHtLZr9_ibNbQJtddyKzepmiX0Aau1kImnQ>
    <xmx:mmYAYMWAEtOhmir81R00IbMZDaov_UiFjLtrUJbGPD8RnvV2_tAjYg>
    <xmx:m2YAYLUpz1XRbRj1nD7CdVlfscpwNtqEYVujt-84dFkmGZjxhn0UzA>
Received: from [10.0.1.13] (unknown [104.163.190.229])
        by mail.messagingengine.com (Postfix) with ESMTPA id 86207240067;
        Thu, 14 Jan 2021 10:43:22 -0500 (EST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] Cache the expanded prompt for editline
From:   June Bug <june@causal.agency>
In-Reply-To: <20210113061802.GA6215@gondor.apana.org.au>
Date:   Thu, 14 Jan 2021 10:43:21 -0500
Cc:     dash@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F9311B17-4FC9-4623-9512-8022D4B96BFB@causal.agency>
References: <20210113061802.GA6215@gondor.apana.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

> On Jan 13, 2021, at 01:18, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
> What if someone actually wanted the prompt to change?

It seems unlikely given the lack of consistency of when libedit
calls the prompt callback. I only noticed it was happening when I
patched in support for EL_RPROMPT (right-aligned prompts), which
when active causes libedit to call the prompt callback on *every*
keypress. It seemed not to happen with only a regular prompt and
it took some experimenting to notice typing backspaces causes it.
The behaviour is completely undocumented in libedit.

Anecdotally, typing at the prompt becomes painful when it is expanded
over and over and does anything non-trivial, even just a command
substitution that runs no external commands.
