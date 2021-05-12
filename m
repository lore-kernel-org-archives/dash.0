Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_05,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED3CC433B4
	for <linux-dash@archiver.kernel.org>; Wed, 12 May 2021 23:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119C3613EE
	for <linux-dash@archiver.kernel.org>; Wed, 12 May 2021 23:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhELXAv (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 12 May 2021 19:00:51 -0400
Received: from sdaoden.eu ([217.144.132.164]:39650 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347455AbhELVrh (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 12 May 2021 17:47:37 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 May 2021 17:47:37 EDT
Received: from kent.sdaoden.eu (kent.sdaoden.eu [10.5.0.2])
        by sdaoden.eu (Postfix) with ESMTPS id 8956916056;
        Wed, 12 May 2021 23:36:50 +0200 (CEST)
Received: by kent.sdaoden.eu (Postfix, from userid 1000)
        id E765F10D41; Wed, 12 May 2021 23:36:48 +0200 (CEST)
Date:   Wed, 12 May 2021 23:36:48 +0200
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     DASH shell mailing list <dash@vger.kernel.org>
Subject: 0.5.11.3: fyi: reverse solidus "expanded away"
Message-ID: <20210512213648.Df_R7%steffen@sdaoden.eu>
User-Agent: s-nail v14.9.22-137-g8f799568ca
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello.

Just fyi, i stumbled upon this a minute ago:

  #?0|kent:steffen$ echo du \\\\\
  > hey
  du \\hey

That was bash 5.1.8.

  #?0|kent:steffen$ dash
  #kent:$ echo du \\\\\
  > das
  du \das
  #kent:$

This is dash 0.5.11.3 (compiled by gcc (CRUX-x86_64-multilib)
10.2.0 on 2020-12-26), running on CRUX-Linux via glibc 2.32/3.
Ciao,

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
