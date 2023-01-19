Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B5BC00A5A
	for <linux-dash@archiver.kernel.org>; Thu, 19 Jan 2023 11:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjASLkF (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 19 Jan 2023 06:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjASLjg (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 19 Jan 2023 06:39:36 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944D178A91
        for <dash@vger.kernel.org>; Thu, 19 Jan 2023 03:38:30 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 64A0F1BF209;
        Thu, 19 Jan 2023 11:38:28 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Date:   Thu, 19 Jan 2023 12:38:24 +0100
Message-ID: <2024648.dncibcYME7@dmc12.centralesupelec.fr>
In-Reply-To: <20230118231534.w90EG%steffen@sdaoden.eu>
References: <7091680.J8PY2HnTC3@home.martymac.org>
 <2175334.ZhQv657J3T@dmc12.centralesupelec.fr>
 <20230118231534.w90EG%steffen@sdaoden.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thursday, January 19, 2023 12:15:34 AM CET Steffen Nurpmeso wrote:

Hello Steffen,

> Not a "backport", but from shallow testing (i have no idea what
> i am doing), the attached patch works.

Yes, it works ! With that patch, fpsync runs smoothly in the background (with 
specific PGIDs for sub-jobs) !

Could a Dash developer review (and, if possible, commit) it ?

Again, Steffen, thank you very much for your help :)

Cheers,

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org


