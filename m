Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9762CC4742C
	for <linux-dash@archiver.kernel.org>; Mon, 16 Nov 2020 11:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446A022245
	for <linux-dash@archiver.kernel.org>; Mon, 16 Nov 2020 11:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgKPK3W (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:29:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58772 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgKPK3V (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 16 Nov 2020 05:29:21 -0500
Received: from [IPv6:2a01:c846:1980:2500:6da7:28ca:8eb0:c2c0] (unknown [IPv6:2a01:c846:1980:2500:6da7:28ca:8eb0:c2c0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: andrewsh)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 45C611F47343;
        Mon, 16 Nov 2020 10:29:20 +0000 (GMT)
To:     dash@vger.kernel.org
Cc:     Michael Biebl <biebl@debian.org>
From:   Andrej Shadura <andrew.shadura@collabora.co.uk>
Subject: Changes to job handling cause hangs in wait
Organization: Collabora
Message-ID: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
Date:   Mon, 16 Nov 2020 11:29:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

I’d like to forward a bug report I received. Michael, who reported it,
was able to bisect it to 6c691b3, which was the first of the series of
commits changing job handling.

I must note that I had troubles debugging it: I was only able to
reproduce the issue in an autopkgtest virtual machine, but not on my
normal system nor in a fresh Debian unstable Docker container.

I’m considering reverting some of the relevant commits, but it’d be best
if we could track this down and get it fixed.

The full details can be found at: https://bugs.debian.org/974705

Thanks.

-- 
Cheers,
  Andrej
