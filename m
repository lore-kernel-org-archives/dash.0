Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513DFC352A1
	for <linux-dash@archiver.kernel.org>; Tue,  6 Dec 2022 10:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiLFKlF (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 6 Dec 2022 05:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiLFKko (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 6 Dec 2022 05:40:44 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4D31DF13
        for <dash@vger.kernel.org>; Tue,  6 Dec 2022 02:40:42 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p2VNQ-004REC-4Z; Tue, 06 Dec 2022 18:40:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 06 Dec 2022 18:40:40 +0800
Date:   Tue, 6 Dec 2022 18:40:40 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] eval: Always set exitstatus in evaltree
Message-ID: <Y48cKLFyrgU/+ckE@gondor.apana.org.au>
References: <Y48CCiIAagbl5q0L@gondor.apana.org.au>
 <ce0c3ef7-66a9-08de-546f-d8ef8263b6da@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce0c3ef7-66a9-08de-546f-d8ef8263b6da@gigawatt.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Dec 06, 2022 at 10:15:03AM +0000, Harald van Dijk wrote:
>
> There is a long-standing bug that may or may not be harder to fix if this
> patch goes in, depending on how you want to fix it. Here's a script that
> already fails on current dash.
> 
>   f() {
>     if ! return 0
>     then :
>     fi
>   }
>   f
> 
> This should return 0, and does return 0 in bash and ksh (and almost all
> shells), but returns 1 in dash.
> 
> There are a few possible ways of fixing it. Some of them rely on continuing
> to conditionally set exitstatus.

Thanks.  I'll keep this in mind.  We could always back this out
if needed.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
