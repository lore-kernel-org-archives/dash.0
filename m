Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5230DC433F5
	for <linux-dash@archiver.kernel.org>; Tue, 25 Jan 2022 03:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243916AbiAYDeU (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 24 Jan 2022 22:34:20 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60394 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3412327AbiAYAgl (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 24 Jan 2022 19:36:41 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nC9p5-0001pz-O7; Tue, 25 Jan 2022 11:36:36 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 25 Jan 2022 11:36:35 +1100
Date:   Tue, 25 Jan 2022 11:36:35 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     dash@vger.kernel.org
Subject: Re: possible wrong behaviour with patterns double [ with no closing ]
Message-ID: <Ye9GE+kuzAhQldKP@gondor.apana.org.au>
References: <YeZbt7nhvODBSL0I@gondor.apana.org.au>
 <7cdd1179822902ab5f9c565c35ac8d45dec51d04.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cdd1179822902ab5f9c565c35ac8d45dec51d04.camel@scientia.org>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Mon, Jan 24, 2022 at 05:26:16PM +0100, Christoph Anton Mitterer wrote:
> On Tue, 2022-01-18 at 17:18 +1100, Herbert Xu wrote:
> > This happens only with fnmatch.  So I would presume that it's
> > a bug in glibc and you can take it up with them.
> 
> FYI:
> 
> Was apparently fixed in git:
> https://sourceware.org/git/?p=glibc.git;a=commit;h=8442f0d966da5a9333e961af9e98b41aabdd9f1b

Thanks Chris!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
