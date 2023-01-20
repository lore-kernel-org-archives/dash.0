Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6951CC05027
	for <linux-dash@archiver.kernel.org>; Fri, 20 Jan 2023 11:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjATLk0 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 20 Jan 2023 06:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjATLkZ (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 20 Jan 2023 06:40:25 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B08D10A8C
        for <dash@vger.kernel.org>; Fri, 20 Jan 2023 03:40:23 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id D0C032000F;
        Fri, 20 Jan 2023 11:40:21 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Date:   Fri, 20 Jan 2023 12:40:18 +0100
Message-ID: <4663342.6VxJRJWXgM@dmc12.centralesupelec.fr>
In-Reply-To: <20230119183330.geEMf%steffen@sdaoden.eu>
References: <7091680.J8PY2HnTC3@home.martymac.org>
 <2024648.dncibcYME7@dmc12.centralesupelec.fr>
 <20230119183330.geEMf%steffen@sdaoden.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thursday, January 19, 2023 7:33:30 PM CET Steffen Nurpmeso wrote:

Hello Steffen,

> Hm, i will attach a better one..  Shall anyone consider this,
> please use that not the older one!  Thanks.

Thanks for the update!

I can confirm that your new patch:

- allows to run fpsync in the background
- fixes the situation with the loop using 100% CPU
  (detailed at the beginning of that thread)

I hope someone from dash team will have a look at it :)

Cheers,

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org


