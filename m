Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D98C433F5
	for <linux-dash@archiver.kernel.org>; Wed,  1 Jun 2022 13:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351852AbiFANIY (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 1 Jun 2022 09:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353094AbiFANIW (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 1 Jun 2022 09:08:22 -0400
X-Greylist: delayed 428 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jun 2022 06:08:19 PDT
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBD92651
        for <dash@vger.kernel.org>; Wed,  1 Jun 2022 06:08:18 -0700 (PDT)
Received: from kent.sdaoden.eu (kent.sdaoden.eu [192.0.2.2])
        by sdaoden.eu (Postfix) with ESMTPS id 2A99916059;
        Wed,  1 Jun 2022 15:01:07 +0200 (CEST)
Received: by kent.sdaoden.eu (Postfix, from userid 1000)
        id A1DD7858A5; Wed,  1 Jun 2022 14:47:22 +0200 (CEST)
Date:   Wed, 01 Jun 2022 14:47:22 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     charles.fisher@arconic.com, dash@vger.kernel.org
Subject: Re: EXIT trap does not fire
Message-ID: <20220601124722.Gejd_%steffen@sdaoden.eu>
In-Reply-To: <c9c96d88c226cc9db0d447fc1160608a6c5e0362.camel@mad-scientist.net>
References: <NOATDC-APPGTW91Teip00015ab2@NOATDC-APPGTW91.arconic.com>
 <c9c96d88c226cc9db0d447fc1160608a6c5e0362.camel@mad-scientist.net>
User-Agent: s-nail v14.9.24-249-g3661bfa033
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Paul Smith wrote in
 <c9c96d88c226cc9db0d447fc1160608a6c5e0362.camel@mad-scientist.net>:
 |On Tue, 2022-05-31 at 16:39 -0400, charles.fisher@arconic.com wrote:
 |> The ssh-agent used in the context immediately below seems to prevent
 |> an EXIT trap from firing upon abnormal termination:
 |
 |Unfortunately it's not clearly specified in the standard what should
 |happen in this situation.  There is an open issue about this:
 |
 |https://austingroupbugs.net/view.php?id=621
 |
 |and here it's pointed out that many shells do not run the EXIT trap
 |when a signal is received, but a few do (bash is one of the few).  So,
 |this is just an unfortunately unclear area of the standard and shells
 |choose to do different things depending on what they interpret "exit"
 |to mean: if they interpret it to mean only "normal exit, by someone
 |running exit or reaching EOF" then they will behave as dash does.  If
 |they interpret it to mean "the shell process is going away for any
 |reason", then they'll interpret it as bash does.
 |
 |You can, of course, add multiple conditions:
 |
 |   trap ... EXIT INT ABRT KILL TERM

I do

  trap "echo on exit" EXIT
  trap "trap '' INT HUP QUIT TERM; exit 1" INT HUP QUIT TERM

So whether it truly protects everywhere i do not know.

 |or similar so both possibilities are catered to.
 --End of <c9c96d88c226cc9db0d447fc1160608a6c5e0362.camel@mad-scientist.net>

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
