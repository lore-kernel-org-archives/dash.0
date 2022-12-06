Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5DAC352A1
	for <linux-dash@archiver.kernel.org>; Tue,  6 Dec 2022 15:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiLFPVB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 6 Dec 2022 10:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbiLFPUR (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 6 Dec 2022 10:20:17 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E73963AB
        for <dash@vger.kernel.org>; Tue,  6 Dec 2022 07:19:52 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 496E89212D9;
        Tue,  6 Dec 2022 15:19:48 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 57AD492128B;
        Tue,  6 Dec 2022 15:19:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670339987; a=rsa-sha256;
        cv=none;
        b=w8s+7Aw1GnzveBX6tr1qQ3gumL+9trhGrF46/l+ZHPenA4yHSWRxha6h34HqrmpNSQPRMl
        ZYFcZrUzMeVawNQUAjP8/xrWF0BhbooWrdmgExETr+JD4N/m3LC3hi1lOwv6IV0ud5L2bu
        GbwPN2mzZmOlsx/SH4MxqLYvibOggAtynPsAzjrtrtAcKA4VmdyxFZAvqQsmZKDfHIpAOS
        +wEjTJJdwMBz93Xa+t3xVl9y9eciWUcoV8MVyPSZUHqVS3j9hDeVtKkCqKECAYmv3IXb/6
        /qNmt7sVS4HiBBt324SQSprAxp5Odr3wR/T/SFls25OOoXiBiusrV+40iEeHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670339987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bx439wEP8qdTKQSJYYH6LCmrZYpiouAGV/1CWJnjuHA=;
        b=LaeqVr7ceGoNKVeEHEto9e9WO2rlqYl+xHcSbG0QlTEXygxsWkqp5W2SivE4njzDlzpwiP
        yY1ld/0/KxBQ9e8+YneehO6ikZTetBoYhBuOrm2o3MtCl1aPW23tnyqLv3XrqGTYR/gBJl
        TiLuDv2NoNyhZypkVgGC0ZQDzdzDhUy0Bm0O2OjrfOmP1VIheTAnN+5cw5KGX/fzXAI7f1
        esKTGtaas98fAsSIDeN1hZPB2D822IQivR9Qi62t26GtEdu1Nyhx9w1S9LseIq21WII1Zr
        XDzdEk7113cVN6rAkL/mCIRW93Eno1Scmny0AU2leAVp2orwqbScEqhz0Pyn3Q==
ARC-Authentication-Results: i=1;
        rspamd-84789cff4b-78mbd;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Skirt-Daffy: 545f621e2eba1906_1670339987950_2512932086
X-MC-Loop-Signature: 1670339987950:3399364006
X-MC-Ingress-Time: 1670339987950
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.97.48.119 (trex/6.7.1);
        Tue, 06 Dec 2022 15:19:47 +0000
Received: from p57b04dfc.dip0.t-ipconnect.de ([87.176.77.252]:48346 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1p2ZjR-003o5X-UG;
        Tue, 06 Dec 2022 15:19:45 +0000
Message-ID: <2ec90a7f0cf3f0eebb9092725804f9d0bc4ec756.camel@scientia.org>
Subject: Re: [PATCH] parser: Add VSBIT to ensure subtype is never zero
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Harald van Dijk <harald@gigawatt.nl>
Cc:     dash@vger.kernel.org
Date:   Tue, 06 Dec 2022 16:19:39 +0100
In-Reply-To: <Y47ZlpwkQy+jiule@gondor.apana.org.au>
References: <Y47ZlpwkQy+jiule@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hey.

Is that already the final version of the patch? Cause then we could
ping klibc sh / busybox about it.


Thanks,
Chris.
