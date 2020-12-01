Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA4CC64E7A
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 05:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2672B2087D
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 05:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgLAFmp (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 1 Dec 2020 00:42:45 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:47720 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgLAFmp (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 1 Dec 2020 00:42:45 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kjyQN-0003lN-5e; Tue, 01 Dec 2020 16:42:04 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 01 Dec 2020 16:42:03 +1100
Date:   Tue, 1 Dec 2020 16:42:03 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc:     dash@vger.kernel.org, Michael Biebl <biebl@debian.org>,
        974705@bugs.debian.org
Subject: Re: Changes to job handling cause hangs in wait
Message-ID: <20201201054203.GA27074@gondor.apana.org.au>
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
 <20201201053837.GA26889@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201053837.GA26889@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Dec 01, 2020 at 04:38:37PM +1100, Herbert Xu wrote:
> 
> FWIW I'm unable to reproduce it with autopkgtest.  This is what
> I get:
> 
> root@test0:~# autopkgtest --test-name=timedated systemd-246.6/ -B -- lxc -s autopkgtest-sid
> autopkgtest [16:32:45]: starting date: 2020-12-01
> autopkgtest [16:32:45]: version 5.15
> autopkgtest [16:32:45]: host test0; command line: /usr/bin/autopkgtest --test-name=timedated systemd-246.6/ -B -- lxc -s autopkgtest-sid
> autopkgtest [16:33:13]: testbed dpkg architecture: amd64
> autopkgtest [16:33:13]: testbed running kernel: Linux 5.9.0-rc1+ #18 SMP PREEMPT Sat Aug 29 23:45:30 AEST 2020
> autopkgtest [16:33:13]: @@@@@@@@@@@@@@@@@@@@ unbuilt-tree systemd-246.6/
> autopkgtest [16:33:18]: testing package systemd version 246.6-5

Nevermind, I see that the script has been modified to use bash.

I can reproduce the problem now so it's all good.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
