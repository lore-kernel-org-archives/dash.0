Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CE0C7EE29
	for <linux-dash@archiver.kernel.org>; Thu,  8 Jun 2023 10:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjFHKCs (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 8 Jun 2023 06:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjFHKCr (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 8 Jun 2023 06:02:47 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C1926BA
        for <dash@vger.kernel.org>; Thu,  8 Jun 2023 03:02:45 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q7CTT-000XqU-DZ; Thu, 08 Jun 2023 18:02:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 08 Jun 2023 18:02:35 +0800
Date:   Thu, 8 Jun 2023 18:02:35 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
Subject: Re: [Debian#1037195] dash: $(here-doc in <<substitution) is always
 empty, must consume subsequent lines per POSIX?
Message-ID: <ZIGnOzJfPR0+0PNx@gondor.apana.org.au>
References: <ZIGaJAHo8OY1QzQa@gondor.apana.org.au>
 <efbfb9b1-5e73-0ff7-2b17-56c1406982c7@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efbfb9b1-5e73-0ff7-2b17-56c1406982c7@gigawatt.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thu, Jun 08, 2023 at 10:19:24AM +0100, Harald van Dijk wrote:
>
> https://austingroupbugs.net/view.php?id=1036

If this is the text in the final document, then there is no
question that the behaviour of dash is allowed:

: For "$(" and '`' only, if instances of io_here tokens are found nested
: within the substitution, they shall be parsed according to the rules
: of [xref to 2.7.4]; if the terminating ')' or '`' of the substitution
: occurs before the NEWLINE token marking the start of the here-document,
: the behavior is unspecified.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
