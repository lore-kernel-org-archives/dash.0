Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5285BC38142
	for <linux-dash@archiver.kernel.org>; Tue, 31 Jan 2023 11:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjAaLrG (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 31 Jan 2023 06:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjAaLrF (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 31 Jan 2023 06:47:05 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF865FF4
        for <dash@vger.kernel.org>; Tue, 31 Jan 2023 03:47:03 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 1DA631BF209;
        Tue, 31 Jan 2023 11:47:00 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>, jilles@stack.nl,
        dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Date:   Tue, 31 Jan 2023 12:46:57 +0100
Message-ID: <2865051.slGk94SIus@home.martymac.org>
In-Reply-To: <Y9iI+ehXvUlbFEGa@gondor.apana.org.au>
References: <Y9Olps/fwxaItE4j@gondor.apana.org.au> <5757811.Zv9zXsTiuT@home.martymac.org>
 <Y9iI+ehXvUlbFEGa@gondor.apana.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tuesday, January 31, 2023 4:20:25 AM CET Herbert Xu wrote:

> Thanks! This seems to have made it into patchwork.  I will review
> it.

Perfect, thanks Herbert!

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org


