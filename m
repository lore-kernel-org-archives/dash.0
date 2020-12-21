Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47103C433E6
	for <linux-dash@archiver.kernel.org>; Mon, 21 Dec 2020 19:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0409622D49
	for <linux-dash@archiver.kernel.org>; Mon, 21 Dec 2020 19:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgLUThF (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:37:05 -0500
Received: from sdaoden.eu ([217.144.132.164]:49826 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLUThF (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 21 Dec 2020 14:37:05 -0500
Received: by sdaoden.eu (Postfix, from userid 1000)
        id 636E316057; Mon, 21 Dec 2020 20:36:22 +0100 (CET)
Date:   Mon, 21 Dec 2020 20:36:21 +0100
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     DASH shell mailing list <dash@vger.kernel.org>
Subject: Re: dash 0.5.11.2: somehow falsely waits
Message-ID: <20201221193621.eKxnM%steffen@sdaoden.eu>
In-Reply-To: <20201220014300.8lXtI%steffen@sdaoden.eu>
References: <20201220014300.8lXtI%steffen@sdaoden.eu>
User-Agent: s-nail v14.9.20-84-g7268a84d
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello on a Monday.

Steffen Nurpmeso wrote in
 <20201220014300.8lXtI%steffen@sdaoden.eu>:
 |There is another issue with at least dash (the others not yet
 |tested).  I cloned the git repo and it is still present at
 |6ba88b3ed28fb4b52f20b730194c4ad3d8aad037.
 |
 |With the original test script of what is in "Re: dash 0.5.11.2,
 |busybox sh 1.32.0, FreeBSD 12.2 sh: spring TTOU but should not
 |i think" the sleeper will randomly wake too early for whatever
 |reason.  The sleeper is:
 |
 |  i=
 |  trap 'i=1' USR1 # "reaper (actually a notify timer only) is up"
 |  (
 |      parent=${$}
 |      sleeper= int=0 hot=0
 |      trap '' EXIT HUP QUIT CHLD
 |      trap 'exit 0' INT
 |      trap '
 |         int=1 hot=1
 |         [ -n "${sleeper}" ] && kill -TERM ${sleeper} >/dev/null 2>&1
 |      ' USR1
 |      trap '
 |         int=1 hot=0
 |         [ -n "${sleeper}" ] && kill -TERM ${sleeper} >/dev/null 2>&1
 |      ' USR2
 |      trap '
 |         [ -n "${sleeper}" ] && kill -TERM ${sleeper} >/dev/null 2>&1
 |         echo "Stopping job reaper"
 |         exit 0
 |      ' TERM
 |
 |      # traps are setup, notify parent that we are up and running
 |      kill -USR1 ${parent} >/dev/null 2>&1
 |
 |      while :; do
 |         int=0
 |         /bin/sleep ${JOBWAIT} &
 |         sleeper=${!}
 |         wait ${sleeper}
 |         sleeper=
 |         [ "${int}${hot}" = 01 ] && kill -USR1 ${parent} >/dev/null 2>&1
 |      done
 |   ) </dev/null & #>/dev/null 2>&1 &
 |   JOBREAPER=${!}

What seems to work absolutely reliable on Linux is

   i=
   trap 'i=1' USR1 # "reaper (actually a notify timer only) is up"
   (
      parent=${$}
      sleeper=
      trap '' EXIT HUP QUIT CHLD
      trap 'exit 0' INT
      trap '
         (
            trap 'exit 1' TERM
            /bin/sleep ${JOBWAIT}
            kill -USR1 ${parent} >/dev/null 2>&1
         ) </dev/null &
         sleeper=${!}
      ' USR1
      trap '
         [ -n "${sleeper}" ] && kill -TERM ${sleeper} >/dev/null 2>&1
         sleeper=
      ' USR2
      trap '
         [ -n "${sleeper}" ] && kill -TERM ${sleeper} >/dev/null 2>&1
         echo "Stopping job reaper"
         exit 0
      ' TERM

      # traps are setup, notify parent that we are up and running
      kill -USR1 ${parent} >/dev/null 2>&1

      while :; do
         sleep >/dev/null 2>&1
      done
   ) </dev/null & #>/dev/null 2>&1 &
   JOBREAPER=${!}

Unfortunately this causes all sorts of trouble on a lot of other
shells on Solaris at least, with and without backgrounding the
sleeper and waiting on it in the USR1 trap.

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
