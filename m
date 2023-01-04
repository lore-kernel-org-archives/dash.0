Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F640C5479D
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 09:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjADJwJ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Jan 2023 04:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjADJvj (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Jan 2023 04:51:39 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A967114D24
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 01:51:38 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pD0Qm-00DlLT-Q5; Wed, 04 Jan 2023 17:51:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 04 Jan 2023 17:51:32 +0800
Date:   Wed, 4 Jan 2023 17:51:32 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
Subject: Re: [PATCH v2 2/3] parser: synerror: explicitly consume the entire
 invalid line
Message-ID: <Y7VMJGPXXziUrBio@gondor.apana.org.au>
References: <Y7OKk/jM53zRE4xg@gondor.apana.org.au>
 <bb422d70-0ba5-e29b-3ec8-8fc1c4630233@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb422d70-0ba5-e29b-3ec8-8fc1c4630233@gigawatt.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Jan 03, 2023 at 11:47:05AM +0000, Harald van Dijk wrote:
>
> In order for this to be a problem, we need something where the newline
> itself triggers a syntax error. For synexpect(TDO), is that possible? In all
> cases where synexpect(TDO) is called, a newline is permitted, and it is the
> token after the newline that the error will be reported on, no? In that
> situation, reading the rest of the line is correct.

You're right, it isn't possible with TDO.

> I'm not going to rule out that there is a potential for problems, but if
> there is, it's not the situation you say.

However, the synexpect in parsefname would seem to qualify:

cat <<- <newline>

> Handling it in the input layer after the error has already been reported
> means we get inconsistent error handling when running with dash -isv. The
> error may, depending on whether the rest of the line was in the buffer
> already, be reported either in the middle of the input line, or on the next
> line.
> 
> Just try changing sh -i to sh -iv in the reproducer and seeing what what
> happens with your patch.

I don't think this is such a big deal.  You get the same effect
if you simply do input line buffering but only up to a certain
length.  I tried one million instead of ten thousand with the
reproducer and ksh93 prints out the error after only 65536
characters.

In any case, we could actually fix this by buffering stderr and
then making sh -v bypass the buffer and write directly to 2.

I tried it and it actually seems to work.  But all the extra flush
calls bloat up the code a bit so it needs a bit more work before
I'm happy to run with it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
