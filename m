Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72867C433F5
	for <linux-dash@archiver.kernel.org>; Sun, 20 Feb 2022 07:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbiBTHaj (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 20 Feb 2022 02:30:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiBTHai (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 20 Feb 2022 02:30:38 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C4850E2D
        for <dash@vger.kernel.org>; Sat, 19 Feb 2022 23:30:17 -0800 (PST)
Received: from relay8-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::228])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 2D01FC363D
        for <dash@vger.kernel.org>; Sun, 20 Feb 2022 07:15:53 +0000 (UTC)
Received: (Authenticated sender: stephane@chazelas.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 068671BF20A;
        Sun, 20 Feb 2022 07:15:44 +0000 (UTC)
Date:   Sun, 20 Feb 2022 07:15:44 +0000
From:   Stephane Chazelas <stephane@chazelas.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Harald van Dijk <harald@gigawatt.nl>, calestyo@scientia.org,
        dash@vger.kernel.org
Subject: Re: [v2 PATCH] expand: Always quote caret when using fnmatch
Message-ID: <20220220071544.7odyx5urgcwjsobd@chazelas.org>
References: <YeZadfOkUDdN7JqS@gondor.apana.org.au>
 <c31fb498-0f82-dcdc-b1c6-212b8c919c07@gigawatt.nl>
 <YeejsuVQaGCkQ97t@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeejsuVQaGCkQ97t@gondor.apana.org.au>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

2022-01-19 16:37:54 +1100, Herbert Xu:
[...]
> This patch forces ^ to be a literal when we use fnmatch.
[...]

Hi,

I'm coming here from a discussion at
https://www.austingroupbugs.net/view.php?id=1558 where I'm
trying to get POSIX to mandate (or suggest that it will mandate
in the future) [^x] works like [!x] to negate a bracket
expression set like it does already in most
shell/fnmatch()/glob() implementations, and to remove that
non-sensical (to me at least) discrepancy with regexps and most
other shells / languages.

To me, that patch is a step in the wrong direction.

Other Ash-based shells already made the move (make [^x] an alias
for [!x]) a long time ago (FreeBSD / NetBSD sh in 1997), BSD
fnmatch() in 1994. The GNU libc and GNU shell have always
supported [^x] AFAIK. So has zsh. ksh made the move in 2005.

In dash, the move to fnmatch() in that case was a step in the
right direction, and reverting it would be an unfortunate step
back to me.

If the point of having dash use fnmatch() is to add consistency
with other tools used from the shell (like find -name/-path...),
then this change doesn't help either on the majority of systems.

The "fix" also seems incomplete and causes at least this
regression:

$ ltrace -e fnmatch ./bin/dash -c 'case "\\" in ($1) echo match; esac' sh '[\^]'
dash->fnmatch("[\\\\^]", "\\", 0)                              = 0
match

See how that added \ caused it to be included in the set. Compare with:

+++ exited (status 0) +++
$ ltrace -e fnmatch ./bin/dash -c 'case "\\" in ($1) echo match; esac' sh '[\!]'
dash->fnmatch("[\\!]", "\\", 0)                                = 1
+++ exited (status 0) +++
$ ltrace -e fnmatch ./bin/dash -c 'case "\\" in ($1) echo match; esac' sh '[\x]'
dash->fnmatch("[\\x]", "\\", 0)                                = 1
+++ exited (status 0) +++

(here on Debian with glibc 2.33)

-- 
Stephane
