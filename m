Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90F2C4332F
	for <linux-dash@archiver.kernel.org>; Thu, 15 Dec 2022 17:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiLORNU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 15 Dec 2022 12:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiLORNP (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 15 Dec 2022 12:13:15 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33DE297
        for <dash@vger.kernel.org>; Thu, 15 Dec 2022 09:13:04 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1206C2016E3
        for <dash@vger.kernel.org>; Thu, 15 Dec 2022 17:13:03 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 442FF201053
        for <dash@vger.kernel.org>; Thu, 15 Dec 2022 17:13:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1671124382; a=rsa-sha256;
        cv=none;
        b=n711QdNmqshVW6PzoTNl05w0PrLJ2Y4JO7sZvLmwYWUQ2YatribMvqnfBH7zaVHZyvz/S0
        W2ZP8grE93NkpbgPr41GKkclJR6zUHXWVCi1XU3iXW2rgjTvIV0I/ca1mF46292HuPlEpi
        pp26Bj1yVRYRYo2SdGuWQ35milE8BzjeowI6bt4X5bRZuRZN2B1PD72+chDw83zkIqI1H3
        LaPpf6C2yVwiY2nh0Y7uAJEukQ33VBMz3PTr8Sph46PzULvBBj/vZ3VSKjqhJQbI2W+VEV
        xhXGAGU8LoGhlm9QGigkDFJRGP6Ek5I2aGdQE0sTBjvh8ou/rM8YxdMWlUbuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1671124382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZAjRGHTZbZjQCKTP8hWywGHYzXTFAqygH2VMqjzrALA=;
        b=wF/4n+RtjiOR+sJzxuYa5qHQB9SCMstBUZSvTvyvzKhfsUzTu1V4HsmfbHGj87Gve4n3Im
        u4kYxPY+TEbu2HlQ2XoGuldDleVuappyAgEY6q7KDOmGqmFB7JpoNLyOE+/mMeF/G21NMz
        tvToaD9QHUqoNUCwsoJ/lJt7q6WVk7fbaV8147taN6+YNorXo+njtRbvZLNjY5XVDFmP3W
        0jKm3D24cVXZ1fZ/aPE/ArEH2O/ydnnULORf7BhICMiRqjgxew8IyQ178HIbo5udO22cj2
        K8war5/qKAd+xpi30CjQd3jVMtBeR3xzdlB/E/Ln+w3NCxsiOZPdo2BGePLmlQ==
ARC-Authentication-Results: i=1;
        rspamd-747d4f8b9f-gwz7x;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Squirrel-Whispering: 32c4fa5c2f625f9f_1671124382755_3924096628
X-MC-Loop-Signature: 1671124382755:2768260048
X-MC-Ingress-Time: 1671124382754
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.99.229.10 (trex/6.7.1);
        Thu, 15 Dec 2022 17:13:02 +0000
Received: from ppp-46-244-253-169.dynamic.mnet-online.de ([46.244.253.169]:40276 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1p5rmy-00BNJN-UE
        for dash@vger.kernel.org;
        Thu, 15 Dec 2022 17:13:00 +0000
Message-ID: <2dfc2b4ed23d79dd53b6d37cbd06710c266128dc.camel@scientia.org>
Subject: next POSIX issue will include dollar-single-quotes $'...'
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     dash@vger.kernel.org
Date:   Thu, 15 Dec 2022 18:12:54 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hey.

Just a heads up in case this hasn't been noticed yet, dollar-single-
quotes $'...' will be part of the next POSIX (issue 8).

Are there any plans to add support for these?
Guess it would be quite helpful, for all the cases where right now it's
rather cumbersome to write e.g. literal \n or \t.

AFAICS, supporting ISO C's \u… and \U… was left out as optional, so I
guess dash wouldn't need nay locale/Unicode support for that.

Cheers,
Chris.
