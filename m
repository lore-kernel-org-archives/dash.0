Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B251C4167B
	for <linux-dash@archiver.kernel.org>; Sun, 18 Dec 2022 03:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiLRDEZ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 17 Dec 2022 22:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRDEY (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 17 Dec 2022 22:04:24 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBC4D110
        for <dash@vger.kernel.org>; Sat, 17 Dec 2022 19:04:22 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p6jyN-008Bnu-Q2; Sun, 18 Dec 2022 11:04:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 18 Dec 2022 11:04:19 +0800
Date:   Sun, 18 Dec 2022 11:04:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] alias: aliascmd: refuse uninvokable aliases
Message-ID: <Y56DMzRWQB1CEH5J@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221217190705.atfwacsgggtafzl2@tarta.nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
> [-- text/plain, encoding quoted-printable, charset: us-ascii, 109 lines --]
> 
> See standards quote within, but the fun bit is:
>  alias "a'b=c" "ls&id=cd"; alias
> outputs
>  ls&id='cd'
>  a'b='c'
> neither of which is What You Want, and also you can't invoke them
> because you need to escape the quote/&/whatever, which disables
> alias processing. Forbid the minimum broken set.
> 
> For reference's sake, here's a test driver:
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <sys/wait.h>
>  #include <unistd.h>
>  int main(int _, char ** argv) {
>        putenv("LC_ALL=C");
>        char val[] = "alias 'aQb=echo a' && alias";
>        unsigned char * vp = strchr(val, 'Q');
>        for(unsigned i = 0; i <= 0xFF; ++i) {
>                *vp = i;
>                if(!vfork()) {
>                        execl(argv[1], "sh", "-c", val, (char *)NULL);
>                        _exit(-1);
>                }
>                int r;
>                wait(&r);
>                fprintf(stderr, "%02x: %d\n", i, WEXITSTATUS(r));
>        }
>  }
> 
> zsh  refuses nothing
> dash refuses 09 0a 20 22 24 26 27 28 29 3b 3c 3e 5c 60 7c
> bash refuses dash + 2f
> mksh refuses bash + 23 + 2a + 3f + 5e + <20 + >7c
> ksh  refuses bash + 2a + 3f + 5b + 7b + 7d
> 
> Fixes: https://bugs.debian.org/758542

The main objective of dash is to try to be minimal, so I'm not
going to take this patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
