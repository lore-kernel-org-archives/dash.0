Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FE1C677F1
	for <linux-dash@archiver.kernel.org>; Wed, 18 Jan 2023 12:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjARMTY (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjARMRF (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 18 Jan 2023 07:17:05 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C42E54B1D
        for <dash@vger.kernel.org>; Wed, 18 Jan 2023 03:40:18 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id C880E6000A;
        Wed, 18 Jan 2023 11:40:16 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Date:   Wed, 18 Jan 2023 12:40:12 +0100
Message-ID: <2175334.ZhQv657J3T@dmc12.centralesupelec.fr>
In-Reply-To: <20230117210401.wrEtj%steffen@sdaoden.eu>
References: <7091680.J8PY2HnTC3@home.martymac.org> <2021198.x0N0T6uNKo@home.martymac.org>
 <20230117210401.wrEtj%steffen@sdaoden.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tuesday, January 17, 2023 10:04:01 PM CET Steffen Nurpmeso wrote:

Hello Steffen,

> In the meantime i have taken over Jilles' commit to busybox ash,
> hopefully correct, let's see whether it is taken.

Fantastic, thanks!

Any chance to get it backported to Dash too ?

> [...]
> Ah, all on my side.  For example i find it disturbing that my
> interactive shell (bash) exits when the script backgrounds the
> recursive shell above via & .. it reads EOF, and without "set -o
> ignoreeof" or jobbed job it goes home.  I would not have expected
> this.  (If is start it via "./test.sh &" then ok, too.)
> No expert, but at occasions Wheeler really helps out.

Cheers,

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org


