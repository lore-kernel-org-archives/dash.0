Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553B0C54EBE
	for <linux-dash@archiver.kernel.org>; Mon, 16 Jan 2023 19:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjAPTlY (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 16 Jan 2023 14:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjAPTlW (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 16 Jan 2023 14:41:22 -0500
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5981CAD5
        for <dash@vger.kernel.org>; Mon, 16 Jan 2023 11:41:19 -0800 (PST)
Date:   Mon, 16 Jan 2023 20:41:14 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Ganael Laplanche <ganael.laplanche@martymac.org>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Message-ID: <20230116194114.Ydo5A%steffen@sdaoden.eu>
In-Reply-To: <2616938.TYJnH3iKXO@home.martymac.org>
References: <7091680.J8PY2HnTC3@home.martymac.org>
 <2755634.0OmqyTZxqa@dmc12.centralesupelec.fr>
 <20230113210335.lQ0hq%steffen@sdaoden.eu>
 <2616938.TYJnH3iKXO@home.martymac.org>
User-Agent: s-nail v14.9.24-398-g20005f74ec
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello Ganael.

Ganael Laplanche wrote in
 <2616938.TYJnH3iKXO@home.martymac.org>:
 |On Friday, January 13, 2023 10:03:35 PM CET Steffen Nurpmeso wrote:
 |> Well i mean, in spirit of Wheeler's "anything is possible with
 |> (one more) indirection" it could be possible nonetheless?
 ...
 |It is not clear for me why that extra fork fixes the problem, but it \
 |works, 
 |thanks!
 |
 |Unfortunately, my initial goal is to get a new process group for later 
 |children processes, but FreeBSD's sh (as well as dash) requires 'set \
 |-m' to be 
 |executed from the first process [1]. The extra fork breaks that requirem\
 |ent. 
 |The following example shows that the new process' PGID remains the \
 |same as the 
 |initial shell:
 |
 |$ cat test_pgid.sh
 |(
 |  set -m
 |  (
 |    sleep 1
 |  ) &
 |  i=$!
 |  echo "Main shell has: $(ps -o pid,pgid $$)"
 |  echo "Sub-shell has: $(ps -o pid,pgid $i)"
 |  wait $i
 |)
 |$ dash test_pgid.sh &
 |Main shell has:   PID  PGID
 |10362 10362
 |Sub-shell has:   PID  PGID
 |10364 10362
 |[1]  + done       dash test_pgid.sh
 |
 |So I am afraid the 'extra fork' tip is not useable for me...

Thanks for this information, that i did not expect.
Indeed .. it seems no new process group is used for the child
shell.  That thoroughly i have not looked.

  ...
 |[1] Discussed here: https://lists.freebsd.org/archives/freebsd-hackers/2\
 |022-March/000924.html

Very interesting.  With the correction (fwiw) that

  * with bash, it hangs (as expected with a new process group)

is not true with bash 5.2.15 on Linux 6.1 with glibc

  $ bash -c '(set -m; echo "echo from background" & wait "$!"); echo "wait returns $?"'
  echo from background
  [1]+  Done                    echo "echo from background"
  wait returns 0

(Well the following "hangs" in that it does not print a prompt)

  $ bash -c '(set -m; echo "echo from background $$" & echo $!; wait "$!"); echo "wait returns $?"' &
  [1] 21123
  #?0|kent:nail.git$ 21125
  echo from background 21123
  [1]+  Done                    echo "echo from background $$"
  wait returns 0

So i think i am out of ideas except doing what Jilles suggested
in the message, enwrapping the inner thing with sh -c '..'.
And that seems to work a bit as

  #!/bin/dash
  #(
    sh -c '
    set -m
    (
      sleep 1
    ) &
    i=$!
    echo >&2 "inner Main shell has: $(ps -o pid,pgid $$)"
    echo >&2 "inner Sub-shell has: $(ps -o pid,pgid $i)"
    wait $i
    ' </dev/null >/dev/null &
    echo "Main shell has: $(ps -o pid,pgid $$)"
  #)
    echo "outer Main shell has: $(ps -o pid,pgid $$)"

ends up as

  #?148|kent:tmp$ ./t.sh
  Main shell has:   PID  PGID
  22300 22300
  inner Main shell has:   PID  PGID
  22301 22301
  outer Main shell has:   PID  PGID
  22300 22300
  #?0|kent:tmp$ inner Sub-shell has:   PID  PGID
  22303 22303
  sh: 9: Cannot set tty process group (No such process)

  logout
  There are stopped jobs.

Ciao!

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
