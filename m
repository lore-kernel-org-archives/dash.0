Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C613AC433FE
	for <linux-dash@archiver.kernel.org>; Wed, 23 Nov 2022 04:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiKWEEZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 22 Nov 2022 23:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbiKWEEX (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 22 Nov 2022 23:04:23 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0145C0B
        for <dash@vger.kernel.org>; Tue, 22 Nov 2022 20:04:22 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8BDCC141D9B;
        Wed, 23 Nov 2022 04:04:21 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id CBE9D141C3E;
        Wed, 23 Nov 2022 04:04:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1669176261; a=rsa-sha256;
        cv=none;
        b=Y58mo/5fzlTRgJ8A2AeL98jGG+OruosNy3RTncBHj8GzBQgqAN9IDvVNUke7jFvuJO2JtQ
        N8sr6V3IJTAxIXg6JDOkYHluKIdvm8YNZ1QRqZdmk+9Nrgu582Dfa5S/jzyZdWoJlKtll2
        jZV8DQhNfHMQmOLaV9W8EwOD3OwMW8hrbQ35tj9BJDQNkkEr/iWNn/Sl0N2BYb9+F+kv7Y
        hosQsnqqoMIaY4kwkmOhlu6HNilLQg2UgyI90oCFcrfzc+yuNhCcwBWbZn82FBJ7uGJ7Gz
        7S9SdCAH/pgl+v/MKaPOKPkKXZOqnknVSfPPS2U7JLk+IB93Er0tJabJwtVp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1669176261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6huKyrSvjjfrwAgoOIQFZF31vPlS1MIZtRfhFvNTH5c=;
        b=mqtem6V9TIhL2AKc/OGJLukm5ZPi4nVvPPYaskfoNsd8mkcuE2YZz73Yn+X6hwSAN4pREK
        PAdVm+m0+GOzpzBI79NduJmGimahkzeV4hQHvLUj9aEYXtxRLmw/N064KinO5AHJzoe3Mt
        q7oIKtc74gDpcUUQb584s/zk+xuXSyg9cK+f3xPIESmL2tU61jZNnH3HT9WDwvOtB8T9ZO
        bwCweptWMzZVZQoaEALBHJTWDwHhkl3+5AJprbW6CXhk+JS0PucoDLAqoM1hpw87JrW5L2
        fBuyyWkj60SCjsZ/z84yY73VmUOHdunxfj+Or0rlxx6hbDezF0shtwwiT+jVhA==
ARC-Authentication-Results: i=1;
        rspamd-65567d767-hlph2;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Thread-Belong: 07546fa94486c121_1669176261285_3185983855
X-MC-Loop-Signature: 1669176261285:758340972
X-MC-Ingress-Time: 1669176261285
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.103.24.105 (trex/6.7.1);
        Wed, 23 Nov 2022 04:04:21 +0000
Received: from ppp-46-244-242-174.dynamic.mnet-online.de ([46.244.242.174]:43148 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oxgzg-0003zW-7O;
        Wed, 23 Nov 2022 04:04:19 +0000
Message-ID: <cb7fedc28911acde1f94b76d1dec1ad220172825.camel@scientia.org>
Subject: Re: segfault with invalid shell script
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Date:   Wed, 23 Nov 2022 05:04:13 +0100
In-Reply-To: <8710d1c3-d7c9-7332-4bc7-ce243a1cbd37@gigawatt.nl>
References: <b2e298215b3d51d8284296484caa138faddaa0e4.camel@scientia.org>
         <6af07303-357f-6274-6c16-df00835c7f6c@gigawatt.nl>
         <8710d1c3-d7c9-7332-4bc7-ce243a1cbd37@gigawatt.nl>
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

Wasn't busxybox' sh (and that of klibc-utils) based on dash/ash as
well?

Tried it with them, but there I couldn't reproduce the issue.

Thanks,
Chris.
