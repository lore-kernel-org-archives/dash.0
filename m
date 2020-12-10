Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A958FC433FE
	for <linux-dash@archiver.kernel.org>; Thu, 10 Dec 2020 11:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610B423D57
	for <linux-dash@archiver.kernel.org>; Thu, 10 Dec 2020 11:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389571AbgLJLgM (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 10 Dec 2020 06:36:12 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57806 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389478AbgLJLgG (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 10 Dec 2020 06:36:06 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1knKE0-0004Y4-93; Thu, 10 Dec 2020 22:35:09 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 10 Dec 2020 22:35:08 +1100
Date:   Thu, 10 Dec 2020 22:35:08 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     976865@bugs.debian.org, andrew@shadura.me, dash@vger.kernel.org,
        peff@peff.net
Subject: Re: Bug#976865: Fwd: Bug#974900: dash removes trailing slash from
 script arguments
Message-ID: <20201210113508.GA28224@gondor.apana.org.au>
References: <20201116094531.GA40024@coredump.intra.peff.net>
 <20201210025654.GA26577@gondor.apana.org.au>
 <20201210075837.GN2297@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210075837.GN2297@aurel32.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thu, Dec 10, 2020 at 08:58:37AM +0100, Aurelien Jarno wrote:
>
> That's the dash symptoms. glob(3) takes a pattern and just returns the
> paths matching the pattern, as they are named on the filesystem. That
> said, the option GLOB_MARK can return a trailing slash for all matched
> path that are a directory.

Yes but it's really a bug in glob(3).  It should really return
a no-match for the case in question, rather than matching and then
returning a filename without the slash.

IOW the pattern "foo\/" should not match a regular file foo.

Note that the problem doesn't occur for "foo/".

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
