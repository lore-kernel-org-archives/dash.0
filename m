Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D5DC46467
	for <linux-dash@archiver.kernel.org>; Wed, 11 Jan 2023 16:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjAKQ2H (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 11 Jan 2023 11:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjAKQ1n (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 11 Jan 2023 11:27:43 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8A51DDE7
        for <dash@vger.kernel.org>; Wed, 11 Jan 2023 08:25:16 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 591EA240013;
        Wed, 11 Jan 2023 16:25:14 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     Jilles Tjoelker <jilles@stack.nl>
Cc:     dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Date:   Wed, 11 Jan 2023 17:25:10 +0100
Message-ID: <7895519.bYQgcRI8ro@home.martymac.org>
In-Reply-To: <20230110212842.GA2103@stack.nl>
References: <7091680.J8PY2HnTC3@home.martymac.org> <20230110212842.GA2103@stack.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tuesday, January 10, 2023 10:28:42 PM CET Jilles Tjoelker wrote:

Hello Jilles,

> The loop with SIGTTIN is the right thing for an interactive job control
> shell. It ensures that two job control shells do not interfere. The idea
> is that the user can later 'fg' from the outer job control shell.
> 
> The loop also helps with suspending a job control shell, for example via
> the funcs/suspend function from the ash source (containing 'local -',
> 'set +m' and 'kill -TSTP 0'): when trying to resume the inner shell via
> 'bg' in the outer shell, it is this loop that makes the inner shell stop
> itself.

Thanks for those explanations.

> However, for a non-interactive shell, monitor mode is most useful for
> its effect of placing jobs in their own process groups. This does not
> necessarily imply any tty manipulation.
> 
> To make this possible, feature was added to FreeBSD sh in
> https://cgit.freebsd.org/src/commit/?id=cd60e2c67d52e1f957841af19128c7227880
> 743a
> 
> This commit allows using job control without a tty in non-interactive
> mode.
> [...]

This is exactly what I use fpsync for (to get a new process group). Do I 
understand that this feature is not available in Dash ?

> Manipulating the disposition of TTIN/TTOU/TSTP with job control enabled
> might be a question of "if it hurts, don't do that".

Thanks!

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org


