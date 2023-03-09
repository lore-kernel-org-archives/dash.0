Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44195C61DA4
	for <linux-dash@archiver.kernel.org>; Thu,  9 Mar 2023 06:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjCIGlC (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 9 Mar 2023 01:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjCIGkw (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 9 Mar 2023 01:40:52 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5F95A18B
        for <dash@vger.kernel.org>; Wed,  8 Mar 2023 22:40:47 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id C0AB520008;
        Thu,  9 Mar 2023 06:40:44 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>, jilles@stack.nl,
        dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Date:   Thu, 09 Mar 2023 07:40:42 +0100
Message-ID: <2151930.yCM3HcAoFy@dmc12.centralesupelec.fr>
In-Reply-To: <ZAl0zmzBKjTINyEp@gondor.apana.org.au>
References: <Y9Olps/fwxaItE4j@gondor.apana.org.au>
 <1742108.iAzbLhWyP0@dmc12.centralesupelec.fr>
 <ZAl0zmzBKjTINyEp@gondor.apana.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thursday, March 9, 2023 6:55:26 AM CET Herbert Xu wrote:

Hello Herbert,

> Thanks for letting me know! I have no idea how this happened.
> 
> I did a search and discovered quite a few archived patches.
> I've unarcived all of them.

Thanks, but it still appears as archived ("State: New, archived") and does not 
show up in :

https://patchwork.kernel.org/project/dash/list/

It seems it has been flagged as "New" but the old "archived" flag is still 
there...

Best regards,

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org


