Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F36C433F5
	for <linux-dash@archiver.kernel.org>; Tue, 18 Jan 2022 06:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiARGNZ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 18 Jan 2022 01:13:25 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59638 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbiARGNZ (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 18 Jan 2022 01:13:25 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n9hjx-00076O-Im; Tue, 18 Jan 2022 17:13:10 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 18 Jan 2022 17:13:09 +1100
Date:   Tue, 18 Jan 2022 17:13:09 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     calestyo@scientia.org, dash@vger.kernel.org
Subject: [PATCH] expand: Always quote caret when using fnmatch
Message-ID: <YeZadfOkUDdN7JqS@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e341e41f-8c32-b6e4-8be3-8f94fae2677c@gigawatt.nl>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Harald van Dijk <harald@gigawatt.nl> wrote:
> 
> On 12/01/2022 16:25, Christoph Anton Mitterer wrote:
>> The results for the run-circumflex seem pretty odd.
>> Apparently, the ^ is taken literally, but the other two are negated.
> 
> The ^ is not taken literally. The ^ in the pattern is wrongly taken as 
> the negation operator, and the ^ in the argument is then reported as a 
> match because it is neither . nor a.
> 
> This bug (you're right that it's a bug) is specific to builds that use 
> fnmatch(). In dash itself, ^ is always assumed as a literal. In builds 
> with --disable-fnmatch you get correct results. In builds with 
> --enable-fnmatch, because dash assumes ^ is assumed as a literal, dash 
> fails to escape it before passing it on to fnmatch(), and the system 
> fnmatch() may choose differently from dash on how to deal with unquoted 
> ^s. What dash should do to get whatever behaviour the system fnmatch() 
> chooses is leave unquoted ^s unquoted, and leave quoted ^s quoted. This 
> can be achieved by
> 
> --- a/src/mksyntax.c
> +++ b/src/mksyntax.c
> @@ -178,14 +178,14 @@ main(int argc, char **argv)
>         add("$", "CVAR");
>         add("}", "CENDVAR");
>         /* ':/' for tilde expansion, '-' for [a\-x] pattern ranges */
> -       add("!*?[=~:/-]", "CCTL");
> +       add("!*?[^=~:/-]", "CCTL");
>         print("dqsyntax");
>         init();
>         fputs("\n/* syntax table used when in single quotes */\n", cfile);
>         add("\n", "CNL");
>         add("'", "CENDQUOTE");
>         /* ':/' for tilde expansion, '-' for [a\-x] pattern ranges */
> -       add("!*?[=~:/-]\\", "CCTL");
> +       add("!*?[^=~:/-]\\", "CCTL");
>         print("sqsyntax");
>         init();
>         fputs("\n/* syntax table used when in arithmetic */\n", cfile);
> 
> However, whether this is the correct approach is a matter of opinion: 
> dash could alternatively choose to always take ^ as a literal and always 
> escape it before passing it on to fnmatch(), overriding whatever 
> decision the libc people had taken.

Yes, this would produce the most consistent result.

This patch forces ^ to be a literal when we use fnmatch.

Fixes: 7638476c18f2 ("shell: Enable fnmatch/glob by default")
Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Suggested-by: Harald van Dijk <harald@gigawatt.nl>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index aea5cc4..04bf8fb 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -47,6 +47,9 @@
 #include <string.h>
 #ifdef HAVE_FNMATCH
 #include <fnmatch.h>
+#define FNMATCH_IS_ENABLED 1
+#else
+#define FNMATCH_IS_ENABLED 0
 #endif
 #ifdef HAVE_GLOB
 #include <glob.h>
@@ -1693,8 +1696,11 @@ _rmescapes(char *str, int flag)
 			notescaped = 0;
 			goto copy;
 		}
+		if (FNMATCH_IS_ENABLED && *p == '^')
+			goto add_escape;
 		if (*p == (char)CTLESC) {
 			p++;
+add_escape:
 			if (notescaped)
 				*q++ = '\\';
 		}
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
