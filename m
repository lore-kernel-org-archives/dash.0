Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B8CC3DA78
	for <linux-dash@archiver.kernel.org>; Tue, 17 Jan 2023 15:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjAQPFw (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 17 Jan 2023 10:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjAQPFt (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 17 Jan 2023 10:05:49 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421FA3E633
        for <dash@vger.kernel.org>; Tue, 17 Jan 2023 07:05:45 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 23ACB1BF216;
        Tue, 17 Jan 2023 15:05:43 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Date:   Tue, 17 Jan 2023 16:05:40 +0100
Message-ID: <2021198.x0N0T6uNKo@home.martymac.org>
In-Reply-To: <20230116194114.Ydo5A%steffen@sdaoden.eu>
References: <7091680.J8PY2HnTC3@home.martymac.org> <2616938.TYJnH3iKXO@home.martymac.org>
 <20230116194114.Ydo5A%steffen@sdaoden.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Monday, January 16, 2023 8:41:14 PM CET Steffen Nurpmeso wrote:

Hello Steffen,

> So i think i am out of ideas except doing what Jilles suggested
> in the message, enwrapping the inner thing with sh -c '..'.
> [...]

Yes, I am afraid it's the only syntax that works (but it is not very 
convenient).

I had to remove /dev/null redirections for stdin and stdout to avoid getting a 
"Cannot set tty process group (Operation not permitted)" error.

Finally, that gives, on FreeBSD:

$ cat ./test.sh
#!/usr/local/bin/dash
/usr/local/bin/dash -c '
    set -m
    (
      sleep 1
    ) &
    i=$!
    echo >&2 "inner Main shell has: $(ps -o pid,pgid $$)"
    echo >&2 "inner Sub-shell has: $(ps -o pid,pgid $i)"
    wait $i
'
echo "outer Main shell has: $(ps -o pid,pgid $$)"

$ ./test.sh
inner Main shell has:   PID  PGID
20457 20457
inner Sub-shell has:   PID  PGID
20458 20458
outer Main shell has:   PID  PGID
20456 20456

Thanks again for your help!

Cheers,

Ganael.

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org


