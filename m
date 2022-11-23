Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2293C433FE
	for <linux-dash@archiver.kernel.org>; Wed, 23 Nov 2022 17:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbiKWRbT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 23 Nov 2022 12:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbiKWRbG (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 23 Nov 2022 12:31:06 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC66A8FFB0
        for <dash@vger.kernel.org>; Wed, 23 Nov 2022 09:31:01 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 33BAE3C1929;
        Wed, 23 Nov 2022 17:21:39 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 27D7F3C0CAD;
        Wed, 23 Nov 2022 17:21:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1669224098; a=rsa-sha256;
        cv=none;
        b=nkSIF4ayHLYidjmG5EeSlzHtR3x5CW0KfadPtMG2cKGkVsv1KewzeSzb1SoRHIAJWHgU9/
        2g4fC3JiF45mvBxVgxH6PDJi5+sTKixJQGmOAw3H/ug33Q3oupOv4CEupHJhcJiV3Ua1YQ
        RihX0WKkOHT4J4NVV2b3dmw2sjZNTGdQSIcW/uUI0DZ9FEGmQY3a+v80WLea8spLXXl49t
        jhDnBUkm5io9/+YOkMzJNrFxsTJ2K8pNgnMCZD6VCQjjoAfjR7jPC/LldXLx7l6EQV1A6o
        JbvyQn1Tr08fs4q4/pq0yNlUAtNc+yQ+Gol+aI+HlzTKsiUM+g3cttM7b6eQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1669224098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ZudM9KJjM2ivsSorL170jeUY7dso+JPxUK6TolFQrc=;
        b=msgb5ZPUpNV6gYyV8nYet4Ub0bFKHH/12i8/gRybof5SOm9YcFx8xQrEGf3HuML04ZU2X9
        +zi1q2AE3pgrXWJ6mUSXMET9/+kSQ4jvKCmVtQsb1q1VP/ApZjtPmuvV2IbqdYYcBBzL6h
        uJpjv54GzZXdZ/yHQ7jAQ2dxAHSioUqM8jCqn/xjxbQcEwYJl5q28YoSA1nbK6DG5Gsodv
        cVM3/jocuiBKf/pZKiD9ngPNDbys/TZnbhfbuPHWeMjA0UpFfLDrL7lnH/5o6YD7365LYM
        +7O5Cc36Is9n2/xjVmVm2nBsrviryROcWOfy5k/zwXGEurpFihEmu90/ywwN5Q==
ARC-Authentication-Results: i=1;
        rspamd-54446896b4-p6zc6;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Reign-Name: 020ee33057df7a38_1669224098806_942594105
X-MC-Loop-Signature: 1669224098806:3071501103
X-MC-Ingress-Time: 1669224098806
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.99.229.30 (trex/6.7.1);
        Wed, 23 Nov 2022 17:21:38 +0000
Received: from ppp-46-244-242-174.dynamic.mnet-online.de ([46.244.242.174]:38258 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oxtRF-00013a-On;
        Wed, 23 Nov 2022 17:21:36 +0000
Message-ID: <fe9be702c676b43bba8e0136a94583f919a05a66.camel@scientia.org>
Subject: Re: segfault with invalid shell script
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Date:   Wed, 23 Nov 2022 18:21:31 +0100
In-Reply-To: <aa7ac22c-73ad-d7ff-f058-7c3e542326c7@gigawatt.nl>
References: <b2e298215b3d51d8284296484caa138faddaa0e4.camel@scientia.org>
         <6af07303-357f-6274-6c16-df00835c7f6c@gigawatt.nl>
         <8710d1c3-d7c9-7332-4bc7-ce243a1cbd37@gigawatt.nl>
         <cb7fedc28911acde1f94b76d1dec1ad220172825.camel@scientia.org>
         <aa7ac22c-73ad-d7ff-f058-7c3e542326c7@gigawatt.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, 2022-11-23 at 10:54 +0000, Harald van Dijk wrote:
> With the busybox I have on my own system, I ran reproduce it with:
> 
>    busybox ash -c 'f() { echo ${PWD-${PWD!}}; }; f'
> 
> This segfaults.

Would you mind reporting this at busybox and klib-utils sh then?

I mean I could do, if you want me to, ... but since this was rather
found by you now, you should take the "credit".


Thanks,
Chris.
