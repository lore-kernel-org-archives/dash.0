Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B4BC4708D
	for <linux-dash@archiver.kernel.org>; Wed,  7 Dec 2022 04:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLGEDo (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 6 Dec 2022 23:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiLGEDn (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 6 Dec 2022 23:03:43 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805BD54B2C
        for <dash@vger.kernel.org>; Tue,  6 Dec 2022 20:03:42 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p2leg-004lsR-Bc; Wed, 07 Dec 2022 12:03:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 07 Dec 2022 12:03:34 +0800
Date:   Wed, 7 Dec 2022 12:03:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: Re: [PATCH] parser: Add VSBIT to ensure subtype is never zero
Message-ID: <Y5AQliTzAVyrF6x8@gondor.apana.org.au>
References: <Y47ZlpwkQy+jiule@gondor.apana.org.au>
 <2ec90a7f0cf3f0eebb9092725804f9d0bc4ec756.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec90a7f0cf3f0eebb9092725804f9d0bc4ec756.camel@scientia.org>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Dec 06, 2022 at 04:19:39PM +0100, Christoph Anton Mitterer wrote:
> 
> Is that already the final version of the patch? Cause then we could
> ping klibc sh / busybox about it.

Yes I will commit this to git soon.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
