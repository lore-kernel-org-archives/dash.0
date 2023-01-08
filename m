Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2DDC54EBC
	for <linux-dash@archiver.kernel.org>; Sun,  8 Jan 2023 12:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjAHMHA (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 8 Jan 2023 07:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjAHMG6 (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Jan 2023 07:06:58 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE4710075
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 04:06:56 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pEURt-00FD37-LP; Sun, 08 Jan 2023 20:06:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 08 Jan 2023 20:06:49 +0800
Date:   Sun, 8 Jan 2023 20:06:49 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     jilles@stack.nl, dash@vger.kernel.org
Subject: Re: [PATCH v2] redir: savefd: use F_DUPFD_CLOEXEC instead of
 F_DUPFD+F_SETFD, if available
Message-ID: <Y7qx2R+lmJ4KFpln@gondor.apana.org.au>
References: <Y7aVs5pglzAvbnfn@gondor.apana.org.au>
 <20230105124321.gsmk7h7xpuss75hw@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105124321.gsmk7h7xpuss75hw@tarta.nabijaczleweli.xyz>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thu, Jan 05, 2023 at 01:43:21PM +0100, наб wrote:
> This saves a syscall on every source file open, &c.;
> F_DUPFD_CLOEXEC is a mandatory part of POSIX since Issue 7
> (Austin Group Interpretation 1003.1-2001 #171).
> ---
>  configure.ac | 11 +++++++++++
>  src/redir.c  |  7 ++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
