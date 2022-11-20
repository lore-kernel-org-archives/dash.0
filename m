Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957A5C4332F
	for <linux-dash@archiver.kernel.org>; Sun, 20 Nov 2022 04:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiKTE5x convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 19 Nov 2022 23:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTE5w (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 19 Nov 2022 23:57:52 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC03C8757B
        for <dash@vger.kernel.org>; Sat, 19 Nov 2022 20:57:50 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 10C155C1617
        for <dash@vger.kernel.org>; Sun, 20 Nov 2022 04:57:50 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2F3665C1620
        for <dash@vger.kernel.org>; Sun, 20 Nov 2022 04:57:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668920269; a=rsa-sha256;
        cv=none;
        b=mtjZEzE/SEw7+sW4eUgsGpGyvIU1fS8JT590fF8EkL/l8pBxjeJzZAN5zfnD1uc4F272pz
        aUfKf5PZiTGdG3OgnqpLDS5Iq3UorvejAE908r77IjYRAULrBn37lqXXsYG5RTtHnP7cxx
        b/SPTSUHm1t1v4iQr9dmKy/h3zTSh32n67PLL2lYdIALGSFoQS5MOGWCvzJ0uSHRyARxpA
        71reJsap5kJc5cq421a7KwubaQrABKRr+UQSgxoOCeq3Mg+Ej6JXrU0QtMPfFneuNIeqiX
        hO/u1LJ3AzfNtiVhR1zDFv3VDj9VprzxpmYTI0l+uFsIQpFTCe34GommSW0/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668920269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=S6iSmvxhbEMNeZX2Whktgo2a4pjYiFrgUx3nhhJaBTU=;
        b=Q9SxwB7fQQAb8am+WEwxvE0bqrqlqFPh6Xa7gTpZY5b4+rDFM7vFHO+DG8T1NoOtGqF/vw
        kRtGwNd1OjZLf2uv06pVeB/1MwURVk91NVAeaggxJbYmNr6SZtHsNR6ffG1zBi68aRRbu3
        LapVZF9ZVlgV9u69iI4Fi87i+WPS5r0Zpyh0XhZAfQD4TkAD8+t6keupWh/NUH7M1g6Ifs
        7BrDjaOHKrWJWgfCtr3UWUczs03Cw0dASCSutExcnqihF/ROQymwqU/vb6VyQ6j4MYeG56
        r0prJd23ODiQXd2aOwtr7WJrYTlS185+L8KEwRpQfNokn62h0wZnmyZ17HSylw==
ARC-Authentication-Results: i=1;
        rspamd-65567d767-qn787;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Absorbed-Shrill: 3712dcd1381541c4_1668920269663_1848627607
X-MC-Loop-Signature: 1668920269663:2150694769
X-MC-Ingress-Time: 1668920269663
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.120.227.158 (trex/6.7.1);
        Sun, 20 Nov 2022 04:57:49 +0000
Received: from p57b04dfc.dip0.t-ipconnect.de ([87.176.77.252]:47680 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1owcOl-0004nt-2W
        for dash@vger.kernel.org;
        Sun, 20 Nov 2022 04:57:47 +0000
Message-ID: <3c3c3df0f7b172a9a1befceccd18c7e71fa91ee9.camel@scientia.org>
Subject: incomplete documentation of local?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     dash@vger.kernel.org
Date:   Sun, 20 Nov 2022 05:57:42 +0100
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

I noticed two things in dash’s "local" which seem to be missing from
dash’s manpage:


1) Like bash’s, dash’s local seem to support:
   local foo=bar
   which doesn't seem to be mentioned in the manpage.

   I guess many people nevertheless use this (with dash), so it should
   either be documented as working, or as something one cannot rely on
   in the future.


2) There is no clear documentation about "local"’s exit status.
   The section describing it doesn’t say anything and it doesn’t seem
   to follow from other sections, e.g. "Command Exit Status" says
   merely:
   > Additionally, the builtin commands return exit
   > codes, as does an executed shell function.

   This is especially important as dash’s local seems to do the
   something similar than e.g. bash’s, and return 0 unless used outside
   of a function or on some invalid variable name (e.g. "$").

   However, it does not fail, when called on a readonly variable.

   The main problem of this not being documented is IMO, that people
   may easily be tempted that:
     local foo="$(somecommmand)"
     rc="$?"
   works like:
     foo="$(somecommmand)"
     rc="$?"
   and gives back the exit status of somecommand, which it does not.


I could provide a patch with some wording if that helps.


Thanks,
Chris.
