Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0DDC64EC4
	for <linux-dash@archiver.kernel.org>; Wed,  8 Mar 2023 17:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjCHRgM (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 8 Mar 2023 12:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCHRgL (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 8 Mar 2023 12:36:11 -0500
X-Greylist: delayed 1682 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 09:36:02 PST
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B821C4E98
        for <dash@vger.kernel.org>; Wed,  8 Mar 2023 09:36:01 -0800 (PST)
Date:   Wed, 08 Mar 2023 18:00:37 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Ganael Laplanche <ganael.laplanche@martymac.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, jilles@stack.nl,
        dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Message-ID: <20230308170037.ypbys%steffen@sdaoden.eu>
In-Reply-To: <1742108.iAzbLhWyP0@dmc12.centralesupelec.fr>
References: <Y9Olps/fwxaItE4j@gondor.apana.org.au>
 <Y9iI+ehXvUlbFEGa@gondor.apana.org.au> <2865051.slGk94SIus@home.martymac.org>
 <1742108.iAzbLhWyP0@dmc12.centralesupelec.fr>
User-Agent: s-nail v14.9.24-432-g67dd7ec606
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Ganael Laplanche wrote in
 <1742108.iAzbLhWyP0@dmc12.centralesupelec.fr>:
 |On Tuesday, January 31, 2023 12:46:57 PM CET Ganael Laplanche wrote:
 |Hello Herbert,
 |
 |I hope you are doing fine.
 |
 |>> Thanks! This seems to have made it into patchwork.  I will review
 |>> it.
 |> 
 |> Perfect, thanks Herbert!
 |
 |It seems the patch has been archived in Patchwork :
 |
 |https://patchwork.kernel.org/project/dash/patch/
 |dedaa3fa370ea9c4aeb1771b5568a7bef4065b04.1675113321.git.steffen@sdaoden.eu/
 |
 |Is that Intended ? Has it been refused ?

I would not worry that soon; some examples from git:

  AuthorDate: 2022-01-19 16:37:54 +1100
  CommitDate: 2022-12-07 16:27:49 +0800
...
  AuthorDate: 2021-09-05 09:36:11 +0100
  CommitDate: 2022-12-07 16:27:49 +0800

So maybe .. Easter 2024 .. seems an appropriate ping date.
:-)

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
