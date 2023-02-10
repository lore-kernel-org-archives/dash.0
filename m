Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA656C636D4
	for <linux-dash@archiver.kernel.org>; Fri, 10 Feb 2023 02:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBJCn2 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 9 Feb 2023 21:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjBJCn0 (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 9 Feb 2023 21:43:26 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A339170977
        for <dash@vger.kernel.org>; Thu,  9 Feb 2023 18:43:24 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pQJNf-009WAW-PT; Fri, 10 Feb 2023 10:43:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Feb 2023 10:43:19 +0800
Date:   Fri, 10 Feb 2023 10:43:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH v2] Prototype all function definitions for C23 compat
Message-ID: <Y+WvR6PY6vmVtUHr@gondor.apana.org.au>
References: <Y+R8SCX45HlQY8Xk@gondor.apana.org.au>
 <20230209131154.zbh3tagewd7u6vq5@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230209131154.zbh3tagewd7u6vq5@tarta.nabijaczleweli.xyz>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thu, Feb 09, 2023 at 02:11:54PM +0100, наб wrote:
>
>  STATIC int
> -describe_command(out, command, path, verbose)
> -	struct output *out;
> -	char *command;
> -	const char *path;
> -	int verbose;
> +describe_command(struct output *out, char *command,
> +                 const char *path, int verbose)

This looks exactly the same as the first patch.  Did you send
out the wrong one perhaps?

Just to recap if we're touching the function definition they
should now look like:

static int describe_command(struct output *out, char *command,
			    const char *path, int verbose)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
