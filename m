Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042DFC4361B
	for <linux-dash@archiver.kernel.org>; Sun, 20 Dec 2020 01:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54F423A00
	for <linux-dash@archiver.kernel.org>; Sun, 20 Dec 2020 01:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgLTBnm (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 19 Dec 2020 20:43:42 -0500
Received: from sdaoden.eu ([217.144.132.164]:47892 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbgLTBnm (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 19 Dec 2020 20:43:42 -0500
Received: by sdaoden.eu (Postfix, from userid 1000)
        id F25B916057; Sun, 20 Dec 2020 02:43:00 +0100 (CET)
Date:   Sun, 20 Dec 2020 02:43:00 +0100
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     DASH shell mailing list <dash@vger.kernel.org>
Subject: dash 0.5.11.2: somehow falsely waits
Message-ID: <20201220014300.8lXtI%steffen@sdaoden.eu>
User-Agent: s-nail v14.9.20-84-g7268a84d
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello.

There is another issue with at least dash (the others not yet
tested).  I cloned the git repo and it is still present at
6ba88b3ed28fb4b52f20b730194c4ad3d8aad037.

With the original test script of what is in "Re: dash 0.5.11.2,
busybox sh 1.32.0, FreeBSD 12.2 sh: spring TTOU but should not
i think" the sleeper will randomly wake too early for whatever
reason.  The sleeper is:

  i=
  trap 'i=1' USR1 # "reaper (actually a notify timer only) is up"
  (
      parent=${$}
      sleeper= int=0 hot=0
      trap '' EXIT HUP QUIT CHLD
      trap 'exit 0' INT
      trap '
         int=1 hot=1
         [ -n "${sleeper}" ] && kill -TERM ${sleeper} >/dev/null 2>&1
      ' USR1
      trap '
         int=1 hot=0
         [ -n "${sleeper}" ] && kill -TERM ${sleeper} >/dev/null 2>&1
      ' USR2
      trap '
         [ -n "${sleeper}" ] && kill -TERM ${sleeper} >/dev/null 2>&1
         echo "Stopping job reaper"
         exit 0
      ' TERM

      # traps are setup, notify parent that we are up and running
      kill -USR1 ${parent} >/dev/null 2>&1

      while :; do
         int=0
         /bin/sleep ${JOBWAIT} &
         sleeper=${!}
         wait ${sleeper}

This wait does not seem to work as it should.
I can run this test on OpenBSD (sh,ksh), NetBSD (sh,ksh), Solaris
(xpg4/sh) and on Linux with bash and i think also mksh and it just
works.  With dash i get things as below.

         sleeper=
         [ "${int}${hot}" = 01 ] && kill -USR1 ${parent} >/dev/null 2>&1
      done
   ) </dev/null & #>/dev/null 2>&1 &
   JOBREAPER=${!}

So with date before+after and a shrunken set of tests look like

  Sun Dec 20 02:36:27 CET 2020
  make[1]: Entering directory '/tmp/.nail/y'
  make[1]: warning: -j4 forced in makefile: resetting jobserver mode.
  Mode: --check, binary: ./s-nail
  Trying to detect UTF-8 locale via /tmp/.nail/y/./s-nail
  Using Unicode locale en_US.utf8
  Job number derived from MAKEFLAGS: 4
  Will do up to 4 tests in parallel, with a 20 second timeout
  Starting job reaper (timeout of 20 seconds)
  .. waiting for job reaper to come up
  ... [1=environ] [2=loptlocenv] [3=macro_param_shift] [4=csop] .. waiting
  SLEEPER USR1
  SLEEPER USR2
  [environ]
  1:ok 2:ok 3:ok 4:ok 5:ok
  !! Timeout: reaped job 1 [environ]
  [loptlocenv]

  !! Timeout: reaped job 2 [loptlocenv]
  [macro_param_shift]
  1:ok
     [Debug/Devel: nullified errors]
     reproducible_build: shift: cannot shift 2 of 1 parameters
     reproducible_build: shift: cannot shift 2 of 1 parameters
  [csop]
  1:ok
  ... [1=eval] [2=X_Y_opt_input_go_stack] [3=X_errexit] [4=Y_errexit] .. waiting
  SLEEPER USR1
  SLEEPER USR2
  [eval]
  1:ok
  [X_Y_opt_input_go_stack]
  1:ok 2:ok 3:ok 4:ok 5:ok 6:ok 7:ok 8:ok 9:ok 10:ok cmdline:ok 11:ok
  [X_errexit]
  1:ok 2:ok 3:ok 4:ok 5:ok 6:ok 7:ok 8:ok 9:ok 10:ok 11:ok 12:ok 13:ok 14:ok
  [Y_errexit]
  1:ok 2:ok 3:ok 4:ok 5:ok 6:ok
  ... [1=S_freeze] [2=f_batch_order] .. waiting
  SLEEPER USR1
  SLEEPER USR2
  [S_freeze]
  1:ok 2:ok 3:ok 4:ok 5:ok 6:ok 7:ok
  [f_batch_order]
  1:ok 2:ok
  Stopping job reaper
  44 tests: 44 ok, 2 failure(s).  0 test(s) skipped
  make[1]: Leaving directory '/tmp/.nail/y'
  Sun Dec 20 02:36:29 CET 2020

Total run time 2 seconds, the sleep was 20 seconds, it should
never have been woken up.  With bash and mksh it just works.

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
