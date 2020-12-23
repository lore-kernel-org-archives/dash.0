Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE3DC433E0
	for <linux-dash@archiver.kernel.org>; Wed, 23 Dec 2020 08:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394AB2251F
	for <linux-dash@archiver.kernel.org>; Wed, 23 Dec 2020 08:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgLWIN0 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 23 Dec 2020 03:13:26 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:36888 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbgLWINZ (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 23 Dec 2020 03:13:25 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1krzG9-0006vW-7z; Wed, 23 Dec 2020 19:12:38 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Dec 2020 19:12:37 +1100
Date:   Wed, 23 Dec 2020 19:12:37 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Denys Vlasenko <vda.linux@googlemail.com>
Cc:     DASH shell mailing list <dash@vger.kernel.org>
Subject: [PATCH] input: Clear unget on RESET
Message-ID: <20201223081237.GA16045@gondor.apana.org.au>
References: <CAK1hOcOsHYf+aJwJCDhunWNcXvWrLwObnviPms_CkspYsL6BcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1hOcOsHYf+aJwJCDhunWNcXvWrLwObnviPms_CkspYsL6BcQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Sat, Dec 19, 2020 at 02:23:44PM +0100, Denys Vlasenko wrote:
> Current git:
> 
> $ ;l
> dash: 1: Syntax error: ";" unexpected
> $ s
> COPYING    ChangeLog.O    Makefile.am  aclocal.m4  autom4te.cache
> config.h     config.log     configure       dash
> dollar_altvalue1.tests  missing  stamp-h1
> ChangeLog  Makefile    Makefile.in  autogen.sh  compile
> config.h.in  config.status  configure.ac  depcomp  install-sh
>   src      trace

This patch fixes it by clearing ungetc on RESET.

Fixes: 17db43b58415 ("input: Allow two consecutive calls to pungetc")
Reported-by: Denys Vlasenko <vda.linux@googlemail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index 4987732..d7c101b 100644
--- a/src/input.c
+++ b/src/input.c
@@ -87,6 +87,7 @@ INIT {
 RESET {
 	/* clear input buffer */
 	basepf.lleft = basepf.nleft = 0;
+	basepf.unget = 0;
 	popallfiles();
 }
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
