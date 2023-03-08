Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41A9C6FD1F
	for <linux-dash@archiver.kernel.org>; Wed,  8 Mar 2023 11:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjCHLrh (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 8 Mar 2023 06:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCHLre (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 8 Mar 2023 06:47:34 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC071B952D
        for <dash@vger.kernel.org>; Wed,  8 Mar 2023 03:47:29 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 849F81BF210;
        Wed,  8 Mar 2023 11:47:26 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>, jilles@stack.nl,
        dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Date:   Wed, 08 Mar 2023 12:47:23 +0100
Message-ID: <1742108.iAzbLhWyP0@dmc12.centralesupelec.fr>
In-Reply-To: <2865051.slGk94SIus@home.martymac.org>
References: <Y9Olps/fwxaItE4j@gondor.apana.org.au> <Y9iI+ehXvUlbFEGa@gondor.apana.org.au>
 <2865051.slGk94SIus@home.martymac.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tuesday, January 31, 2023 12:46:57 PM CET Ganael Laplanche wrote:

Hello Herbert,

I hope you are doing fine.

> > Thanks! This seems to have made it into patchwork.  I will review
> > it.
> 
> Perfect, thanks Herbert!

It seems the patch has been archived in Patchwork :

https://patchwork.kernel.org/project/dash/patch/
dedaa3fa370ea9c4aeb1771b5568a7bef4065b04.1675113321.git.steffen@sdaoden.eu/

Is that Intended ? Has it been refused ?

Cheers,

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org


