Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4736C433FE
	for <linux-dash@archiver.kernel.org>; Fri, 11 Dec 2020 02:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E7923E54
	for <linux-dash@archiver.kernel.org>; Fri, 11 Dec 2020 02:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgLKCGU (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 10 Dec 2020 21:06:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:57648 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388647AbgLKCFt (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 10 Dec 2020 21:05:49 -0500
Received: (qmail 3587 invoked by uid 109); 11 Dec 2020 02:05:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Dec 2020 02:05:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1991 invoked by uid 111); 11 Dec 2020 02:05:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Dec 2020 21:05:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Dec 2020 21:05:02 -0500
From:   Jeff King <peff@peff.net>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Aurelien Jarno <aurelien@aurel32.net>, 976865@bugs.debian.org,
        andrew@shadura.me, dash@vger.kernel.org
Subject: Re: Bug#976865: Fwd: Bug#974900: dash removes trailing slash from
 script arguments
Message-ID: <X9LTzo2b9iREhlEJ@coredump.intra.peff.net>
References: <20201116094531.GA40024@coredump.intra.peff.net>
 <20201210025654.GA26577@gondor.apana.org.au>
 <20201210075837.GN2297@aurel32.net>
 <20201210113508.GA28224@gondor.apana.org.au>
 <X9I8vStSYdovXOIM@coredump.intra.peff.net>
 <20201211020311.GA31996@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201211020311.GA31996@gondor.apana.org.au>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Fri, Dec 11, 2020 at 01:03:11PM +1100, Herbert Xu wrote:

> On Thu, Dec 10, 2020 at 10:20:29AM -0500, Jeff King wrote:
> >
> > It seems like it happens for "foo/", too. If I compile:
> 
> I think the key is that dash uses GLOB_NOMAGIC.

I wondered that, too, but adding GLOB_NOMAGIC to the call doesn't seem
to change the results. This is all with libc6 2.31-5, by the way.

-Peff
