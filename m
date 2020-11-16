Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3696C4742C
	for <linux-dash@archiver.kernel.org>; Mon, 16 Nov 2020 11:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D712224B
	for <linux-dash@archiver.kernel.org>; Mon, 16 Nov 2020 11:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgKPKas (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:30:48 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:52007 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727293AbgKPKas (ORCPT
        <rfc822;dash@vger.kernel.org>); Mon, 16 Nov 2020 05:30:48 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 74102953;
        Mon, 16 Nov 2020 05:30:46 -0500 (EST)
Received: from imap36 ([10.202.2.86])
  by compute3.internal (MEProxy); Mon, 16 Nov 2020 05:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shadura.me; h=
        mime-version:message-id:date:from:to:cc:subject:content-type; s=
        fm2; bh=o0xEVrZTkVHnWG/PzTCu2xDseNz2IcjnENW4ajts/GU=; b=kHPlFiiR
        OxMqA4/1I7X3giFtbwjGsDrvCYPYNYbpemqCkDo32zT0yBTn0DMtvAkuWf+L7jOi
        iEBff6X7g63pAUMBhrUC5KayfCQzui/6QfKe7zBUpxuuEqt85xyzvFhYWvHnXq23
        31f2yRjF+OZ5eypXVrWfG7G9zhSEU8S5ba9IDnPCHKFYLyp/3+tczvBlHDfwCj1G
        yRjBKLQlpJNXw9cViJ2pbqERG30rNVoC2rrlwMq9eve+dSuWpnwmSfnbK4Cl6LAs
        VP8BtM2sgSAvVDLP+rkNvmG167xuWNCemf7+UTEGbdrJ94xjvgfzcj8SO+B94W69
        VSjeRofI2lqImg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=o0xEVrZTkVHnWG/PzTCu2xDseNz2I
        cjnENW4ajts/GU=; b=cc9ovBY/mVY6uapUFqpxM2bjnGgakgNKK7QScV891en+q
        Dlelu/jTFwChE0mi128tdaXN/IwJij/slU/U9CsjDEievZpqkvNCRLwsu92ZCuvc
        a0MT2eeszK1UnTNL8yzHrdRxdySAZBY8DwHmMPzUlc0A7AjXusNcVJCkMiSCQx+8
        1xObwj/DEuKDHyn52yaLx7gcj3DTpZPMtkR/qxIR7ux0+hkBCKPRGi2ngV/oBxas
        /itYxlZcxxF1i6nXphX+2cWi5dUhCzLWC1cNNMK3WjsWvyJTevJbvQT95EE4soIK
        unLkiD5wonSR3f2LTtycOp9HX0TcOiSKEgTj3FVnA==
X-ME-Sender: <xms:1VSyXxYTvsq1c5W2jfuS-q3PkqEJKVux_3F4sziKFIrYANnx9D15uw>
    <xme:1VSyX4YAUgxYgSCSxgEOUy3lonbrzhttCEDruU-ryNB5NCpeP33dJzFdyuPZNgWBC
    -IYF-5oZHQT_1QSd4U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedftehnughrvghjucfuhhgrughurhgrfdcuoegrnhgurhgvfies
    shhhrgguuhhrrgdrmhgvqeenucggtffrrghtthgvrhhnpefgjeettefhvdfgueefffejge
    ekleffffehleeuvdfhvdelleehtdeuhefgtdfhveenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesshhhrgguuhhrrgdrmhgv
X-ME-Proxy: <xmx:1VSyXz_1SpJ3Fvj19NFhgdT5-eoOVTQonlSJXcP76d0OugebwDFrIg>
    <xmx:1VSyX_pxOJ9vOOUdKx2sjOkZpIFKF7OeVpkKUBj9oopTZZglV3WPkA>
    <xmx:1VSyX8rnKpzSQySWa3Dj7s8Npnd25POpjjvfEI9Pm4zzuoUS6cNYLg>
    <xmx:1lSyX5ACim8_Og4E93pTAn8P0xM1M3wyTbzX8M4EC7jXeO6JM4nWmg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7CA1C188007B; Mon, 16 Nov 2020 05:30:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-570-gba0a262-fm-20201106.001-gba0a2623
Mime-Version: 1.0
x-forwarded-message-id: <20201116094531.GA40024@coredump.intra.peff.net>
Message-Id: <f957f8b9-3430-4752-9798-9c5417d9707a@www.fastmail.com>
Date:   Mon, 16 Nov 2020 11:30:24 +0100
From:   "Andrej Shadura" <andrew@shadura.me>
To:     dash@vger.kernel.org
Cc:     "Jeff King" <peff@peff.net>
Subject: Fwd: Bug#974900: dash removes trailing slash from script arguments
Content-Type: text/plain
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

this is another bug report I have received.

----- Original message -----
From: Jeff King <peff@peff.net>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: Bug#974900: dash removes trailing slash from script arguments
Date: Monday, 16 November 2020 10:45

Package: dash
Version: 0.5.11+git20200708+dd9ef66-2
Severity: normal
Tags: upstream

With the latest version of dash, I get this behavior:

  $ touch here
  $ dash -c 'printf "%s\n" "$@"' -- here/ not-here/
  here
  not-here/

The trailing slash is stripped from the argument "here/", when the file
"here" exists in the current directory (but not from "not-here/", which
does not exist).

This is rather surprising to scripts which may not even intend for their
arguments to be files (I noticed because it breaks Git's test suite,
which expects "some-script foo/" to preserve the trailing slash, which
is meaningful in its internal path matching). And certainly it differs
from the behavior of 0.5.10.2-7, which prints "here/".

Bisection points to upstream 7638476 (shell: Enable fnmatch/glob by
default, 2020-05-28). And indeed, building locally with "./configure
--disable-fnmatch" makes the problem go away. But since that commit was
only flipping the defaults, presumably the problem was already there.
Bisecting with "--enable-fnmatch --enable-glob" shows that it comes from
6900ff6 (expand: Fix glibc glob(3) support, 2018-03-26).

-- System Information:
Debian Release: bullseye/sid
  APT prefers unstable
  APT policy: (500, 'unstable'), (500, 'testing'), (1, 'experimental')
Architecture: amd64 (x86_64)
Foreign Architectures: i386

Kernel: Linux 5.9.0-2-amd64 (SMP w/16 CPU threads)
Kernel taint flags: TAINT_PROPRIETARY_MODULE, TAINT_OOT_MODULE, TAINT_UNSIGNED_MODULE
Locale: LANG=en_US.UTF-8, LC_CTYPE=en_US.UTF-8 (charmap=UTF-8), LANGUAGE not set
Shell: /bin/sh linked to /usr/bin/dash
Init: systemd (via /run/systemd/system)

Versions of packages dash depends on:
ii  debconf [debconf-2.0]  1.5.74
ii  debianutils            4.11.2
ii  dpkg                   1.20.5
ii  libc6                  2.31-4

dash recommends no packages.

dash suggests no packages.

-- debconf information:
* dash/sh: true
