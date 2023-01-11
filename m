Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5BEC5479D
	for <linux-dash@archiver.kernel.org>; Wed, 11 Jan 2023 16:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbjAKQin (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 11 Jan 2023 11:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbjAKQiB (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 11 Jan 2023 11:38:01 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFF3395D6
        for <dash@vger.kernel.org>; Wed, 11 Jan 2023 08:37:23 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id A2434C000C;
        Wed, 11 Jan 2023 16:37:21 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     Jilles Tjoelker <jilles@stack.nl>
Cc:     dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Date:   Wed, 11 Jan 2023 17:37:17 +0100
Message-ID: <3939408.BRNeRiNLvY@home.martymac.org>
In-Reply-To: <7895519.bYQgcRI8ro@home.martymac.org>
References: <7091680.J8PY2HnTC3@home.martymac.org> <20230110212842.GA2103@stack.nl>
 <7895519.bYQgcRI8ro@home.martymac.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wednesday, January 11, 2023 5:25:10 PM CET Ganael Laplanche wrote:

> This is exactly what I use fpsync for (to get a new process group). Do I
> understand that this feature is not available in Dash ?

I'll rephrase : this is exactly what I use *for* fpsync (to get a new process 
group for each sub-job). Do I understand that this feature is not available in 
Dash ?

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org


