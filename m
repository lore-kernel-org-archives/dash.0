Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9E6C5479D
	for <linux-dash@archiver.kernel.org>; Wed, 11 Jan 2023 17:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjAKRfB (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 11 Jan 2023 12:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbjAKRed (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 11 Jan 2023 12:34:33 -0500
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F082B3D5FF
        for <dash@vger.kernel.org>; Wed, 11 Jan 2023 09:31:54 -0800 (PST)
Received: from kent.sdaoden.eu (kent.sdaoden.eu [192.0.2.2])
        by sdaoden.eu (Postfix) with ESMTPS id 34CCB16059;
        Wed, 11 Jan 2023 18:31:52 +0100 (CET)
Received: by kent.sdaoden.eu (Postfix, from userid 1000)
        id EF783B59E9; Wed, 11 Jan 2023 18:31:50 +0100 (CET)
Date:   Wed, 11 Jan 2023 18:31:50 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Ganael Laplanche <ganael.laplanche@martymac.org>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Message-ID: <20230111173150.h5oDl%steffen@sdaoden.eu>
In-Reply-To: <3939408.BRNeRiNLvY@home.martymac.org>
References: <7091680.J8PY2HnTC3@home.martymac.org>
 <20230110212842.GA2103@stack.nl> <7895519.bYQgcRI8ro@home.martymac.org>
 <3939408.BRNeRiNLvY@home.martymac.org>
User-Agent: s-nail v14.9.24-390-g5eddb1e5df
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Ganael Laplanche wrote in
 <3939408.BRNeRiNLvY@home.martymac.org>:
 |On Wednesday, January 11, 2023 5:25:10 PM CET Ganael Laplanche wrote:
 |
 |> This is exactly what I use fpsync for (to get a new process group). Do I
 |> understand that this feature is not available in Dash ?
 |
 |I'll rephrase : this is exactly what I use *for* fpsync (to get a new \
 |process 
 |group for each sub-job). Do I understand that this feature is not availa\
 |ble in 
 |Dash ?

Just to note that shells may have problems with monitor mode
(especially scripted, non-interactive).  This was a problem when
writing a scaling multi-processed test script.  I now do

        [ -n "${JOBMON}" ] && set -m >/dev/null 2>&1
        ( # Place the job in its own directory to ease file management
                trap '' EXIT HUP INT QUIT TERM USR1 USR2
                JOB_MSG_ID=
                ${mkdir} t.${JOBS}.d && cd t.${JOBS}.d &&
                        eval t_${1} ${JOBS} ${1} &&
                        ${rm} -f ../t.${JOBS}.id
        ) > t.${JOBS}.io </dev/null & # 2>&1 </dev/null &
        i=${!}
        [ -n "${JOBMON}" ] && set +m >/dev/null 2>&1
        JOBLIST="${JOBLIST} ${i}"

This is a problem if $JOBMON=, as unfortunately it may leave
zombie processes running.  Luckily all {,/usr/xpg4}/bin/sh'ells do
this well, including dash.

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
