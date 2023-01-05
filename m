Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78F4C3DA7A
	for <linux-dash@archiver.kernel.org>; Thu,  5 Jan 2023 09:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjAEJCr (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 Jan 2023 04:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjAEJCp (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 Jan 2023 04:02:45 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7699D50068
        for <dash@vger.kernel.org>; Thu,  5 Jan 2023 01:02:43 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pDM92-00E8ge-D1; Thu, 05 Jan 2023 17:02:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Jan 2023 17:02:40 +0800
Date:   Thu, 5 Jan 2023 17:02:40 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH v2] parser: don't keep alloca()ing in a loop for
 substitutions
Message-ID: <Y7aSMJlVi7fXD1DC@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221215170216.hm6i5akmxbz6u62j@tarta.nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> Naturally, I hadn't considered that.
> 
> This version I've run through valgrind in a good few configurations and
> am happy to conclude there are no leaks (and the memory usage bump is
> imperceptible unless you were almost-crashing anyway).

Nice work!

> @@ -1446,10 +1443,8 @@ done:
>        if (oldstyle)
>                tokpushback = 0;
>        out = growstackto(savelen + 1);
> -       if (str) {
> -               memcpy(out, str, savelen);
> -               STADJUST(savelen, out);
> -       }
> +       memcpy(out, str, savelen);
> +       STADJUST(savelen, out);

Minor nit but these three lines can be combined into:

	out = stnputs(stackblock(), str, savelen);

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
