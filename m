Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47C9C2B9F7
	for <linux-dash@archiver.kernel.org>; Wed, 26 May 2021 05:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C6D61402
	for <linux-dash@archiver.kernel.org>; Wed, 26 May 2021 05:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhEZFvN (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 26 May 2021 01:51:13 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51606 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231998AbhEZFvN (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 26 May 2021 01:51:13 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1llmQH-00066Q-GN; Wed, 26 May 2021 13:49:41 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1llmQF-0000eH-0u; Wed, 26 May 2021 13:49:39 +0800
Date:   Wed, 26 May 2021 13:49:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Saagar Jha <saagar@saagarjha.com>
Cc:     dash@vger.kernel.org
Subject: shell: Call CHECK_DECL on stat64
Message-ID: <20210526054938.tgkhhh3z5vn2hjyi@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BAE642E9-DFE3-496D-8520-394443D0F24A@saagarjha.com>
X-Newsgroups: apana.lists.os.linux.dash
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Saagar Jha <saagar@saagarjha.com> wrote:
>
> Even though stat64 is not in the public headers, AC_CHECK_FUNC will “find” it because the symbol exists at link time for the test, even though it is not meant to be used. What do you think would be the best way to fix this check on this platform? Would it be preferred to check if the headers contain a declaration of the function?

Yes we should check for a declaration.  Does this patch fix the
problem?

---8<---
On macOS it is possible to find stat64 at link-time but not at
compile-time.  To make the build process more robust we should
check for the header file as well as the library.

Reported-by: Saagar Jha <saagar@saagarjha.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/configure.ac b/configure.ac
index 44f2f95..466df4c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -140,11 +140,12 @@ if test "$ac_cv_func_signal" != yes; then
 fi
 
 dnl Check for stat64 (dietlibc/klibc).
-AC_CHECK_FUNC(stat64,, [
+AC_CHECK_DECL(stat64, AC_CHECK_FUNC(stat64))
+if test "$ac_cv_func_stat64" != yes; then
 	AC_DEFINE(fstat64, fstat, [64-bit operations are the same as 32-bit])
 	AC_DEFINE(lstat64, lstat, [64-bit operations are the same as 32-bit])
 	AC_DEFINE(stat64, stat, [64-bit operations are the same as 32-bit])
-])
+fi
 
 AC_CHECK_FUNC(glob64,, [
 	AC_DEFINE(glob64_t, glob_t, [64-bit operations are the same as 32-bit])
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
