Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C98C54EBE
	for <linux-dash@archiver.kernel.org>; Mon, 16 Jan 2023 11:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjAPLQJ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 16 Jan 2023 06:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjAPLQD (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 16 Jan 2023 06:16:03 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47771A96B
        for <dash@vger.kernel.org>; Mon, 16 Jan 2023 03:16:00 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 2CC421C0012;
        Mon, 16 Jan 2023 11:15:56 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Date:   Mon, 16 Jan 2023 12:15:52 +0100
Message-ID: <2616938.TYJnH3iKXO@home.martymac.org>
In-Reply-To: <20230113210335.lQ0hq%steffen@sdaoden.eu>
References: <7091680.J8PY2HnTC3@home.martymac.org>
 <2755634.0OmqyTZxqa@dmc12.centralesupelec.fr>
 <20230113210335.lQ0hq%steffen@sdaoden.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Friday, January 13, 2023 10:03:35 PM CET Steffen Nurpmeso wrote:

Hello Steffen,

> Well i mean, in spirit of Wheeler's "anything is possible with
> (one more) indirection" it could be possible nonetheless?
> [...]

Well, my initial examples then become :

$ cat test_ko.sh
set -m
$ dash test_ko.sh &
[1]  + suspended (tty input)  dash test_ko.sh

$ cat test_ok.sh
(
  set -m
)
$ dash test_ok.sh &
[1]  + done       dash test_ok.sh

It is not clear for me why that extra fork fixes the problem, but it works, 
thanks!

Unfortunately, my initial goal is to get a new process group for later 
children processes, but FreeBSD's sh (as well as dash) requires 'set -m' to be 
executed from the first process [1]. The extra fork breaks that requirement. 
The following example shows that the new process' PGID remains the same as the 
initial shell:

$ cat test_pgid.sh
(
  set -m
  (
    sleep 1
  ) &
  i=$!
  echo "Main shell has: $(ps -o pid,pgid $$)"
  echo "Sub-shell has: $(ps -o pid,pgid $i)"
  wait $i
)
$ dash test_pgid.sh &
Main shell has:   PID  PGID
10362 10362
Sub-shell has:   PID  PGID
10364 10362
[1]  + done       dash test_pgid.sh

So I am afraid the 'extra fork' tip is not useable for me...

Cheers,

Ganael.

[1] Discussed here: https://lists.freebsd.org/archives/freebsd-hackers/2022-March/000924.html

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org


