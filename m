Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F26C54EAA
	for <linux-dash@archiver.kernel.org>; Mon, 30 Jan 2023 07:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjA3HWF (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 30 Jan 2023 02:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3HWE (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 30 Jan 2023 02:22:04 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72DA18144
        for <dash@vger.kernel.org>; Sun, 29 Jan 2023 23:22:02 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pMOUC-005Ugp-ED; Mon, 30 Jan 2023 15:21:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 30 Jan 2023 15:21:52 +0800
Date:   Mon, 30 Jan 2023 15:21:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ganael Laplanche <ganael.laplanche@martymac.org>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>, jilles@stack.nl,
        dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Message-ID: <Y9dwEOSA7SR9+ovZ@gondor.apana.org.au>
References: <Y9Olps/fwxaItE4j@gondor.apana.org.au>
 <2744018.j5hJsU0yqa@dmc12.centralesupelec.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2744018.j5hJsU0yqa@dmc12.centralesupelec.fr>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Fri, Jan 27, 2023 at 12:46:35PM +0100, Ganael Laplanche wrote:
>
> Here it is:

Sorry but that didn't work either, please have a look at the
list of patches on the queue:

https://patchwork.kernel.org/project/dash/list/

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
