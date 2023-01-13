Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294B2C6379F
	for <linux-dash@archiver.kernel.org>; Fri, 13 Jan 2023 21:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjAMVUX (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 13 Jan 2023 16:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjAMVUJ (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 13 Jan 2023 16:20:09 -0500
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D69188DE8
        for <dash@vger.kernel.org>; Fri, 13 Jan 2023 13:20:08 -0800 (PST)
Date:   Fri, 13 Jan 2023 22:03:35 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Ganael Laplanche <ganael.laplanche@martymac.org>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Message-ID: <20230113210335.lQ0hq%steffen@sdaoden.eu>
In-Reply-To: <2755634.0OmqyTZxqa@dmc12.centralesupelec.fr>
References: <7091680.J8PY2HnTC3@home.martymac.org>
 <2273710.GFeA0BcqPk@dmc12.centralesupelec.fr>
 <20230112150049.kxcn6%steffen@sdaoden.eu>
 <2755634.0OmqyTZxqa@dmc12.centralesupelec.fr>
User-Agent: s-nail v14.9.24-390-g5eddb1e5df
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello Ganael.

Ganael Laplanche wrote in
 <2755634.0OmqyTZxqa@dmc12.centralesupelec.fr>:
 |On Thursday, January 12, 2023 4:00:49 PM CET Steffen Nurpmeso wrote:
 |
 |>|I could not find Jilles' commit (cd60e2c) equivalent in dash code, so I
 |>|presume enabling job control without a tty in non-interactive mode \
 |>|is just not
 |>|possible with dash, am I right ?
 |> 
 |> It seems i have not really looked at the problem you have.
 |> Sorry, yes, that not.
 |
 |Thanks for this confirmation!

Well i mean, in spirit of Wheeler's "anything is possible with
(one more) indirection" it could be possible nonetheless?

  #!/bin/dash
  rm -f BGBG
  (
  set -m
  i=$(set -o)
  echo >&2 set sub 1 is $i
  (
  sleep 1
  echo i am here > BGBG
  set -o >> BGBG
  ) &
  i=$!
  echo >&2 JOB IS $i
  wait $i
  ) & #</dev/null >/dev/null &

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
