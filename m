Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E38C5519F
	for <linux-dash@archiver.kernel.org>; Fri, 20 Nov 2020 13:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C57222BA
	for <linux-dash@archiver.kernel.org>; Fri, 20 Nov 2020 13:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgKTN6U (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 20 Nov 2020 08:58:20 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:58427 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgKTN6U (ORCPT
        <rfc822;dash@vger.kernel.org>); Fri, 20 Nov 2020 08:58:20 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6AC9AFB5
        for <dash@vger.kernel.org>; Fri, 20 Nov 2020 08:58:19 -0500 (EST)
Received: from imap36 ([10.202.2.86])
  by compute3.internal (MEProxy); Fri, 20 Nov 2020 08:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shadura.me; h=
        mime-version:message-id:date:from:to:subject:content-type
        :content-transfer-encoding; s=fm2; bh=xf5cvjdL4PyaiHp6wG7xrCXAzU
        K0TR/e9E0ZFmeqvfM=; b=plON7pmzNpjLGVigfvObjVVOAZMmu9XyA00m9NaMns
        /ffCxUsCPa0tx2DI1k6K1plw8Ms3hxj5yzLPKJlsKSfydnCG94Tfub+YucKgFNyi
        PPgp2k5tt7a/NiHOgHnlXIpCLuQkxrtA7l/dJDSEP/7Ga7C3ujVD+XSaK4WaJDDX
        s0g8fHDWTc83Z0JJ6wqh0L5DOOxTI0W1wVk1z9kF5n87D3O8YwFUrFDRhAaHlvCg
        VExHKfFTf9YI3SqkvhV0+yGtlzdnJothDNKiVgGNdgYqxKBgQ7a18W8+A3Hlt0T8
        Caxbmrux4gzO0sFZROa4I2l/BuCDnyV43k0ERMH3fyFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xf5cvj
        dL4PyaiHp6wG7xrCXAzUK0TR/e9E0ZFmeqvfM=; b=XJhHXGxAKwbivZ4XeT70Ui
        RM/WYS9J7mG8D7LpOJh3Pc26AzXUL6grGdbuZo9L6gvk3NiqFom9//izQU7XXyMv
        24BtvZpwY86yazRXZ96F7H5QMtum/6CFAo5XcYjQQWIFC1V5jxnQRbWfacKkdlR2
        oBXXrWiAUc1q22Z22ALX18K/pbo4HKJd/m2ORNWZz5gPFDqAhhFzZoEVqOArmD5U
        zjuv9HXuPEBu6u3osJUz9Ae6iTAOmCC8T8V7w/TWbDmY0tFmvcsTwbUiPqJYhQib
        tajqJGVtx73kFfc3hgyLbcJxfg4GAI8KW/IbAIta1rLkLldc0KYgrtUIBLeJ2wrg
        ==
X-ME-Sender: <xms:esu3X5X3lsNmGlXzDM2EzZIsvmB5E60yYWfgVopnWuhw8Q1XvcPTHA>
    <xme:esu3X5lkCaXgkTs-mTAkPySVAFyhtMoPzKE4yApiFnE7R8DglUmRiqjXhyqL_qEH0
    C_PdoreGburWavt5RM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegtddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreerjeenucfhrhhomhepfdetnhgurhgvjhcuufhhrgguuhhrrgdfuceorghnughrvgif
    sehshhgrughurhgrrdhmvgeqnecuggftrfgrthhtvghrnhepudffueegleeftdegtdeuke
    etieehfffhleeuleduveejgefgjefgvdekhfdvieeknecuffhomhgrihhnpehvihhntgdu
    jedrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesshhhrgguuhhrrgdrmhgv
X-ME-Proxy: <xmx:esu3X1ajzRedLRu4dCN6OJnGmlfeDZvRbmhYaJ-8QStUWLpgAQOyrQ>
    <xmx:esu3X8U7eU-Vx6wrnCIYoaW9Hdtmd_T7UkfsTUCWmfmAMfBYE1ov0g>
    <xmx:esu3Xzk1Me76GmFC3879Ovb9ASXVUi22oSkNZoX27tXe3VzfddcEzw>
    <xmx:e8u3XyuVr_cH2eTDx7gKoeVtibSc25lhcuWJ-HpgfDFXRnDPD5ZXNg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8229E188007B; Fri, 20 Nov 2020 08:58:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
x-forwarded-message-id: <20201120135450.GA190228@zira.vinc17.org>
Message-Id: <cce8a10d-b41c-45aa-8edf-39bffffea684@www.fastmail.com>
Date:   Fri, 20 Nov 2020 14:57:58 +0100
From:   "Andrej Shadura" <andrew@shadura.me>
To:     dash@vger.kernel.org
Subject: =?UTF-8?Q?Fwd:_Bug#975325:_dash(1)_man_page:_ulimit_documentation_is_inc?=
 =?UTF-8?Q?onsistent_and_out-of-date?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org



----- Original message -----
From: Vincent Lefevre <vincent@vinc17.net>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: Bug#975325: dash(1) man page: ulimit documentation is inconsist=
ent and out-of-date
Date: Friday, 20 November 2020 14:54

Package: dash
Version: 0.5.11+git20200708+dd9ef66-2
Severity: normal

In the ulimit documentation from the dash(1) man page:

     ulimit [-H | -S] [-a | -tfdscmlpnv [value]]
[...]
            -r          show or set the limit on the real-time schedulin=
g
                        priority of a process

The -r option is not listed in the synopsis, but described anyway.
However, it is not supported:

$ ulimit -r
sh: 17: ulimit: Illegal option -r

Moreover, the -w option is supported:

$ ulimit -w
unlimited

but neither given in the synopsis, nor described.

-- System Information:
Debian Release: bullseye/sid
  APT prefers unstable-debug
  APT policy: (500, 'unstable-debug'), (500, 'stable-updates'), (500, 'u=
nstable'), (500, 'testing'), (500, 'stable'), (1, 'experimental')
Architecture: amd64 (x86_64)

Kernel: Linux 5.9.0-2-amd64 (SMP w/8 CPU threads)
Kernel taint flags: TAINT_PROPRIETARY_MODULE, TAINT_OOT_MODULE, TAINT_UN=
SIGNED_MODULE
Locale: LANG=3DPOSIX, LC_CTYPE=3DC.UTF-8 (charmap=3DUTF-8), LANGUAGE not=
 set
Shell: /bin/sh linked to /bin/dash
Init: systemd (via /run/systemd/system)
LSM: AppArmor: enabled

Versions of packages dash depends on:
ii  debconf [debconf-2.0]  1.5.74
ii  debianutils            4.11.2
ii  dpkg                   1.20.5
ii  libc6                  2.31-4

dash recommends no packages.

dash suggests no packages.

-- debconf information excluded

--=20
Vincent Lef=C3=A8vre <vincent@vinc17.net> - Web: <https://www.vinc17.net=
/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>=

Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
