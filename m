Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2024FC56202
	for <linux-dash@archiver.kernel.org>; Mon, 16 Nov 2020 02:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90EF22314
	for <linux-dash@archiver.kernel.org>; Mon, 16 Nov 2020 02:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgKPCwZ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 15 Nov 2020 21:52:25 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:43604 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgKPCwZ (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 15 Nov 2020 21:52:25 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1keUcw-0007vo-Ju; Mon, 16 Nov 2020 13:52:23 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 16 Nov 2020 13:52:22 +1100
Date:   Mon, 16 Nov 2020 13:52:22 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     dash@vger.kernel.org
Subject: [PATCH] shell: Disable glob again as it strips traing slashes
Message-ID: <20201116025222.GA28742@gondor.apana.org.au>
References: <b8881007-eb6d-17b4-a023-31275ef28b94@web.de>
 <20201116024748.GA26881@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201116024748.GA26881@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Mon, Nov 16, 2020 at 01:47:48PM +1100, Herbert Xu wrote:
> René Scharfe <l.s.r@web.de> wrote:
> > 
> > on Debian testing dash eats trailing slashes of parameters that happen
> > to be regular files when expanding "$@".  Example:
> > 
> >   $ rm -f foo bar
> >   $ touch foo
> >   $ dash -c 'echo "$0" "$@"' baz foo/ bar/ ./
> >   baz foo bar/ ./
> 
> In fact you just have to do
> 
> 	dash -c 'echo bar\/'
> 
> This is a bug in glob(3).  It's stripping the slash.
> 
> I guess we'll just have to disable glob again.

This patch disables glob(3) by default.

Reported-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/configure.ac b/configure.ac
index ab3c02e..e9ae792 100644
--- a/configure.ac
+++ b/configure.ac
@@ -39,8 +39,7 @@ fi
 
 AC_ARG_ENABLE(fnmatch, AS_HELP_STRING(--disable-fnmatch, \
 				      [Do not use fnmatch(3) from libc]))
-AC_ARG_ENABLE(glob, AS_HELP_STRING(--disable-glob, \
-				   [Do not use glob(3) from libc]))
+AC_ARG_ENABLE(glob, AS_HELP_STRING(--enable-glob, [Use glob(3) from libc]))
 
 dnl Checks for libraries.
 
@@ -128,7 +127,7 @@ if test "$enable_fnmatch" != no; then
 	AC_CHECK_FUNCS(fnmatch, use_fnmatch=yes)
 fi
 
-if test "$use_fnmatch" = yes && test "$enable_glob" != no; then
+if test "$use_fnmatch" = yes && test "$enable_glob" = yes; then
 	AC_CHECK_FUNCS(glob)
 fi
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
