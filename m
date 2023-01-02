Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D217C3DA7A
	for <linux-dash@archiver.kernel.org>; Mon,  2 Jan 2023 09:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjABJTZ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 2 Jan 2023 04:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjABJTY (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 2 Jan 2023 04:19:24 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D92E6A
        for <dash@vger.kernel.org>; Mon,  2 Jan 2023 01:19:20 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pCGyT-00D6Tp-CZ; Mon, 02 Jan 2023 17:19:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 02 Jan 2023 17:19:17 +0800
Date:   Mon, 2 Jan 2023 17:19:17 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH 1/2] exec: type: ignore first --, per POSIX
Message-ID: <Y7KhlatS/XnFn3VP@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9085f1a9812a436d37bc6f8d96d17bdba4433c5.1670966008.git.nabijaczleweli@nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
> [-- text/plain, encoding quoted-printable, charset: utf-8, 41 lines --]
> 
> Issue 7, XCU, type, OPTIONS reads "None.",

type is marked XSI.  dash does claim conformance with respect
to XSI.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
