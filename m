Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6CAC53210
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 14:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjADOmD (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Jan 2023 09:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239658AbjADOl3 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Jan 2023 09:41:29 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23E13477A
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 06:41:20 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pD4x8-00Dqoc-RX; Wed, 04 Jan 2023 22:41:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 04 Jan 2023 22:41:14 +0800
Date:   Wed, 4 Jan 2023 22:41:14 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
Subject: Re: [PATCH v2 2/3] parser: synerror: explicitly consume the entire
 invalid line
Message-ID: <Y7WQCoSQmTniSXUx@gondor.apana.org.au>
References: <Y7OKk/jM53zRE4xg@gondor.apana.org.au>
 <bb422d70-0ba5-e29b-3ec8-8fc1c4630233@gigawatt.nl>
 <Y7VMJGPXXziUrBio@gondor.apana.org.au>
 <8ddcc8a3-9588-435a-9d5f-1edbcd121012@gigawatt.nl>
 <Y7WIuSnsIbkHrEvH@gondor.apana.org.au>
 <6883838e-4340-c80a-cca4-83d2d57078ba@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6883838e-4340-c80a-cca4-83d2d57078ba@gigawatt.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Jan 04, 2023 at 02:30:00PM +0000, Harald van Dijk wrote:
>
> In theory, yes. In practice, because of the default Linux overcommit
> behaviour, that is not going to happen, that's going to cause the OOM killer
> to kick in and forcibly kill the whole process without any way of handling
> it. Either that, or forcibly kill some other process that we get no
> indication of.
> 
> Even if we change the overcommit settings, I'm struggling to think of any
> situation where parsing fails because we run out of memory, but freeing the
> memory we've already allocated for parsing that one line of input frees
> enough to allow us to meaningfully continue.

ckmalloc is just an example.  It could really come from anywhere.
For example, expandstr calls expandarg, which could trigger an
exception for SIGINT.  Indeed, getting SIGINT directly while in
the parser would also do the trick.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
