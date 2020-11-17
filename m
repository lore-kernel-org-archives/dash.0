Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02E4C6369E
	for <linux-dash@archiver.kernel.org>; Tue, 17 Nov 2020 03:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76FFF246A7
	for <linux-dash@archiver.kernel.org>; Tue, 17 Nov 2020 03:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgKQDcI (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 16 Nov 2020 22:32:08 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:47396 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgKQDcH (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 16 Nov 2020 22:32:07 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kerit-0000qn-QA; Tue, 17 Nov 2020 14:32:04 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 17 Nov 2020 14:32:03 +1100
Date:   Tue, 17 Nov 2020 14:32:03 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrej Shadura <andrew@shadura.me>
Cc:     dash@vger.kernel.org, peff@peff.net, 974900@bugs.debian.org
Subject: Re: Fwd: Bug#974900: dash removes trailing slash from script
 arguments
Message-ID: <20201117033203.GA1084@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f957f8b9-3430-4752-9798-9c5417d9707a@www.fastmail.com>
X-Newsgroups: apana.lists.os.linux.dash
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Andrej Shadura <andrew@shadura.me> wrote:
> 
> this is another bug report I have received.

This is a bug in glob(3).  Please dup and reassign to libc6.  There
is a patch in the queue to disable glob by default again.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
