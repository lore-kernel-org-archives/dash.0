Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FE9C433DB
	for <linux-dash@archiver.kernel.org>; Sat,  6 Feb 2021 06:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E71364FCF
	for <linux-dash@archiver.kernel.org>; Sat,  6 Feb 2021 06:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhBFGFC (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 6 Feb 2021 01:05:02 -0500
Received: from ns.simtreas.ru ([94.25.26.30]:53233 "EHLO ns.simtreas.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhBFGFC (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 6 Feb 2021 01:05:02 -0500
Received: from dzo.ulttk.ru (IDENT:1000@dzo-home-tun.ufk68.roskazna.local [192.168.68.4])
        by ns.simtreas.ru (8.14.2/8.14.2) with ESMTP id 11664A9B027784
        for <dash@vger.kernel.org>; Sat, 6 Feb 2021 10:04:10 +0400
To:     dash@vger.kernel.org
From:   "Vladimir N. Oleynik" <dzo@simtreas.ru>
Subject: [BUG] any subtitution with @/*: ${@#str} or ${*#str} etc
Organization: Ulyanovsk Treasury
Message-ID: <119bc180-454e-6a36-c880-9f226d97163a@simtreas.ru>
Date:   Sat, 6 Feb 2021 10:04:10 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (ns.simtreas.ru [94.25.26.30]); Sat, 06 Feb 2021 10:04:10 +0400 (SAMT)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello.

$ showargs() {
    local i=0 a
    echo \$\#=$#
    for a; do
     echo \$$((i=i+1))=$a
    done
}
$ set -- ab bb bc

$ showargs "${@#b}"
$#=3
$1=ab
$2=bb
$3=bc

but need:
$#=3
$1=ab
$2=b
$3=c

$ showargs "${@%bb}"
$#=2
$1=ab
$2=

but need:
$#=3
$1=ab
$2=
$3=bc

$ echo "${*%b}"
ab bb bc

but need:
a b bc

etc etc

I wanted to make a fix, but the code is easier to completely rewrite
than fix. :(


--w
vodz
