Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7B0C433E0
	for <linux-dash@archiver.kernel.org>; Mon, 21 Dec 2020 19:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19F722511
	for <linux-dash@archiver.kernel.org>; Mon, 21 Dec 2020 19:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgLUTnn (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:43:43 -0500
Received: from sdaoden.eu ([217.144.132.164]:49828 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgLUTnn (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 21 Dec 2020 14:43:43 -0500
Received: by sdaoden.eu (Postfix, from userid 1000)
        id E223416057; Mon, 21 Dec 2020 20:43:01 +0100 (CET)
Date:   Mon, 21 Dec 2020 20:43:00 +0100
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Jilles Tjoelker <jilles@stack.nl>
Cc:     Harald van Dijk <harald@gigawatt.nl>,
        DASH shell mailing list <dash@vger.kernel.org>,
        Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: dash 0.5.11.2, busybox sh 1.32.0, FreeBSD 12.2 sh:
 spring TTOU but should not i think
Message-ID: <20201221194300.i8cmF%steffen@sdaoden.eu>
In-Reply-To: <20201221162442.GA26001@stack.nl>
References: <20201219172838.1B-WB%steffen@sdaoden.eu>
 <20201219222122.p9UYT%steffen@sdaoden.eu>
 <9bb6fbb5-20e1-eae1-0144-67a4c7e20496@gigawatt.nl>
 <20201221162442.GA26001@stack.nl>
User-Agent: s-nail v14.9.20-84-g7268a84d
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Jilles Tjoelker wrote in
 <20201221162442.GA26001@stack.nl>:
 |On Sat, Dec 19, 2020 at 11:52:31PM +0000, Harald van Dijk wrote:
 |> On 19/12/2020 22:21, Steffen Nurpmeso wrote:
 |>> Steffen Nurpmeso wrote in
 |>>   <20201219172838.1B-WB%steffen@sdaoden.eu>:
 |>>|Long story short, after falsely accusing BSD make of not working
 |
 |>> After dinner i shortened it a bit more, and attach it again, ok?
 |>> It is terrible, but now less redundant than before.
 |>> Sorry for being so terse, that problem crosses my head for about
 |>> a week, and i was totally mislead and if you bang your head
 |>> against the wall so many hours bugs or misbehaviours in a handful
 |>> of other programs is not the expected outcome.
 |
 |> I think a minimal test case is simply
 |
 |> all:
 |>         $(SHELL) -c 'trap "echo TTOU" TTOU; set -m; echo all good'
 |
 |> unless I accidentally oversimplified.
 |
 |Yes, and it can be simplified a bit more to remove make from the
 |picture:
 |    (SHELL -c 'trap "echo TTOU" TTOU; set -m; echo all good'; :)

Cool, .. but it all seems to depend on the outer shell

  #$ bash -c  "( /bin/dash -c 'trap echo\ TTOU TTOU; set -m; echo all good' )"
  /bin/dash: 1: set: Cannot set tty process group (Interrupted system call)
  #$ mksh -c  "( /bin/dash -c 'trap echo\ TTOU TTOU; set -m; echo all good' )"
  /bin/dash: 1: set: Cannot set tty process group (Interrupted system call)
  #$ dash -c  "( /bin/dash -c 'trap echo\ TTOU TTOU; set -m; echo all good' )"
  all good

which results in the funny experience

  #?0|kent:tmp$ smake -f t.mk SHELL=/bin/bash
  .../bin/bash -c 'trap "echo TTOU" TTOU; set -m; echo all good'
  all good
  #?0|kent:tmp$ smake -f t.mk SHELL=/bin/mksh
  .../bin/mksh -c 'trap "echo TTOU" TTOU; set -m; echo all good'
  all good
  #?0|kent:tmp$ smake -f t.mk SHELL=/bin/dash
  .../bin/dash -c 'trap "echo TTOU" TTOU; set -m; echo all good'
  /bin/dash: 1: set: Cannot set tty process group (Interrupted system call)
  smake: *** Code 2 (No such file or directory) from command line for target 'all'.
  smake: Couldn't make 'all'.

Ah, it is a Monday ..

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
