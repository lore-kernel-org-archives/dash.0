Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AD1C4332F
	for <linux-dash@archiver.kernel.org>; Sun, 18 Dec 2022 02:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLRC3j (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 17 Dec 2022 21:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRC3h (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 17 Dec 2022 21:29:37 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AE9E033
        for <dash@vger.kernel.org>; Sat, 17 Dec 2022 18:29:35 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p6jQe-008BbU-4a; Sun, 18 Dec 2022 10:29:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 18 Dec 2022 10:29:28 +0800
Date:   Sun, 18 Dec 2022 10:29:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jilles Tjoelker <jilles@stack.nl>
Cc:     nabijaczleweli@nabijaczleweli.xyz, dash@vger.kernel.org
Subject: Re: [PATCH] redir: savefd: use F_DUPFD_CLOEXEC instead of
 F_DUPFD+F_SETFD
Message-ID: <Y557CKtBkfwavGYP@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221217144420.GA3954@stack.nl>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Jilles Tjoelker <jilles@stack.nl> wrote:
> On Sat, Dec 17, 2022 at 12:01:09AM +0100, наб wrote:
>> [use F_DUPFD_CLOEXEC instead of F_DUPFD+F_SETFD]
>> This saves a syscall on every source file open, &c.;
>> F_DUPFD_CLOEXEC is a mandatory part of POSIX since Issue 7
>> (Austin Group Interpretation 1003.1-2001 #171).
> 
> This is a small optimization and simplification if all target platforms
> support F_DUPFD_CLOEXEC, but it may not be worth it if this code is
> supposed to work on older platforms. In the mailing list archives, there
> are various patches (some applied) to make dash work on old platforms.
> 
> Often, the newer _CLOEXEC interfaces are used to avoid race conditions,
> but not here, which might confuse porters that the necessary changes are
> more complicated than they need to be.

Right.  I would accept this patch if you add the autoconf bits
to retain support for older platforms.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
