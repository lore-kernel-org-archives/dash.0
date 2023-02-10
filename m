Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37888C05027
	for <linux-dash@archiver.kernel.org>; Fri, 10 Feb 2023 03:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBJDCL (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 9 Feb 2023 22:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBJDCK (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 9 Feb 2023 22:02:10 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C9425976
        for <dash@vger.kernel.org>; Thu,  9 Feb 2023 19:02:08 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pQJfj-009WU1-2Y; Fri, 10 Feb 2023 11:02:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Feb 2023 11:01:59 +0800
Date:   Fri, 10 Feb 2023 11:01:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
Subject: Re: [PATCH v2] Prototype all function definitions for C23 compat
Message-ID: <Y+WzpyK7wSfCb+/+@gondor.apana.org.au>
References: <Y+R8SCX45HlQY8Xk@gondor.apana.org.au>
 <20230209131154.zbh3tagewd7u6vq5@tarta.nabijaczleweli.xyz>
 <Y+WvR6PY6vmVtUHr@gondor.apana.org.au>
 <1d291f6d-30b2-720a-9a34-bf3471648534@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d291f6d-30b2-720a-9a34-bf3471648534@gigawatt.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Fri, Feb 10, 2023 at 02:51:18AM +0000, Harald van Dijk wrote:
.
> It looks like наб took this as a request to break the parameters over
> multiple lines, and updated the patch accordingly. The initial patch had
> them all on a single line. This is also how I had read the request. It is
> only in this second message that I notice that you no longer have a line
> break before the function name, so to hopefully help avoid
> misunderstandings, I am spelling this out explicitly here.

Oh yes indeed.  Sorry for the confusion.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
