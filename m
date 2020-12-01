Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CCCC64E7A
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 11:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE64C2080A
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 11:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgLALCi (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:02:38 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:48576 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgLALCi (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 1 Dec 2020 06:02:38 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kk3Pm-0003Fa-Mn; Tue, 01 Dec 2020 22:01:47 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 01 Dec 2020 22:01:46 +1100
Date:   Tue, 1 Dec 2020 22:01:46 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     Andrej Shadura <andrew.shadura@collabora.co.uk>,
        dash@vger.kernel.org, Michael Biebl <biebl@debian.org>,
        974705@bugs.debian.org
Subject: Re: Changes to job handling cause hangs in wait
Message-ID: <20201201110146.GA28450@gondor.apana.org.au>
References: <20201201053837.GA26889@gondor.apana.org.au>
 <20201201054203.GA27074@gondor.apana.org.au>
 <20201201060618.GA27281@gondor.apana.org.au>
 <0e6bb3c5-96d9-18e1-e6bb-87cb34f85fab@gigawatt.nl>
 <20201201103448.GA28234@gondor.apana.org.au>
 <861e7a14-3dfc-83f7-8872-714b333d4246@gigawatt.nl>
 <20201201105328.GA28341@gondor.apana.org.au>
 <0db96973-afda-81a3-004f-786ffa60dca9@gigawatt.nl>
 <20201201105604.GA28392@gondor.apana.org.au>
 <f49a6670-dab4-9e0b-24c0-9506cbf76b03@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f49a6670-dab4-9e0b-24c0-9506cbf76b03@gigawatt.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Dec 01, 2020 at 10:59:20AM +0000, Harald van Dijk wrote:
> 
> I do not appreciate your false accusation that I did not read your follow-up
> email. You suggested that as an alternative, without retracting your claim
> that this is a problem in bash.

Well I'm not accusing you of anything, I was just trying to make
sure you are aware of my complete message.

In any case, I never said that this is a bug in bash, merely that
bash is involved in creating a situation where dash started out
with children in the background.

If anything this could just be an artefact of the bash script
rather than bash itself.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
