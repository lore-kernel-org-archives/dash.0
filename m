Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E41C433FE
	for <linux-dash@archiver.kernel.org>; Tue, 18 Jan 2022 22:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349991AbiARWd7 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 18 Jan 2022 17:33:59 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59650 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237457AbiARWd7 (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 18 Jan 2022 17:33:59 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n9x2z-0002W1-EN; Wed, 19 Jan 2022 09:33:50 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 19 Jan 2022 09:33:49 +1100
Date:   Wed, 19 Jan 2022 09:33:49 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     harald@gigawatt.nl, dash@vger.kernel.org
Subject: Re: [PATCH] expand: Always quote caret when using fnmatch
Message-ID: <YedATfqFnNsewxG+@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00db46ee5ab57e1282f4808e2103e74699083db3.camel@scientia.org>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Christoph Anton Mitterer <calestyo@scientia.org> wrote:
> Hey.
> 
> Just for confirmation:
> 
> Would that also be an issue in fnmatch() (i.e. should it be forwarded?)
> or really just something in dash?

No I don't think this is an fnmatch issue.  It's dash's fault
for not quoting the caret before passing it to glibc.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
