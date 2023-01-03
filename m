Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067BDC3DA7A
	for <linux-dash@archiver.kernel.org>; Tue,  3 Jan 2023 01:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjACBjY (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 2 Jan 2023 20:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjACBjY (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 2 Jan 2023 20:39:24 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3229B2ADF
        for <dash@vger.kernel.org>; Mon,  2 Jan 2023 17:39:20 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pCWGr-00DJwR-CC; Tue, 03 Jan 2023 09:39:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 03 Jan 2023 09:39:17 +0800
Date:   Tue, 3 Jan 2023 09:39:17 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH 1/2] exec: type: ignore first --, per POSIX
Message-ID: <Y7OHRV9Mf1agWIMC@gondor.apana.org.au>
References: <b9085f1a9812a436d37bc6f8d96d17bdba4433c5.1670966008.git.nabijaczleweli@nabijaczleweli.xyz>
 <Y7KhlatS/XnFn3VP@gondor.apana.org.au>
 <20230102124628.w6mtevhvnuthco4j@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230102124628.w6mtevhvnuthco4j@tarta.nabijaczleweli.xyz>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Mon, Jan 02, 2023 at 01:46:28PM +0100, наб wrote:
> On Mon, Jan 02, 2023 at 05:19:17PM +0800, Herbert Xu wrote:
> > наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
> > > Issue 7, XCU, type, OPTIONS reads "None.",
> > type is marked XSI.  dash does claim conformance with respect
> > to XSI.
> Which means it ought to abide by "None." in the OPTIONS sexion,
> as out-lined in the subsequent lines, i.e. discard an initial --, yes.
> 
> Good to see we agree, I guess?

Sorry, I meant that dash does not claim conformance.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
