Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0ECC4332F
	for <linux-dash@archiver.kernel.org>; Thu, 15 Dec 2022 10:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiLOK1t (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 15 Dec 2022 05:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLOK1r (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 15 Dec 2022 05:27:47 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F522F17
        for <dash@vger.kernel.org>; Thu, 15 Dec 2022 02:27:47 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p5lSq-007SsB-DY; Thu, 15 Dec 2022 18:27:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 15 Dec 2022 18:27:44 +0800
Date:   Thu, 15 Dec 2022 18:27:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] parser: don't keep alloca()ing in a loop for
 substitutions
Message-ID: <Y5r2oJdWI6CfwwHR@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221214233921.m6hpt5a6kb3wgyjl@tarta.nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> diff --git a/src/parser.c b/src/parser.c
> index a552c47..3f7e50a 100644
> --- a/src/parser.c
> +++ b/src/parser.c
> @@ -898,6 +898,7 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
>        struct nodelist *bqlist;
>        int quotef;
>        int oldstyle;
> +       char *parsebackq_save;
>        /* syntax stack */
>        struct synstack synbase = { .syntax = syntax };
>        struct synstack *synstack = &synbase;
> @@ -906,6 +907,7 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
>                synstack->dblquote = 1;
>        quotef = 0;
>        bqlist = NULL;
> +       parsebackq_save = NULL;
> 
>        STARTSTACKSTR(out);
>        loop: { /* for each line, until end of word */
> @@ -1355,15 +1357,18 @@ badsub:
> parsebackq: {
>        struct nodelist **nlpp;
>        union node *n;
> -       char *str;
> +       char *str, *mstr;
>        size_t savelen;
>        struct heredoc *saveheredoclist;
>        int uninitialized_var(saveprompt);
> 
> -       str = NULL;
> +       str = mstr = NULL;
>        savelen = out - (char *)stackblock();
>        if (savelen > 0) {
> -               str = alloca(savelen);
> +               if (savelen > 1024)
> +                       str = mstr = ckmalloc(savelen);
> +               else
> +                       str = parsebackq_save ?: (parsebackq_save = alloca(1024));
>                memcpy(str, stackblock(), savelen);
>        }
>         if (oldstyle) {
> @@ -1449,6 +1454,7 @@ done:
>        if (str) {
>                memcpy(out, str, savelen);
>                STADJUST(savelen, out);
> +               free(mstr);

You can't just call ckmalloc because that memory will be leaked
if there is a longjmp (such as sh_error) before you free it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
