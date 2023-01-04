Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EECC46467
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 08:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjADI7f (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Jan 2023 03:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjADI7M (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Jan 2023 03:59:12 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B7B1F2
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 00:59:11 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pCzc0-00DkPM-Qw; Wed, 04 Jan 2023 16:59:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 04 Jan 2023 16:59:04 +0800
Date:   Wed, 4 Jan 2023 16:59:04 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
Subject: Re: [v3 PATCH] input: Read standard input byte-wise
Message-ID: <Y7U/2PnYCDA5stZ8@gondor.apana.org.au>
References: <Y7PIHqN4ic4UBOBb@gondor.apana.org.au>
 <9a6c2bc5-11aa-db99-8db5-541060624b01@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a6c2bc5-11aa-db99-8db5-541060624b01@gigawatt.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Jan 03, 2023 at 11:54:55AM +0000, Harald van Dijk wrote:
>
> Does it? preadbuffer() knows to call history() with the H_APPEND flag to
> append a next chunk of input to what was already added to the buffer.

It only uses H_APPEND once a newline has been detected and
whichprompt switches over to PS2.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
