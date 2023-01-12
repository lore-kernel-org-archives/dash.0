Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2A4C54EBC
	for <linux-dash@archiver.kernel.org>; Thu, 12 Jan 2023 11:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjALLvd (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 12 Jan 2023 06:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbjALLvA (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 12 Jan 2023 06:51:00 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2BF19024
        for <dash@vger.kernel.org>; Thu, 12 Jan 2023 03:40:41 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 5634BC0009;
        Thu, 12 Jan 2023 11:40:39 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Date:   Thu, 12 Jan 2023 12:40:34 +0100
Message-ID: <2273710.GFeA0BcqPk@dmc12.centralesupelec.fr>
In-Reply-To: <20230111173150.h5oDl%steffen@sdaoden.eu>
References: <7091680.J8PY2HnTC3@home.martymac.org> <3939408.BRNeRiNLvY@home.martymac.org>
 <20230111173150.h5oDl%steffen@sdaoden.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wednesday, January 11, 2023 6:31:50 PM CET Steffen Nurpmeso wrote:

Hello Steffen,

> Just to note that shells may have problems with monitor mode
> (especially scripted, non-interactive).  This was a problem when
> writing a scaling multi-processed test script.  I now do
> [...]

Thanks for your feedback.

I use the same kind of code in fpsync and it works great with dash, right.

The problem is when the main script is started *in the background*. Can your 
test script successfully be run in the background with dash if $JOBMON is not 
empty ? I think you'll face the same problem as I do.

I could not find Jilles' commit (cd60e2c) equivalent in dash code, so I 
presume enabling job control without a tty in non-interactive mode is just not 
possible with dash, am I right ?

Best regards,

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org


