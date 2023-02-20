Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56675C05027
	for <linux-dash@archiver.kernel.org>; Mon, 20 Feb 2023 09:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBTJE6 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 20 Feb 2023 04:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjBTJE5 (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 20 Feb 2023 04:04:57 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FF61025D
        for <dash@vger.kernel.org>; Mon, 20 Feb 2023 01:04:36 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pU262-00DIlA-5E; Mon, 20 Feb 2023 17:04:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 20 Feb 2023 17:04:30 +0800
Date:   Mon, 20 Feb 2023 17:04:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Schwindl <schwindl@posteo.de>
Cc:     dash@vger.kernel.org
Subject: Re: STATIC vs static
Message-ID: <Y/M3nmu6MdFLaCtm@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CQKVLXJRDK3X.124XXVEY9RH6K@morphine>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Tom Schwindl <schwindl@posteo.de> wrote:
> Hi all,
> 
> as I was skimming through the codebase, I noticed that sometimes there is a
> macro, STATIC, used to represent the normal static. Is there a reason for that
> or would a s/STATIC/static/g be welcome? Now that we are revising the prototypes
> anyway I think it's the right time to bring this up.

There is no reason why STATIC should exist in dash.  But if we're
going to clean it up we should make the whole function prototype and
definition consistent and not just the one word.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
