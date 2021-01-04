Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB82C433DB
	for <linux-dash@archiver.kernel.org>; Mon,  4 Jan 2021 12:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7A121D93
	for <linux-dash@archiver.kernel.org>; Mon,  4 Jan 2021 12:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbhADMup (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 4 Jan 2021 07:50:45 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:49852 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbhADMup (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 4 Jan 2021 07:50:45 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kwPJ7-00076C-Jw; Mon, 04 Jan 2021 23:49:58 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 04 Jan 2021 23:49:57 +1100
Date:   Mon, 4 Jan 2021 23:49:57 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Denys Vlasenko <vda.linux@googlemail.com>
Cc:     DASH shell mailing list <dash@vger.kernel.org>
Subject: Re: set -I is not required by standard, and does not match bash
Message-ID: <20210104124957.GB21283@gondor.apana.org.au>
References: <CAK1hOcPjYpXa8GQsD5dmYnkUHqc_KC2BXj0NC6d49qi10Qt4kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1hOcPjYpXa8GQsD5dmYnkUHqc_KC2BXj0NC6d49qi10Qt4kA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Mon, Jan 04, 2021 at 01:22:30PM +0100, Denys Vlasenko wrote:
> Hello,
> 
> In dash, set -I is a short-option alias to set -o ignoreeof.
> 
> However, bash does not have such alias, it has an undocumented
> set -I which switches off "invisible variables"
> (I don't know what that is).
> 
> Standards do not mention any -I option.
> 
> I propose, in the interests of keeping things less disparate,
> to remove set -I support from dash: make "ignoreeof" to be
> only an -o long option.

This option goes all the way back to BSD.  Unless they have all
removed this option I'm not going to change it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
