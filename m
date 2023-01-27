Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA288C54EAA
	for <linux-dash@archiver.kernel.org>; Fri, 27 Jan 2023 10:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjA0KVm (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 27 Jan 2023 05:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjA0KVl (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 27 Jan 2023 05:21:41 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB811EBE5
        for <dash@vger.kernel.org>; Fri, 27 Jan 2023 02:21:37 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pLLrK-004g8d-DV; Fri, 27 Jan 2023 18:21:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Jan 2023 18:21:26 +0800
Date:   Fri, 27 Jan 2023 18:21:26 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     ganael.laplanche@martymac.org, jilles@stack.nl,
        dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Message-ID: <Y9Olps/fwxaItE4j@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119183330.geEMf%steffen@sdaoden.eu>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Steffen Nurpmeso <steffen@sdaoden.eu> wrote:
.
> Hm, i will attach a better one..  Shall anyone consider this,
> please use that not the older one!  Thanks.

Could you please resubmit the patch inline? For some reason it's
not getting picked up by patchwork and the quoted-printable format
does not a bit iffy.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
