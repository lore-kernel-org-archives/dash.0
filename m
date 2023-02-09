Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1628C05027
	for <linux-dash@archiver.kernel.org>; Thu,  9 Feb 2023 05:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBIFdA (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 9 Feb 2023 00:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBIFdA (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 9 Feb 2023 00:33:00 -0500
X-Greylist: delayed 2364 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Feb 2023 21:32:57 PST
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4212301B5
        for <dash@vger.kernel.org>; Wed,  8 Feb 2023 21:32:57 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pPyw4-0099Rt-F3; Thu, 09 Feb 2023 12:53:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Feb 2023 12:53:28 +0800
Date:   Thu, 9 Feb 2023 12:53:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] Prototype all function definitions for C23 compat
Message-ID: <Y+R8SCX45HlQY8Xk@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230207163439.d3fqmpyh6ak3wyhw@tarta.nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> STATIC int
> -describe_command(out, command, path, verbose)
> -       struct output *out;
> -       char *command;
> -       const char *path;
> -       int verbose;
> +describe_command(struct output *out, char *command, const char *path, int verbose)

Thanks for doing this!

But since you are here, could you please change the style to:

static int describe_command(struct output *out, char *command,
			    const char *path, int verbose)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
