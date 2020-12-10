Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFEFC4361B
	for <linux-dash@archiver.kernel.org>; Thu, 10 Dec 2020 12:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CFC420709
	for <linux-dash@archiver.kernel.org>; Thu, 10 Dec 2020 12:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgLJMNe (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 10 Dec 2020 07:13:34 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57832 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbgLJMNa (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 10 Dec 2020 07:13:30 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1knKoG-0005J7-Js; Thu, 10 Dec 2020 23:12:37 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 10 Dec 2020 23:12:36 +1100
Date:   Thu, 10 Dec 2020 23:12:36 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     Andrej Shadura <andrew@shadura.me>, dash@vger.kernel.org,
        peff@peff.net, 976865@bugs.debian.org
Subject: Re: Fwd: Bug#974900: dash removes trailing slash from script
 arguments
Message-ID: <20201210121236.GA28441@gondor.apana.org.au>
References: <f957f8b9-3430-4752-9798-9c5417d9707a@www.fastmail.com>
 <20201117033203.GA1084@gondor.apana.org.au>
 <20201209122717.GA2598168@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209122717.GA2598168@aurel32.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Dec 09, 2020 at 01:27:17PM +0100, Aurelien Jarno wrote:
>
> Can you please describe more precisely what is the problem with glob(3)?

Create a regular file called "foo", then call glob(3) with the
pattern "foo\/".  This returns a single match with the string
"foo".  This should return no match.

If you change the pattern to "foo/", then it also matches but
returns with the string "foo/" as expected.

The only flag we pass to glob(3) is GLOB_NOMAGIC.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
