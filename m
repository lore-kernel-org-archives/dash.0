Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBACC4332F
	for <linux-dash@archiver.kernel.org>; Sat, 17 Dec 2022 14:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLQOxE (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 17 Dec 2022 09:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiLQOxD (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 17 Dec 2022 09:53:03 -0500
X-Greylist: delayed 517 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Dec 2022 06:53:01 PST
Received: from mail02.stack.nl (scw01.stack.nl [51.15.111.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13C413FA6
        for <dash@vger.kernel.org>; Sat, 17 Dec 2022 06:53:01 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail02.stack.nl (Postfix) with ESMTP id 039DE1E0508;
        Sat, 17 Dec 2022 14:44:23 +0000 (UTC)
Received: from mail02.stack.nl ([127.0.0.1])
        by localhost (mail02.stack.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XvXEET3X8O_T; Sat, 17 Dec 2022 14:44:21 +0000 (UTC)
Received: from blade.stack.nl (blade.stack.nl [192.168.121.130])
        by mail02.stack.nl (Postfix) with ESMTP id E7EF41E0504;
        Sat, 17 Dec 2022 14:44:20 +0000 (UTC)
Received: by blade.stack.nl (Postfix, from userid 1677)
        id CF1C3237C53; Sat, 17 Dec 2022 15:44:20 +0100 (CET)
Date:   Sat, 17 Dec 2022 15:44:20 +0100
From:   Jilles Tjoelker <jilles@stack.nl>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] redir: savefd: use F_DUPFD_CLOEXEC instead of
 F_DUPFD+F_SETFD
Message-ID: <20221217144420.GA3954@stack.nl>
References: <20221216230109.zujtrue6a3qtj6fo@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221216230109.zujtrue6a3qtj6fo@tarta.nabijaczleweli.xyz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Sat, Dec 17, 2022 at 12:01:09AM +0100, наб wrote:
> [use F_DUPFD_CLOEXEC instead of F_DUPFD+F_SETFD]
> This saves a syscall on every source file open, &c.;
> F_DUPFD_CLOEXEC is a mandatory part of POSIX since Issue 7
> (Austin Group Interpretation 1003.1-2001 #171).

This is a small optimization and simplification if all target platforms
support F_DUPFD_CLOEXEC, but it may not be worth it if this code is
supposed to work on older platforms. In the mailing list archives, there
are various patches (some applied) to make dash work on old platforms.

Often, the newer _CLOEXEC interfaces are used to avoid race conditions,
but not here, which might confuse porters that the necessary changes are
more complicated than they need to be.

-- 
Jilles Tjoelker
