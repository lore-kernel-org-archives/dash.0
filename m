Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1C4C4332F
	for <linux-dash@archiver.kernel.org>; Thu, 24 Nov 2022 05:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiKXFTC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 24 Nov 2022 00:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXFTB (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 24 Nov 2022 00:19:01 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C04CBB9DA
        for <dash@vger.kernel.org>; Wed, 23 Nov 2022 21:18:56 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6DD5E821B49;
        Thu, 24 Nov 2022 05:18:55 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 36E63821D8E;
        Thu, 24 Nov 2022 05:18:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1669267134; a=rsa-sha256;
        cv=none;
        b=ksiQJWv/LUVrmvSSqxuQoRjVYLEMjU5a8U6mF/jN8QPqZY/cbeNGntBxk9tbLRqupexcFW
        I4rnFja66325ONnm0t5WVBKVdgCha6+iRSlvAXUSmiTRBX0nl17mcvaPswAOAeR44U7apD
        PDYGG3FmmWiYGxSzkn8eok6sURGxQUBk9eImmuPvAfHKyyYyQFado1/YbyYFU1W8NN9H4o
        iuVzU1Td4oaVTE8vK848R2JUlYdfbhz8NseB46Rc0drvxR7yA/QjkJwdaiq24vQZ8Rbqb+
        iIBka9ExyXsjOUrYfsdwXDYD3Ks7Ub1XU2uTZiMrvvvcgzmkLT5ePzSoi7bRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1669267134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bw0YiT1LsIJjvNsidikRn1+1QuurQDC6HnIUIb6dj0A=;
        b=tak8X811275QP/sOwdbR5J1TrOcD57akNUBzqKj/bj7M4ZhziyIFnRSbw9JHPbs5t0FSQD
        l3KNHYOSQ+vQ4bY4BiBYHnQZugg8tkAgql04kADtCH6CgT93XPzCT8YAK0mpksQyZxjgcb
        rPbAeK/fgsyp7xCN5uFbXjCCtNauRmImCe/bsRKE5pEW9pQwePjCuz+zECGzGz6BOfUCf2
        kJ0UFgC7IftlexYXguZa3YYj+9nL0XjIYZvw6LaGx89vEHc9cWJEogGuJNMYKnZf7P7UEU
        RMXNh3UZDylJxoyR776LkyyBerovN/pVU/Scr/ykrC32v7DNjipjhvgFsIR7nQ==
ARC-Authentication-Results: i=1;
        rspamd-54446896b4-hg7v9;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-White-Trade: 17eb82bf2aa575a2_1669267134852_163624744
X-MC-Loop-Signature: 1669267134852:458505969
X-MC-Ingress-Time: 1669267134852
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.109.196.224 (trex/6.7.1);
        Thu, 24 Nov 2022 05:18:54 +0000
Received: from ppp-46-244-242-174.dynamic.mnet-online.de ([46.244.242.174]:38040 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oy4dO-0005Im-1n;
        Thu, 24 Nov 2022 05:18:52 +0000
Message-ID: <e8b863bf0bfe1a89a4dd0b80b9cc4c5386197634.camel@scientia.org>
Subject: Re: segfault with invalid shell script
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     dash@vger.kernel.org
Date:   Thu, 24 Nov 2022 06:18:47 +0100
In-Reply-To: <9b7465c0-a562-e175-292e-6c860ee9a091@gigawatt.nl>
References: <b2e298215b3d51d8284296484caa138faddaa0e4.camel@scientia.org>
         <6af07303-357f-6274-6c16-df00835c7f6c@gigawatt.nl>
         <8710d1c3-d7c9-7332-4bc7-ce243a1cbd37@gigawatt.nl>
         <cb7fedc28911acde1f94b76d1dec1ad220172825.camel@scientia.org>
         <aa7ac22c-73ad-d7ff-f058-7c3e542326c7@gigawatt.nl>
         <fe9be702c676b43bba8e0136a94583f919a05a66.camel@scientia.org>
         <9b7465c0-a562-e175-292e-6c860ee9a091@gigawatt.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, 2022-11-23 at 23:30 +0000, Harald van Dijk wrote:
> Sure, I have reported this to the busybox list and CCed you.

Thanks, they'd also have a bugtracker:
https://bugs.busybox.net/


>  If there is 
> a separate list for klib-utils where this should also be reported (I
> am 
> not aware of one), could you forward it there?

There is:
https://git.kernel.org/pub/scm/libs/klibc/klibc.git/tree/README

I've forwarded it there (with you in CC):
https://lists.zytor.com/archives/klibc/2022-November/004694.html
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1024735

Thanks,
Chris
