Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0543C4361B
	for <linux-dash@archiver.kernel.org>; Sat, 12 Dec 2020 21:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9E42250E
	for <linux-dash@archiver.kernel.org>; Sat, 12 Dec 2020 21:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407958AbgLLVZH (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 12 Dec 2020 16:25:07 -0500
Received: from albireo.enyo.de ([37.24.231.21]:53002 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgLLVZH (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 12 Dec 2020 16:25:07 -0500
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Dec 2020 16:25:07 EST
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1koCHL-00027R-1n; Sat, 12 Dec 2020 21:18:11 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1koCHK-0007fW-VR; Sat, 12 Dec 2020 22:18:10 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Aurelien Jarno <aurelien@aurel32.net>, 976865@bugs.debian.org,
        andrew@shadura.me, dash@vger.kernel.org, peff@peff.net
Subject: Re: Bug#976865: Fwd: Bug#974900: dash removes trailing slash from script arguments
References: <20201116094531.GA40024@coredump.intra.peff.net>
        <20201210025654.GA26577@gondor.apana.org.au>
        <20201210075837.GN2297@aurel32.net>
        <20201116094531.GA40024@coredump.intra.peff.net>
        <20201210113508.GA28224@gondor.apana.org.au>
Date:   Sat, 12 Dec 2020 22:18:10 +0100
In-Reply-To: <20201210113508.GA28224@gondor.apana.org.au> (Herbert Xu's
        message of "Thu, 10 Dec 2020 22:35:08 +1100")
Message-ID: <877dpmsoz1.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

* Herbert Xu:

> On Thu, Dec 10, 2020 at 08:58:37AM +0100, Aurelien Jarno wrote:
>>
>> That's the dash symptoms. glob(3) takes a pattern and just returns the
>> paths matching the pattern, as they are named on the filesystem. That
>> said, the option GLOB_MARK can return a trailing slash for all matched
>> path that are a directory.
>
> Yes but it's really a bug in glob(3).  It should really return
> a no-match for the case in question, rather than matching and then
> returning a filename without the slash.
>
> IOW the pattern "foo\/" should not match a regular file foo.

I believe this has been reported upstream here:

  <https://sourceware.org/bugzilla/show_bug.cgi?id=25659>

(But I have not reveiwed this particular bug thread here, sorry.)
