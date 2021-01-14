Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06928C433DB
	for <linux-dash@archiver.kernel.org>; Thu, 14 Jan 2021 20:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDAE623A05
	for <linux-dash@archiver.kernel.org>; Thu, 14 Jan 2021 20:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbhANUX0 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:23:26 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50599 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbhANUX0 (ORCPT
        <rfc822;dash@vger.kernel.org>); Thu, 14 Jan 2021 15:23:26 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 11D995C00F5;
        Thu, 14 Jan 2021 15:22:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 14 Jan 2021 15:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=causal.agency;
         h=content-type:mime-version:subject:from:in-reply-to:date:cc
        :content-transfer-encoding:message-id:references:to; s=fm3; bh=q
        Z9IqyR9pViunW0x9OSOduMOSQBNmNCq+YlOCxE9Mgg=; b=Ypa5TT9ZwX9mgPc5q
        OAS3DTl3eAUE7TV54bFEob1Jaqrf3VeJlfH9J4tbIrmIPNmbjZPgEcAgoAFl39eP
        EBROsIWHpBMnFuL1FbNz4ej/y/2G7ZQCuCetglL6G+I1erGCa5r6sYT1l7EWpdln
        tt/QtiEhX9C60jHDwExjhiQxdqF03MehSJ/d6ZRrog5QTLZMYCfQpJ32FCWUIG8j
        q+8zd0o8yBTzxj2fj7IfKDU3GaamIMR8uMCbRgvgEGsMsrrhJcZ4R8bdNO9jCvHD
        yAw0MXCDsRoD7dOu/C4mvahXsQBdWFu9HK8I65kB+zv++jmAsOnjL4k14ss4pEWD
        RwNiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=qZ9IqyR9pViunW0x9OSOduMOSQBNmNCq+YlOCxE9M
        gg=; b=ReURgSo8KLQNHkgamcIuOEuPLx7GMzOAAGNkXgEAnlKXsweMcNI3ni+jf
        Lj6BoC+QziYP/JZJxctzIUYsGHQ5A4PQd7CjGIU454OStxnue6K45hg3cludmcN9
        uSkEaUb512laTj7bIic33NxpV8EfPye+LIQpr0KM1aBlnNGuGs3b848gUEqjvc1A
        Gxn98Jv7VyqcnG0nvJcGpcL7HYwXUf/COcZVjrMB2HkHkFxwXVFxpV61yuZaDUqe
        Dn0jK/8PiNwFNxPrdSFvT/4M3so+YZJkgcld2OT9SHWIszJT11M9QwzeVUhzoiv9
        1V23j3y/Z6I+0uIbVXXFIShuNebTQ==
X-ME-Sender: <xms:9qcAYLTvVVWB3Ec5wF3xk4lUSboNlcu6BeeiIgzzn-ll8Yxy8C_EJQ>
    <xme:9qcAYMtIWAW_XjrfR-_UIGhH-uqqPmk56N_DktZNLpAEZYH1mtduM8vsQ2S8q9Xmx
    1_fve7Qy1QuqjRP3zs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddtgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheplfhunhgv
    uceuuhhguceojhhunhgvsegtrghushgrlhdrrghgvghntgihqeenucggtffrrghtthgvrh
    hnpeffueeigeeftdettefggffhuedtffdukeehtdefudfgfeeiieehveeigefgtdelgfen
    ucfkphepuddtgedrudeifedrudeltddrvddvleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhnvgestggruhhsrghlrdgrghgvnhgthi
X-ME-Proxy: <xmx:9qcAYNtVRl5rJ11FCSjrEw8vCqdZcwRj6XKnEosius7OfHzgkR61UA>
    <xmx:9qcAYCw9pCZSDtnWjXwOCX61RNAlGqVP0BHOYuYPurm6j1TPpLwMPQ>
    <xmx:9qcAYDidcp4FvO_C9FXgFpvfsuYZHQr19lIncJEyURzdOT0FMNXgqw>
    <xmx:96cAYP6UkwE_nu45lFYSXEPKPRHS8QHMzcFZwDOZTyRy7FGWgGKtsA>
Received: from [10.0.1.13] (unknown [104.163.190.229])
        by mail.messagingengine.com (Postfix) with ESMTPA id 03318240057;
        Thu, 14 Jan 2021 15:22:13 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] Cache the expanded prompt for editline
From:   June Bug <june@causal.agency>
In-Reply-To: <20210114201257.GA15898@gondor.apana.org.au>
Date:   Thu, 14 Jan 2021 15:22:12 -0500
Cc:     dash@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE821D1C-17D6-4C23-8318-AA0006483B0D@causal.agency>
References: <20210113061802.GA6215@gondor.apana.org.au>
 <F9311B17-4FC9-4623-9512-8022D4B96BFB@causal.agency>
 <20210114201257.GA15898@gondor.apana.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

> On Jan 14, 2021, at 15:12, Herbert Xu <herbert@gondor.apana.org.au> =
wrote:
>=20
> OK, in that case I think it's best to fix this in libedit instead.

Huh? There=E2=80=99s no issue in libedit, only unclear documentation. =
The
application is the right place to store the prompt: it can be in a
static buffer, or a constant string, in which case libedit has no
need to save its own copy.
