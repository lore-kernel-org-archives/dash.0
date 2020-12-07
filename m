Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BFAC4361B
	for <linux-dash@archiver.kernel.org>; Mon,  7 Dec 2020 03:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D33E230FA
	for <linux-dash@archiver.kernel.org>; Mon,  7 Dec 2020 03:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgLGDzz (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 6 Dec 2020 22:55:55 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:42256 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgLGDzy (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 6 Dec 2020 22:55:54 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1km7cA-0006m9-6P; Mon, 07 Dec 2020 14:55:07 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 07 Dec 2020 14:55:06 +1100
Date:   Mon, 7 Dec 2020 14:55:06 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Michael Biebl <biebl@debian.org>
Cc:     Andrej Shadura <andrew.shadura@collabora.co.uk>,
        dash@vger.kernel.org, 974705@bugs.debian.org
Subject: Re: Changes to job handling cause hangs in wait
Message-ID: <20201207035505.GA10592@gondor.apana.org.au>
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
 <20201201053837.GA26889@gondor.apana.org.au>
 <20201201054203.GA27074@gondor.apana.org.au>
 <20201201060618.GA27281@gondor.apana.org.au>
 <20201201065623.GA27646@gondor.apana.org.au>
 <86689c77-34c6-2dbe-32d2-95f826bfa634@debian.org>
 <20201201232606.GA32382@gondor.apana.org.au>
 <8f71b2dc-bb40-ec95-51a9-2b60e730bc84@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f71b2dc-bb40-ec95-51a9-2b60e730bc84@debian.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thu, Dec 03, 2020 at 01:27:51PM +0100, Michael Biebl wrote:
>
> Hm, so I applied this change and switched backed to dash, but now I get
> 
> autopkgtest systemd --test-name=timedated -s -- lxc -s autopkgtest-sid
> ...
> disable NTP
> enable NTP
> Terminated
> autopkgtest [13:21:42]: test timedated: -----------------------]
> autopkgtest [13:21:42]: test timedated:  - - - - - - - - - - results - - - -
> - - - - - -
> timedated            FAIL non-zero exit status 143
> 
> 
> Running with sh -x
> ...
> + kill 825
> + wait 825
> Terminated
> 
> 
> Herbert, any idea what going wrong there?
> (systemd 247.1-2 and dash 0.5.11+git20200708+dd9ef66-2)

Sorry, my bad.  wait(1) with no arguments ignores the error status
of the child and always return zero.  wait(1) specifically on a
child obviously returns the error status of that child.  Since the
child was killed, we need to ignore that, so this works for me:

	wait $MONPID 2> /dev/null || :

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
