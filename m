Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31362C53210
	for <linux-dash@archiver.kernel.org>; Thu,  5 Jan 2023 09:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjAEJpi (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 Jan 2023 04:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjAEJph (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 Jan 2023 04:45:37 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A464E479EA
        for <dash@vger.kernel.org>; Thu,  5 Jan 2023 01:45:36 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pDMoX-00E9Wu-U4; Thu, 05 Jan 2023 17:45:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Jan 2023 17:45:33 +0800
Date:   Thu, 5 Jan 2023 17:45:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] miscbltin: ulimitcmd: actually accept -r
Message-ID: <Y7acPW+gKpl0o54b@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221216172019.upb425kmpx75epml@tarta.nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
> [-- text/plain, encoding quoted-printable, charset: us-ascii, 30 lines --]
> 
> From: Vincent Lefevre <vincent@vinc17.net>
> 
> The original commit that added it supposes this works, but it only adds
> it to the ulimit -a listing and the manual, but doesn't allow it as an
> option.
> 
> Fixes: commit 46abc8c6d8a5e9a5712bdc1312c0b6960eec65a4 ("[BUILTIN] Add
> support for ulimit -r")
> Fixes: https://bugs.debian.org/975326
> ---
> src/miscbltin.c | 3 +++
> 1 file changed, 3 insertions(+)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
