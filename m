Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1128C433DB
	for <linux-dash@archiver.kernel.org>; Thu,  7 Jan 2021 02:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6874822D75
	for <linux-dash@archiver.kernel.org>; Thu,  7 Jan 2021 02:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbhAGCv0 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 6 Jan 2021 21:51:26 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:34760 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbhAGCv0 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 6 Jan 2021 21:51:26 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kxLNl-0003xd-L6; Thu, 07 Jan 2021 13:50:38 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 07 Jan 2021 13:50:37 +1100
Date:   Thu, 7 Jan 2021 13:50:37 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     dash@vger.kernel.org
Subject: Re: dash 0.5.11.2: somehow falsely waits
Message-ID: <20210107025037.GA376@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106204403.jGQ3n%steffen@sdaoden.eu>
X-Newsgroups: apana.lists.os.linux.dash
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Steffen Nurpmeso <steffen@sdaoden.eu> wrote:
>
> |Can you please retest with 6359d7aa739b9f02f622805f4dbddeaf0ae61981?
> 
> It works fine with the patch from the other message (repository at
> kernel.org does not know about the commit).

Thanks for confirming.  It's strange that you can't find the
commit though because it appears to be there:

https://git.kernel.org/pub/scm/utils/dash/dash.git/commit/?id=6359d7aa739b9f02f622805f4dbddeaf0ae61981

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
