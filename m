Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA6EC2D0E4
	for <linux-dash@archiver.kernel.org>; Mon, 16 Nov 2020 02:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5148216C4
	for <linux-dash@archiver.kernel.org>; Mon, 16 Nov 2020 02:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKPCrx (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 15 Nov 2020 21:47:53 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:43470 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgKPCrx (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 15 Nov 2020 21:47:53 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1keUYW-0007ul-UG; Mon, 16 Nov 2020 13:47:50 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 16 Nov 2020 13:47:48 +1100
Date:   Mon, 16 Nov 2020 13:47:48 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] shell: Enable fnmatch/glob by default
Message-ID: <20201116024748.GA26881@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8881007-eb6d-17b4-a023-31275ef28b94@web.de>
X-Newsgroups: apana.lists.os.linux.dash
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

René Scharfe <l.s.r@web.de> wrote:
> Hello,
> 
> on Debian testing dash eats trailing slashes of parameters that happen
> to be regular files when expanding "$@".  Example:
> 
>   $ rm -f foo bar
>   $ touch foo
>   $ dash -c 'echo "$0" "$@"' baz foo/ bar/ ./
>   baz foo bar/ ./

In fact you just have to do

	dash -c 'echo bar\/'

This is a bug in glob(3).  It's stripping the slash.

I guess we'll just have to disable glob again.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
