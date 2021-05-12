Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDB3C433ED
	for <linux-dash@archiver.kernel.org>; Wed, 12 May 2021 23:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E8661419
	for <linux-dash@archiver.kernel.org>; Wed, 12 May 2021 23:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbhELXp1 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 12 May 2021 19:45:27 -0400
Received: from sdaoden.eu ([217.144.132.164]:39656 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242523AbhELX2o (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 12 May 2021 19:28:44 -0400
Received: from kent.sdaoden.eu (kent.sdaoden.eu [10.5.0.2])
        by sdaoden.eu (Postfix) with ESMTPS id 54B4716056;
        Thu, 13 May 2021 01:27:34 +0200 (CEST)
Received: by kent.sdaoden.eu (Postfix, from userid 1000)
        id 672AE10D57; Thu, 13 May 2021 01:27:31 +0200 (CEST)
Date:   Thu, 13 May 2021 01:27:31 +0200
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     DASH shell mailing list <dash@vger.kernel.org>
Subject: Re: 0.5.11.3: fyi: reverse solidus "expanded away"
Message-ID: <20210512232731.xIIL4%steffen@sdaoden.eu>
In-Reply-To: <71144bd0-153d-f144-efd4-7600a2f96740@gigawatt.nl>
References: <20210512213648.Df_R7%steffen@sdaoden.eu>
 <71144bd0-153d-f144-efd4-7600a2f96740@gigawatt.nl>
User-Agent: s-nail v14.9.22-137-g8f799568ca
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Harald van Dijk wrote in
 <71144bd0-153d-f144-efd4-7600a2f96740@gigawatt.nl>:
 |On 12/05/2021 22:36, Steffen Nurpmeso wrote:
 |> Just fyi, i stumbled upon this a minute ago:
 |> 
 |>    #?0|kent:steffen$ echo du \\\\\
 |>> hey
 |>    du \\hey
 |> 
 |> That was bash 5.1.8.
 |> 
 |>    #?0|kent:steffen$ dash
 |>    #kent:$ echo du \\\\\
 |>> das
 |>    du \das
 |>    #kent:$
 ...
 |This is expected as dash's echo always processes backslashes. bash will 
 |give the same output when its xpg_echo option is enabled.

Ah, ok.  Thank you, and sorry for the noise.
Ciao,

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
