Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C35BC433EF
	for <linux-dash@archiver.kernel.org>; Fri,  1 Jul 2022 23:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiGAXgs (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 1 Jul 2022 19:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiGAXgr (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 1 Jul 2022 19:36:47 -0400
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2742B3AA69
        for <dash@vger.kernel.org>; Fri,  1 Jul 2022 16:36:47 -0700 (PDT)
Received: from kent.sdaoden.eu (kent.sdaoden.eu [192.0.2.2])
        by sdaoden.eu (Postfix) with ESMTPS id B32EA16059;
        Sat,  2 Jul 2022 01:36:45 +0200 (CEST)
Received: by kent.sdaoden.eu (Postfix, from userid 1000)
        id 5F0D48E248; Sat,  2 Jul 2022 01:36:44 +0200 (CEST)
Date:   Sat, 02 Jul 2022 01:36:44 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     DASH shell mailing list <dash@vger.kernel.org>,
        Robert Elz <kre@munnari.OZ.AU>
Subject: Re: $(()) pre/postfix bug
Message-ID: <20220701233644.ZGiHI%steffen@sdaoden.eu>
In-Reply-To: <20220701231439.egWzS%steffen@sdaoden.eu>
References: <20220701231439.egWzS%steffen@sdaoden.eu>
User-Agent: s-nail v14.9.24-259-ge9cf982228
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Steffen Nurpmeso wrote in
 <20220701231439.egWzS%steffen@sdaoden.eu>:
 ..
 |While doing so i encountered diverging behaviour in between
 |shells, and a bug in dash (and a memory failure in NetBSD 9 ksh).

Nonsense.  dash simply does not support pre/postfix operators.
Sorry for the noise.

  ...
 |NetBSD n-0900 9.0 NetBSD 9.0 (GENERIC) #0: Fri Feb 14 00:06:28 UTC \
 |2020  mkrepro@mkrepro.NetBSD.org:/usr/src/sys/arch/amd64/compile/GENERIC \
 |amd64
 |
 |#?0|n-0900:steffen$ ksh -c '(i=10; echo $((++-+++i)))'
 |Memory fault
 ...

Ok, maybe a bug report over there.

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
