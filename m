Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3961C433EF
	for <linux-dash@archiver.kernel.org>; Tue, 31 May 2022 22:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348341AbiEaWTE (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 31 May 2022 18:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237879AbiEaWTD (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 31 May 2022 18:19:03 -0400
X-Greylist: delayed 1296 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 May 2022 15:19:02 PDT
Received: from qproxy1-pub.mail.unifiedlayer.com (qproxy1-pub.mail.unifiedlayer.com [173.254.64.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5A09CC89
        for <dash@vger.kernel.org>; Tue, 31 May 2022 15:19:02 -0700 (PDT)
Received: from gproxy4-pub.mail.unifiedlayer.com (unknown [69.89.23.142])
        by qproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id 56606802B82B
        for <dash@vger.kernel.org>; Tue, 31 May 2022 21:57:25 +0000 (UTC)
Received: from cmgw11.mail.unifiedlayer.com (unknown [10.0.90.126])
        by progateway6.mail.pro1.eigbox.com (Postfix) with ESMTP id AD16F10047A68
        for <dash@vger.kernel.org>; Tue, 31 May 2022 21:57:24 +0000 (UTC)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with ESMTP
        id w9rgnErLIj8kTw9rgnHKvg; Tue, 31 May 2022 21:57:24 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=MbSpB7zf c=1 sm=1 tr=0 ts=62968f44
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=oZkIemNP1mAA:10:nop_rcvd_month_year
 a=3EOfIcITIxQA:10:endurance_base64_authed_username_1 a=YQUT7v5oAAAA:8
 a=npldXguGAAAA:8 a=RZhU0FMr2O8awl1-hNYA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=1Z6EAcxPEhoA:10:demote_hacked_domain_2
 a=Y6yEfkeh0FwA:10:demote_hacked_domain_42 a=D10gDlKhOp7erM-JtTWk:22
 a=1MEZn5qd6kv58cYvHi58:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=saCyEP5bKymhEgdtcKJ8GLb6jUWZ3HlbTDKdmKUJdVI=; b=tv2R9J3o0yt+p6bY0UEhWsEIA/
        3bxpEyDj+RIpdhDe0leQjaODnf30xT2VcehDVL13Tbnj95CsXLbStW2xnUXIQDxDEwV74wMNRTlzh
        UfZeFr5Byq1vUngbgc/bXmZCg;
Received: from [160.231.0.90] (port=14589 helo=llin-psh13-dsa.dsone.3ds.com)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <paul@mad-scientist.net>)
        id 1nw9rf-001zF4-Ua; Tue, 31 May 2022 15:57:24 -0600
Message-ID: <c9c96d88c226cc9db0d447fc1160608a6c5e0362.camel@mad-scientist.net>
Subject: Re: EXIT trap does not fire
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     charles.fisher@arconic.com, dash@vger.kernel.org
Date:   Tue, 31 May 2022 17:57:22 -0400
In-Reply-To: <NOATDC-APPGTW91Teip00015ab2@NOATDC-APPGTW91.arconic.com>
References: <NOATDC-APPGTW91Teip00015ab2@NOATDC-APPGTW91.arconic.com>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (by Flathub.org)) 
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 160.231.0.90
X-Source-L: No
X-Exim-ID: 1nw9rf-001zF4-Ua
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.0.90]:14589
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, 2022-05-31 at 16:39 -0400, charles.fisher@arconic.com wrote:
> The ssh-agent used in the context immediately below seems to prevent
> an EXIT trap from firing upon abnormal termination:

Unfortunately it's not clearly specified in the standard what should
happen in this situation.  There is an open issue about this:

https://austingroupbugs.net/view.php?id=3D621

and here it's pointed out that many shells do not run the EXIT trap
when a signal is received, but a few do (bash is one of the few).  So,
this is just an unfortunately unclear area of the standard and shells
choose to do different things depending on what they interpret "exit"
to mean: if they interpret it to mean only "normal exit, by someone
running exit or reaching EOF" then they will behave as dash does.  If
they interpret it to mean "the shell process is going away for any
reason", then they'll interpret it as bash does.

You can, of course, add multiple conditions:

   trap ... EXIT INT ABRT KILL TERM

or similar so both possibilities are catered to.
