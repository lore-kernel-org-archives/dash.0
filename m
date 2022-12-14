Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AD4C4167B
	for <linux-dash@archiver.kernel.org>; Wed, 14 Dec 2022 17:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbiLNRzo (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 14 Dec 2022 12:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbiLNRzn (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 14 Dec 2022 12:55:43 -0500
X-Greylist: delayed 349 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Dec 2022 09:55:41 PST
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F851DF9
        for <dash@vger.kernel.org>; Wed, 14 Dec 2022 09:55:39 -0800 (PST)
Received: from kent.sdaoden.eu (kent.sdaoden.eu [192.0.2.2])
        by sdaoden.eu (Postfix) with ESMTPS id 6290916059;
        Wed, 14 Dec 2022 18:49:48 +0100 (CET)
Received: by kent.sdaoden.eu (Postfix, from userid 1000)
        id D0352B08EF; Wed, 14 Dec 2022 18:49:46 +0100 (CET)
Date:   Wed, 14 Dec 2022 18:49:46 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Michael Greenberg <michael@greenberg.science>
Cc:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
Subject: Re: [PATCH] options: don't error when unsetting OPTIND
Message-ID: <20221214174946.yISP5%steffen@sdaoden.eu>
In-Reply-To: <m2edt2nk5q.fsf@greenberg.science>
References: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
 <m2edt2nk5q.fsf@greenberg.science>
User-Agent: s-nail v14.9.24-366-g1658bd0402
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Michael Greenberg wrote in
 <m2edt2nk5q.fsf@greenberg.science>:
 ...
 |Bafflingly, the POSIX spec gives the example `readonly HOME PWD`, but
 |with no explanation about why one might want to do that. (I get making
 |`HOME` readonly, but `PWD`? Is that supposed to stop `cd` from working?)

PWD is a beast with lots of "behaviors of the cd and pwd utilities
are unspecified" in case of user edits, see "2.5.3 Shell Variables".

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
