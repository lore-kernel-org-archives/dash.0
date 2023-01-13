Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39CCC54EBE
	for <linux-dash@archiver.kernel.org>; Fri, 13 Jan 2023 11:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbjAMLvd (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 13 Jan 2023 06:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbjAMLvO (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 13 Jan 2023 06:51:14 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2A0B94
        for <dash@vger.kernel.org>; Fri, 13 Jan 2023 03:44:53 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 12B84E0007;
        Fri, 13 Jan 2023 11:44:51 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Date:   Fri, 13 Jan 2023 12:44:48 +0100
Message-ID: <2755634.0OmqyTZxqa@dmc12.centralesupelec.fr>
In-Reply-To: <20230112150049.kxcn6%steffen@sdaoden.eu>
References: <7091680.J8PY2HnTC3@home.martymac.org>
 <2273710.GFeA0BcqPk@dmc12.centralesupelec.fr>
 <20230112150049.kxcn6%steffen@sdaoden.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thursday, January 12, 2023 4:00:49 PM CET Steffen Nurpmeso wrote:

Hello Steffen,

>  |I could not find Jilles' commit (cd60e2c) equivalent in dash code, so I
>  |presume enabling job control without a tty in non-interactive mode \
>  |is just not
>  |possible with dash, am I right ?
> 
> It seems i have not really looked at the problem you have.
> Sorry, yes, that not.

Thanks for this confirmation!

Best regards,

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org


