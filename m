Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F21C433EF
	for <linux-dash@archiver.kernel.org>; Tue, 18 Jan 2022 06:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiARGSf (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 18 Jan 2022 01:18:35 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59640 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbiARGSe (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 18 Jan 2022 01:18:34 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n9hp9-0007BS-Hu; Tue, 18 Jan 2022 17:18:32 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 18 Jan 2022 17:18:31 +1100
Date:   Tue, 18 Jan 2022 17:18:31 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     dash@vger.kernel.org
Subject: Re: possible wrong behaviour with patterns double [ with no closing ]
Message-ID: <YeZbt7nhvODBSL0I@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3709ca54c9001bffd3e690695c3b44d47d50c7c8.camel@scientia.org>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Christoph Anton Mitterer <calestyo@scientia.org> wrote:
>
> This works, btw. in bash, but neither in busybox sh, nor klibc sh.

This happens only with fnmatch.  So I would presume that it's
a bug in glibc and you can take it up with them.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
