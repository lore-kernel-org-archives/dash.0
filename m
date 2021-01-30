Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B91C433E6
	for <linux-dash@archiver.kernel.org>; Sat, 30 Jan 2021 09:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FAA564E25
	for <linux-dash@archiver.kernel.org>; Sat, 30 Jan 2021 09:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhA3JJw (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:09:52 -0500
Received: from ns.simtreas.ru ([94.25.26.30]:32829 "EHLO ns.simtreas.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhA3JIN (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 30 Jan 2021 04:08:13 -0500
Received: from dzo.ulttk.ru (IDENT:1000@dzo-home-tun.ufk68.roskazna.local [192.168.68.4])
        by ns.simtreas.ru (8.14.2/8.14.2) with ESMTP id 10U6deOF024216
        for <dash@vger.kernel.org>; Sat, 30 Jan 2021 10:39:40 +0400
Subject: Re: getopts appears to not be shifting $@ when consuming options
To:     dash@vger.kernel.org
References: <YBRTFXGM6pLwR5hg@teapot> <20210129203650.GA21262@stack.nl>
 <YBSLRXjBSbNmOHP2@teapot>
From:   "Vladimir N. Oleynik" <dzo@simtreas.ru>
Organization: Ulyanovsk Treasury
Message-ID: <e984c34c-1257-c461-f003-45c80080ad8f@simtreas.ru>
Date:   Sat, 30 Jan 2021 10:39:41 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.5.1
MIME-Version: 1.0
In-Reply-To: <YBSLRXjBSbNmOHP2@teapot>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (ns.simtreas.ru [94.25.26.30]); Sat, 30 Jan 2021 10:39:40 +0400 (SAMT)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello,

>> set -- -a foo -a bar # for testing
>> while getopts :a: arg; do
>> ...

You can use typical array cryptic emulation with dash for this :)

#!/bin/dash

main() {
   local i=0 l= oIFS="$IFS" n=

   while getopts :a:u:n: arg; do
     case $arg in
      a) local l$((i=i+1))="$OPTARG"; l="${l}${l:+ }"'attr="$l'$i\";;
      n) n=$OPTARG;;
     esac
   done
   shift "$((OPTIND - 1))"
   IFS=' '; eval set -- $l '"$@"'; IFS=$oIFS

   echo '$@:' "$@"
   echo "n=$n"
}

main -a "foo 1" -a '$((ls))' -u unused -n x -n last_n_val a1 a2
