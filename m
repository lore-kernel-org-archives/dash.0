Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96786C4332F
	for <linux-dash@archiver.kernel.org>; Mon, 21 Nov 2022 02:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiKUCie convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 20 Nov 2022 21:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKUCid (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 20 Nov 2022 21:38:33 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAF3D111
        for <dash@vger.kernel.org>; Sun, 20 Nov 2022 18:38:31 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 36DBE5412F8
        for <dash@vger.kernel.org>; Mon, 21 Nov 2022 02:38:31 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0D82F5412BF
        for <dash@vger.kernel.org>; Mon, 21 Nov 2022 02:38:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668998310; a=rsa-sha256;
        cv=none;
        b=4GTcFxULtVuS32Jd6xqW+QcZwI1q3mOysEx0KHvrmTvvC6n4fpXPgMFLjAFuw/HSjCLIbh
        grMIGjDG8TQnlEuVsXlOafYTdECO9+IYpjpiyN66fP2ynGZzzptctGX8xRsRllrw5qQzob
        /HUtQacutRJtBSl/JVFeuxJ5g+YSgE1L4KX9NkztSintdzmZ5PMv0OWMRz7Qrcheudy7TJ
        3TH1B6RniIg8bbwDT0CGSkmN+qiua2sagNpvKLmeXLEpltf3/SEZVZeZelsBu1QARzIMrN
        +MJg739baYcaSit3zTWdhgQ1W6SYYj+mhmRAQRAF/xqfoSwqZhDOZajR78pSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668998310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jN4AcvjF2ceYTFq2yUI7gR6XDTPRWJk5JozJQp2X8kw=;
        b=nxUCOeOAqUJgXzrTS/AiKRo/DTs+lR4sbBe6YePjl3Q9vnJIWEiUYYrlA/2i3DYAM0AtgE
        H29IN+yAy1NeMieehpT2Us6l1rTnFn1rjtZhAd8mVA3zwtlWAvxNQCM/gbQ1OHz0zEKzvz
        IAhjjmSzQWwZGnpLjt+IwNVwQdK0+O2qSQuQogzCbGKH2rSoq7WoFf/aL/V2qB/N+ytdm5
        BcQvKZ5TjK7h0bZWyQANBNe9Bfc8779PV+ZnFy9eFWltV6C19+TUJWlJ1L/x08Gy7c4Y6X
        CoNQktAB0B7nnfuLw+n8QknhKDNq9UWX09npmOBR+yiHFkpVZJkKp0UWm8xClg==
ARC-Authentication-Results: i=1;
        rspamd-65567d767-fx7r7;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Daffy-Towering: 36dca29049ad7740_1668998310547_1315222317
X-MC-Loop-Signature: 1668998310547:1749175892
X-MC-Ingress-Time: 1668998310547
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.103.24.91 (trex/6.7.1);
        Mon, 21 Nov 2022 02:38:30 +0000
Received: from p57b04dfc.dip0.t-ipconnect.de ([87.176.77.252]:34372 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1owwhT-000452-Me
        for dash@vger.kernel.org;
        Mon, 21 Nov 2022 02:38:28 +0000
Message-ID: <b2e298215b3d51d8284296484caa138faddaa0e4.camel@scientia.org>
Subject: segfault with invalid shell script
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     dash@vger.kernel.org
Date:   Mon, 21 Nov 2022 03:38:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.2
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hey.


I found the following issue by chance, when converting a shell
script[0] from bash to POSIX sh (well that + the use of "local"):

Below is a strongly reduced version of [0] which still causes the
error:
-------------------------------------------------------------------
#!/bin/sh


reject_and_die()
{
    exit 1
}


reject_filtered_cmd()
{
    reject_and_die "disallowed command${restrict_path_list:+ (restrict-path: \"${restrict_path_list//|/\", \"}\")}"
}

reject_filtered_cmd
-------------------------------------------------------------------

As you can see, I missed one bashism, namely the
${parameter//pattern/string} form of parameter expansion.


Now executing this with dash:
$ dpkg -l dash | grep ^ii
ii  dash           0.5.11+git20210903+057cd650a4ed-9 amd64        POSIX-compliant shell
$ dash ssh_filter_btrbk.sh 
Segmentation fault
$

With kernel log:
Nov 21 03:31:37 heisenberg kernel: dash[145217]: segfault at 1 ip 000055fa32ef8cd4 sp 00007ffd79a75140 error 4 in dash[55fa32ef3000+13000]
Nov 21 03:31:37 heisenberg kernel: Code: e2 01 4c 8d 34 42 48 8d 05 61 d9 00 00 49 01 c6 89 f0 83 e0 02 89 85 fc fe ff ff 74 17 c7 85 fc fe ff ff 00 00 00 00 83 e3 fd <41> 80 3f 7e 0f 84 c2 05 00 00 48 8b 35 8b 58 01 00 48 8b 05 5c 53


Shouldn't that rather give some parsing error?



One some other system (where I cannot really test any further since I
have no root) it even may have caused some more:
[10527194.157467] ssh_filter_btrb[816610]: segfault at 0 ip 000055c8ac34a698 sp 00007ffd4a997080 error 4 in dash[55c8ac344000+13000]
[10527194.157482] Code: 85 c4 01 00 00 48 83 c4 68 4c 89 f8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 00 48 83 c2 02 eb a2 66 90 4c 89 fa 4d 85 f6 78 98 <48> 8b 36 bf 01 00 00 00 eb 8e 66 0f 1f 44 00 00 0f b6 42 01 48 83
[10527195.790531] traps: pool-tracker-st[816482] trap int3 ip:7f94e8271295 sp:7f94deffc770 error:0 in libglib-2.0.so.0.6400.6[7f94e8235000+84000]

Not sure whether that traps is in anyway related or just some
coincidence.



Thanks,
Chris.


[0] https://github.com/digint/btrbk/blob/master/ssh_filter_btrbk.sh
