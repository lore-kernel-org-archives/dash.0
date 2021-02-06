Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9276C433E0
	for <linux-dash@archiver.kernel.org>; Sat,  6 Feb 2021 07:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91AFD64FCC
	for <linux-dash@archiver.kernel.org>; Sat,  6 Feb 2021 07:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhBFHR1 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 6 Feb 2021 02:17:27 -0500
Received: from ns.simtreas.ru ([94.25.26.30]:50296 "EHLO ns.simtreas.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBFHR1 (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 6 Feb 2021 02:17:27 -0500
Received: from dzo.ulttk.ru (IDENT:1000@dzo-home-tun.ufk68.roskazna.local [192.168.68.4])
        by ns.simtreas.ru (8.14.2/8.14.2) with ESMTP id 1167Gfpq028711
        for <dash@vger.kernel.org>; Sat, 6 Feb 2021 11:16:41 +0400
Subject: Re: [BUG] any subtitution with @/*: ${@#str} or ${*#str} etc
From:   "Vladimir N. Oleynik" <dzo@simtreas.ru>
To:     dash@vger.kernel.org
References: <119bc180-454e-6a36-c880-9f226d97163a@simtreas.ru>
Organization: Ulyanovsk Treasury
Message-ID: <37d4a83b-737e-87aa-6be7-4ce9797ac571@simtreas.ru>
Date:   Sat, 6 Feb 2021 11:16:42 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.5.1
MIME-Version: 1.0
In-Reply-To: <119bc180-454e-6a36-c880-9f226d97163a@simtreas.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (ns.simtreas.ru [94.25.26.30]); Sat, 06 Feb 2021 11:16:42 +0400 (SAMT)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Vladimir N. Oleynik пишет:

> $ echo "${*%b}"
> ab bb bc
> 
> but need:
> a b bc

Interesting moment: bash/ksh produde "a b bc" always, but zsh produce
more funny and like for me:

$ echo ${*%b}
a b bc

$ echo "${*%b}"
ab bb bc

$ echo "${*%c}"
ab bb b

but a knotty logic also:

$ echo "${*#a}"
ab bb bc

$ echo ${*#a}
b bb bc

ohhh

--w
vodz
