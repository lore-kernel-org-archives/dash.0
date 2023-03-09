Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659F7C61DA4
	for <linux-dash@archiver.kernel.org>; Thu,  9 Mar 2023 11:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCILeR (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 9 Mar 2023 06:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCILeQ (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 9 Mar 2023 06:34:16 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09848241DA
        for <dash@vger.kernel.org>; Thu,  9 Mar 2023 03:34:13 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 3187C1BF209;
        Thu,  9 Mar 2023 11:34:10 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>, jilles@stack.nl,
        dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Date:   Thu, 09 Mar 2023 12:34:07 +0100
Message-ID: <72975207.eZY8pxDAZN@dmc12.centralesupelec.fr>
In-Reply-To: <ZAmtJ6IHkECJeVsp@gondor.apana.org.au>
References: <Y9Olps/fwxaItE4j@gondor.apana.org.au> <ZAmlT1GX5hTzCrMg@gondor.apana.org.au>
 <ZAmtJ6IHkECJeVsp@gondor.apana.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thursday, March 9, 2023 10:55:51 AM CET Herbert Xu wrote:

> I've changed all the patches to "Under Review" and hopefully
> that should keep them from being moved back into the archive.
> 
> If you notice anything strange please let me know.

Perfect, thanks!

Have a nice day,

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org


