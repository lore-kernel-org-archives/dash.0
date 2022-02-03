Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AD8C433EF
	for <linux-dash@archiver.kernel.org>; Thu,  3 Feb 2022 15:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347983AbiBCPPI (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 3 Feb 2022 10:15:08 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:47479 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235309AbiBCPPI (ORCPT
        <rfc822;dash@vger.kernel.org>); Thu, 3 Feb 2022 10:15:08 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6E8A13202227;
        Thu,  3 Feb 2022 10:15:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 03 Feb 2022 10:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        greenberg.science; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=CXxveSqRpsjcQMdWfuVQ6SwaJth9shphfUOj0tqXK/Y=; b=RVnM6
        Zxrdv6XjfNVvSPP78AxgnJny46MuTJujyEETIgnIuxF2XIcvtDj/zUWZzfV0V89I
        v8EpGPAuDy84qP33eIs1grrCcETpbiOROk6sZmrhBTuFHB+ejGxq1bWEXpdaIYqs
        A9rV/OsLmoIaAy46kX6tAcdTjxQg1nrHwB7pXu5pDtBdwJctOZAQUEiCrnZYzbyV
        NRUVci4Od+IsS3iffgXaxYNd4VwzjQrGg2K4jSH7JnftSnV2l+CLa9Sj79FH2/Im
        ehfZAkSKOm26I4vXAmlLLVvX9Qoiq9LLEpQ991tCtmPA0Txbmm/6DqKALIUEsEjl
        bXnbDYE6Fap3rn+aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=CXxveSqRpsjcQMdWfuVQ6SwaJth9shphfUOj0tqXK/Y=; b=Tfu9Gvvw
        7bs9kwmNLD6d8wqSVqxGBaFvX3RTNEw488M2RSb091LdbHaiOGXLkqTNg9BaIZjU
        3EN9N8vatfvSIYPznRr/qSBA1DJYg88rsfS7HtWYNLnXxsEow+gZJ7aAVTJ9EVks
        GCVPWRE4f4MI35+5zMjuRaMnx/2fLq1hJV7gBVv2c7ZKldFGqExjB6oDHaN1iBul
        pJA6cm5emh1F8SJ/0U8xuXce4/OLUbCtvvpOfB1P2xzkK2gvelU61kn905zOlXUo
        GNOEAjB6EMUT2q6BIm1lq9h2QCSZewBxBFb/tBGJOyxNV4zN3lSXIK3Lb3MqmTTF
        2z85qp7qA9wH6A==
X-ME-Sender: <xms:evH7YXj20rHFV2G2ViDXpPZcLZCU6HyjDJmrunhQKZeSDeORDlpHtg>
    <xme:evH7YUDd2M68ioWpvD5l4Rkw7Uzb84CKFii3faDw_5XQ8z9yoNXnMXDz9q2Gp07Kn
    Uq67DUMXbPi5xWT8y4>
X-ME-Received: <xmr:evH7YXEMfldo_7qm2EEQ7ipqXRKblIVmVXnPykJy97JT0fD8R5aPq089NQ0U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeejgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffujghffffkgggtgfesthhqredttddtjeenucfhrhhomhepofhitghhrggv
    lhcuifhrvggvnhgsvghrghcuoehmihgthhgrvghlsehgrhgvvghnsggvrhhgrdhstghivg
    hntggvqeenucggtffrrghtthgvrhhnpeeggfeugeefffelheegfefgfffhgeeggeevieef
    veetueekffelgefftdfgkedtieenucffohhmrghinhepohhpvghnghhrohhuphdrohhrgh
    dpghhithhhuhgsrdgtohhmpdhoihhlshhhvghllhdrohhrghdpghhnuhdrohhrghdpfihi
    nhgurhhivhgvrhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmihgthhgrvghlsehgrhgvvghnsggvrhhgrdhstghivghntggv
X-ME-Proxy: <xmx:evH7YUQ-6DoM77FSRC0bRhyytvjFmtFRVzY37huGGAmIxP4qDvLrgQ>
    <xmx:evH7YUxfx1f-Y63YF445aik8719WUqTod9F0zCvt497EfQAaWZQvqw>
    <xmx:evH7Ya53eMIsGI1QArU71Ms4g2atnEVxe6KLt6yRYugvjFmF2vzqdQ>
    <xmx:e_H7YRpOxy04vE06AHkJM-3W5t6xqYhSEzP07vqvAgD4MLs4BmaXRA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Feb 2022 10:15:06 -0500 (EST)
From:   Michael Greenberg <michael@greenberg.science>
To:     Brian Kuhl <brian.kuhl@windriver.com>,
        Andrej Shadura <andrew.shadura@collabora.co.uk>,
        dash <dash@vger.kernel.org>
Subject: Re: Testing dash on a new OS?
In-Reply-To: <46266bf7-82ec-945e-7645-6d65b5393119@collabora.co.uk>
References: <DM6PR11MB34686DFD31F7C9C07D3F8B1D998B9@DM6PR11MB3468.namprd11.prod.outlook.com>
 <BL0PR11MB34587FF7466464F0C18F2C68998B9@BL0PR11MB3458.namprd11.prod.outlook.com>
 <46266bf7-82ec-945e-7645-6d65b5393119@collabora.co.uk>
Date:   Thu, 03 Feb 2022 10:15:05 -0500
Message-ID: <m2r18kf0cm.fsf@greenberg.science>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Bumping this old thread.

There are a few attempts at carefully testing POSIX shells:

  - POSIX <http://www.opengroup.org/testing/downloads.html>

  - Smoosh <https://github.com/mgree/smoosh/tree/master/tests>
    [disclaimer: I'm the author]

  - Oil
    <https://www.oilshell.org/release/latest/test/spec.wwz/survey/osh.html>

  - Yash <https://github.com/posix-shell-tests/posix-shell-tests>

  - Bash <https://git.savannah.gnu.org/cgit/bash.git/tree/tests>

None of these are a perfect fit for testing any of dash's particular
behaviors (e.g., dash treats non-lexical control differently from bash).

I would be _very_ interested in helping to build a test suite for POSIX
shells in general; I would be happy to also build a test suite for dash
in particular. Not only would such a test suite help identify
regressions in dash, it would also serve to document dash-specific
choices for unspecified and undefined behavior.

Cheers,
Michael

On 2021-11-02 at 01:47:53 PM, Andrej Shadura wrote:

> Hi,
>
> On 02/11/2021 01:45, Kuhl, Brian wrote:
>> Myself and an intern are working on porting dash to VxWorks.
>> https://www.windriver.com/products/vxworks
>>=20
>> I've found harness for testing scripts, I haven't found anything for ver=
ifying dash itself?
>> How does Debian, or any other distro, (or for that matter a BSD),  regre=
ssion test dash?
>
> Answering for Debian: we don=E2=80=99t really. There is only a smoke test=
=20
> verifying dash exists and symlinks to it are all in place, but nothing=20
> more than that at the moment.
>
> --=20
> Cheers,
>    Andrej
