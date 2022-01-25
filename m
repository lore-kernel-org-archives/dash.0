Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5AEC433F5
	for <linux-dash@archiver.kernel.org>; Tue, 25 Jan 2022 05:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391318AbiAYFVQ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 25 Jan 2022 00:21:16 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:61570 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358192AbiAYFAE (ORCPT
        <rfc822;dash@vger.kernel.org>); Tue, 25 Jan 2022 00:00:04 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B5CE688195C;
        Tue, 25 Jan 2022 04:59:58 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id D8648881471;
        Tue, 25 Jan 2022 04:59:57 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.103.158.127 (trex/6.4.3);
        Tue, 25 Jan 2022 04:59:58 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Chief-Chief: 7673f3c931a41173_1643086798525_2482502090
X-MC-Loop-Signature: 1643086798524:2456789115
X-MC-Ingress-Time: 1643086798524
Received: from ppp-88-217-33-146.dynamic.mnet-online.de ([88.217.33.146]:45092 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nCDvr-0006un-Cs; Tue, 25 Jan 2022 04:59:56 +0000
Message-ID: <e312d45e17b49c418c3a62a56da758977067b563.camel@scientia.org>
Subject: dash doesn't support switching LC_* during a script/session
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     dash@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue, 25 Jan 2022 05:59:50 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hey.

I've noticed that dash (like klibc-utils sh - but unlike bash or
busybox sh) doesn't seem to support the follwoing:

Switching LC_*/LANG variables during a script/session and have that
change take effect on the very same script/session.


Consider the following check for this:
# check whether LC_* switch works in one script

#in UTF-8 the following is U+220B CONTAINS AS MEMBER
bs="$(printf '\342\210\213' )"

export LC_ALL=C.UTF-8
len1=${#bs}

export LC_ALL=C
len2=${#bs}

printf '%s %s\n' "${len1}" "${len2}"

# should return "1 2"



Now I'm not really sure whether or not POSIX mandates that this should
work or whether it's unspecified.
I'd kinda vaguely guess that it actually must be supported because of:
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_05_03

Quoting:
"The following variables shall affect the execution of the shell:
[...]
LANG
[...]
LC_ALL
[...]
"

And it really says: the following variables (and the chapter is "Shell
Variables") and "shall affect the execution of the shell".
It does not say, "environment variables" (in the sense that it would
have been just set once when the shell was invoked).


Even if POSIX wouldn't mandate this behaviour, I'd kindly ask to
support it, given that it's a requirement for the (apparently) only
really portable way of implementing/hacking command substitution that
keeps trailing newlines (see
e.g. https://unix.stackexchange.com/a/383390/474076).


Thanks,
Chris.
