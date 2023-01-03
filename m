Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687D8C3DA7A
	for <linux-dash@archiver.kernel.org>; Tue,  3 Jan 2023 01:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjACBx2 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 2 Jan 2023 20:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjACBx1 (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 2 Jan 2023 20:53:27 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE5064CF
        for <dash@vger.kernel.org>; Mon,  2 Jan 2023 17:53:27 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pCWUV-00DK3n-RH; Tue, 03 Jan 2023 09:53:24 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 03 Jan 2023 09:53:23 +0800
Date:   Tue, 3 Jan 2023 09:53:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org, harald@gigawatt.nl
Subject: Re: [PATCH v2 2/3] parser: synerror: explicitly consume the entire
 invalid line
Message-ID: <Y7OKk/jM53zRE4xg@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b62afca3e10b03c802276ace6e514f7ccb7a5134.1670979949.git.nabijaczleweli@nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> synerror(const char *msg)
> {
>        errlinno = plinno;
> +
> +       /* If we see a syntax error in a command, read the rest of the
> +        * line now before reporting the error. This ensures we get error
> +        * reporting that does not depend on buffering details. */
> +       skipline();

This is broken.  What if we already read a newline just before
the syntax error (e.g., synexpect(TDO))?

This needs to be dealt with in the input layer.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
