Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722D9C38142
	for <linux-dash@archiver.kernel.org>; Tue, 17 Jan 2023 23:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjAQXRx (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 17 Jan 2023 18:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjAQXQp (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 17 Jan 2023 18:16:45 -0500
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039DA46736
        for <dash@vger.kernel.org>; Tue, 17 Jan 2023 13:04:06 -0800 (PST)
Date:   Tue, 17 Jan 2023 22:04:01 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Ganael Laplanche <ganael.laplanche@martymac.org>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Message-ID: <20230117210401.wrEtj%steffen@sdaoden.eu>
In-Reply-To: <2021198.x0N0T6uNKo@home.martymac.org>
References: <7091680.J8PY2HnTC3@home.martymac.org>
 <2616938.TYJnH3iKXO@home.martymac.org>
 <20230116194114.Ydo5A%steffen@sdaoden.eu>
 <2021198.x0N0T6uNKo@home.martymac.org>
User-Agent: s-nail v14.9.24-398-g20005f74ec
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello Ganael.

For nothing really!

Ganael Laplanche wrote in
 <2021198.x0N0T6uNKo@home.martymac.org>:
 |On Monday, January 16, 2023 8:41:14 PM CET Steffen Nurpmeso wrote:
 |> So i think i am out of ideas except doing what Jilles suggested
 |> in the message, enwrapping the inner thing with sh -c '..'.
 |> [...]
 |
 |Yes, I am afraid it's the only syntax that works (but it is not very 
 |convenient).
 |
 |I had to remove /dev/null redirections for stdin and stdout to avoid \
 |getting a 
 |"Cannot set tty process group (Operation not permitted)" error.

In the meantime i have taken over Jilles' commit to busybox ash,
hopefully correct, let's see whether it is taken.

 |Finally, that gives, on FreeBSD:
 |
 |$ cat ./test.sh
 |#!/usr/local/bin/dash
 |/usr/local/bin/dash -c '
 |    set -m
 |    (
 |      sleep 1
 |    ) &
 |    i=$!

I could avoid many problems by doing "set +m" here.  But not all.

 |    echo >&2 "inner Main shell has: $(ps -o pid,pgid $$)"
 |    echo >&2 "inner Sub-shell has: $(ps -o pid,pgid $i)"
 |    wait $i
 |'
 |echo "outer Main shell has: $(ps -o pid,pgid $$)"
 |
 |$ ./test.sh
 |inner Main shell has:   PID  PGID
 |20457 20457
 |inner Sub-shell has:   PID  PGID
 |20458 20458
 |outer Main shell has:   PID  PGID
 |20456 20456
 |
 |Thanks again for your help!

Ah, all on my side.  For example i find it disturbing that my
interactive shell (bash) exits when the script backgrounds the
recursive shell above via & .. it reads EOF, and without "set -o
ignoreeof" or jobbed job it goes home.  I would not have expected
this.  (If is start it via "./test.sh &" then ok, too.)
No expert, but at occasions Wheeler really helps out.

Ciao,

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
