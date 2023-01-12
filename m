Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E846C54EBD
	for <linux-dash@archiver.kernel.org>; Thu, 12 Jan 2023 15:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbjALPMV (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjALPLs (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 12 Jan 2023 10:11:48 -0500
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C86DD79
        for <dash@vger.kernel.org>; Thu, 12 Jan 2023 07:00:52 -0800 (PST)
Received: from kent.sdaoden.eu (kent.sdaoden.eu [192.0.2.2])
        by sdaoden.eu (Postfix) with ESMTPS id 5342716059;
        Thu, 12 Jan 2023 16:00:50 +0100 (CET)
Received: by kent.sdaoden.eu (Postfix, from userid 1000)
        id 2C7C1B5A27; Thu, 12 Jan 2023 16:00:49 +0100 (CET)
Date:   Thu, 12 Jan 2023 16:00:49 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Ganael Laplanche <ganael.laplanche@martymac.org>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Message-ID: <20230112150049.kxcn6%steffen@sdaoden.eu>
In-Reply-To: <2273710.GFeA0BcqPk@dmc12.centralesupelec.fr>
References: <7091680.J8PY2HnTC3@home.martymac.org>
 <3939408.BRNeRiNLvY@home.martymac.org>
 <20230111173150.h5oDl%steffen@sdaoden.eu>
 <2273710.GFeA0BcqPk@dmc12.centralesupelec.fr>
User-Agent: s-nail v14.9.24-390-g5eddb1e5df
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello.

Ganael Laplanche wrote in
 <2273710.GFeA0BcqPk@dmc12.centralesupelec.fr>:
 |On Wednesday, January 11, 2023 6:31:50 PM CET Steffen Nurpmeso wrote:
 |> Just to note that shells may have problems with monitor mode
 |> (especially scripted, non-interactive).  This was a problem when
 |> writing a scaling multi-processed test script.  I now do
 |> [...]
 |
 |Thanks for your feedback.
 |
 |I use the same kind of code in fpsync and it works great with dash, right.
 |
 |The problem is when the main script is started *in the background*. \
 |Can your 
 |test script successfully be run in the background with dash if $JOBMON \
 |is not 
 |empty ? I think you'll face the same problem as I do.
 |
 |I could not find Jilles' commit (cd60e2c) equivalent in dash code, so I 
 |presume enabling job control without a tty in non-interactive mode \
 |is just not 
 |possible with dash, am I right ?

It seems i have not really looked at the problem you have.
Sorry, yes, that not.

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
